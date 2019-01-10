<?php

namespace helper;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\ClientException;
use think\Config;

class Util
{
    const DEFAULT_COVER = '/node_modules/hdjs/images/nopic.jpg';

    /**
     * 获取项目根目录绝对路径地址
     *
     * @return mixed
     */
    public static function getRoot()
    {
        return $_SERVER['DOCUMENT_ROOT'];
    }

    /**
     * 生成文件保存路径
     *
     * @param $local_file
     * @return null|string
     */
    public static function generateFilePath($local_file)
    {
        if (!is_file($local_file)) return null;
        $save_name = date('Ym') . '/' . date('d') . '/' . md5($local_file)
            . date('His') . '.' . self::getFileExtension($local_file);
        return $save_name;
    }

    /**
     * 获取文件后缀类型
     *
     * @param $file_path
     * @return string
     */
    public static function getFileExtension($file_path)
    {
        $finfo = finfo_open(FILEINFO_MIME_TYPE);
        $mime = finfo_file($finfo, $file_path);
        switch ($mime) {
            case 'audio/x-m4a':
                return 'm4a';
            case 'audio/mpeg':
                return 'mp3';
            case 'audio/x-wav':
                return 'wav';
            case 'image/jpeg':
                return 'jpg';
            case 'image/gif':
                return 'gif';
            case 'image/png':
                return 'png';
            default:
                return '';
        }
    }

    /**
     * 请求远程 Api
     *
     * @param string $url
     * @param $data
     * @param string $base_uri
     * @param string $key
     * @return array|mixed
     * @throws \GuzzleHttp\Exception\GuzzleException
     */
    public static function requestApi(string $url, $data, string $base_uri, string $key)
    {
        $data = base64_encode(json_encode($data, JSON_UNESCAPED_UNICODE));
        $timestamp = time();
        $sign = hash_hmac('sha256', "$data $timestamp", $key);
        $body = "$data $sign $timestamp";

        $client = new Client([
            'base_uri' => $base_uri,
            'timeout' => 15.0,
        ]);
        try {
            $res = $client->request('POST', $url, [
                'headers' => [
                    'Accept' => 'application/json',
                    'X-Forwarded-For' => $_SERVER['REMOTE_HOST'] ?? '',
                    'Content-Type' => 'text/plain',
                ],
                'body' => $body,
            ]);
        } catch (ClientException $e) {
            $res = $e->getResponse();
        }
        $body = $res->getBody();
        $content = $body->getContents();
        $result = json_decode($content, true);
        if (is_array($result)) $result['status'] = $res->getStatusCode();
        return $result;
    }

    /**
     * 发送邮件
     *
     * @param array $mail
     */
    public static function sendMail(array $mail)
    {
        $pushServer = Config::get('pushserver');
        self::requestApi('/api/email', ['emails' => [$mail]], $pushServer['url'], $pushServer['key']);
    }

    /**
     * 生成随机数
     *
     * @param int $length
     * @param int $type
     * @return string
     */
    public static function randomKeys(int $length, int $type = 1)
    {
        $key = '';
        $pattern = '';
        if ($type & 1)
            $pattern .= '1234567890';
        if ($type & 2)
            $pattern .= 'abcdefghijklmnopqrstuvwxyz';
        if ($type & 4)
            $pattern .= 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $p_length = strlen($pattern) - 1;
        for ($i = 0; $i < $length; $i++)
            $key .= $pattern{mt_rand(0, $p_length)};
        return $key;
    }

    /**
     * 保存 base64 的图片为文件
     *
     * @param string $base64_image_content
     * @return string
     * @throws \Exception
     */
    public static function SaveBase64Image(string $base64_image_content)
    {
        if (!preg_match('/^(data:\s*image\/(\w+);base64,)/', $base64_image_content, $result)) {
            throw new \Exception('base64 内容错误');
        }

        $dir = self::getRoot() . '/uploads/' . date('Ymd') . '/';
        if (!is_dir($dir)) {
            mkdir($dir);
        }

        $local_file_name = $dir . md5(self::randomKeys(6, 2) . time()) . '.' . $result[2];
        $fp = fopen($local_file_name, 'w');
        fwrite($fp, base64_decode(str_replace($result[1], '', $base64_image_content)));
        fclose($fp);
        unset($result);

        return $local_file_name;
    }

}
