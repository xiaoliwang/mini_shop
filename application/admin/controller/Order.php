<?php

namespace app\admin\controller;

use app\home\model\Users;
use think\Controller;
use app\home\model\Order as OrderModel;
use app\admin\model\GoodsSort;
use app\admin\model\Goods;
use app\home\model\Address;

class Order extends Controller
{
    //订单列表
    public function lists(){
        $orderModel = OrderModel::all();
        return view('',compact('orderModel'));
    }

    public function changeStatus()
    {
        $id = input('id');
        $orderModel = OrderModel::get($id);

        if (request()->isPost()) {
            $orderModel['status'] = input('post.status');
            //这里的save操作如果放在review结尾前，则下面的一些赋值操作也将作为save保存，会出现异常情况
            //如果items字段不存在
            //其实最好重新实例化一个OrderModel类再保存
            $orderModel->save();
            $this->success('更改成功，信息将在前台用户订单中心显示','lists');
        }

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
        $orderModel['username'] = Users::where('id',$orderModel['user_id'])->find()->username;

        return view('',compact('orderModel'));
    }

}
