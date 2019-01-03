<?php

namespace app\component\controller;

use think\Controller;
use think\Request;

class Upload extends Controller
{
    public function uploader()
    {
        $file = request()->file('file');
        $path = ROOT_PATH . 'public' . DS . 'uploads';
        $info = $file->move($path);
        if ($file) {
            echo json_encode(['valid' => 1, 'message' =>'/uploads/' . $info->getSaveName()]);
        } else {
            echo json_encode(['valid' => 0, 'message' =>$file->getError()]);
        }
        exit;//!!!!!!!!!!!!!!!!!!!一定要加！！！！！！！！！！
    }
}
