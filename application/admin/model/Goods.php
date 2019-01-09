<?php

namespace app\admin\model;

use think\Config;
use think\Model;

/**
 * This is the model class for table "goods".
 *
 * The followings are the available columns in table 'goods':
 * @property integer $gid
 * @property string $title
 * @property integer $cate_id
 * @property float $market_price
 * @property float $shop_price
 * @property string $slogan
 * @property string $details
 * @property string $preview
 * @property string $list_pic
 * @property integer $is_hot
 * @property integer $is_onsale
 * @property integer $click
 * @property integer $is_recommended
 * @property integer $is_cover
 * @property string $slide
 */
class Goods extends Model
{
    // todo: change bucket
    const DEFAULT_OSS_COVER = 'http://missevan-test.oss-cn-hangzhou.aliyuncs.com/test/images/nopic.jpg';

    public $img_list_pic = self::DEFAULT_OSS_COVER;
    public $img_preview = [];
    public $img_slide;

    protected $type = [
        //以下已经转换成json了
        //["\/node_modules\/hdjs\/images\/nopic.jpg","\/node_modules\/hdjs\/images\/nopic.jpg","\/node_modules\/hdjs\/images\/nopic.jpg"]
        'preview'  =>  'json',//输入转换为json输出转换为数组（自动）
    ];

    public function goods_sort(){
        return $this->hasMany('GoodsSort','goods_id');
    }

    public static function processImg(self $model)
    {
        $publicUrl  = Config::get('oss.publicUrl');
        if ($model->list_pic) {
            $model->img_list_pic = $publicUrl . $model->list_pic;
        }
        if ($model->slide) {
            $model->img_slide = $publicUrl . $model->slide;
        }
        $model->img_preview = array_map(function ($img) use ($publicUrl) {
            return $publicUrl . $img;
        }, $model->preview);

        preg_match_all('/\<img.+?src=\"(.+?)\".*?\>/', $model->details, $match);
        if ($match[1]) {
            $temp = array_map(function ($img) use ($publicUrl) {
                return $publicUrl . $img;
            }, $match[1]);
            $model->details = str_replace($match[1], $temp, $model->details);
        }

        return $model;
    }

}
