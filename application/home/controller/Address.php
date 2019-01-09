<?php

namespace app\home\controller;

use think\Controller;
use think\Request;
use app\home\model\Address as AddressModel;
use think\Session;

class Address extends Common
{
    public function lists()
    {
        $addressModel = AddressModel::all(['user_id' => Session::get('user.id')]);
        return view('', compact('addressModel'));
    }

    public function add()
    {
        if (request()->isPost()) {
            $count = AddressModel::model()->where('user_id', Session::get('user.id'))->count();
            if ($count > AddressModel::MAX_COUNT) {
                $this->error('收货地址最多只能保存5条，请删除后再添加或修改其它的收货地址', 'addressList');
                return;
            }

            $post = input('post.');
            $addressModel = new AddressModel;
            $addressModel->recipient = $post['recipient'];
            $addressModel->address = $post['address'];
            $addressModel->phone = $post['phone'];
            // 默认地址只能有一个
            // 设置了这个的话则把其它的默认地址字段值变成0（不是默认地址）
            if ($post['is_default'] ?? 0) {
                AddressModel::where('id', Session::get('user.id'))
                    ->update(['is_default' => 0]);
                $addressModel->is_default = 1;
            }

            $addressModel->save();
            $this->success('添加成功', 'lists');
        }

        return view();
    }

    public function edit()
    {
        $id = input('id');
        $addressModel = AddressModel::get(['id '=> $id, 'user_id' => Session::get('user.id')]);
        if (!$addressModel) {
            $this->error('该收货地址不存在', 'lists');
        }
        if (request()->isPost()) {
            $post = input('post.');
            $addressModel->recipient = $post['recipient'];
            $addressModel->address = $post['address'];
            $addressModel->phone = $post['phone'];

            $addressModel->is_default = 0;
            if ($post['is_default'] ?? 0) {
                AddressModel::where('id', Session::get('user.id'))
                    ->update(['is_default' => 0]);
                $addressModel->is_default = 1;
            }

            $addressModel->save();
            $this->success('修改成功', 'lists');
        }

        return view('', compact('addressModel'));
    }

    public function del()
    {
        $id = input('id');
        AddressModel::get($id)->delete();
        $this->success('删除成功', 'lists');
    }

}
