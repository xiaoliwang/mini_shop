<?php
/**
 * Created by PhpStorm.
 * User: chenh
 * Date: 2019/1/8
 * Time: 15:26
 */

namespace helper;

use OSS\OssClient as BaseClient;
use OSS\Core\OssException;
use think\Config;
use think\Exception;

class OssClient extends BaseClient
{
    public $accessKeyId;
    public $accessKeySecret;
    public $endpoint;
    public $isCName = false;
    public $securityToken = null;

    public $bucket = 'missevan-test';
    public $publicUrl;

    public function __construct(array $config = [])
    {
        if (empty($config)) {
            throw new Exception('oss config error');
        }

        $this->accessKeyId = $config['accessKeyId'];
        $this->accessKeySecret = $config['accessKeySecret'];
        $this->endpoint = $config['endpoint'];
        $this->bucket = $config['bucket'];
        $this->publicUrl = $config['publicUrl'];

        if (isset($config['isCName'])) {
            $this->isCName = $config['isCName'];
        }
        if (isset($config['securityToken'])) {
            $this->securityToken = $config['securityToken'];
        }

        try {
            return parent::__construct($this->accessKeyId, $this->accessKeySecret, $this->endpoint, $this->isCName, $this->securityToken);
        } catch(OssException $e) {
            echo $e->getMessage();
            exit(1); // 创建失败则退出程序
        }
    }

    /**
     * 上传文件或者内容，最大上传文件不能超过5G
     *
     * @param string $path_or_content 需要上传的内容或者文件路径
     * @param string $remote_path oss 对应的 object 地址
     * @param bool $is_file 上传的是否为文件，否则为内容。默认为 false
     * @param array $heads 具体看下面的设置 heads
     *
     * @return string oss 对应的 object 地址
     * @throws OssException
     *
     * 设置文件 heads
     * [
     *    'Expires' => '2012-10-01 08:00:00',
     *    'Content-Disposition' => 'attachment; filename="xxxxxx"',
     *    'Content-Type' => 'application/octet-stream'
     *    'Cache-Control' => ''
     * ]
     */
    public function upload(string $path_or_content, string $remote_path, bool $is_file = true, array $heads = [])
    {
        $options = $heads ? [ self::OSS_HEADERS => $heads ] : [];
        if ($is_file) {
            parent::uploadFile($this->bucket, $remote_path, $path_or_content, $options);
        } else {
            $this->putObject($this->bucket, $remote_path, $path_or_content, $options);
        }
        return $remote_path;
    }

    /**
     * 载文件到本地文件或内存
     *
     * @param string $remote_path oss 对应的 object 地址
     * @param string $file_path 本地文件地址，当本地地址缺省时，默认返回文件内容
     * @return string | bin 返回文件地址或文件内容
     */
    public function download(string $remote_path, $file_path = Null)
    {
        if ($file_path) {
            $options = [self::OSS_FILE_DOWNLOAD => $file_path];
            $this->getObject($this->bucket, $remote_path, $options);
        } else {
            $file_path = $this->getObject($this->bucket, $remote_path);
        }
        return $file_path;
    }

    /**
     * @param array $options
     * @param int $maxKeys
     * @return \OSS\Model\ObjectListInfo
     *
     * options 参数说明
     * prefix 相当于 object 的文件夹
     * marker 从 marker 之后按字母排序的第一个开始返回。默认值为 ''。
     *
     * ObjectListInfo 说明
     * getNextMarker(); 获取 marker，当 marker 再次为''时，遍历结束
     * getObjectList(); 获取 object 列表
     * getPrefixList(); 获取 prefix 列表
     */
    public function list(array $options, int $maxKeys = 30)
    {
        $in_options = [
            'delimiter' => '/',
            'max-keys' => $maxKeys,
            'marker' => '',
        ];
        $options = $options + $in_options;
        return $this->listObjects($this->bucket, $options);
    }

    /**
     * 判断 object 是否存在
     *
     * @param $remote_path oss object 地址
     * @return bool
     */
    public function exist(string $remote_path)
    {
        return $this->doesObjectExist($this->bucket, $remote_path);
    }

    /**
     * @param string $from_path 需要复制的 object 地址
     * @param string $to_path 复制到的地址
     */
    public function copy(string $from_path, string $to_path)
    {
        $this->copyObject($this->bucket, $from_path, $this->bucket, $to_path);
    }

    /**
     * 软删除，可以使用 recoverFile 函数恢复
     *
     * @param string $remote_path 需要删除的文件地址
     * @return bool true表示删除成功, false表示删除失败
     */
    public function deleteFile(string $remote_path)
    {
        if ($this->exist($remote_path)) {
            $trash_path = '.trash/' . $remote_path;
            $this->copy($remote_path, $trash_path);
            $this->hDeleteFile($remote_path);
            return true;
        } else {
            return false;
        }
    }

    /**
     * 恢复软删除文件
     * @param string $remote_path 需要恢复的文件地址
     * @return bool true表示恢复成功，false表示恢复失败
     */
    public function recoverFile(string $remote_path)
    {
        $trash_path = './trash/' . $remote_path;
        if ($this->exist($trash_path)) {
            $this->copy($trash_path, $remote_path);
            $this->hDeleteFile($trash_path);
            return true;
        } else {
            return false;
        }
    }

    /**
     * 获取 object 的Meta信息
     *
     * @param string $remote_path 需要获取Meta的 object 的地址
     * @return array | false 返回meta信息 object 不存在時返回false
     */
    public function getMeta(string $remote_path)
    {
        if ($this->exist($remote_path)) {
            return $this->getObjectMeta($this->bucket, $remote_path);
        } else {
            return false;
        }
    }

    /**
     * 修改 object 头信息
     *
     * @param string $remote_path oss object 地址
     * @param array $heads 具体参考上传中的heads
     */
    public function changeHeads(string $remote_path, array $heads)
    {
        $options = [
            BaseClient::OSS_HEADERS => $heads
        ];
        $this->copyObject($this->bucket, $remote_path, $this->bucket, $remote_path, $options);
    }

    private function hDeleteFile($remote_path)
    {
        return $this->deleteObject($this->bucket, $remote_path);
    }


    /**
     * 组合 OSS 中文件的全路径
     * @param string $oss_dir 存放的 OSS 目录
     * @param string $file_name 文件名
     * @return string 全路径的文件地址
     */
    public function getUrl(string $oss_dir, string $file_name)
    {
        return $this->publicUrl . '/' . $oss_dir . '/' . $file_name;
    }

    public static function instance()
    {
        return new self(Config::get('oss'));
    }

}
