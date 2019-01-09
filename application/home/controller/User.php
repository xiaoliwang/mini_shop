<?php

namespace app\home\controller;

use helper\Util;
use think\Cache;
use think\Controller;
use app\home\model\Users as UserModel;
use think\Session;
use think\Validate;

class User extends Controller
{
    // post:
    //   mail
    //   username
    //   captcha|验证码
    //   password
    //   password_confirm
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
                $userModel->mail = $post['mail'];
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

    // post:
    //  mail
    public function ajax_check_mail()
    {
        $validate = new Validate(['mail' => 'require|email|unique:users'], [
            'mail.require' => '邮箱不为空',
            'mail.email' => '邮箱格式错误',
            'mail.unique' => '邮箱已被注册',
        ]);
        if (!$validate->check(['mail' => input('mail')])) {
            return ['success' => false, 'info' => $validate->getError()];
        };
        return ['success' => true, 'info' => '邮箱正确'];
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

    // post:
    //  mail
    //  forget_code
    //  username
    //  password
    //  password_confirm
    public function forgetpassword()
    {
        if (request()->isPost()) {
            $post = input('post.');
            $validate = \think\Loader::validate('Users');
            if (!$validate->scene('forgetpassword')->check($post)) {
                Session::flash('forgetPwdError', $validate->getError());
            } else {
                if ($userModel = UserModel::get(['username' => $post['username'], 'mail' => $post['mail']])) {
                    $userModel->password = md5($post['password']);
                    $userModel->save();
                    Session::destroy();
                    $this->success('密码修改成功，请重新登录...', 'user/login');
                } else {
                    $this->error('该用户不存在');
                }
            }
        }

        return view();
    }

    // post:
    //   email
    public function sendforgetpasswordmail()
    {
        try {
            if (!request()->isAjax()) {
                throw new \Exception('非法请求');
            }

            $mailAccount = input('account');
            $validate = new Validate(['account' => 'require|email'], [
                'account.require' => '邮箱不能为空',
                'account.email' => '邮箱格式错误',
            ]);
            if (!$validate->check(['account' => $mailAccount])) {
                throw new \Exception($validate->getError());
            }

            $code = Util::randomKeys(6);
            Session::set('forget_code', $code);
            Util::sendMail([
                'to' => $mailAccount,
                'subject' => '【宅喵商城】验证码',
                'template' => 'vcode',
                'payload' => [
                    'code' => $code,
                    'confirm_content' => '您的账号正在进行找回密码的操作',
                ],
            ]);
            return [
                'success' => true,
                'info' => '发送成功',
            ];
        } catch (\Exception $e) {
            return [
                'success' => false,
                'info' => $e->getMessage(),
            ];
        }
    }

}
