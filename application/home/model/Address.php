<?php

namespace app\home\model;

use think\Model;

class Address extends Model
{
    const MAX_COUNT = 4;

    public static function model()
    {
        return new self;
    }

}
