<!--dialogJs消息弹窗-->
document.write('<script src="/addons/dialog/js/dialog.js"></script>');

//删除确认
function delconfirm(url) {
    $('body').dialog({
        type: 'warning',
        showBoxShadow: true,
        buttons: ['确定','取消'],
        discription: '删除后不可恢复，您确认要删除吗？',
        animateIn: 'fadeIn',
        animateOut: 'fadeOut'
    }, function (ret) {
        if(ret.index === 0) {
            ajax_func(url);
        }
    });//$('body')
}//delconfirm
//异步弹窗
function ajax_func(url) {
    $.ajax({
        url:url,
        dataType:'json',
        success:function(response){
            response = JSON.parse(response);
            icon = response.status?6:5;
            layer.alert(response.msg, {icon: icon});
        }
    });
}//ajax_func



//如果在click中用var obj则会有bug点击一个取消再点击一个确定则页面会显示两个被删除
// （虽然只发了一个异步实际删除一个）但是影响体验效果
//可能的原因是var会开辟新的内存空间再赋值
//而let只开辟一个内存空间在其中赋值或替换
let obj;

//与异步删除同步删除页面标签：栏目列表
    $('.btn-del-category').click(function () {
        obj = $(this).parents('.gradeU');
        var cid = obj.find('td.cid').text();//当前要删除的记录的cid
        //查找下一条记录的pid（因为经过树形结构，如果有子栏目则会排在下面）
        var pid = obj.next().find('td .btn-del').attr('pid');

        $('body').on('click','.btn_span[data-name=确定]',function () {
            //如果当前记录的cid等于下一条记录的pid（即当前栏目为下一栏目的父栏目）则不删除
            //否则删除
            if(cid!=pid){
                obj.css('backgroundColor','red').animate({'opacity':0},1000,function () {
                    obj.remove();
                });
            }
        });
    });
//与异步删除同步删除页面标签：商品列表
$('.btn-del-goods').click(function () {
    obj = $(this).parents('.gradeU');
    $('body').on('click','.btn_span[data-name=确定]',function () {
        obj.css('backgroundColor','red').animate({'opacity':0},1000,function () {
            obj.remove();
        });
    });
});


