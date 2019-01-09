<?php

namespace app\admin\controller;

use think\Controller;
use think\Request;
use app\admin\model\Category as CategoryModel;
use think\View;
use think\Session;

class Category extends Common
{
    //栏目列表
    public function lists()
    {
        //获得树状层级的栏目项
        $cateData = (new CategoryModel)->getTreeData();

        $total['categoryNum'] = count(CategoryModel::all());
        $total['goodsNum'] = count(\app\admin\model\Goods::all());
        return view()->assign(compact('cateData','total'));
    }

    //添加栏目
    public function add()
    {
        //获得树状层级的栏目项
        $cateData = (new CategoryModel)->getTreeData();

        if (request()->isPost()) {
            $post = input('post.');

            //验证栏目名
            $validate = \think\Loader::validate('Category');
            if(!$validate->check($post)){
                Session::flash('addCateError',$validate->getError());
            }else{
                $cateModel = new CategoryModel;
                $cateModel->pid = $post['pid'];
                $cateModel['cname']=$post['cname'];
                $cateModel->save();

                $this->success('添加成功',url('lists'));
            }
        }

        return view()->assign(compact('cateData'));
    }

    //编辑栏目
    public function edit(Request $request)
    {
        $CategoryModel = new CategoryModel;
        //获得当前栏目及其子栏目不可选的层级树状栏目项
        $cateData = $CategoryModel->getNoneMine(input('cid'));
        //获得当前编辑的栏目项
        $editCate = $CategoryModel->get(input('cid'));

        if (request()->isPost()) {
            $post = input('post.');

            $editCate->pid = $post['pid'];
            $editCate['cname']=$post['cname'];
            $editCate->save();

            $this->success('编辑成功',url('lists'));
        }

        return view()->assign(compact('cateData','editCate'));
    }

    //删除栏目
    public function del()
    {
        $childData = (new CategoryModel)->where('pid',input('cid'))->find();
        if ($childData) {
            $delMsg = ['msg'=>'该栏目下包含子栏目，请先删除其中的子栏目后再删除该栏目','status'=>false];
            return json_encode($delMsg,JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES);
        }
        CategoryModel::destroy(input('cid'));

        $delMsg = ['msg'=>'删除成功','status'=>true];
        return json_encode($delMsg,JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES);
    }

}
