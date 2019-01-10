<?php

namespace app\home\model;

use think\Model;

/**
 * This is the model class for table "goods_comment".
 *
 * The followings are the available columns in table 'goods_comment':
 * @property integer $id
 * @property string $content
 * @property integer $goods_id
 * @property integer $user_id
 * @property integer $star
 * @property integer $create_time
 */
class GoodsComment extends Model
{
    public static function model()
    {
        return new self;
    }

}
