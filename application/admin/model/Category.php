<?php
//栏目数据模型
namespace app\admin\model;
use think\Db;
use think\Model;

class Category extends Model
{
    public function getTreeData(){
        $cateData =  Db::table('gf_category category')
            ->field('category.*,count(goods.gid) goods_count')
            ->order('category.cid','asc')
            ->group('category.cid')
            ->join('goods','category.cid = goods.cate_id','left')
            ->select();
        //或 $cateData = db('category')->select();
        return $this->treeSort($cateData);
    }

    //分类形成树形结构（无限级分类）
    public function treeSort($data,$pid=0,$level=0){
        static $arr=[];
        foreach ($data as $v):
            if($v['pid']==$pid){
                $v['level']=$level;
                $v['_cname']=str_repeat('&nbsp;',$level*5).($level?'┗':'').($level?str_repeat('─',$level):'').$v['cname'];
                $arr[]=$v;
                $this->treeSort($data,$v['cid'],$level+1);
            }
        endforeach;
        return $arr;
    }



    //获得当前栏目及其子栏目不可选的栏目项
    public function getNoneMine($cid){
        $cateData = $this->getTreeData();
        foreach ($cateData as $k=>$v){
            $cateData[$k]['_disabled']='';
            if($v['cid']==$cid){//使当前的栏目不可选作为父栏目
                $cateData[$k]['_disabled']='disabled';
            }
        }
        return $this->disableChild($cateData,$cid);
    }
    public function disableChild($cateData,$pid){
        foreach ($cateData as $k=>$v):
           //使当前栏目下的子栏目不可选
            if($v['pid']==$pid){
                $cateData[$k]['_disabled']='disabled';
                $cateData = $this->disableChild($cateData,$v['cid']);
            }
        endforeach;
        return $cateData;
    }


}
