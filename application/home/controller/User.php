<?php

namespace app\home\controller;

use app\home\model\Address;
use think\Cache;
use think\Controller;
use app\home\model\Users as UserModel;
use think\Session;
use think\Validate;

class User extends Controller
{

    public function reg()
    {
        if (request()->isPost()) {
            $post = input('post.');
            $userModel = new UserModel;
            Cache::set('username', $post['username']);
            $validate = \think\Loader::validate('Users');
            if (!$validate->scene('reg')->check($post)) {
                Session::flash('regError', $validate->getError());
            } else {
                $userModel->username = $post['username'];
                $userModel->password = md5($post['password']);
                $userModel->save();
                $this->success('注册成功，正在跳转至登录页面...', 'user/login');
            }

        }

        return view();
    }

    public function ajax_check_username()
    {
        $rule = ['username' => 'require|unique:users|regex:\w{6,10}',];
        $msg = [
            'username.require' => '用户名不能为空',
            'username.unique' => '用户名已被注册，请尝试其它用户名',
            'username.regex' => '用户名必须为6-10位(字母、数字、下划线组合)',
        ];
        $validate = new Validate($rule, $msg);
        if (!$validate->check($_POST)) {
            echo $validate->getError();
        };
    }

    public function ajax_check_captcha()
    {
        $rule = ['captcha|验证码' => 'require|captcha',];
        $msg = [];
        $validate = new Validate($rule, $msg);
        if (!$validate->check($_POST)) {
            echo $validate->getError();
        };
    }

    public function logout()
    {
        Session::flush();
        Session::set('user', null);
        $this->success('退出成功', '/');
    }

    public function login()
    {
        if (request()->isPost()) {
            $post = input('post.');

            $errorTimes = Session::get('errorTimes') ?: 0;

            Cache::set('username', $post['username']);
            Cache::set('password', $post['password']);
            if (isset($post['captcha'])) {
                $rule = ['captcha|验证码' => 'require|captcha',];
                $msg = [];
                $validate = new Validate($rule, $msg);
                if (!$validate->check(['captcha' => $post['captcha']])) {
                    Session::set('errorTimes', 3);
                    $this->error($validate->getError(), 'user/login');
                    exit;
                };
            }

            if ($post['username'] == '' || $post['password'] == '') {
                p($post);
                $errorTimes += 1;
                Session::set('errorTimes', $errorTimes);
                $this->error('用户名或密码不能为空，请重新输入！');
                exit;
            }

            $userModel = UserModel::where('username', $post['username'])->find();
            if (!$userModel) {
                $errorTimes += 1;
                Session::set('errorTimes', $errorTimes);
                $this->error('该用户名不存在，请重新输入！');
                exit;
            }
            if (md5($post['password']) != $userModel['password']) {
                $errorTimes += 1;
                Session::set('errorTimes', $errorTimes);
                $this->error('密码输入错误，请重新输入！');
                exit;
            }
            Session::set('user', ['id' => $userModel['id'], 'username' => $userModel['username']]);
            $this->success('登录成功，正在跳转中...', 'profile');
        }

        return view();
    }

    public function profile()
    {
        new Common;
        return view();
    }

    // post:
    //   o-password
    //   password
    //   password_confirm
    public function changepassword()
    {
        new Common;

        if (request()->isPost()) {
            p($_POST);
            $userId = Session::get('user')['id'];
            $post = input('post.');
            $userModel = UserModel::where('id', $userId)->find();
            $validate = \think\Loader::validate('Users');
            if (!$validate->scene('changepassword')->check($post)) {
                Session::flash('changPwdError', $validate->getError());
            } else {
                $userModel->password = md5($post['password']);
                $userModel->save();
                Session::destroy();
                $this->success('密码修改成功，请重新登录...', 'user/login');
            }
        }

        return view();
    }

}
