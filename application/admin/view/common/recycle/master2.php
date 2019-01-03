<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="/static/admin/master/images/favicon.png">

    <title>后台</title>



    <!-- Bootstrap core CSS -->
    <link href="/static/admin/master/js/bootstrap/dist/css/bootstrap.css" rel="stylesheet"/>
    <link rel="stylesheet" href="/static/admin/master/fonts/font-awesome-4/css/font-awesome.min.css">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="/static/admin/master/js/html5shiv.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="/static/admin/master/js/jquery.gritter/css/jquery.gritter.css"/>

    <link rel="stylesheet" type="text/css" href="/static/admin/master/js/jquery.nanoscroller/nanoscroller.css"/>
    <link rel="stylesheet" type="text/css"
          href="/static/admin/master/js/jquery.easypiechart/jquery.easy-pie-chart.css"/>
    <link rel="stylesheet" type="text/css" href="/static/admin/master/js/bootstrap.switch/bootstrap-switch.css"/>
    <link rel="stylesheet" type="text/css"
          href="/static/admin/master/js/bootstrap.datetimepicker/css/bootstrap-datetimepicker.min.css"/>
    <link rel="stylesheet" type="text/css" href="/static/admin/master/js/jquery.select2/select2.css"/>
    <link rel="stylesheet" type="text/css" href="/static/admin/master/js/bootstrap.slider/css/slider.css"/>

    <!--消息弹出框样式-->
    <link rel="stylesheet" href="/addons/dialog/css/global.css">
    <link rel="stylesheet" href="/addons/dialog/css/dialog.css">

    <!-- Custom styles for this template -->
    <link href="/static/admin/master/css/style.css" rel="stylesheet"/>
    <link href="/static/admin/master/css/fix.css" rel="stylesheet"/>

    <script type="text/javascript" src="/static/admin/master/js/jquery.js"></script>

    <script>
        //模块配置项
        var hdjs = {
            //框架目录
            'base': '/node_modules/hdjs',
            //上传文件后台地址
            'uploader': '/admin/upload/uploader',
            //获取文件列表的后台地址
            'filesLists': '/component/filesLists?',
        };
    </script>
    <script src="/node_modules/hdjs/app/util.js"></script>
    <script src="/node_modules/hdjs/require.js"></script>
    <script src="/node_modules/hdjs/config.js"></script>
</head>
<body>

<!--顶部导航栏-->
<div id="head-nav" class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="fa fa-gear"></span>
            </button>
            <a class="navbar-brand" href="#"><span>后台管理</span></a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">常用</a></li>
                <li><a href="#about">我的面板</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">设置 <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">Action</a></li>
                        <li><a href="#">Another action</a></li>
                        <li><a href="#">Something else here</a></li>
                        <li class="dropdown-submenu"><a href="#">abc</a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">模块<b class="caret"></b></a>
                    <ul class="dropdown-menu col-menu-2">
                        <li class="col-sm-6 no-padding">
                            <ul>
                                <li class="dropdown-header"><i class="fa fa-group"></i>Users</li>
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                                <li class="dropdown-header"><i class="fa fa-gear"></i>Config</li>
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                            </ul>
                        </li>
                        <li class="col-sm-6 no-padding">
                            <ul>
                                <li class="dropdown-header"><i class="fa fa-legal"></i>Sales</li>
                                <li><a href="#">New sale</a></li>
                                <li><a href="#">Register a product</a></li>
                                <li><a href="#">Register a client</a></li>
                                <li><a href="#">Month sales</a></li>
                                <li><a href="#">Delivered orders</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right user-nav">
                <li class="dropdown profile_menu">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><img alt="Avatar"
                                                                                    src="/static/admin/master/images/avatar2.jpg"/><span>{:think\\Session::get('username')}</span>
                        <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">账号中心</a></li>
                        <li><a href="{:url('user/changePassword')}">修改密码</a></li>
                        <li class="divider"></li>
                        <li><a href="{:url('user/logout')}">退出</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right not-nav">
                <li class="button dropdown">
                    <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown"><i
                                class=" fa fa-comments"></i></a>
                    <ul class="dropdown-menu messages">
                        <li>
                            <div class="nano nscroller">
                                <div class="content">
                                    <ul>
                                        <li>
                                            <a href="#">
                                                <img src="/static/admin/master/images/avatar2.jpg" alt="avatar"/><span
                                                        class="date pull-right">13 Sept.</span> <span class="name">Daniel</span>
                                                I'm following you, and I want your money!
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <img src="/static/admin/master/images/avatar_50.jpg" alt="avatar"/><span
                                                        class="date pull-right">20 Oct.</span><span
                                                        class="name">Adam</span> is now following you
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <img src="/static/admin/master/images/avatar4_50.jpg"
                                                     alt="avatar"/><span class="date pull-right">2 Nov.</span><span
                                                        class="name">Michael</span> is now following you
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <img src="/static/admin/master/images/avatar3_50.jpg"
                                                     alt="avatar"/><span class="date pull-right">2 Nov.</span><span
                                                        class="name">Lucy</span> is now following you
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <ul class="foot">
                                <li><a href="#">View all messages </a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li class="button dropdown">
                    <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown"><i
                                class="fa fa-globe"></i><span class="bubble">2</span></a>
                    <ul class="dropdown-menu">
                        <li>
                            <div class="nano nscroller">
                                <div class="content">
                                    <ul>
                                        <li><a href="#"><i class="fa fa-cloud-upload info"></i><b>Daniel</b> is now
                                                following you <span class="date">2 minutes ago.</span></a></li>
                                        <li><a href="#"><i class="fa fa-male success"></i> <b>Michael</b> is now
                                                following you <span class="date">15 minutes ago.</span></a></li>
                                        <li><a href="#"><i class="fa fa-bug warning"></i> <b>Mia</b> commented on post
                                                <span class="date">30 minutes ago.</span></a></li>
                                        <li><a href="#"><i class="fa fa-credit-card danger"></i> <b>Andrew</b> killed
                                                someone <span class="date">1 hour ago.</span></a></li>
                                    </ul>
                                </div>
                            </div>
                            <ul class="foot">
                                <li><a href="#">View all activity </a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li class="button"><a href="javascript:;" class="speech-button"><i class="fa fa-microphone"></i></a>
                </li>
            </ul>

        </div><!--/.nav-collapse animate-collapse -->
    </div>
</div>

<div id="cl-wrapper" class="fixed-menu">

    <!--侧边栏-->
    <div class="cl-sidebar" data-position="right" data-step="1"
         data-intro="<strong>Fixed Sidebar</strong> <br/> It adjust to your needs.">
        <div class="cl-toggle"><i class="fa fa-bars"></i></div>
        <div class="cl-navblock">
            <div class="menu-space">
                <div class="content">
                    <div class="side-user">
                        <div class="info">
                            <p>Disk Usage: 40 <b>GB</b> / 100 <b>GB</b><a href="#"><i class="fa fa-plus"></i></a></p>
                            <div class="progress progress-user">
                                <div style="width: 40%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="40"
                                     role="progressbar" class="progress-bar progress-bar-info">
                                    <span class="sr-only">50% Complete (success)</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <ul class="cl-vnavigation">
                        <li><a href="#"><i class="fa fa-home"></i><span>Dashboard</span></a>
                            <ul class="sub-menu">
                                <li class="active"><a href="index.html">Version 1</a></li>
                                <li><a href="dashboard2.html"><span class="label label-primary pull-right">New</span>
                                        Version 2</a></li>
                            </ul>
                        </li>
                        <!--栏目管理-->
                        <li><a href="#"><i class="fa fa-smile-o"></i><span>栏目管理</span></a>
                            <ul class="sub-menu">
                                <li><a href="{:url('category/lists')}">栏目列表</a></li>
                                <li><a href="{:url('category/add')}">栏目添加</a></li>
                            </ul>
                        </li>
                        <!--//栏目管理-->

                        <!--商品管理-->
                        <li><a href="#"><i class="fa fa-list-alt"></i><span>商品管理</span></a>
                            <ul class="sub-menu">
                                <li><a href="/admin/goods/lists">商品列表</a></li>
                                <li><a href="/admin/goods/add">商品添加<span class="label label-primary pull-right">New</span></a></li>
                            </ul>
                        </li>
                        <!--//商品管理-->

                        <li><a href="#"><i class="fa fa-table"></i><span>Tables</span></a>
                            <ul class="sub-menu">
                                <li><a href="tables-general.html">General</a></li>
                                <li><a href="tables-datatables.html"><span
                                                class="label label-primary pull-right">New</span>Data Tables</a></li>
                            </ul>
                        </li>
                        <li><a href="#"><i class="fa fa-map-marker nav-icon"></i><span>Maps</span></a>
                            <ul class="sub-menu">
                                <li><a href="maps.html">Google Maps</a></li>
                                <li><a href="vector-maps.html"><span class="label label-primary pull-right">New</span>Vector
                                        Maps</a></li>
                            </ul>
                        </li>
                        <li><a href="#"><i class="fa fa-envelope nav-icon"></i><span>Email</span></a>
                            <ul class="sub-menu">
                                <li><a href="email-inbox.html">Inbox</a></li>
                                <li><a href="email-read.html">Email Detail</a></li>
                                <li><a href="email-compose.html"><span class="label label-primary pull-right">New</span>Email
                                        Compose</a></li>
                            </ul>
                        </li>
                        <li><a href="typography.html"><i class="fa fa-text-height"></i><span>Typography</span></a></li>
                        <li><a href="charts.html"><i class="fa fa-bar-chart-o"></i><span>Charts</span></a></li>
                        <li><a href="#"><i class="fa fa-file"></i><span>Pages</span></a>
                            <ul class="sub-menu">
                                <li><a href="pages-blank.html">Blank Page</a></li>
                                <li><a href="pages-blank-header.html">Blank Page Header</a></li>
                                <li><a href="pages-blank-aside.html">Blank Page Aside</a></li>
                                <li><a href="pages-login.html">Login</a></li>
                                <li><a href="pages-404.html">404 Page</a></li>
                                <li><a href="pages-500.html">500 Page</a></li>
                                <li><a href="pages-sign-up.html"><span class="label label-primary pull-right">New</span>Sign
                                        Up</a></li>
                                <li><a href="pages-forgot-password.html"><span class="label label-primary pull-right">New</span>Forgot
                                        Password</a></li>
                                <li><a href="pages-profile.html"><span class="label label-primary pull-right">New</span>Profile</a>
                                </li>
                                <li><a href="pages-search.html"><span class="label label-primary pull-right">New</span>Search</a>
                                </li>
                                <li><a href="pages-calendar.html"><span
                                                class="label label-primary pull-right">New</span>Calendar</a></li>
                                <li><a href="pages-code-editor.html"><span
                                                class="label label-primary pull-right">New</span>Code Editor</a></li>
                                <li><a href="pages-gallery.html">Gallery</a></li>
                                <li><a href="pages-timeline.html">Timeline</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="text-right collapse-button" style="padding:7px 9px;">
                <input type="text" class="form-control search" placeholder="Search..."/>
                <button id="sidebar-collapse" class="btn btn-default" style=""><i style="color:#fff;"
                                                                                  class="fa fa-angle-left"></i></button>
            </div>
        </div>
    </div>

    <!--中间操作内容区-->
    <div class="container-fluid" id="pcont">
        <link href="/static/admin/category/fix.css" rel="stylesheet">
        {block name="content"}操作内容{/block}
    </div>

</div>


<script type="text/javascript" src="/static/admin/master/js/jquery.gritter/js/jquery.gritter.js"></script>
<script type="text/javascript" src="/static/admin/master/js/jquery.nanoscroller/jquery.nanoscroller.js"></script>
<script type="text/javascript" src="/static/admin/master/js/behaviour/general.js"></script>
<script src="/static/admin/master/js/jquery.ui/jquery-ui.js" type="text/javascript"></script>
<script type="text/javascript" src="/static/admin/master/js/jquery.sparkline/jquery.sparkline.min.js"></script>
<script type="text/javascript" src="/static/admin/master/js/jquery.easypiechart/jquery.easy-pie-chart.js"></script>
<script type="text/javascript" src="/static/admin/master/js/jquery.nestable/jquery.nestable.js"></script>
<script type="text/javascript" src="/static/admin/master/js/bootstrap.switch/bootstrap-switch.min.js"></script>
<script type="text/javascript" src="/static/admin/master/js/bootstrap.datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script src="/static/admin/master/js/jquery.select2/select2.min.js" type="text/javascript"></script>
<script src="/static/admin/master/js/skycons/skycons.js" type="text/javascript"></script>
<script src="/static/admin/master/js/bootstrap.slider/js/bootstrap-slider.js" type="text/javascript"></script>


<!-- Bootstrap core JavaScript
  ================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init({
            nanoScroller: false
        });

        App.dashBoard();

        introJs().setOption('showBullets', false).start();

    });
</script>
<script src="/static/admin/master/js/behaviour/voice-commands.js"></script>
<script src="/static/admin/master/js/bootstrap/dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/static/admin/master/js/jquery.flot/jquery.flot.js"></script>
<script type="text/javascript" src="/static/admin/master/js/jquery.flot/jquery.flot.pie.js"></script>
<script type="text/javascript" src="/static/admin/master/js/jquery.flot/jquery.flot.resize.js"></script>
<script type="text/javascript" src="/static/admin/master/js/jquery.flot/jquery.flot.labels.js"></script>


<!--消息弹窗-->
<script src="/addons/dialog/js/dialog.js"></script>
<!--异步弹窗-->
<script>
    //var stat;
    function ajax_func(url) {
        $.ajax({
            url:url,
            dataType:'json',
            success:function(response){

                response = JSON.parse(response);
                //stat = response.status;
                let type = response.status?'success':'danger';
                $('body').dialog({
                    type: type,
                    showBoxShadow: true,
                    buttons: ['确定'],
                    discription: response.msg,
                    animateIn: 'fadeIn',
                    animateOut: 'fadeOut'
                }, function (ret) {


                })//$('body')
            }
        });
    }
</script>
<!--自定义补充js：与异步同时删除页面标签-->
<script type="text/javascript" src="/static/admin/master/extends/ps.js"></script>
</body>
</html>
