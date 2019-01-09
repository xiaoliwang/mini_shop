<?php

namespace helper;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\ClientException;
use think\Config;

class Util
{
    const DEFAULT_COVER = '/node_modules/hdjs/images/nopic.jpg';

    public static function getRoot()
    {
        return $_SERVER['DOCUMENT_ROOT'];
    }

    public static function generateFilePath($local_file)
    {
        if (!is_file($local_file)) return null;
        $save_name = date('Ym') . '/' . date('d') . '/' . md5($local_file)
            . date('His') . '.' . self::getFileExtension($local_file);
        return $save_name;
    }

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

    public static function sendMail($mail)
    {
        $pushServer = Config::get('pushserver');
        self::requestApi('/api/email', ['emails' => [$mail]], $pushServer['url'], $pushServer['key']);
    }

    // 随机数
    public static function randomKeys($length, $type = 1)
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

}
