<?php

namespace app\admin\controller;

use think\Controller;
use think\Request;
use think\Session;

class Common extends Controller
{
    //检测是否登录了
    public function __construct()
    {
        if(!Session::get('username')){
            $this->error('请先登录后再操作！',url('user/login'));
        }
    }
}
