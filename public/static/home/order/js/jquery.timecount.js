/*! jQuery Timecount */

var COUNTER_OPTIONS;
(function($){
	$.timecount = function(options){
		var defaults={
			ts:0,
			container: "",
			hour_id: "",
			second_id: "",
			minute_id: "",
			fmt:"HH小时ii分ss秒",
			timeout:function(){}
		}
		for(k in options){
			if(defaults[k] != 'undifined')
			{
				defaults[k] = options[k];
			}
		}
		COUNTER_OPTIONS = defaults;
		fun_timecount();
	}
})(jQuery);
function fun_timecount()
{
	if(COUNTER_OPTIONS['ts'] < 0) COUNTER_OPTIONS['ts'] = 0;

	var hours = Math.floor(COUNTER_OPTIONS['ts'] /(60 * 60));
    var minutes = Math.floor(COUNTER_OPTIONS['ts'] / 60) % 60;
    var seconds = COUNTER_OPTIONS['ts'] % 60;

	hours = hours < 10?'0'+hours:hours;
	minutes = minutes < 10?'0'+minutes:minutes;
	seconds = seconds < 10?'0'+seconds:seconds;

	if(COUNTER_OPTIONS['container'] != '')
	{
		var str = COUNTER_OPTIONS['fmt'].replace('HH', hours);
		str = str.replace('ii', minutes);
		str = str.replace('ss', seconds);
		document.getElementById(COUNTER_OPTIONS['container']).innerHTML = str;
	}
	if(COUNTER_OPTIONS['hour_id'] != '')
	{
		document.getElementById(COUNTER_OPTIONS['hour_id']).innerHTML = hours;
	}
	if(COUNTER_OPTIONS['minute_id'] != '')
	{
		document.getElementById(COUNTER_OPTIONS['minute_id']).innerHTML = minutes;
	}
	if(COUNTER_OPTIONS['second_id'] != '')
	{
		document.getElementById(COUNTER_OPTIONS['second_id']).innerHTML = seconds;
	}

	COUNTER_OPTIONS['ts']--;
	if(COUNTER_OPTIONS['ts'] >= 0)
	{
		setTimeout("fun_timecount()", 1000);
		return;
	}
	if(typeof(COUNTER_OPTIONS['timeout']) == 'function')
	{
		COUNTER_OPTIONS['timeout']();
	}
}
