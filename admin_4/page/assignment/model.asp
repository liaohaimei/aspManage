<!--#include file="../../admin_inc.asp"-->
<%
dim username:username=ReplaceSymbols(getForm("username","post")) : if isNul(username) then username="."
dim email:email=ReplaceSymbols(getForm("email","post"))
dim password:password=md5(ReplaceSymbols(getForm("password","post"))&salt)
dim status:status=ReplaceSymbols(getForm("status","post"))
dim action : action = getForm("action", "get")
dim created_at:created_at=now()
dim updated_at:updated_at=now()
echo action
'添加
if action="0" then
insertSql = "insert into {pre}admin([username],[email],[password],[status],[created_at],[updated_at]) values ('"&username&"','"&email&"','"&password&"','"&status&"','"&created_at&"','"&updated_at&"')"
dbconn.db insertSql,"execute"
echo "<script>$(function(){fun._alertMes()})</script>"
end if
'修改
if action="1" then
sqlstr="username='"&username&"',email='"&email&"',password='"&password&"'"
updateSql = "update {pre}admin  set "&sqlstr&" where ID="&getForm("id","get")
dbconn.db updateSql,"execute"
echo "<script>$(function(){fun._alertSuccess()})</script>"
end if


function getPar(id)
getPar=getForm(id,"get")
if varNull(getPar)=false then
getPar=0
end if 	
end function


%>

