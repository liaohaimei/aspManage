<!--#include file="../../admin_inc.asp"-->
<script src="../../../assets/scripts/jquery.min.js" type="text/javascript"></script>
<script src="../../../assets/layer/layer.js"></script>
<script type="text/javascript" src="../../layui/layui.js"></script>
<script type="text/javascript" src="index.js"></script>
<%
dim username:username=ReplaceSymbols(getForm("username","post")) : if isNul(username) then username="."
dim email:email=ReplaceSymbols(getForm("email","post"))
dim opwd:opwd=getForm("password","post")
dim password:password=md5(ReplaceSymbols(getForm("password","post"))&salt)
dim status:status=ReplaceSymbols(getForm("status","post"))
dim action : action = getForm("action", "get")
dim created_at:created_at=now()
dim updated_at:updated_at=now()
dim editpwd:editpwd=getForm("editpwd", "post")
'添加
if action="0" then
	if checkAdminuser(username)<=0 and checkAdminemail(email)<=0 then
	insertSql = "insert into {pre}admin([username],[email],[password],[status],[created_at],[updated_at]) values ('"&username&"','"&email&"','"&password&"','"&status&"','"&created_at&"','"&updated_at&"')"
	dbconn.db insertSql,"execute"
	echo "<script>$(function(){fun._alertMes()})</script>"
	else
	echo "<script>$(function(){fun._alertFail()})</script>"
	end if
end if
'修改
if action="1" then
	dim id : id = getForm("id", "get")
	if editCheckAdminuser(username,id)<=0 and  editCheckAdminemail(email,id)<=0 then
	if  getForm("password","post")<>"" then
	pwd=",[password]='"&password&"'"
	end if
	sqlstr="[username]='"&username&"',[email]='"&email&"'"&pwd&",[status]='"&status&"',[updated_at]='"&updated_at&"'"
	updateSql = "update {pre}admin  set "&sqlstr&" where ID="&id
	dbconn.db updateSql,"execute"
	echo "<script>$(function(){fun._alertSuccess()})</script>"
	else
	echo "<script>$(function(){fun._alertFail()})</script>"
	end if
end if


function getPar(id)
getPar=getForm(id,"get")
if varNull(getPar)=false then
getPar=0
end if 	
end function

'添加时检测用户名
function checkAdminuser(str)
	Sql="select count(*) from {pre}admin where username='"&str&"'"
 	checkAdminuser = dbconn.db(Sql,"execute")(0)
end function
'添加时检测邮箱
function checkAdminemail(str)
	Sql="select count(*) from {pre}admin where email='"&str&"'"
 	checkAdminemail = dbconn.db(Sql,"execute")(0)
end function
'修改时检测用户名
function editCheckAdminuser(str,id)
	Sql="select count(*) from {pre}admin where username='"&str&"' and id<>"&id&""
 	editCheckAdminuser = dbconn.db(Sql,"execute")(0)
end function
'修改时检测邮箱
function editCheckAdminemail(str,id)
	Sql="select count(*) from {pre}admin where email='"&str&"' and id<>"&id&""
 	editCheckAdminemail = dbconn.db(Sql,"execute")(0)
end function
%>

