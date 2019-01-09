<?php

function p($var)
{
    if(is_bool($var) || is_null($var)){
        var_dump($var);
        return;
    }
    echo "<pre style='background-color: #ccc;padding: 50px;font-size: 14px;color: red;font-weight: 700'>" . print_r($var, true) . "</pre>";
}

/**
 * 数组分页函数  核心函数  array_slice
 * 用此函数之前要先将数据库里面的所有数据按一定的顺序查询出来存入数组中
 * $count   每页多少条数据
 * $page   当前第几页
 * $array   查询出来的所有数组
 * order 0 - 不变     1- 反序
 */

function page_array($count,$page,$array,$order=0){
    global $countpage; #定全局变量
    $page=(empty($page))?'1':$page; #判断当前页面是否为空 如果为空就表示为第一页面
    $start=($page-1)*$count; #计算每次分页的开始位置
    if($order==1){
        $array=array_reverse($array);
    }
    $totals=count($array);
    $countpage=ceil($totals/$count); #计算总页面数
    define('__COUNTPAGE__',$countpage);
    $pagedata=array();
    $pagedata=array_slice($array,$start,$count);
    return $pagedata;  #返回查询数据
}
/**
 * 分页及显示函数
 * $countpage 全局变量，照写
 * $url 当前url
 */
//$url = $_SERVER['HTTP_HOST'].$_SERVER['SCRIPT_NAME'];
function show_array($countpage,$url){
    $page=empty($_GET['page'])?1:$_GET['page'];
    if($page > 1){
        $uppage=$page-1;

    }else{
        $uppage=1;
    }

    if($page < $countpage){
        $nextpage=$page+1;

    }else{
        $nextpage=$countpage;
    }

    $str='<div style="border:1px; width:100%; height:30px; color:#9999CC">';
    if($page==1){
        $str.="<a class='btn btn-default btn-xs' disabled>   首页  </a>";
        $str.="<a class='btn btn-turquoise btn-xs' disabled> 上一页  </a>";
    }else{
        $str.="<a href='//$url?page=1' class='btn btn-default btn-xs'>   首页  </a>";
        $str.="<a href='//$url?page={$uppage}' class='btn btn-turquoise btn-xs'> 上一页  </a>";
    }
    if($page==$countpage){
        $str.="<a class='btn btn-turquoise btn-xs' disabled>下一页  </a>";
        $str.="<a class='btn btn-default btn-xs' disabled>尾页  </a>";
    }else{
        $str.="<a href='//$url?page={$nextpage}' class='btn btn-turquoise btn-xs'>下一页  </a>";
        $str.="<a href='//$url?page={$countpage}' class='btn btn-default btn-xs'>尾页  </a>";
    }

    $str.="<span class='pull-right'>共  {$countpage}  页 / 第 {$page} 页</span>";
    $str.='</div>';
    return $str;
}
