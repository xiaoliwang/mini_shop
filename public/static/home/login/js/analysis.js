/* 
 * Analysis script
 * Google conversion
 */

<!-- Google Code for &#20877;&#33829;&#38144;&#26631;&#35760; -->
<!-- Remarketing tags may not be associated with personally identifiable information or placed on pages related to sensitive categories. For instructions on adding this tag and more information on the above requirements, read the setup guide: google.com/ads/remarketingsetup -->

//一推代码
/*var _etui_unit_id = "46";
(function() {
	var _ets = document.createElement("script");
	_ets.type = "text/javascript";
	_ets.async = true;
	_ets.src = ("https:" == document.location.protocol ? "https://ssl" : "http://etui") + ".linezing.com/ana/et.js";
	var s = document.getElementsByTagName("script")[0];
	s.parentNode.insertBefore(_ets, s);
})();*/


/* <![CDATA[ */
/* var google_conversion_id = 1000098639;
var google_conversion_label = "LJ36CNGSggQQz5bx3AM";
var google_custom_params = window.google_tag_params;
var google_remarketing_only = true; */
/* ]]> */

// 写入google conversion.js
/* var __BODY = document.getElementsByTagName('body').item(0);
var __conversionScript = document.createElement("script");
__conversionScript.type = "text/javascript";
__conversionScript.src = "http://www.googleadservices.com/pagead/conversion.js";

try{
	__BODY.appendChild( __conversionScript );
}catch(e){} */

/* 此部分代码已放在公共foot中
<noscript>
<div style="display:inline;"><img height="1" width="1" style="border-style:none;" alt="" src="//googleads.g.doubleclick.net/pagead/viewthroughconversion/1000098639/?value=0&amp;label=LJ36CNGSggQQz5bx3AM&amp;guid=ON&amp;script=0"/></div>
</noscript>
*/
/* yima ETC code  start*/
/*
  var _adwq = _adwq || [];
  _adwq.push(['_setAccount', 'jw99x']);
  _adwq.push(['_setDomainName', '.okhqb.com']);
  _adwq.push(['_trackPageview']);
  (function() {
    var adw = document.createElement('script');
    adw.type = 'text/javascript';
    adw.async = true;
    adw.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://s') + '.emarbox.com/js/adw.js';
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(adw, s);
  })();
 *?

/* yima ETC code  start end*/

/* mediav code start */
/* var _mvq = _mvq || [];
_mvq.push(['$setAccount', 'm-354-1']);

_mvq.push(['$logConversion']);
(function() {
	var mvl = document.createElement('script');
	mvl.type = 'text/javascript'; mvl.async = true;
	mvl.src = ('https:' == document.location.protocol ? 'https://static-ssl.mediav.com/mvl.js' : 'http://static.mediav.com/mvl.js');
	var s = document.getElementsByTagName('script')[0];
	s.parentNode.insertBefore(mvl, s); 
})(); */

/* mediav code end */

/* yiqifa cookie handler */

// http://a.okhqb.com/plus/cps_track.php?src=emar&channel=cps&cid=101&wi=NDgwMDB8dGVzdA==&url=http://www.okhqb.com

(function(){
	
	var Referer = document.referrer;
	var yiqifaCookie = $.cookie('yiqifa_cps_okhqb');
    var yqab = $.cookie('yqab');
	try{
		if(!yqab && Referer != '' && Referer.indexOf('okhqb.com') < 0 && yiqifaCookie ){		
			$.cookie(
				'yiqifa_cps_okhqb',
				null,
				{
					path: '/', 
					domain: '.okhqb.com',
					expires: -1
				}
			); 
		}
		$.cookie('yqab',null,{path: '/', domain: '.okhqb.com',expires: -1}); 
	}catch(e){}
	
})();