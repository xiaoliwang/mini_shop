/*
 * Author: KILLHAPPY
 * Date: 2011-06-09
 */

$(document).ready(function(){
    var reg1 = /<\/?.+?>/g;
    var reg2 = /[ ]/g;
    var acti;
    var isfocus = false;
    var uipt = $('.username');
    var mbox = $('.mailbox');
    var mbli = $('.mailbox dt');
    var cache = {};
    uipt.attr('autocomplete', 'off');
    
    // flush cache
    function flushCache(){
        cache = {};
        cache.data = {};
        cache.length = 0;
    };
    
    // flush cache
    flushCache();
    function init_selval(_ipt){
        mbox.show();
        var mstr = $(_ipt).val();
        var s = mstr.indexOf('@');
        //alert(s);
        if (s != -1) {
            $(mbli).find('span').html(left(mstr, s));
        }
        else {
            $(mbli).find('span').html(mstr);
        }
        var mblispan = $(mbli).find('span').html();
        if (mblispan.length != 0) {
            mbox.show();//.css({'height': '140px', 'overflow':'auto'});
            $(mbli).hover(function(){
                $(mbli).removeClass('mbsel');
                $(this).addClass('mbsel');
                acti = -1;
            }, function(){
                $(this).removeClass('mbsel');
            });
            if (s != -1) {
                $(mbli).hide();
                //$(mbli).removeClass('sel');
                for (var i = 0; i < mbli.length; i++) {
                    var listr = $(mbli[i]).html().replace(reg1, '').replace(reg2, '');
                    var oldstr = right(listr, listr.length - mblispan.length);
                    var newstr = right(mstr, mstr.length - mblispan.length);
                    var m = oldstr.indexOf(newstr);
                    if (m != -1) {
                        $(mbli[i]).addClass('mbs');
                        $('.mbs').show();
                    }
                    else {
                        $(mbli[i]).removeClass('mbs');
                        $(mbli[i]).hide();
                        if ($('.mbs').length == 0) {
                            mbox.hide();
                        }
                    }
                    if (mstr == listr) {
                        mbox.hide();
                    }
                }
            }
            else {
                $(mbli).show();
            }
            $(mbli).click(function(){
                init_chkval(this);
            });
        }
        else {
            mbox.hide();
        }
    }
    uipt.keyup(function(e){
        init_selval(this);
        //keyboard control
        switch (e.keyCode) {
            case 38: // up
                if ($('.mbs').size() == 0) {
                    movesel(mbli, -1);
                }
                else {
                    movesel($('.mbs'), -1);
                }
				e.preventDefault();
                break;
            case 40: // down
                if ($('.mbs').size() == 0) {
                    movesel(mbli, 1);
                }
                else {
                    movesel($('.mbs'), 1);
                }
				e.preventDefault();
                break;
            case 13: // return
                var selhtml = $('.mbsel').html();
                if (selhtml != null) {
                    init_chkval($('.mbsel'));
                }
                else {
                    mbox.hide();
                }
                break;
            default:
                mbli.removeClass('mbsel');
                acti = -1;
                break;
        }
    });
    function init_chkval(_obj){
        var lihtml = $(_obj).html();
        var usval = lihtml.replace(reg1, '');
        usval = usval.replace(reg2, '');
        $(uipt).val(usval);
        $(uipt).focus();
        mbox.hide();
    }
    function movesel(_lis, n){
        if (!_lis) 
            return;
        acti += n;
        if (acti < 0) {
            acti = _lis.size() - 1;
        }
        else 
            if (acti >= _lis.size()) {
                acti = 0;
            }
        _lis.removeClass("mbsel");
        $(_lis[acti]).addClass("mbsel");
		mbox.scrollTop($(_lis[acti]).height()*acti);
    };
    uipt.blur(function(){
        if (isfocus) {
            mbox.show();
        }
        else {
            mbox.hide();
        }
    });
    mbox.hover(function(){
        isfocus = true;
    }, function(){
        isfocus = false;
    });
});
function left(_str, n){
    if (n > 0) {
        return _str.substring(0, n);
    }
    else {
        return null;
    }
}

function right(_str, n){
    if (_str.length - n >= 0 && _str.length >= 0 && _str.length - n <= _str.length) {
        return _str.substring(_str.length - n, _str.length);
    }
    else {
        return null;
    }
}

function mid(_str, sn, en){
    if (_str.length >= 0) {
        return _str.substr(sn, en);
    }
    else {
        return null;
    }
}