<?php
namespace app\home\controller;

use app\admin\model\Category;
use app\admin\model\Goods;
use app\home\model\GoodsComment;
use app\home\model\SearchWords;
use app\home\model\ViewTimes;
use think\Config;
use think\Cookie;
use think\Db;
use think\Session;
class Entry
{
    public function index()
    {
        $cartList = Session::get('cart.goods');
        $cartTotal['rows'] = Session::get('cart.total_rows');
        $cartTotal['cost'] = Session::get('cart.total');

        $goods = Goods::model()->where('is_onsale', 1)->paginate(6);

        return view('', compact('cartList', 'cartTotal', 'goods'));
    }

    public function lists()
    {
        $cid = input('cid');
        $cateModel = Category::get($cid);

        if ($cateModel['pid']==0) {
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

    public function details()
    {
        $gid =  input('gid');
        $goodsModel = Goods::get($gid);
        $goodsModel->setInc('click');//自增1，不用save
        Goods::processImg($goodsModel);

        $uid = Session::get('user')['id'];
        if ($uid) {
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

        $comments = Db::table('gf_goods_comment comment')
            ->where('comment.goods_id', $gid)
            ->field('comment.content, comment.star, comment.create_time, users.username, users.avatar')
            ->order('comment.id', 'DESC')
            ->join('users', 'comment.user_id = users.id')
            ->paginate(5);
        $count = GoodsComment::model()->where('goods_id', $gid)->count();
        $avg_star = ceil(GoodsComment::where('goods_id', $gid)->avg('star'));

        return view('',compact('goodsModel','goodsSort','cartList','cartTotal','cateData', 'comments', 'count', 'avg_star'));
    }

    public function getmorecomments()
    {
        $gid =  input('gid');
        $page = input('page');
        $comments = Db::table('gf_goods_comment comment')
            ->where('comment.goods_id', $gid)
            ->field('comment.content, comment.star, comment.create_time, users.username, users.avatar')
            ->order('comment.id', 'DESC')
            ->join('users', 'comment.user_id = users.id')
            ->limit(5 * ($page - 1))
            ->paginate(5)->toArray();
        $comments['data'] = array_map(function ($comment) {
            $comment['create_time'] = date('Y-m-d H:i:s', $comment['create_time']);
            $comment['avatar'] = Config::get('oss.publicUrl') . $comment['avatar'];
            return $comment;
        }, $comments['data']);
        return [
            'success' => true,
            'info' => $comments,
        ];
    }

    public function search()
    {
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

    public function join()
    {
        return view('');
    }

}
