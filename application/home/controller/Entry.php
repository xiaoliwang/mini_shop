<?php
namespace app\home\controller;

use app\admin\model\Category;
use app\admin\model\Goods;
use app\home\model\SearchWords;
use app\home\model\ViewTimes;
use think\Cookie;
use think\Session;
class Entry
{
    public function index()
    {
//        $goodsData = Category::limit(1,2)->select();
//        p($goodsData);exit;

        $cartList = Session::get('cart')['goods'];
        $cartTotal['rows'] = Session::get('cart')['total_rows'];
        $cartTotal['cost'] = Session::get('cart')['total'];
        return view('',compact('cartList','cartTotal'));
    }

    public function lists(){
        $cid = input('cid');
        $cateModel = Category::get($cid);

        if($cateModel['pid']==0){
            //如果所点击的栏目为顶级栏目
            //则列表页中显示该栏目下的所有栏目的商品数据
            $cateData['pname'] = '';//获得当前栏目的父级栏目名(顶级栏目没有父栏目名则赋值为空)
            $subCateModel = Category::where('pid',$cid)->select();//获取顶级栏目的子栏目
            $subCidArr = [];//获取子栏目的cid集合
            foreach ($subCateModel as $v){
                $subCidArr[]=$v['cid'];
            }

            $goodsData = Goods::whereIn('cate_id',$subCidArr)->paginate(8); //获取所有子栏目中的商品数据
        }else{
            //如果所点击的栏目不是顶级栏目
            //则显示该栏目中的所有商品数据
            $cateData['pname'] = Category::where('cid',$cateModel['pid'])->find()->cname;//获得当前栏目的父级栏目名
            $goodsData = Goods::where('cate_id',$cid)->paginate(8);
        }
        foreach ($goodsData as $k=>$v){
            $goodsSort =$v->goods_sort()->find()->toArray();
            $goodsData[$k]['goodsSort']=$goodsSort;
        }


        $cartTotal['rows'] = Session::get('cart')['total_rows'];
        $cateData['cid'] = $cid;
        $cateData['pid'] = $cateModel['pid'];
        $cateData['cname'] = $cateModel['cname'];//获得当前栏目名
        return view('',compact('goodsData','cateData','cartTotal'));
    }

    public function details(){
        $gid =  input('gid');
        $goodsModel = Goods::get($gid);
        $goodsModel->setInc('click');//自增1，不用save

        $uid = Session::get('user')['id'];
        if($uid){
//            echo 2222;
            $viewTimesModel = ViewTimes::where('gid',$gid)->find();
            if($viewTimesModel){
                $viewTimesModel->setInc('times');
            }else{
                (new ViewTimes)->insert(['uid'=>$uid,'gid'=>$gid]);
            }
        }



        $cateData = Category::where('cid',$goodsModel['cate_id'])->find();
        $cateData['pname']='';
        if($cateData['pid']!=0){
            $cateData['pname'] = Category::where('cid',$cateData['pid'])->find()->cname;
        }

        $goodsSort = $goodsModel->goods_sort()->select();

        $cartList = Session::get('cart')['goods'];
        $cartTotal['rows'] = Session::get('cart')['total_rows'];
        $cartTotal['cost'] = Session::get('cart')['total'];

        return view('',compact('goodsModel','goodsSort','cartList','cartTotal','cateData'));
    }

    public function search(){
        $sword = input('sword');
        Cookie::set('sword',$sword,180);
        $goodsData = Goods::where('title','like',"%$sword%")->paginate(8);
        $count = count(Goods::where('title','like',"%$sword%")->select());

        foreach ($goodsData as $k=>$v){
            $goodsSort =$v->goods_sort()->find()->toArray();
            $goodsData[$k]['goodsSort']=$goodsSort;
        }


        $searchWordsModel = SearchWords::where('search_word',$sword)->find();
        if($searchWordsModel){
            $searchWordsModel->setInc('times');
        }else{
            (new SearchWords)->insert(['search_word'=>$sword]);
        }

        $cartTotal['rows'] = Session::get('cart')['total_rows'];
        return view('',compact('cartTotal','goodsData','count'));
    }


    public function search_ajax(){
        $sword = input('sword');
        if(!empty($sword)){
            $goodsData = Goods::where('title','like',"%$sword%")->limit(10)->select();
            if($goodsData){
                $reArr = [];
                foreach ($goodsData as $k=>$v):
                    $item = ['key'=>$v['title']];
                    $reArr[] = $item;
                endforeach;
                $json = json_encode($reArr,JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES);
            }else{
                $json = json_encode([['key'=>'未找到相关结果，请尝试输入其它关键词']],JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES);
            }
        }else{
            $json = "{}";
        }

        return $json;exit;
    }


}
