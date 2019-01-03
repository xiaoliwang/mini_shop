<?php

namespace app\home\model;

use think\Model;

class Order extends Model
{
    public function order_items(){
        return $this->hasMany('OrderItems','order_id');
    }
}
