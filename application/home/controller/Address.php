<?php

namespace app\home\controller;

use think\Controller;
use think\Request;
use app\home\model\Address as AddressModel;

class Address extends Common
{
    public function lists(){
        $addressModel = AddressModel::all();
        return view('',compact('addressModel'));
    }

    public function add(){
        if(IS_POST){
            $allAddressModel = AddressModel::all();

            $count = count($allAddressModel);
            //p($allAddressModel);exit;
            if($count>4){///???不应该是>5吗
                $this->error('收货地址最多只能保存5条，请删除后再添加或修改其它的收货地址','addressList');
                exit;
            }

            $post = input('post.');
            $addressModel = new AddressModel;
            $addressModel->recipient = $post['recipient'];
            $addressModel->address = $post['address'];
            $addressModel->phone = $post['phone'];
            //默认地址只能有一个
            //设置了这个的话则把其它的默认地址字段值变成0（不是默认地址）
            if(isset($post['is_default'])){
                foreach ($allAddressModel as $k=>$v){
                    $allAddressModel[$k]->is_default = 0;
                    $allAddressModel[$k]->save();
                }
                $addressModel->is_default = 1;
            }

            $addressModel->save();
            $this->success('添加成功','lists');
        }

        return view();
    }

    public function edit(){
        $id = input('id');
        $addressModel = AddressModel::get($id);
        if(IS_POST){
            $post = input('post.');
            $addressModel->recipient = $post['recipient'];
            $addressModel->address = $post['address'];
            $addressModel->phone = $post['phone'];

            $addressModel->is_default = 0;
            if(isset($post['is_default'])){
                $allAddressModel = AddressModel::all();
                foreach ($allAddressModel as $k=>$v){
                    $allAddressModel[$k]->is_default = 0;
                    $allAddressModel[$k]->save();
                }
                $addressModel->is_default = 1;
            }

            $addressModel->save();
            $this->success('修改成功','lists');
        }

//        $this->assign('addressModel',$addressModel);//这个为什么不行？？？
        return view('',compact('addressModel'));
    }

    public function del(){
        $id = input('id');
        AddressModel::get($id)->delete();
        $this->success('删除成功','lists');
    }

}
