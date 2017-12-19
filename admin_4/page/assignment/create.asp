<!--#include file="../../admin_inc.asp"-->
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>后台管理系统</title>
    <link rel="stylesheet" href="../../layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="../../css/news.css" media="all" />
</head>
<body>

<div class="layui-fluid">
<!--#include file="_form.asp"-->
</div>
<script src="../../../assets/scripts/jquery.min.js" type="text/javascript"></script>
<script src="../../../assets/layer/layer.js"></script>
<script type="text/javascript" src="../../layui/layui.js"></script>
<script>
//Demo
layui.use('form', function(){
  var form = layui.form();

  //监听指定开关
  form.on('switch(switchStatus)', function(data){
    $(this).prev(".layui-checkbox").val(this.checked ? 1 : 0);
    layer.tips('温馨提示：启用/禁用当前用户', data.othis)
  });
  //监听提交
 /* form.on('submit(formDemo)', function(data){
    layer.msg(JSON.stringify(data.field));
    return true;
  });*/
});
</script>

<script>
var fun = {
    _alertMes:function(){
      layer.msg('添加成功', {btn: ['继续添加', '退出添加'],no: function(index, layero){},btn2: function(index, layero){window.parent.location.reload();parent.layer.closeAll();}});
    },
    _alertSuccess:function(){
      layer.msg('修改成功',{
        icon: 1,
        time: 2000 //2秒关闭（如果不配置，默认是3秒）
      },function(){window.parent.location.reload();parent.layer.closeAll();});
    }    
  };
</script>
</body>
</html>
