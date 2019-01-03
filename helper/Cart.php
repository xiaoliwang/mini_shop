<?php namespace helper;

use think\Session;

/**
 * 购物车处理类
 * Class Cart
 *
 * @package Hdphp\Cart
 * 修复者    [马震宇] <[<410004417@qq.com>]>
 */
class Cart {

	public $cartName = 'cart';


	/**
	 * 添加购物车
	 *
	 * @access  public
	 *
	 * @param array $data
	 *      <code>
	 *      $data为数组包含以下几个值
	 *      $Data=array(
		 *      "id"=>1,                        //商品ID
		 *      "name"=>"后盾网2周年西服",         //商品名称
		 *      "num"=>2,                       //商品数量
		 *      "price"=>188.88,                //商品价格
		 *      "options"=>array(               //其他参数，如价格、颜色可以是数组或字符串|可以不添加
		 *      "color"=>"red",
		 *      "size"=>"L"
	 *      )
	 *      </code>
	 *
	 * @return void
	 */




	public function add( $data ) {

		//$data为数组
		//$data = ['id'=>'','name'=>','num'=>''];
		if ( ! is_array( $data ) || ! isset( $data['id'] ) || ! isset( $data['name'] ) || ! isset( $data['num'] ) || ! isset( $data['price'] ) ) {
			exit( '购物车ADD方法参数设置错误' );
		}
		//???$data[0]
		//如果$data中存在一个元素则不改变$data
		//否则变成二维数组？？？
		$data  = isset( $data[0] ) ? $data : array( $data );
		$goods = $this->getGoods(); //获得购物车已有的商品数据
		
		//添加商品增持【多】商品添加
		foreach ( $data as $v ) {
			$options = isset( $v['options'] ) ? $v['options'] : '';
			$sid     = substr( md5( $v['id'] . serialize( $options ) ), 0, 8 ); //生成维一ID用于处理相同商品有不同属性时
			
			
			if ( isset( $goods[ $sid ] ) ) {
				//已经存在相同商品时增加商品数量
				if ( $v['num'] == 0 ) {
					//如果数量为0删除商品
					unset( $goods[ $sid ] );
					continue;
				}
				$goods[ $sid ]['num']   = $goods[ $sid ]['num'] + $v['num'];
				$goods[ $sid ]['total'] = $goods[ $sid ]['num'] * $goods[ $sid ]['price'];
			} else {
				//购物车中没有相同商品时则增加商品数量
				if ( $v['num'] == 0 ) {
					//添加的数量为0则不添加
					continue;
				}
				$goods[ $sid ]          = $v;
				$goods[ $sid ]['total'] = $v['num'] * $v['price'];
			}
		}
		$this->save( $goods );
	}

	private function save( $goods ) {
		//将修改后购物车信息写入到session当中
		Session::set( $this->cartName . '.goods', $goods );//购物中各商品详细数据
		Session::set( $this->cartName . '.total_rows', $this->getTotalNums() );//购物车中所有商品数量
		Session::set( $this->cartName . '.total', $this->getTotalPrice() );//购物车中所有商品总价格
	}

	/**
	 * 更新购物车
	 *
	 * @param array $data
	 *  $data为数组包含以下几个值
	 *  $Data=[
		 *  "sid"=>1,                        //商品的唯一SID，不是商品的ID
		 *  "num"=>2,                       //商品数量
	 * ]
	 */
	public function update( $data ) {
		$goods = $this->getGoods(); //获得商品数据
		if ( ! isset( $data['sid'] ) || ! isset( $data['num'] ) ) {
			halt( '购物车update方法参数错误，缺少sid或num值' );
		}
		$data = isset( $data[0] ) ? $data : array( $data ); //允许一次删除多个商品
		foreach ( $data as $dataOne ) {//循环修改的商品数据
			foreach ( $goods as $k => $v ) {//循环购物车中已有的商品数据

				if ( $k == $dataOne['sid'] ) {
					//购物车中某个商品sid与要修改的商品sid相同时
					
					if ( $dataOne['num'] == 0 ) {
					//将数量改为0的话则商品购物车中的该商品
						unset( $goods[ $k ] );
						continue;
					}
					$goods[ $k ]['num']   = $dataOne['num'];//修改该商品的数量
					$goods[ $k ]['total'] = $dataOne['num'] * $v['price'];//修改该商品的小计
				}

			}
		}
		$this->save( $goods );
	}

	/**
	 * 统计购物车中商品数量
	 */
	public function getTotalNums() {
		$goods = $this->getGoods(); //获得商品数据
		$rows  = 0;
		foreach ( $goods as $v ) {
			$rows += $v['num'];
		}

		return $rows;
	}

	/**
	 * 获得商品汇总价格
	 */
	public function getTotalPrice() {
		$goods = $this->getGoods(); //获得商品数据
		$total = 0;
		foreach ( $goods as $v ) {
			$total += $v['price'] * $v['num'];
		}
		return $total;
	}

	/**
	 * 删除购物车
	 * 必须传递商品的sid值
	 *
	 * @param $data
	 *
	 * @return bool
	 */
	public function del( $data ) {//传入的是商品的sid
		$goods = $this->getGoods(); //获得购物中已有商品数据
		if ( empty( $goods ) ) {//购物中没有商品数据则不执行删除
			return false;
		}
		$sid = array(); //要删除的商品SID集合
		if ( is_string( $data ) ) {//传入的是数组的话则进行赋值给商品sid集合
			$sid['sid'] = $data;
		}
		if ( is_array( $data ) && ! isset( $data['sid'] ) ) {//传入的是数组且数组缺少sid的话报错
			halt( '购物车update方法参数错误，缺少sid值' );
		}

		$sid = isset( $sid[0] ) ? $sid : array( $sid ); //可以一次删除多个商品???
		foreach ( $sid as $d ) {//循环要删除的商品sid集合
			foreach ( $goods as $k => $v ) {//循环购物车现在的商品数据
				if ( $k == $d['sid'] ) {//如果购物车中商品sid与要删除的sid集合中的sid相同的话则删除购物中的该商品
					unset( $goods[ $k ] );
				}
			}
		}
		$this->save( $goods );
	}

	/**
	 * 清空购物车中的所有商品
	 */
	public function flush() {
		$data               = array();
		$data['goods']      = array();//这样留下一个空的结构
		$data['total_rows'] = 0;
		$data['total']      = 0;
		Session::set( $this->cartName, $data );
	}

	/**
	 * 获得购物车【商品】数据
	 */
	public function getGoods() {
		$data = Session::get( $this->cartName );
		if ( $data ) {
			//有结构及数据的话返回数据
			//有结构没数据的话返回空
			return isset( $data['goods'] ) ? $data['goods'] : null;
		}
		//没结构则创建出结构并返回空
		$data = array( "goods" => array(), "total_rows" => 0, "total" => 0 );
		Session::set( $this->cartName, $data );

		return null;
	}

	/**
	 * 获得购物车中的所有数据
	 * 包括【商品】数据、【总数量、总价格】
	 */
	public function getAllData() {
		return Session::get( $this->cartName );
	}

	/**
	 * 获得订单号
	 * @return string
	 */
	public function getOrderId() {
		$year_code = array(
			'A','B','C','D','E','F','G',

			'H','I','J','K','L','M','N',

			'O','P','Q','R','S','T',

			'U','V','W','X','Y','Z'
		);
		$i         = intval( date( 'Y' ) ) - 2010 - 1;

		return $year_code[ $i ] . date( 'md' ) . substr( time(), - 5 ) . substr( microtime(), 2, 5 ) . str_pad( mt_rand( 1, 99 ), 2, '0', STR_PAD_LEFT );
	}
}