/***
* @auth: qh
* @method: muiToolBar
* @time: 2014-4-21
* @requirt: jQuery.js
**/

;(function($){
	/*!
	* 划过延时插件
	* @para { Object } 参入的参数对象
	* hoverDuring  鼠标经过的延时时间
	* outDuring    鼠标移出的延时时间
	* hoverEvent   鼠标经过执行的方法
	* outEvent     鼠标移出执行的方法
	*/
	$.fn.hoverDelay = function(options){
		var defaults = {
			hoverDuring: 200,
			outDuring: 200,
			hoverEvent: $.noop,
			outEvent: $.noop
		}, sets;
		
		sets = $.extend(defaults, options || {});
		
		return $(this).each(function(){
			var _this = this;
			
			$(this).hover(function(){
				clearTimeout(_this.outTimer);
				_this.hoverTimer = setTimeout(function(){
					sets.hoverEvent.call(_this);
				}, sets.hoverDuring);
			},function(){
				clearTimeout(_this.hoverTimer);
				_this.outTimer = setTimeout(function(){
					sets.outEvent.call(_this);
				}, sets.outDuring);
			});
		});
	}
})(jQuery)

;$(function(){
	var _loginUrl = 'http://login.okhqb.com/member/getLoginInfo.json',
		_cartUrl = 'http://buy.okhqb.com/cart/getCartsForToolbar.json',
		_auth = (window.Auth && Auth.getAuthInfo()) || null;

	var muiToolBar = {		
		init: function () {
			this.load_style(
				'http://s2.hqbcdn.com/',
				'assets/v4/css/muiToolBar-1.0.0.css'
			)
						
			this.renderDom(); // 渲染浮层工具条
			this.render_loginInPannel(function () {
				muiToolBar.event_sign_handle();
				muiToolBar.event_tempt_newuser();
			});
			
			this.eventTrigger(); // 事件控制
			this.render_cartCount();//初始化购物车
			this.time_clock();
		},
		load_style: function (domain_name, css_path) {
			try{
				var head = document.getElementsByTagName('head').item(0), style;
				
				style = document.createElement( 'link' ); 
				style.setAttribute( 'rel', 'stylesheet' ); 
				style.setAttribute( 'type', 'text/css' ); 
				style.setAttribute( 'href', domain_name + css_path );
				
				head.appendChild( style );
				
			}catch( e ){}
		},
		renderDom: function () {
			var _html = '<div id="mui_bar"><div class="mui_bar_con"><div class="newuser"><a class="newuserRemindIcon" href="http://stopic.okhqb.com/xinren2016.html?utml=xrcelan" target="_blank"></a><a class="temptToRegister" href="http://stopic.okhqb.com/xinren.html?utml=xrcelan" target="_blank">新人专享</a></div><div class="userArea"><div class="login_in_pannel hide"></div><div class="login_up_pannel"><a class="login_up_i"></a></div></div><div class="miniCart"><a class="cart" href="javascript:;"><i class="cart_icon"></i>购物车<em class="cart_num">0</em></a></div><div class="kfPannel"><a id="kfNewPannel" href="javascript:;"></a><div class="nav-contact-kfNew">联系客服</div></div><div class="scrollTop"><a href="javascript:;" title="返回顶部"></a></div></div><div class="cart_con_box"><h2>购物车<i class="nav_car_times" data-times="0"></i><i class="nav_car_close"></i></h2> <div class="cart_con"><div class="cart_tips">您的购物车是空的<br>如您已添加商品，请<a target="_blank" href="http://login.okhqb.com/member/login.html">登录</a>查看</div></div></div></div>';
			$('body').append(_html);
		},
		render_loginInPannel: function (callback) {
			var $parent = $('.userArea'),
				$loginInPannel = $('.login_in_pannel', $parent),
				$loginUpPannel = $('.login_up_pannel', $parent),
				_html = '';

			if (_auth && _auth.logined === 1 && _auth.member_type === 1) { //已登录
				_html = '<span class="login_in_i"><a href="http://my.okhqb.com/my/home.html?ad=dd_id"><img width="30" height="30" src="' + _auth.avatar + '" alt="用户头像" class="user_avatar" /></a></span><div class="login_in hide"><a href="http://www.okhqb.com/member/logout.html" class="login_out">[退出]</a><span class="u_head"><img width="80" height="80" src="' + _auth.avatar + '" alt="用户头像"><a class="u_mask" href="http://my.okhqb.com/my/home.html?ad=dd_id"></a></span><div class="u_info"><p class="u_name"><a href="http://my.okhqb.com/my/home.html?ad=dd_id" target="_blank">Hi, ' + _auth.nickname + '</a></p><p class="u_coin">小强币：<b>' + (_auth.total_points || 0) + '</b>个</p></div></div>';
				
				$loginInPannel.empty().append(_html).show();
				$loginUpPannel.hide();
			} else { // 未登录
				if (!$loginUpPannel.find('.login_up').length) {					
					_html = '<div class="login_up hide"><form action=""><div class="f_item"><label for="userName" class="f_label">用户名：</label><input type="text" id="userName" name="userName" class="f_input" maxlength="50" value=""></div><div class="f_item"><label for="passWord" class="f_label">密码：</label><input type="password" id="passWord" name="passWord" class="f_input" value=""></div><p class="f_tips"></p><a href="javascript:;" class="sub_btn">登录</a><p class="forgetpwd"><a target="_blank" href="http://login.okhqb.com/member/memberForget.html">忘记密码？</a></p></form></div>';
					
					$loginUpPannel.append(_html);
				}
				$loginUpPannel.show();
				$loginInPannel.hide();
			}
			
			if (callback && typeof callback === 'function') {
				callback.apply($parent);
			}
		},
		render_toolbar: function( nick_name ){
			var Toolbar = $('#toolbar_bg') || $('#toolbar'),
			    nick_name = nick_name || '强粉';			
			try{
				Toolbar.find('.notloggedin').hide();
				Toolbar.find('.thelogged').html(
					'您好，<a class="u_name" rel="nofollow" href="' + _href + '">'
					+ nick_name + '</a>&nbsp;&nbsp;欢迎回来&nbsp;&nbsp;<a href="http://www.okhqb.com/member/logout.html" class="logout">&nbsp;退出</a>'
					+ '<a href="http://my.okhqb.com/my/home.html?ad=dd_id" class="signEveryday"><span>签到赚小强币</span></a>'
				).show();
			}catch( e ){}
		},
		event_tempt_newuser: function() {
			var $newuser = $('#mui_bar').find('.newuser'),
				$temptToRegister = $('#mui_bar').find('.temptToRegister');


				/*$newuser.hoverDelay({
					hoverEvent: function (e) {
						$temptToRegister.show();
					},
					outEvent: function (e) {
						$temptToRegister.hide();
					},
					hoverDuring: 300
				});*/
		},
		event_sign_handle: function () {
			var $parent = $('.userArea'),
				$loginInPannel = $('.login_in_pannel', $parent),
				$loginUpPannel = $('.login_up_pannel', $parent),
				$loginInIco = $('.login_in_i', $parent),
				$loginUpIco = $('.login_up_i', $parent),
				$userName = $('#userName', $loginUpPannel),
				$passWord = $('#passWord', $loginUpPannel),
				$tips = $('.f_tips', $loginUpPannel),
				$subBtn = $('.sub_btn', $parent);

			// 已登录
			$loginInPannel.hoverDelay({
				hoverEvent: function (e) {
					$loginInPannel.find('.login_in').show();
				},
				outEvent: function (e) {
					$loginInPannel.find('.login_in').hide();
				},
				hoverDuring: 300
			});
			
			// 未登录
			$loginUpPannel.hoverDelay({
				hoverEvent: function () {
					$loginUpPannel.find('.login_up').show();
				},
				outEvent: function () {
					$loginUpPannel.find('.login_up').hide();
				},
				hoverDuring: 300
			});
			
			// 获焦点清空错误信息
			$userName.add($passWord).on('focus', function() {
				$tips.removeClass('f_tip_error').html('').hide();
			}).keypress(function (e) {
				if (e.which === 13) {
					$subBtn.trigger('click');
				}
			})
			
			// 登录
			$subBtn.on('click', function () {					
				var	userName_val = $.trim($userName.val()),
					passWord_val = $.trim($passWord.val());
				
				if (userName_val.length < 1) {
					$tips.addClass('f_tip_error').html('请输入您的用户名！').show();
					return false;
				} else if (passWord_val.length < 1) {
					$tips.addClass('f_tip_error').html('请输入您的密码！').show();
				} else {
					try {
						$.ajax({
							url: 'http://login.okhqb.com/member/boxLogin.json',
							data: {'userName': userName_val, 'passWord': passWord_val},
							type: 'POST',
							dataType: 'jsonp',
							jsonpCallback: 'signInCallback',
							beforeSend: function(){
								$tips.addClass('f_tip_error').html('正在为您努力登录...').show();
							},
							success: function( result ){							
								if( result.code == 200 ){
									_auth = $.parseJSON( result.data );

									muiToolBar.render_loginInPannel();
									muiToolBar.render_toolbar( _auth.nickname );
									
									$tips.removeClass('f_tip_error').html('').hide();
									
									window.location.href = window.location.href
								}else{
									$tips.addClass('f_tip_error').html(result.msg);
								}
							}
						})
					} catch (e) {
						$tips.addClass('f_tip_error').html('登录失败：系统异常').show();
					} 
				}
				return false;
			});
		},
		render_cartCount: function(){ //购物车初始化 
			$.ajax({
				  type:'GET',
				  url:'http://buy.okhqb.com/cart/getCartsForToolbar.json',
				  dataType: 'jsonp',
				  jsonp:'callback',
				  success: function (result) {		
					  if (result.code == 200) {
							  $('.cart_num').html(result.data.count);							  
							  if(result.data.items){								  
								   var data= result.data,
								   	   items = data.items,
									   t= 3600-(parseInt(data.currentTime*0.001)-parseInt(data.countDownTime*0.001)),
									   str='';
								   if(t>0){
								       str='<h2>购物车<i class="nav_car_times" data-times="'+t+'">库存有限，保留0分0秒</i><i class="nav_car_close"></i></h2><div class="cart_con"><div class="cart_list_box" id="cart_list_box"><ul class="cart_list">';
								   }else{
									   str='<h2>购物车<i class="nav_car_times" data-times="'+t+'">已超时，请尽快结算</i><i class="nav_car_close"></i></h2><div class="cart_con"><div class="cart_list_box" id="cart_list_box"><ul class="cart_list">';
								   }

								   for(var i=0;i<items.length;i++){
									   str+='<li class="'+items[i].skuId+'"><a title="'+items[i].goodsTitle+'" target="_blank" href="http://www.okhqb.com/item/'+items[i].skuId+'.html" class="goods_pic"><img height="60" alt="'+items[i].goodsTitle+'" src="'+items[i].imageMD5+'" widht="60"></a>';
                    				   str+='<div class="goods_info">';
                        			   str+='<a target="_blank" title="'+items[i].goodsTitle+'" href="http://www.okhqb.com/item/'+items[i].skuId+'.html" class="goods_tit">'+items[i].goodsTitle+'</a>';
                        			   str+='<div class="goods_num"><i class="price">&yen;'+(items[i].promotePrice || items[i].price)+'</i>×<i class="num">'+items[i].quantity+'</i></div></div></li>'; 
								   }
								   str+='</ul></div>';
								   str+='<div class="car_list_total"><span>';
                  				   str+='<b class="car_total_price">&yen;<i class="car_total_price_i">'+data.totalFee+'</i></b><br/>'
                 				   str+='<b class="car_total_num">共<i class="car_con_num">'+data.count+'</i>件商品</b></span>';
              					   str+='<a href="http://buy.okhqb.com/buy/cart.html" target="_blank">去购物车结算</a></div>';

								   $('.cart_con_box').html(str);
								   if(items.length>=6){									      										        
								        $('.cart_list_box').height(600);										
										$('.car_list_total').css({'position':'fixed','bottom':0,'width':250});									   		    
								   		$('#cart_list_box').perfectScrollbar({suppressScrollX:true});
								   }
								   window.NAV_RIGHT_TIMER && window.NAV_RIGHT_TIMER.init();
							}else{								  
								  if (_auth && _auth.logined === 1 && _auth.member_type === 1) { //已登录								        
								  		$('.cart_con_box').html('<img width="203" height="184" src="http://s2.hqbcdn.com/assets/v4/images/process/nav_null.jpg" />');
								  }else{									    
								  		$('.cart_con').html('<div class="cart_tips">您的购物车是空的<br>如您已添加商品，请<a target="_blank" href="http://login.okhqb.com/member/login.html">登录</a>查看</div>');
								  }
								 
							}		 
					  }								
				  }
			});				
		},
		time_clock: function(){ // 倒计时	 		   		
			var NAV_RIGHT_TIMER={};					
			NAV_RIGHT_TIMER.init=function(){
				 NAV_RIGHT_TIMER.clockObj = $('.nav_car_times');
				 NAV_RIGHT_TIMER.times = $('.nav_car_times') ? $('.nav_car_times').attr('data-times') : 0; 						 				  		     
				 if(NAV_RIGHT_TIMER.times>0){
					    clearInterval(NAV_RIGHT_TIMER.clock);					        			    				   
			     		NAV_RIGHT_TIMER.clock=setInterval(function(){
								if(NAV_RIGHT_TIMER.times<=0){
									clearInterval(NAV_RIGHT_TIMER.clock);									
									NAV_RIGHT_TIMER.clockObj.html('已超时，立即结算还有库存商品');
									return false;
								}
								NAV_RIGHT_TIMER.times--;
								var m = parseInt(NAV_RIGHT_TIMER.times/60),
									s = parseInt(NAV_RIGHT_TIMER.times%60);
								m = (m >=10) ? m : '0'+m;
								s = (s >=10) ? s : '0'+s;
								NAV_RIGHT_TIMER.clockObj.html('库存有限，保留'+m+'分'+s+'秒');						
						},1000);
				 }
			};
			window.NAV_RIGHT_TIMER = NAV_RIGHT_TIMER;
			NAV_RIGHT_TIMER.init();
			
		},
		event_cart_handle: function () { // 购物车
			var $miniCart = $('#mui_bar .miniCart'),				
				$cartCon = $('.cart_con_box'),
				$cartTips = $('.cart_tips', $cartCon),
				$cartList = $('.cart_list', $cartCon),
				$gotocart = $('.mini_total', $cartCon),
				$cartInfo = $('.cart_info', $cartCon),			
				that = this;

				

			// 购物车为空，一种为未登录为空提示，还一种登录为空提示
			var emptyCart = function () {
				var _htmlDom;
				
				if ( _auth && _auth.logined === 1 && _auth.member_type === 1 ) {
					_htmlDom = '亲爱的<a href="http://my.okhqb.com/my/order.html" target="_blank">' + ( _auth.nickname || _auth.mobile ) + '</a><br/>购物车空空如也，快行动吧！';
				} else {
					_htmlDom = '您的购物车是空的<br/>如您已添加商品，请<a href="http://login.okhqb.com/member/login.html" target="_blank">登录</a>查看';
				}
				
				$cartTips.removeClass('loading_tips').html( _htmlDom ).show();

				$cartList.hide();
				$cartInfo.html('');
				$gotocart.hide();
			};
			$cartList.hide();
			$gotocart.hide();		

			$miniCart.on('click',function(){ //点击购物车		
				$cartCon.show();
				that.render_cartCount(); // 购物车初始数量	
			});
		
		},		
		event_scrollTop_handle: function () {
			var $scrollTop = $('#mui_bar .scrollTop'),
                winHeight = $(window).height();

            if(winHeight<728){
                $('.scrollTop').css('bottom','30px');
            }
			scrollTop($scrollTop);
		},
		event_kf_handle: function () { //客服
            try{
                $('#kfNewPannel,.kfPannel, .service').click(function(){
                    window.open('http://im.okhqb.com/client','OKHQBIM','width=340,height='+window.screen.height+'，menubar=no,location=no,status=no,toolbar=no,left=0,top=0');
                });
            }catch(e) {
                $('#kfNewPannel,.kfPannel').click(function () {
                    art.dialog({
                        id:'__IM',
                        title:'系统提示',
                        content:'客服系统不存在，请联系客服电话<b style="color:red">400-999-1258</b>！'
                    });
                    return false;
                });
            }

		},
		evevt_carlist_handle:function(){//购物车盒子
			var $cart = $('.cart_con_box'),
				$carTime = $('.nav_car_time');		

			$(document).click(function(e){			
				if(!$(e.target).hasClass('cart')){
					$cart.hide();
				}				
			});				
						
			$('.nav_car_close').live('click',function(){				
				$cart.hide();
			});
		},
		eventTrigger: function () {
			this.event_cart_handle(); // 购物车
			this.event_kf_handle(); // 客服
			this.evevt_carlist_handle(); // 购物车盒子
			this.event_scrollTop_handle(); // 返回顶部
		}
		
	};
	
	muiToolBar.init();
	
	// 返回顶部
	function scrollTop($ele) {
		$(window).scroll(function () {
			var _h = $(this).scrollTop();
				
			if (_h >= 200) {
				$ele.show()
			} else {
				$ele.hide()
			}
		});
		
		$ele.on('click', function () {
			$('html, body').animate({
				scrollTop: 0
			}, 300);
			return false;
		})
	}
});

