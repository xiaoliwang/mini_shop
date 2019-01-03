/**
* @auth: qh
* @time: 2014-4-15
* @requirt: jQuery.js
*/

$(function(){
	// 服务时间
	$('#toolbar_bg .kf_phone').hover(function () {
		var $html = '<div class="kf_time">工作日：9:00-22:00<br/>节假日：9:00-18:00</div>';
		$(this).after($html);
	}, function () {
		$(this).next('.kf_time').remove()
	});

	//头部导航栏隐藏显示二级菜单
	$('.secondary_menu').parent('li').on({
		mouseenter : function()	{
			$(this).find('.secondary_menu').show();
			$(this).find('.insurance_icon').removeClass('fold').addClass('unfold');
		},
		mouseleave : function() {
			$(this).find('.secondary_menu').hide();
			$(this).find('.insurance_icon').removeClass('unfold').addClass('fold');
		}
	});
	
	// 搜索
	$('#search_key').each(function () {
		var $this = $(this),
			$sibling = $this.siblings('.placeholder'),
			// 搜索页设置搜索关键词
			setDefaultValue = function () {
				var urlArr = getUrlFileName();
				
				if (urlArr && urlArr[1] === 'html') {
					if (urlArr[0] === 'search') {
						var _keyWord = getQueryString(); // 获取查询字符串
						
						if (_keyWord.q) {
							$sibling.hide();
							$this.val(decodeURIComponent(_keyWord.q));
						}
					}
				}
			};
		
		setDefaultValue();
		
		// 输入框聚焦与失去焦点
		$this.focus(function () {
			$sibling.hide();
		}).blur(function () {
			var _val = $.trim($this.val()),
				_defaultVal = $sibling.text();
			
			if (_val === '' || _val === _defaultVal) {
				$this.val('');
				$sibling.show();
			}
		}).trigger('blur');
		
		return false;
	})
	
	// 获取查询字符串
	function getQueryString() {
		var args = {},
			item = null,
			items = [],
			qs = '',
			name = '',
			value = '';
			
		qs = (location.search.length > 0 ? location.search.substr(1) : '');
		
		if (qs) {
			items = qs.split('&');
			
			for (var i = 0; i < items.length; i++) {
				item = items[i].split('=');			
				name = decodeURIComponent(item[0]);
				value = decodeURIComponent(decodeURIComponent(item[1]));
				args[name] = value;
			}
		}
		
		return args;
	}
	
	/**
	* @method 获取url的文件
	* @para { String } 不输入为地址栏url
	* @return { Array } 无值返回 undefined,否则返回数组arr[0]为文件名称,arr[1]为文件类型
	*/ 
	function getUrlFileName(url){
		var _url = (typeof url === 'string' ? url : '') || location.href,
			_reg = /\/(?![^?]*\/)([^?#]+)(?=\?|$)/,
			arr = [];
			
		if (!!_url.match(_reg)) {
			arr = _url.match(_reg)[1].split('.');
			return arr.length > 0 ? arr : undefined ;
		}
	}
	

	var optionAct = {
		blur : function(obj, index){
			obj.find('li:eq(' + index +')').removeClass('on');			
		},
		focus :function(obj, index){
			var li = obj.find('li:eq(' + index +')');
			obj.find('li:eq(' + index +')').addClass('on');
			$('#search_key').val(li.text());
		}
	};

	var KeyOperationProcess = function(ele, index, code,lens){
		// up
		if(code === 38){
			optionAct.blur(ele , index);
			index = index <= 0 ? (lens -2) : index - 1 ;
			optionAct.focus(ele, index);
		}
		//down
		if(code === 40 ){
			optionAct.blur(ele , index);			
			index = index === (lens-2) ? 0 : index + 1;
			optionAct.focus(ele, index);
		}

		if(code === 13 ){
			$('.search_btn').trigger('click');			
		}
		return index;
	}



	//搜索下拉关键字列表
	function searchDropdown(){
		var _$index = -1;
		
		$('#search_key').on({
			keyup: function(e){
				var iptVal = $.trim($(this).val()),			
					utf8iptVal = encodeURIComponent(iptVal),
					code = e.keyCode,
					$lens = 0,
					tmpCode = '',
					idArr = ['#result_lib','#recommend_lib'],
					selector = $(idArr[0]);


					if(!iptVal ){
						_$index = -1;
						selector.html($(idArr[1]).html());
						selector.show();
						$(idArr[1]).hide();
					}
				
				//判断用户是在输入字符 不是按下上下方向键或者回车键
				if(!( code ===38 || code ===40 || code ===13)){
					$('#recommend_lib').hide();
					$.ajax({
						url:'http://www.okhqb.com/item/suggest.json?key=' + utf8iptVal,					
						type:'GET',
						dataType:'jsonp',					
						jsonp:'callback',
						success:function(data){
							var str = '',							
								num = data.length || 0;
								_$index = -1;
								//新键入的查询字符得到新的结构 使用up\down键控制从头开始
								selector.find('.on').removeClass('on');

							if( !!num ){								
								for(var i = 0; i< num; i++){
									str += '<li><div class="search-item">' + data[i].key + '</div></li>';
								}								
								str += '<li class="close_result">关闭</li>';													
								selector.html(str).show();
							}
						}
					});
				}else{
					$lens = selector.find('li').length;
					
					//由鼠标hover停留的li位置开始转由up\down键控制
					if(!!selector.find('.on').length){
						_$index = selector.find('.on').index();
					}
					_$index = KeyOperationProcess(selector,_$index, code,$lens );					

				}
			},
			focusin:function(){
				var _content = $(this).val();
				if(!_content.length){
					$('#recommend_lib').show();
				}			
			}			
		});
	}
	searchDropdown();
	
	// app down event
	App_Down.init();

	$('.header_extra').mouseleave(function(e){
		setTimeout(function(e){
			$('#result_lib').hide().html('');
			$('#recommend_lib').hide();
		},1000);
		
	});


	$('.dropdown_list').on('mouseenter','li',function(){
		var _self = $(this);
			isCloseTrigger = _self.hasClass('close_result');

		if(!isCloseTrigger){
			_self.siblings('li').removeClass('on');
			_self.addClass('on');			
			$('.search_key').val(_self.text());		
		}else{
			return;
		}
		_$index=_self.index();

	}).on('mouseleave','li',function(){
		$(this).removeClass('on');
	}).on('click','li',function(){
		var isCloseTrigger = $(this).hasClass('close_result'),
			islink = $(this).hasClass('suggest_link');
		if( !isCloseTrigger && !islink){
			$('#search_key').val($(this).text());
			$('.search_btn').trigger('click');
		}else if(islink){
			return;
		}else{			
			$(this).parent('.dropdown_list').html('').hide();
		}
	})

	// 全部商品分类
	$('#menu .classify').each(function(){
		var $this = $(this),
			$classifyTit = $('.classify_tit', $this),
			$classifyCon = $('.classifyCon', $this),
			$ico = $('i', $classifyTit);
			
		$classifyTit.click(function () {
			if ($classifyCon.is(':hidden')) {
				$classifyCon.show();
				$ico.html('&nbsp;-');
			} else {
				$classifyCon.hide();
				$ico.html('+');
			}
		})
		
		$this.mouseleave(function () {
			$classifyCon.hide();
			$ico.html('+');
		})
		
		return false;
	});
	
	//反馈建议
	$('.okhqb_feed').click(function(){
		var content_html;		
		if($('.feedback').length>0){
			content_html = $('.feedback').html();			
		}else{
			content_html='<div class="help_offer_1 cfix">'
            content_html+='<textarea name="inquiry_remark" cols="" rows="" id="inquiry_remark" style="color: rgb(204, 204, 204);">请输入您对我们网站有什么意见或建议，您的反馈将帮助我们更好的为您服务！</textarea>';
            content_html+='<input type="text" style="color: rgb(204, 204, 204);" name="inquiry_email" id="inquiry_email" value="请您填写您的邮箱" class="w_e_mail" placeholder="请您填写您的邮箱">';
            content_html+='<input class="help_tijiao" id="u_inquiry_submit" name="" value=""></div>';
		}
		art.dialog({
			id:'__feed',
			title:'意见反馈',
			content:content_html,
			ok:false,
			noFn:true
		});								
	});	
	$('#inquiry_remark').live({
		focus:function(){
			if($(this).val() == '请输入您对我们网站有什么意见或建议，您的反馈将帮助我们更好的为您服务！'){
				$(this).val('');	
			}else{
				return;	
			}								
		},
		blur:function(){
			if($(this).val() == ''){
				$(this).val('请输入您对我们网站有什么意见或建议，您的反馈将帮助我们更好的为您服务！');	
			}	
		}
	});
	$('#inquiry_email').live({
		focus:function(){
			if($(this).val() == '请您填写您的邮箱'){
				$(this).val('');	
			}else{
				return;	
			}								
		},
		blur:function(){
			if($(this).val() == ''){
				$(this).val('请您填写您的邮箱');	
			}	
		}
	});

	$('#u_inquiry_submit').live('click',function(){
		var _cc = $('#inquiry_remark').val(),
			_ml = $('#inquiry_email').val(),
			reg_email = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
		if(_cc == '' || _cc == '请输入您对我们网站有什么意见或建议，您的反馈将帮助我们更好的为您服务！'){
			art.dialog({
				title:'提示',
				content:'请填写您要反馈的信息！',
				icon:'warning',	
				time:2
			});	
		}else if(_cc.length > 255){
			art.dialog({
				title:'提示',
				content:'反馈信息超过规定长度，请整理后重新提交！',
				icon:'warning',	
				time:2
			});		
		}else if(_ml === '' || _ml === $('#inquiry_email')[0].defaultValue){
			art.dialog({
				title:'提示',
				content:'为了及时解决您反馈的意见或建议，请填写您的邮箱！',
				icon:'warning',	
				time:2
			});	
		}else if(!reg_email.test(_ml)){
			art.dialog({
				title:'提示',
				content:'邮箱格式填写错误，请填写您的正确邮箱！',
				icon:'warning',	
				time:2
			});
		}else{
			$.ajax({
				url: 'http://www.okhqb.com/help/save',
				type: 'post',
				dataType: 'json',
				data: {
				  'url': window.location.href,
				  'inquiry_remark':_cc,
				  'inquiry_email':_ml
				},
				beforeSubmit: function() {
				  $('#u_inquiry_submit').attr('disabled', 'disabled');
				},
				success: function(d) {
				  if (d.status == 1) {
					art.dialog({
						title:'提示',
						content:d.data,
						icon:'succeed',
						time:2
					});
					art.dialog.get('__feed').close();
					return false;
				  } else {
					art.dialog({
						title:'提示',
						content:d.data,
						icon:'warning',
						time:2
					});
					return false;
				  }
				}
			});	
		}											 
	});
	

});
/* 类目分类--- 20160115 */
$(function(){

    ListTab();
    function ListTab(){
        var lTab = $('.sale-list-wrapper'),
            dt = lTab.find('dt'),
            item = $('.sale-list-item', lTab),
            List = $('#sale-list');



        dt.hover(function(){
            var $this = $(this),
                i = $this.index();

            dt.removeClass('on');
            $this.addClass('on');
            item.removeClass('on');
            item.eq(i).addClass('on');
        });

        if($('.hone-list').length > 0){
            lTab.mouseleave(function(){
                dt.removeClass('on');
                item.removeClass('on');
            });
            return false;
        }

        List.hover(function(){
            //List.addClass('on');
            lTab.show();
        },function(e){

            var rT = $(e.relatedTarget);

            if(rT.is('body') || rT.is('#new-menu-v2') || rT.is('.home-nav a') ){
                lTab.hide();
            }

            //List.removeClass('on');


        });
        lTab.hover(function(e){
            //List.addClass('on');
        }, function(){
            lTab.hide();
            //List.removeClass('on');
        });

    }

});

/*手机端嵌入切换m.okhqb.com信息*/
//判断是否为手机端浏览器   
function versions() { 
	var ua = (window.navigator && navigator.userAgent) || '';
	
	return  /^1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\    -m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o    |ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)    |hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|k    yo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p    1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phi    l|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|s    e(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\    -|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g     |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte|xiaomi|meizhou|mobile|miui\-/i.test(ua);	
}

/**
* @method changeTab 选项卡
* @param { Object } 参数对象
* @return { Object } jQuery对象
*/
;(function($){
	$.fn.changeTab = function(json){
	
		/**
		json = {
			tabMenu : 选项卡菜单按钮
			tabBox  : 选项卡内容
			sClass  : 当前选择选项卡菜单的样式
			eType   : 事件类型(默认: mouseover)
		}
		*/
		
		var defaults = { // 默认值
			tabMenu : '.tabMenu',
			tabBox : '.tabBox',
			sClass : 'cur',
			eType : 'mouseover'
		},
		options = $.extend({}, defaults, json);
		
		return this.each(function(){
			var $parent = $(this),
				$tab_menu = $(options.tabMenu, $parent).children(),
				$tab_box = $(options.tabBox, $parent);
				
			$tab_menu.each(function(i){
				var $this = $(this);

				$this.bind(options.eType, function(){
					$this.addClass(options.sClass).siblings().removeClass(options.sClass);
					$tab_box.hide().eq(i).show();
					
					return false;
				});
				
				if( $this.hasClass(options.sClass) ) {
					$tab_box.hide().eq(i).show();
				}
			})
		});
	}
})(jQuery);

// app down guide
(function (win, $) {
	/*  
     *让低版本IE(6/7)浏览器支持数组的indexOf和lastIndexOf方法
     * */
    if( typeof Array.indexOf !== 'function' ){
        Array.prototype.indexOf = function(args){
            var index = -1; 
            for(var i=0,l=this.length; i<l; i++){
                if(this[i] === args){
                    index = i;
                    break;
                }   
            }   
            return index;
        }   
        Array.prototype.lastIndexOf = function(args){
            var index = -1; 
            for(var i=this.length-1; i>=0; i--){
                if(this[i] === args){
                    index = i;
                    break;
                }   
            }   
            return index;
        }   
    }
	var App_Down = {
			init: function () {
				this.setup();	
			}
			, setup: function () {
				var $appDown = $('.J-app-down'),
					_eleArr = ['p', 'dt', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6'],
					_wrapEle = '',
					_app_down_expanded = '',
					$wrapEle;
				
				if (!$appDown.length) return; 
				
				$appDown.each(function () {
					var $self = $(this);
					
					if (_eleArr.indexOf($self.parent()[0].nodeName.toLowerCase()) !== -1) {
						_wrapEle = $('<span class="app-down-wrap"/>')
					} else {
						_wrapEle = '<div class="app-down-wrap"/>'
					}
					$self.wrap(_wrapEle);
				});
				
				$wrapEle = $('.app-down-wrap');
				
				_app_down_expanded = '<span class="app-down-expanded">'
									+'	<img width="98" height="98" src="http://s.hqbcdn.com/assets/v4/images/newindex/app_down.jpg" alt="app download" />随时逛 及时购'
									+'</span>';
				
				$wrapEle.append(_app_down_expanded);
				
				this.$wrapEle = $wrapEle;
				
				// 绑定事件
				this.eventAction();
				
			}
			, eventAction: function () {
				var $wrapEle = this.$wrapEle;
				
				function fixPos (tarEle, relEle) {
					var _left = (tarEle.outerWidth() - relEle.outerWidth()) / 2,
						_top  = relEle.outerHeight();

					return {
						left: _left,
						top : _top
					}
				}
				
				$wrapEle.on('hover.app.down', function (e) {
					var $appDownExpanded = $(this).find('.app-down-expanded'),
						_fixedPos = $(this)[0]['fixPos'];
					
					if ( !_fixedPos || $.isEmptyObject(_fixedPos) ) {
						_fixedPos = $(this)[0]['fixPos'] = fixPos($appDownExpanded, $appDownExpanded.prev('.J-app-down'));
					}
					
					$appDownExpanded.css({'left': -_fixedPos.left, 'top': _fixedPos.top});
					
					$appDownExpanded.toggle();
				})
			}

		}
		
		win.App_Down = App_Down;
})(window, jQuery);