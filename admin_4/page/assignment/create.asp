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
function checkAdminuser(el){
  var value = $(el).val();
  var url = "checkadminuser.asp",
      par = {uname:value};
      $.ajax({
        url : url,
        type : "GET",
        data : par,
        success : function(data){
          console.log(data);
          if(data>=1){
            layer.msg('该用户名已存在',{
            icon: 2,
            time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
          }
        }    
      });
}  
//Demo
layui.use('form', function(){
  var form = layui.form();

  //监听指定开关
  form.on('switch(switchStatus)', function(data){
    $(this).prev(".layui-checkbox").val(this.checked ? 1 : 0);
    layer.tips('温馨提示：启用/禁用当前用户', data.othis)
  });

  //验证用户名密码
  form.verify({
    username: function(value, item){ //value：表单的值、item：表单的DOM对象
      if(!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)){
        return '用户名不能有特殊字符';
      }
      if(/(^\_)|(\__)|(\_+$)/.test(value)){
        return '用户名首尾不能出现下划线\'_\'';
      }
      if(/^\d+\d+\d$/.test(value)){
        return '用户名不能全为数字';
      }
    }
  
  //我们既支持上述函数式的方式，也支持下述数组的形式
  //数组的两个值分别代表：[正则匹配、匹配不符时的提示文字]
    ,pass: [
      /^[\S]{6,12}$/
      ,'密码必须6到12位，且不能出现空格'
    ] 
  });

  //监听提交
 form.on('submit(formDemo)', function(data){
    //layer.msg(JSON.stringify(data.field));
    return true;
  });

});
</script>

</body>
</html>
