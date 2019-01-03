<?php

namespace app\admin\model;

use think\Model;

class Goods extends Model
{
    protected $type = [
        //以下已经转换成json了
        //["\/node_modules\/hdjs\/images\/nopic.jpg","\/node_modules\/hdjs\/images\/nopic.jpg","\/node_modules\/hdjs\/images\/nopic.jpg"]
        'preview'  =>  'json',//输入转换为json输出转换为数组（自动）
    ];

    public function goods_sort(){
        return $this->hasMany('GoodsSort','goods_id');
    }

}
