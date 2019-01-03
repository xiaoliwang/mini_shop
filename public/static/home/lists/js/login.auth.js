/**
 * login auth
 * rely on jquery && jquery.cookie
 **/

var Auth = window.Auth || {};
Auth = {
	init: function(){
        this.DiscusionTimer=null;
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
				url: 'http://login.okhqb.com/member/getLoginInfo.json?callback=?',
				dataType: 'json',
				success: function( result ){
					if( result.code == 200 ){
                        Auth.getMsg();
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
			//this.getDisMsg(); 小强讨论
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
			window.location = 'http://login.okhqb.com/member/autoLogin.html?forward='+window.location.href;
		}
	},
	
	getMsg:function(){//获取会员消息通知
	    $.ajax({
		        url: 'http://my.okhqb.com/my/message/unread.json',
				dataType: 'jsonp', 
				jsonpCallbak:'callback',
				success:function(d){
				      if(d.code==200){
						  $('.nav-message').html(d.data);
					  }  
				}
		})
	},
    getDisMsg:function(){
        $.ajax({
            url: 'http://my.okhqb.com/my/message/unreadDiscussion.json',
            dataType: 'jsonp',
            jsonpCallbak:'callback',
            success:function(d){
                if(d.code==200){
                    Auth.showDiscusonMsg(d.data);
                }
            }
        })
    },
	showDiscusonMsg:function(num){

        if(num>0){
            if($('.dis-msg-remind').length>0){
                $('.dis-msg-num').html(num);
            }else{
                var pos = $('.tel-phone').position(),

                    str ='<div class="dis-msg-remind" style="right:0px;top:36px;">';

                str+='<div class="dis-msg-close">╳</div>';
                str+='<div class="dis-msg-l">';
                str+='<span class="dis-msg-num">'+num+'</span></div>';
                str+='<p>你有<i class="dis-msg-num">'+num+'</i>条新评论</p>';
                str+='<p><a href="http://my.okhqb.com/my/comments/replyMeList.html" target="_blank">查看评论&nbsp;〉</a></p></div>';
                $('.toolbar').append(str);
            }

            $('.dis-msg-close').live('click',function(){
                $('.dis-msg-remind').remove();
            });
        }else{
            $('.dis-msg-remind').remove();
        }

        clearTimeout(Auth.DiscusionTimer);
        Auth.DiscusionTimer = setTimeout(function(){
            Auth.getDisMsg();
        },30*1000);
    },
	msgHover:function(){
			$('.toolbar-right-list li:not(.tel-phone)').hover(function(){
				$(this).addClass('mouse-on');			
				$(this).find('.toolbar-right-box').show();

                $(this).find('.list-icon-new').css({
                    'background-image':'url(http://s.hqbcdn.com/assets/v4/images/newindex/sprites_index_2.png) ',
                    'background-position':'-47px -117px'
                });
			},function(){
				$(this).removeClass('mouse-on');
				$(this).find('.toolbar-right-box').hide();
                $(this).find('.list-icon-new').css({
                    'background-image':'url(http://s.hqbcdn.com/assets/v4/images/newindex/sprites_index_2.png) ',
                    'background-position':'-36px -117px'
                });
			});
			
			$('.okhqb-phone').hover(function(){				
				$('.toolbar-days').show();
			},function(){
				$('.toolbar-days').hide();
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

                                if((odm && odmL==0)&&(sgm && sgmL==0)){
                                    str+='<p style="margin-bottom:5px;width: 100%;line-height: 30px; text-align: center;"><a href="http://my.okhqb.com/my/comments/replyMeList.html" target="_blank" style="display: block;width: 100%;">查看消息</a></p>';
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
										msgCount=$('.nav-message').html();
									count--;
									msgCount--;
									msgCount=msgCount>0 ? msgCount : 0 ;
									$('.nav-message').html(msgCount);
									$('.'+$count).html(count);
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
});
