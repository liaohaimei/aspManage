
<%
typ=getForm("typ","get")
'cid=getPar("id")              '当前ID
'ac=getPar("ac")               '修改状态
' if cid<>"" and ac<>0 then
' sql = "select * from {pre}admin where ID = "&cid
' set rsObj = dbconn.db(sql,"records1")
' if not rsObj.eof then
' username=rsObj("username")
' email=rsObj("email")
' password=rsObj("password")
' end if
' rsObj.close : set rsObj=nothing
' end if
%>
<form class="layui-form"  action="model.asp?action=<%=typ%>" method="post">
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

