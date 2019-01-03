<?php

namespace app\home\controller;

use app\admin\model\Goods;
use app\home\model\ViewTimes;
use think\Controller;
use think\Request;
use think\Session;

class Cart extends Common {

    /*
     * 显示购物车的商品信息
     */
    public function index() {
        $goodsList = Session::get('cart')['goods'];
        $total['rows'] = Session::get('cart')['total_rows'];
        $total['cost'] = Session::get('cart')['total'];

        $viewGoodsId = ViewTimes::where('uid',session('user')['id'])->field('gid')->select();
        $gidArr = [];
        foreach ($viewGoodsId as $k=>$v){
            $gidArr[]=$v->gid;
        }
//        p($gidArr);
        $viewGoods = Goods::whereIn('gid',$gidArr)->select();
        shuffle($viewGoods);//数组随机排序
        $viewGoods = array_slice($viewGoods,0,5);//只截取前5个

        foreach ($viewGoods as $k=>$v){
            $goodsSort =$v->goods_sort()->find()->toArray();
            $viewGoods[$k]['goodsSort']=$goodsSort;
        }
//        p($viewGoods);




        return view('',compact('goodsList','total','viewGoods'));
    }

    public function add() {
        $post = input('post.');

        //如果在商品详情页的购物中还没有添加同样的商品
        //则返回一个标签添加在购物中
        $newGood = <<<str
<li class="1000123398">
    <a title="{$post['name']}" target="_blank" href="" class="goods_pic">
        <img height="60" src="{$post['thumb']}" widht="60">
    </a>
    <div class="goods_info">
        <a target="_blank" title="" href="" class="goods_tit">{$post['name']}</a>
        <div class="goods_num">
            <i class="price">¥<span>{$post['price']}</span></i>
            ×<i class="num">{$post['num']}</i>
        </div>
    </div>
</li>
str;
        //否则的话则在已经存在的该商品的数量+1
        if(isset(Session::get('cart')['goods'])){
            foreach (Session::get('cart')['goods'] as $v){
                if($v['options'][0]==$post['options']){
                    $newGood = 1;
                }
            }
        }

        $data = [
            'id'      => $post['id'], // 商品 ID
            'name'    => $post['name'],// 商品名称
            'num'     => $post['num'], // 商品数量
            'price'   => $post['price'], // 商品价格
            'options' => [$post['options']],// 其他参数如价格、颜色、可以为数组或字符串
            'gsid' => $post['gsid'],//货品id
            'thumb'   => $post['thumb']//商品缩略图
        ];
        $cart = new \helper\Cart();
        $cart->add( $data );

        return $newGood;exit;
        //$this->success( '添加购物车成功', 'index' );
    }


    /**
     * 修改购物车中商品信息
     */
    public function update( Request $request ) {
        $post = input('post.');
        $Data = [
            "sid" => $post['sid'],                        //商品的唯一SID，不是商品的ID
            "num" => $post['num'],                       //商品数量
        ];
        $cart = new \helper\Cart();
        $cart->update($Data);
        return 1;exit;
       // $this->success('修改成功','index');
    }

    /**
     * 删除购物车中商品信息
     */
    public function delete() {
        $cart = new \helper\Cart();
        $cart->flush();
        $this->success( 'yes', 'index' );
    }


    public function moreInfo(){
        $cart = new \helper\Cart();
        $data = $cart->getOrderId();
        p($data);exit;
    }
}
