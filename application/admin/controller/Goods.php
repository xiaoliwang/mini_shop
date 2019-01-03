<?php

namespace app\admin\controller;

use app\admin\model\GoodsSort;
use think\Controller;
use think\Request;
use app\admin\model\Category;
use app\admin\model\Goods as GoodsModel;
use think\Db;
class Goods extends Common
{
    //商品列表
    public function lists()
    {
//        $goodsModel = new GoodsModel;
//        $goodsData = $goodsModel->select();
        //可以取别名
        $goodsData = Db::table('gf_goods goods')
            ->field('goods.gid,goods.title,count(goods_sort.goods_id) goods_count,goods.list_pic,category.cname')
            ->order('category.cid','asc')
            ->group('goods.title')
            ->join('category','category.cid = goods.cate_id')
            ->join('goods_sort','goods_sort.goods_id = goods.gid')
            ->paginate(5);
//        p($goodsData);exit;
        $goodsCount = count(\app\admin\model\Goods::all());
//        p($goodsCount);exit;
        return view('', compact('goodsData','goodsCount'));
    }

    //商品添加
    public function add()
    {
        if (IS_POST){

            $post = input('post.');
            //添加商品表数据
            $goodsModel = new GoodsModel;
            $goodsModel->title = input('title');
            $goodsModel->cate_id = input('cate_id');
            $goodsModel->list_pic = input('list_pic') ?: '/node_modules/hdjs/images/nopic.jpg';
            $goodsModel->slide = str_replace('\\','/',input('slide'))?:'';

            //处理商品图册preview其中含空时将其设置为默认的图片
            $preview = array_map(function ($v) {
                return $v ?: '/node_modules/hdjs/images/nopic.jpg';
            }, $post['preview']);
            $goodsModel->preview = $preview;

//            $goodsModel->click = 0;
            $goodsModel->market_price = input('market_price');
            $goodsModel->shop_price = input('shop_price');
            $goodsModel->is_hot = input('is_hot')?:0;
            $goodsModel->is_onsale = input('is_onsale')?:0;
            $goodsModel->is_recommended = input('is_recommended')?:0;
            $goodsModel->is_cover = input('is_cover')?:0;
            $goodsModel->slogan = input('slogan');
            $goodsModel->details = input('details');
            $goodsModel->save();

            //添加货品表数据

            //input('goods_sort')传过来的是字符串
            //通过json_decode一次性转成数组（包括数组中的json单元）
            foreach (json_decode(input('goods_sort'), true) as $k => $v):
                $goodsSortModel = new GoodsSort;
                $goodsSortModel->property = $v['property'];
                $goodsSortModel->storage = $v['storage'] ?: 0;
                $goodsSortModel->goods_id = $goodsModel->gid;
                $goodsSortModel->save();
            endforeach;

            $this->success('添加成功', 'lists');
        }

        $cateData = (new Category)->getTreeData();
        return view('', compact('cateData'));
    }


    //商品编辑
    public function edit($gid)
    {
        $goodsModel = GoodsModel::get($gid);
        $goodsSortModel = $goodsModel->goods_sort()->select();
        if (IS_POST) {
            $post = input('post.');
            //修改商品表数据
            $goodsModel->title = input('title');
            $goodsModel->cate_id = input('cate_id');
            $goodsModel->list_pic = input('list_pic') ?: '/node_modules/hdjs/images/nopic.jpg';
            $goodsModel->slide = str_replace('\\','/',input('slide'));


            $preview = array_map(function ($v) {
                return $v ?: '/node_modules/hdjs/images/nopic.jpg';
            }, $post['preview']);
            $goodsModel->preview = $preview;

            $goodsModel->market_price = input('market_price');
            $goodsModel->shop_price = input('shop_price');
            $goodsModel->is_hot = input('is_hot')?:0;
            $goodsModel->is_onsale = input('is_onsale')?:0;
            $goodsModel->is_recommended = input('is_recommended')?:0;
            $goodsModel->is_cover = input('is_cover')?:0;

            $goodsModel->slogan = input('slogan');
            $goodsModel->details = input('details');
            $goodsModel->save();

            //修改货品表数据：删了再增
            $goodsModel->goods_sort()->delete();
            foreach (json_decode(input('goods_sort'), true) as $k => $v):
                $goodsSortModel = new GoodsSort;
                $goodsSortModel->property = $v['property'];
                $goodsSortModel->storage = $v['storage'] ?: 0;
                $goodsSortModel->goods_id = $goodsModel->gid;
                $goodsSortModel->save();
            endforeach;

            $this->success('编辑成功', 'lists');


        }

        $cateData = (new Category)->getTreeData();
        $goodsSortData = json_encode($goodsSortModel, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        return view('', compact('cateData', 'goodsModel', 'goodsSortData'));
    }

    //商品删除
    public function del($gid)
    {
        //要删除的商品对象
        $goodsModel = GoodsModel::get($gid);

        //删除商品对应的全部货品
        $goodsModel->goods_sort()->delete();
        //删除商品
        $goodsModel->destroy($gid);

        //返回消息
        $delMsg = ['msg' => '删除成功', 'status' => true];
        return json_encode($delMsg, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    }
}
