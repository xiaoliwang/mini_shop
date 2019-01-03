<?php

namespace app\admin\validate;

use think\Validate;

class Category extends Validate
{
    protected $rule = [
        'cname' => 'require|min:2|max:8'
    ];

    protected $message = [
        'cname.require' => '栏目名称不能为空',
        'cname.min' => '栏目名称长度至少为2个字符',
        'cname.max' => '栏目名称长度至多为8个字符',
    ];

    protected $scene = [
        'add'   =>  ['cname'],
        'edit'  =>  ['cname'],
    ];



}