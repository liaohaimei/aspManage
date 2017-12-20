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

</body>
</html>
