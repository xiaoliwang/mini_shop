<?php

namespace app\home\model;

use think\Model;

/**
 * This is the model class for table "goods".
 *
 * The followings are the available columns in table 'goods':
 * @property integer $id
 * @property string $username
 * @property string $password
 * @property string $mail
 * @property string $avatar
 */
class Users extends Model
{
    // todo: add salt to password
    const PWD_SALT = 'mini_shop';

    const DEFAULT_AVATAR = '/static/home/login/images/member_head.jpg';
}
