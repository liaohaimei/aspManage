
<%
btnName="新增"
typ=getForm("typ","get")
id=getForm("id","get")              '当前ID
if id<>"" then
btnName="更新"
sql = "select * from {pre}admin where ID = "&id
set rsObj = dbconn.db(sql,"records1")
if not rsObj.eof then
username  = rsObj("username")
email     = rsObj("email")
password  = rsObj("password")
status    = rsObj("status")
end if
rsObj.close : set rsObj=nothing
end if
%>
<div class="layui-row">
<form class="layui-form"  action="model.asp?action=<%=typ%>&id=<%=id%>" method="post">
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
      <input type="password" autocomplete="off"  class="layui-input"  id="input-password" name="password" value="" placeholder="密码">
    </div>
  </div>
   <div class="layui-form-item">
    <label class="layui-form-label">状态</label>
    <div class="layui-input-block">
    	<input class="layui-checkbox" type="hidden" name="status" value="1">
    	<input type="checkbox" <%if status=1 then echo" checked" end if%>  lay-filter="switchStatus" lay-skin="switch" lay-text="启用|禁用" >
    </div>
  </div>

  <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" lay-submit><%=btnName%></button>
    </div>
  </div>
</form>
  </div>


