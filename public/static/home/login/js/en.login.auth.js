/**
 * login auth
 * rely on jquery && jquery.cookie
 **/

var Auth = window.Auth || {};
Auth = {
	init: function(){
		var _au = this.getAuthInfo();		
		if( _au ){		
			this.renderingLoginBar( _au );
		}
		this.msgHover();
		this.gotoLogin();
	},	
	getAuthInfo: function(){
		
		var _authCookie = $.cookie('auth'),
		    _sessionCookie = $.cookie('session');

		if( !_authCookie || !_sessionCookie ){
			return null;
		}
		
		/*if( _authCookie.indexOf('~') != -1 ){
			return null;
		}*/
		
		_auth = $.parseJSON( _authCookie );
		
		try{
			returnValue = $.parseJSON( _auth );
		}
		catch(e){ returnValue = null; }
		
		return returnValue;
	
	},
	
	renderingLoginBar: function( auth ){
		
		var $proTool=$('.pro-tool-status');	
				
		if( ! auth ){
			$.ajax({
				url: '/member/getLoginInfo.json?callback=?',
				dataType: 'json',
				success: function( result ){
					if( result.code == 200 ){
						this.getMsg();
						var result_data = $.parseJSON( result.data );					
						if( result_data.logined == 0 ){							
							_unLoginBar.show();
							_loggedBar.hide();					
						}else{
							var nickname = result_data.nickname,
								_href = '';
								
							if( result_data.sys_register == 7 ){
								nickname = result_data.mobile;
							}
							
							if( result_data.member_type == 1 ){ // 主站
								_href = 'http://my.okhqb.com/my/home.html?ad=dd_id';
							}else if ( result_data.member_type == 5 ) { // 批发
								_href = 'http://my.okhqb.com/my/order.html';
							}
							//购物流程头部工具条 购物车 确认订单页
							$proTool.html('华强北商城欢迎您：<a href="'+_href+'" target="_blank" class="tool-bold-red">'+nickname+'</a>&nbsp;&nbsp;&nbsp;<a href="http://www.okhqb.com/member/logout" class="logout">[退出]</a>');	
							//主站 item页 个人中心 头部工具									
							
							$('.dc-nav-user').html(nickname);										
							$('.dc-unlogin').hide();								
							$('.dc-logined').show();								
									
						}
					}
				}
			});						
			return;
		}
		else{
			this.getMsg();
			var nickname = auth.nickname,
				_href = '';
				
			if( auth.sys_register == 7 ){
				nickname = auth.mobile;
			}
			
			if( auth.member_type == 1 ){ // 主站
				_href = 'http://my.okhqb.com/my/home.html?ad=dd_id';
			}else if ( auth.member_type == 5 ) { // 批发
				_href = 'http://my.okhqb.com/my/order.html';
			}
			
			//购物流程头部工具条 购物车 确认订单页
			$proTool.html('华强北商城欢迎您：<a href="'+_href+'" target="_blank" class="tool-bold-red">'+nickname+'</a>&nbsp;&nbsp;&nbsp;<a href="http://www.okhqb.com/member/logout" class="logout">[退出]</a>');	
			//主站 item页 个人中心 头部工具		
			$('.dc-nav-user').html(nickname);										
		    $('.dc-unlogin').hide();								
		    $('.dc-logined').show();
		}		
	},
	gotoLogin:function(){//购物流程登陆 购物车 订单提交页
		$('.pro-login').click(function(){			
			OKHQB_sign.dialog({
				sign_in_callback:function(){
					window.location.reload();
				}
			}); 
		})
	},
	autoLogin:function(){
		var url = window.location.href;
		if( !$.cookie('auth') && $.cookie('okhqb_auto_login') && $.cookie('auto_login_member_id') && url.indexOf('logincallback') < 0 && url.indexOf('.json') < 0 )
		{
			window.location = '/member/autoLogin.html?forward='+window.location.href;
		}
	},
	
	getMsg:function(){//获取会员消息通知
	    $.ajax({
		        url: 'http://my.okhqb.com/my/message/unread.json',
				dataType: 'jsonp', 
				jsonpCallbak:'callback',
				success:function(d){
				      if(d.code==200){
						  $('.dc-nav-msg b').html(d.data);
					  }  
				}
		})
	},
	
	msgHover:function(){
			$('.toolbar-right-list li:not(..tel-phone)').hover(function(){
				$(this).addClass('mouse-on');			
				$(this).find('.toolbar-right-box').show();				
			},function(){
				$(this).removeClass('mouse-on');
				$(this).find('.toolbar-right-box').hide(); 				
			});
			
			$('.okhqb-phone').hover(function(){				
				$('.toolbar-days').show();
			},function(){
				$('.toolbar-days').hide();
			});			
			
			//消息框
			$('.nav-msg').hover(function(){
				var $left=$(this).position().left;
				$(this).addClass('nav-msg-on');
				$('.msg-list-box').css('left',$left+'px').show();
			},function(){
				$(this).removeClass('nav-msg-on');
				$('.msg-list-box').hide();
			});
			
			$('.msg-list-box').hover(function(){
				 $('.nav-msg').addClass('nav-msg-on');
			     $(this).show();
			},function(){
			     $('.nav-msg').removeClass('nav-msg-on');
				 $('.msg-list-box').hide();
			});
			// get user message
			var isAjaxMsg=false;
			$('.nav-msg').mouseover(function(){
				if(isAjaxMsg){
					return false;
				}
				isAjaxMsg=true;
				setTimeout(function(){  isAjaxMsg=false; },30000);
				$.ajax({
						type:'GET',
						url:'http://my.okhqb.com/my/message/subscribeMessages.json',
						dataType:'jsonp',
						jsonp:'callback',
						success:function(d){							
						 	if(d.code===200){								
								if(d.data==''){	
									$('.msg-list-box').html('<p style="margin-bottom:10px;line-heihgt:50px; text-align:center;">暂无消息</p>');							
									return false;
								}								
								var str='<ul>',
									odm=d.data.subscribeOrdersMessages,
									odmL=odm.length,
									sgm=d.data.subscribeGoodsMessages,
									sgmL=sgm.length;
									
								if(odm && odmL>0){																	
									str+='<li><p class="list-title list-no-top"><i>|</i><span class="msg-list-bold">您购买的商品</span>&nbsp;有<span class="odm">'+odmL+'</span>个物流变化</p>';																	
									for(var i=0;i<odmL;i++){
										if(i!==( odmL-1 ) ){
											str+='<p class="list-info list-info-border">';
										}else{
											str+='<p class="list-info">';
										}										
										str+='<a href="http://my.okhqb.com/my/order.html?fromTpe=S"><img src="'+odm[i].imageUrl+'" width="55" height="50" /></a>';
                                		str+='<span><a href="http://my.okhqb.com/my/order.html?fromTpe=S" target="_blank">'+odm[i].tradeSn+'</a></span><span>'+odm[i].message+'</span>';
                                		str+='<a href="javascript:void(0);" data-listNum="'+odm[i].messageId+'" data-counts="odm" class="msg-delte">×</a></p>  ';
									}
									str+='</li>';
								}
								if(sgm && sgmL>0){	
									if(odmL==0){
										str+='<li><p class="list-title list-no-top"><i>|</i><span class="msg-list-bold">您关注的商品</span>&nbsp;有<span class="sgm">'+sgmL+'</span>个动态变化</p>';	
									}else{																
										str+='<li><p class="list-title"><i>|</i><span class="msg-list-bold">您关注的商品</span>&nbsp;有<span class="sgm">'+sgmL+'</span>个动态变化</p>';									
									}
									for(var i=0;i<sgmL;i++){
										if(i!==( sgmL-1 ) ){
											str+='<p class="list-info list-info-border">';
										}else{
											str+='<p class="list-info">';
										}										
										str+='<a href="hhttp://my.okhqb.com/my/subscription.html?fromTpe=S"><img src="'+sgm[i].imageUrl+'" width="55" height="50" /></a>';
                                		str+='<a href="http://my.okhqb.com/my/subscription.html?fromTpe=S" target="_blank" class="list-link">'+sgm[i].skuName+'</a>';
                                		str+='<a href="javascript:void(0);" data-listNum="'+sgm[i].messageId+'" class="msg-delte" data-counts="sgm">×</a></p>  ';
									}
									str+='</li>';
								}
								
								str+='</ul>';								
								$('.msg-list-box').html(str);							
							}							
						}
				 });
				 
				 //delete user message
				 $('.msg-delte').live('click',function(){
					 	
			     		var msgId=$(this).attr('data-listNum'),
							$this=$(this),
							$count=$(this).attr('data-counts');			    
						$.ajax({
							type:'GET',
							url:'http://my.okhqb.com/my/message/unShow.json?messageId='+msgId,
							dataType:'jsonp',
							jsonp:'callback',
							success:function(d){								
								if(d.code===200){
									isAjaxMsg=false;
									$this.parent().remove();
									var count=$('.'+$count).html(),
										msgCount=$('.dc-nav-msg b').html();
									count--;
									msgCount--;
									msgCount=msgCount>0 ? msgCount : 0 ;
									$('.dc-nav-msg b').html(msgCount);							
									if(count<=0){
										$('.'+$count).parents('li').remove();
									}else{
									 	$('.'+$count).html(count);
									}
								}
							}
						});
				 	
				 });
				 
				 
			});	
	}

};

$(document).ready(function(){
	$('.dc-new-phone').hover(function () {
				var $html = '<div class="kf-new-time">工作日：9:00-22:00<br/>节假日：9:00-18:00</div>';
				$(this).after($html);
	}, function () {
				$(this).next('.kf-new-time').remove()
   });	
	
	Auth.init();
	
	/* QQ 彩贝的*/
	var _caibei_attach = $.cookie('caibei_attach');
	var _caibei_ShowMsg = $.cookie('caibei_ShowMsg');
	var _caibei_HeadShow = $.cookie('caibei_HeadShow');
	var _caibei_JiFenUrl = $.cookie('caibei_JiFenUrl');
	var _caibei_nickname = $.cookie('caibei_nickname');
	var _mod_top_banner= '';
	var _loggedBar = $('.thelogged');
	var html='';
	
	if(_caibei_HeadShow){
		
		var _caibei=_caibei_HeadShow.replace(/\+/g,' '),		
		    _mod_top_banner = $('#mod_top_banner');
			
		if( _caibei_ShowMsg ){
			html += '<div class="mod_top_banner"><div class="main_area"><div class="sale_tip">';				
			html += decodeURI(_caibei.substring(1,(_caibei.length)-1));	
			html += '</div><div class="login_status"><span class="qqUser login_btn"><span class="name">';
			html += _caibei_ShowMsg.substring(1,(_caibei_ShowMsg.length)-1);
			html += '</span><a class="my_caibei" title="我的彩贝积分" target="_blank" href="';
			html += _caibei_JiFenUrl;
			html += '" ytag="06808">我的彩贝积分</a></div></div></div>';
			
			_mod_top_banner.html(html);
			
			_loggedBar.html('您好，<a class="u_name" rel="nofollow" href="http://my.okhqb.com/my/order.html">'
				+ _caibei_nickname.substring(1,(_caibei_nickname.length)-1)				
				+ '</a>&nbsp;&nbsp;欢迎回来<a href="http://www.okhqb.com/member/logout.html" class="logout">&nbsp;退出</a>'
				+ '<a href="http://my.okhqb.com/my/home.html?ad=dd_id" class="signEveryday"><span>签到赚小强币</span></a>'
			).show();
		
		}else{
			_mod_top_banner.hide();
		}
	}
});
