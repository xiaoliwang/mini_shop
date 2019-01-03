<?php

namespace app\home\common\taglib;
use app\admin\model\Goods;
use think\template\TagLib;

class Tags extends TagLib
{
    protected $tags = [
        'category' => ['attr' => 'pid,cid,rows', 'close' => 1],
        'goods' => ['attr' => 'hot,sale,click,cate,rows', 'close' => 1],
        'childgoods' => ['attr' => 'hot,sale,click,cate,rows', 'close' => 1],
        'allgoods' => ['attr' => 'hot,sale,click,cate,rows', 'close' => 1],
        'hotwords' => ['attr' => 'hot,sale,click,cate,rows', 'close' => 1],
    ];

    public function tagCategory($tag, $content)
    {
        $cid = isset($tag['cid'])?$tag['cid']:'';
        $pid = isset($tag['pid'])?$tag['pid']:0;

        $rows = isset($tag['rows'])?$tag['rows']:100;
        $arr = explode(',',$rows);
        if(count($arr)>1){
            $rows = $arr[0].",".$arr[1];
        }

        if(!empty($cid)){
            $where = "'cid',$cid";
        }else{
            $where = "'pid',$pid";
        }
        $str = <<<str
<?php
\$cateModelTag = new \app\admin\model\Category;
\$cateDataTag = \$cateModelTag->where($where)->limit($rows)->select();
foreach (\$cateDataTag as \$k=>\$field):
\$field['num']=\$k+1;
\$field['url']="/home/entry/lists/cid/".\$field['cid'];
?>
$content
<?php endforeach;?>
str;

        return $str;
    }



    public function tagGoods($tag,$content){
        $hot = isset($tag['hot']);
        $sale = isset($tag['sale']);
        $click = isset($tag['click'])?1:0;
        $cateid = isset($tag['cate'])?$tag['cate']:'';
        $recommend = isset($tag['recommend'])?$tag['recommend']:'';
        $cover = isset($tag['cover'])?$tag['cover']:'';

        $rows = isset($tag['rows'])?$tag['rows']:100;
        $arr = explode(',',$rows);
        if(count($arr)>1){
            $rows = $arr[0].",".$arr[1];
        }

        $where = '';
        if($hot){
            $where = "'is_hot',1";
        }
        if($sale){
            $where = "'is_onsale',1";
        }
        if($cateid){
            $where = "'cate_id',$cateid";
        }
        if($recommend){
            $where = "'is_recommended',1";
        }
        if($cover){
            $where = "'is_cover',1";
        }
//以下命令为$goodsDataTag为避免和控制器中分配的变量名冲突
//上述定义的$cateDataTag也是一样
        $str  = <<<str
<?php
\$goodsModelTag = new \app\admin\model\Goods;
if($click){
    \$goodsDataTag =\$goodsModelTag->order('click desc')->limit($rows)->select();
}else{
    \$goodsDataTag = \$goodsModelTag->where($where)->limit($rows)->select();
}
foreach(\$goodsDataTag as \$k=>\$field):
\$field['num']=\$k+1;
\$field['url']="/home/entry/details/gid/".\$field['gid'];
?>
$content
<?php endforeach;?>
str;
        return $str;
    }

    //获取顶级栏目下的子栏目中的商品数据
    public function tagChildgoods($tag,$content){
        $cateid = isset($tag['cate'])?$tag['cate']:'';
        $rows = isset($tag['rows'])?$tag['rows']:100;
        $str = <<<str
<?php
\$subCateModel = \app\admin\model\Category::where('pid',$cateid)->select();
\$subCidArr = [];
foreach (\$subCateModel as \$v){
    \$subCidArr[]=\$v['cid'];
}
\$goodsData = \app\admin\model\Goods::whereIn('cate_id',\$subCidArr)->order('click desc')->limit($rows)->select();
foreach(\$goodsData as \$k=>\$field):
\$field['num'] = \$k+1;
\$field['url']="/home/entry/details/gid/".\$field['gid'];
?>
$content
<?php endforeach;?>
str;
        return $str;
    }

    //所有栏目中的商品数据
    public function tagAllgoods($tag,$content){
        $hot = isset($tag['hot']);
        $sale = isset($tag['sale']);
        $click = isset($tag['click'])?1:0;
        $recommend = isset($tag['recommend'])?$tag['recommend']:0;
        $cover = isset($tag['cover'])?$tag['cover']:0;
        $slide = isset($tag['slide'])?$tag['slide']:0;

        $rows = isset($tag['rows'])?$tag['rows']:100;
        $arr = explode(',',$rows);
        if(count($arr)>1){
            $rows = $arr[0].",".$arr[1];
        }

        $where = "1,1";
        if($hot){
            $where = "'is_hot',1";
        }
        if($sale){
            $where = "'is_onsale',1";
        }
        if($recommend){
            $where = "'is_recommended',1";
        }
        if($cover){
            $where = "'is_cover',1";
        }
        if($slide){
            $where = "'slide','neq',''";
        }
        $subCateModel = \app\admin\model\Category::where('pid','in','1,2')->select();
        $subCidArr = '';
        foreach ($subCateModel as $v){
            $subCidArr.=$v['cid'].',';
        }
        $subCidArr = rtrim($subCidArr,',');


        $str  = <<<str
<?php

\$goodsModelTag = new \app\admin\model\Goods;

if($click){
    \$goodsDataTag =\$goodsModelTag->order('click desc')->where('cate_id','not in',"$subCidArr")->limit($rows)->select();
}else{
    \$goodsDataTag = \$goodsModelTag->where($where)->where('cate_id','not in',"$subCidArr")->limit($rows)->select();
}
if($slide){
    \$goodsDataTag =\$goodsModelTag->order('click desc')->where($where)->limit($rows)->select();
}

foreach(\$goodsDataTag as \$k=>\$field):
\$field['num']=\$k+1;
\$field['url']="/home/entry/details/gid/".\$field['gid'];
?>
$content
<?php endforeach;?>
str;
        return $str;
    }


    public function tagHotwords($tag,$content){
        $rows = isset($tag['rows'])?$tag['rows']:100;
        $str = <<<str
<?php
\$searchWordsData = \app\home\model\SearchWords::order('times desc')->limit($rows)->select();
foreach(\$searchWordsData as \$k=>\$field):
\$field['num'] = \$k+1;
\$field['url'] = '/home/entry/search?sword='.\$field['search_word'];
?>
$content
<?php endforeach;?>
str;
        return $str;
    }

}