<?php

namespace app\admin\controller;

use app\admin\model\Admin;
use think\Controller;
use think\Db;
use think\Request;
use think\Session;
use think\View;
use app\admin\validate\Admin as AdminValidator;

class User extends Controller
{
    public function index()
    {
        new Common();
        return view();
    }


    //登陆
    public function login()
    {
        if (request()->isPost()) {
            $post = input('post.');
            $dbData = (new Admin())->where('username', $post['username'])->find();
            if ($dbData) {
                if (md5($post['password']) == $dbData['password']) {
                    Session::set('username', $post['username']);
                    $this->success('登录成功', url('user/index'));
                }
                $this->error('密码错误');
            }
            $this->error('用户名不存在');
        }

        return view('');
    }

    //退出
    public function logout()
    {
        // 清除session（当前作用域）
        Session::clear();
        // 清除think作用域
        Session::clear('think');
        $this->success('退出成功', url('user/login'));
    }

    //修改密码
    public function changePassword()
    {
        new Common();//检测登录与否

        if (request()->isPost()) {
            $post = input('post.');
            // 验证密码（旧、新、确认密码为空，及旧密码是否输入正确）
            $validate = \think\Loader::validate('Admin');
            if (!$validate->check($post)) {
                // 一次只出现一条错误信息
                Session::flash('changPwdError', $validate->getError());
            } else {
                // 执行修改密码
                $user = (new Admin)->where('username', Session::get('username'))->find();
                $user->password = md5($post['password']);
                $user->save();
                // 清除session（当前作用域）
                Session::destroy();
                $this->success('密码修改成功，请重新登录', url('login'));
            }
        }

        return view();
    }

}
