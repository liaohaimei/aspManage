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
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>创建角色</legend>
</fieldset>

<%
cid=getPar("id")              '当前ID
ac=getPar("ac")               '修改状态
if cid<>"" and ac<>0 then
sql = "select * from {pre}admin where ID = "&cid
set rsObj = dbconn.db(sql,"records1")
if not rsObj.eof then
username=rsObj("username")
email=rsObj("email")
password=rsObj("password")
end if
rsObj.close : set rsObj=nothing
end if
%>
<form class="layui-form"  action="?action=<%=getPar("ac")%>&id=<%=getForm("id","get")%>" method="post">
  <div class="layui-form-item">
    <label class="layui-form-label">用户名</label>
    <div class="layui-input-block">
      <input type="text" autocomplete="off"  class="layui-input" id="input-username" name="username" value="<%=username%>" placeholder="用户名">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">邮箱</label>
    <div class="layui-input-block">
      <input type="text" autocomplete="off"  class="layui-input"  id="input-email" name="email" value="<%=email%>" placeholder="邮箱">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">密码</label>
    <div class="layui-input-block">
      <input type="password" autocomplete="off"  class="layui-input"  id="input-password" name="password" value="<%=password%>" placeholder="密码">
    </div>
  </div>
   <div class="layui-form-item">
    <label class="layui-form-label">状态</label>
    <div class="layui-input-block">
    	<input class="layui-checkbox" type="hidden" name="status" value="1">
    	<input type="checkbox" checked  lay-filter="switchStatus" lay-skin="switch" lay-text="启用|禁用" >
    </div>
  </div>




  <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" lay-submit>新增</button>
    </div>
  </div>
</form>
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
<!--#include file="create.asp"-->
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
