<?php

namespace app\home\controller;

use app\admin\model\Goods;
use app\admin\model\GoodsSort;
use app\home\model\Address;
use app\home\model\GoodsComment;
use think\Controller;
use think\Db;
use think\Session;
use app\home\model\Order as OrderModel;
use app\home\model\OrderItems;

class Order extends Common
{
    public function lists()
    {
        $user_id = Session::get('user.id');
        $orderModel = OrderModel::where('user_id',$user_id);

        switch (input('status')){
            case 'topay':
                $orderModel->where('status','待付款');
                break;
            case 'toreceive':
                $orderModel->where('status','待收货');
                break;
            case 'toreview':
                $orderModel->where('status','待评价');
                break;
            case 'done':
                $orderModel->where('status','已完成');
                break;
        }
        $orderModel = $orderModel->paginate(1);

        foreach ($orderModel as $k => $v) {
            $orderItems = $v->order_items()->select();

            foreach ($orderItems as $m => $n) {
                $GoodsSortModel = GoodsSort::where('gsid',$n->goods_sort_id)->find();

                $orderItems[$m]['property'] = $GoodsSortModel->property;

                $goods_id = $GoodsSortModel->goods_id;
                $GoodsModel = Goods::where('gid',$goods_id)->find();

                $orderItems[$m]['gid'] = $goods_id;
                $orderItems[$m]['title'] = $GoodsModel->title;
                $orderItems[$m]['thumb'] = $GoodsModel->list_pic;
                $orderItems[$m]['market_price'] = $GoodsModel->market_price;
                $orderItems[$m]['shop_price'] = $GoodsModel->shop_price;
            }

            $orderModel[$k]['items'] = $orderItems;
        }

        return view('', compact('orderModel'));
    }

    public function confirm()
    {
        if (request()->isPost()) {
            $post = input('post.');
            //p($post);exit;
            $orderModel = new OrderModel;


            $cart = new \helper\Cart();
            $orderModel->order_num = $cart->getOrderId();
            $orderModel->total_price = Session::get('cart.total');
            $orderModel->address_id = $post['address_id'];
            $orderModel->user_id = Session::get('user.id');
            $orderModel->memo = $post['memo'];
            $orderModel->order_time = time();
            $orderModel->save();

            foreach ($post['goods_sort_id'] as $k => $v){
                $orderItemsModel = new OrderItems;
                $orderItemsModel->order_id = $orderModel->id;
                $orderItemsModel->total_sub_price = $post['total_sub_price'][$k];
                $orderItemsModel->num = $post['num'][$k];
                $orderItemsModel->goods_sort_id = $post['goods_sort_id'][$k];
                $orderItemsModel->save();
            }

            $cart->flush();
            $this->success('订单提交成功','lists');
        }


        $goodsList = Session::get('cart.goods');
        $total['rows'] = Session::get('cart.total_rows');
        $total['cost'] = Session::get('cart.total');

        //按is_default降序（让默认地址排在最前面）
        $addressData = Address::where('user_id', Session::get('user.id'))
            ->order('is_default','desc')
            ->select();
        if (!$addressData) {
            $this->error('您还未设置收货地址', '/home/address/add');
        }
        return view('',compact('goodsList','total','addressData'));
    }


    public function details()
    {
        $id = input('id');
        $orderModel = OrderModel::get(['id' => $id, 'user_id' => Session::get('user.id')]);
        $orderItems = $orderModel->order_items()->select();

        foreach ($orderItems as $m=>$n) {
            $GoodsSortModel = GoodsSort::where('gsid',$n->goods_sort_id)->find();

            $orderItems[$m]['property'] = $GoodsSortModel->property;

            $goods_id = $GoodsSortModel->goods_id;
            $GoodsModel = Goods::where('gid',$goods_id)->find();

            $orderItems[$m]['gid'] = $goods_id;
            $orderItems[$m]['title'] = $GoodsModel->title;
            $orderItems[$m]['thumb'] = $GoodsModel->list_pic;
            $orderItems[$m]['market_price'] = $GoodsModel->market_price;
            $orderItems[$m]['shop_price'] = $GoodsModel->shop_price;
        }
        $orderModel['items'] = $orderItems;

        $addressModel = Address::where('id',$orderModel->address_id)->find();
        $orderModel['address'] = $addressModel->address;
        $orderModel['phone'] = $addressModel->phone;
        $orderModel['recipient'] = $addressModel->recipient;

        return view('',compact('orderModel'));
    }

    public function pay()
    {
        $id = input('id');
        $orderModel = OrderModel::get(['id' => $id, 'user_id' => Session::get('user.id')]);

        if (request()->isPost()) {
            //支付成功
            $orderModel->status = '已付款，未发货';
            $orderModel->save();
            $orderItemsModel = $orderModel->order_items()->select();
            foreach ($orderItemsModel as $k=>$v){
                GoodsSort::where('gsid',$v['goods_sort_id'])->setDec('storage',$v['num']);
            }
            $this->success('支付成功，跳转至订单页面...','lists');
        }

        return view('',compact('orderModel'));
    }

    public function cancel()
    {
        $id = input('id');
        $reason = input('reason');

        $orderModel = OrderModel::get(['id' => $id, 'user_id' => Session::get('user.id')]);

        Db::name('reason_of_cancel_order')->insert(['reason'=>$reason]);

        $orderModel->order_items()->delete();
        $orderModel->delete();

        $this->success('取消成功','lists');
    }

    public function del()
    {
        $id = input('id');
        $orderModel = OrderModel::get(['id' => $id, 'user_id' => Session::get('user.id')]);
        $orderModel->order_items()->delete();
        $orderModel->delete();
        $this->success('删除成功','lists');
    }

    public function comment()
    {
        $orderId = input('order_id');
        $commentContent = input('comment');
        $star = input('star');

        $user_id = Session::get('user.id');

        $items = OrderItems::all(['order_id' => $orderId]);
        $goodsSortIds = array_column($items, 'goods_sort_id');
        $goodsIds = array_column(GoodsSort::all($goodsSortIds), 'goods_id');

        $now = $_SERVER['REQUEST_TIME'];
        foreach ($goodsIds as $good_id) {
            $comment = new GoodsComment();
            $comment->goods_id = $good_id;
            $comment->user_id = $user_id;
            $comment->content = $commentContent;
            $comment->star = $star;
            $comment->create_time = $now;
            $comment->save();
        }
        OrderModel::where(['id' => $orderId, 'user_id' => Session::get('user.id')])->update(['status' => '已完成']);

        return [
            'success' => true,
            'info' => '评价成功',
        ];
    }

}
