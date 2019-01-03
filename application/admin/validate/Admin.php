<?php
//注：验证器的文件夹名不能取成除validate的其它名（如validator）？
namespace app\admin\validate;

use phpDocumentor\Reflection\Types\Self_;
use think\Session;
use think\Validate;

class Admin extends Validate
{
    protected $rule = [
        'o-password' => 'require|check_old_password',
        'password' => 'require|confirm',
    ];

    protected $message = [
        'o-password.require' => '旧密码不能为空',
        'password.require' => '新密码不能为空',
        'password.confirm' => '两次密码输入不一致',
        'o-password.check_old_password' => '旧密码输入错误',
    ];

    // 自定义验证规则：判断旧密码输入是否正确
    protected function check_old_password($value, $rule, $data)
    {
        $oldPassword = input('o-password');
        $dbPassword = (new \app\admin\model\Admin)->where('username', Session::get('username'))->value('password');
        if (md5($oldPassword) != $dbPassword) {
            return false;
        }else{
            return true;
        }

    }


}