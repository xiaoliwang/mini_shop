<?php
/**
 * Created by PhpStorm.
 * User: chenh
 * Date: 2019/1/8
 * Time: 18:29
 */

namespace helper;

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

}
