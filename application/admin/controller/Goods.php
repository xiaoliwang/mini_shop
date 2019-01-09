<?php

namespace app\admin\controller;

use app\admin\model\GoodsSort;
use helper\OssClient;
use helper\Util;
use think\Config;
use think\Controller;
use think\Request;
use app\admin\model\Category;
use app\admin\model\Goods as GoodsModel;
use think\Db;

class Goods extends Common
{
    // 商品列表
    public function lists()
    {
        $goodsData = Db::table('gf_goods goods')
            ->field('goods.gid,goods.title,count(goods_sort.goods_id) goods_count,goods.list_pic,category.cname')
            ->order('category.cid', 'asc')
            ->group('goods.title')
            ->join('category', 'category.cid = goods.cate_id')
            ->join('goods_sort', 'goods_sort.goods_id = goods.gid')
            ->paginate(5);

        return view('', compact('goodsData'));
    }

    //商品添加
    public function add()
    {
        if (IS_POST) {
            // 添加商品表数据
            $goodsModel = new GoodsModel;
            $goodsModel->title = input('title');
            $goodsModel->cate_id = input('cate_id');

            // 处理商品图册 preview 其中含空时将其设置为默认的图片
            $post = input('post.');
            $list_pic = input('list_pic') ?: Util::DEFAULT_COVER;
            $slide = str_replace('\\', '/', input('slide'));

            $temp = [];
            $oss = OssClient::instance();
            foreach ($post['preview'] as $img) {
                if (!$img) continue;
                if (Util::DEFAULT_COVER !== $img && strpos($img, '/uploads/') === 0) {
                    $local_file = Util::getRoot() . $img;
                    $remote_path = 'goods/preview/' . Util::generateFilePath($local_file);
                    $oss->upload($local_file, $remote_path);
                    $temp[] = $remote_path;
                } else {
                    $temp[] = $img;
                }
            }
            if ($temp) {
                $goodsModel->preview = $temp;
            }
            if ($list_pic && Util::DEFAULT_COVER !== $list_pic) {
                $local_file = Util::getRoot() . $list_pic;
                $remote_path = 'goods/list_pic/' . Util::generateFilePath($local_file);
                $oss->upload($local_file, $remote_path);
                $goodsModel->list_pic = $remote_path;
            }
            if ($slide && Util::DEFAULT_COVER !== $slide) {
                $local_file = Util::getRoot() . $slide;
                $remote_path = 'goods/slide/' . Util::generateFilePath($local_file);
                $oss->upload($local_file, $remote_path);
                $goodsModel->slide = $remote_path;
            }

            $goodsModel->market_price = input('market_price');
            $goodsModel->shop_price = input('shop_price');
            $goodsModel->is_hot = input('is_hot') ?: 0;
            $goodsModel->is_onsale = input('is_onsale') ?: 0;
            $goodsModel->is_recommended = input('is_recommended') ?: 0;
            $goodsModel->is_cover = input('is_cover') ?: 0;
            $goodsModel->slogan = input('slogan');
            $goodsModel->details = input('details');
            $goodsModel->save();

            // 添加货品表数据

            // input('goods_sort') 传过来的是字符串
            // 通过 json_decode 一次性转成数组（包括数组中的 json 单元）
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

// 商品编辑
/*
Array
(
    [cate_id] => 1
    [title] => kkk
    [shop_price] => 11.00
    [market_price] => 1.00
    [is_onsale] => 0
    [is_hot] => 0
    [is_recommended] => 0
    [is_cover] => 0
    [slide] =>
    [list_pic] => goods/list_pic/201901/09/79476300fa18a33f840b4a775cb965f8103926.jpg
    [preview] => Array
        (
            [0] => /node_modules/hdjs/images/nopic.jpg
            [1] => /node_modules/hdjs/images/nopic.jpg
            [2] => /node_modules/hdjs/images/nopic.jpg
        )

    [slogan] =>
    [details] =>
    [goods_sort] => [
  {
    "gsid": 195,
    "property": "10",
    "storage": 1,
    "goods_id": 53
  }
]
)
*/
    public function edit($gid)
    {
        $goodsModel = GoodsModel::get($gid);
        $goodsSortModel = $goodsModel->goods_sort()->select();
        if (IS_POST) {
            // 修改商品表数据
            $goodsModel->title = input('title');
            $goodsModel->cate_id = input('cate_id');

            $post = input('post.');
            $list_pic = input('list_pic') ?: Util::DEFAULT_COVER;
            $slide = str_replace('\\', '/', input('slide'));

            $temp = [];
            $oss = OssClient::instance();
            foreach ($post['preview'] as $img) {
                if (!$img) continue;
                if (Util::DEFAULT_COVER !== $img && strpos($img, '/uploads/') !== false) {
                    $local_file = Util::getRoot() . $img;
                    $remote_path = 'goods/preview/' . Util::generateFilePath($local_file);
                    $oss->upload($local_file, $remote_path);
                    $temp[] = $remote_path;
                } else {
                    $temp[] = $img;
                }
            }
            if ($temp) {
                $goodsModel->preview = $temp;
            }
            if ($list_pic && $list_pic !== $goodsModel->list_pic) {
                $local_file = Util::getRoot() . $list_pic;
                $remote_path = 'goods/list_pic/' . Util::generateFilePath($local_file);
                $oss->upload($local_file, $remote_path);
                $goodsModel->list_pic = $remote_path;
            }
            if ($slide && $slide !== $goodsModel->slide) {
                $local_file = Util::getRoot() . $slide;
                $remote_path = 'goods/slide/' . Util::generateFilePath($local_file);
                $oss->upload($local_file, $remote_path);
                $goodsModel->slide = $remote_path;
            }

            $goodsModel->market_price = input('market_price');
            $goodsModel->shop_price = input('shop_price');
            $goodsModel->is_hot = input('is_hot') ?: 0;
            $goodsModel->is_onsale = input('is_onsale') ?: 0;
            $goodsModel->is_recommended = input('is_recommended') ?: 0;
            $goodsModel->is_cover = input('is_cover') ?: 0;

            $goodsModel->slogan = input('slogan');

            $details = input('details');

            preg_match_all('/\<img.+?src=\"(.+?)\".*?\>/', $details, $match);
            if ($match[1]) {
                $temp = $match[1];
                file_put_contents('t.log', print_r($match[1], true));
                foreach ($temp as &$img) {
                    $img = str_replace(Config::get('oss.publicUrl'), '', $img);
                    if (strpos($img, 'uploads/') !== false) {
                        $local_file = Util::getRoot() . $img;
                        $remote_path = 'goods/details/' . Util::generateFilePath($local_file);
                        $oss->upload($local_file, $remote_path);
                        $img = $remote_path;
                    }
                }

                $details = str_replace($match[1], $temp, $details);
            }

            $goodsModel->details = $details;
            $goodsModel->save();

            // 修改货品表数据：删了再增
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

        GoodsModel::processImg($goodsModel);
        $cateData = (new Category)->getTreeData();
        $goodsSortData = json_encode($goodsSortModel, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        return view('', compact('cateData', 'goodsModel', 'goodsSortData'));
    }

    // 商品删除
    public function del($gid)
    {
        // 要删除的商品对象
        $goodsModel = GoodsModel::get($gid);

        // 删除商品对应的全部货品
        $goodsModel->goods_sort()->delete();
        // 删除商品
        $goodsModel->destroy($gid);

        // 返回消息
        $delMsg = ['msg' => '删除成功', 'status' => true];
        return json_encode($delMsg, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    }

}
