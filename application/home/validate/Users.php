<?php

namespace app\home\validate;
use think\Session;
use think\Validate;

class Users extends Validate
{
    protected $rule = [
        'username' => 'require|unique:users|regex:\w{6,10}',
        'captcha|验证码'=>'require|captcha',
        'password' => 'require|min:6|max:25|confirm',
        'o-password' => 'require|check_old_password',
    ];

    protected $message = [
        'username.require' => '用户名不能为空',
        'username.unique' => '用户名已被注册，请尝试其它用户名',
        'username.regex' => '用户名必须为6-10位(字母、数字、下划线组合)',
        'password.require' => '登录密码不能为空',
        'password.min' => '密码长度至少为6位',
        'password.max' => '密码长度最多为25位',
        'password.confirm' => '两次密码输入不一致',
        'o-password.require' => '旧密码不能为空',
        'o-password.check_old_password' => '旧密码输入错误',
    ];

    protected $scene = [
        'reg' => ['username', 'captcha|验证码', 'password'],
        'changepassword'  =>  ['o-password','password'],
    ];

    protected function check_old_password($value, $rule, $data)
    {
        $oldPassword = input('o-password');
        $dbPassword = (new \app\home\model\Users)
            ->where('id', Session::get('user')['id'])
            ->value('password');
        if (md5($oldPassword) == $dbPassword) {
            return true;
        }
        return false;
    }

}
