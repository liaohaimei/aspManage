<!--#include file="../../../admin_inc.asp"-->
<script src="../../../../assets/scripts/jquery.min.js" type="text/javascript"></script>
<script src="../../../../assets/layer/layer.js"></script>
<script type="text/javascript" src="../../../layui/layui.js"></script>
<script type="text/javascript" src="../js/controller.js"></script>
<%
dim name:name=ReplaceSymbols(getForm("name","post")) : if isNul(name) then name="."
dim type2 : type2 = 1
dim action : action = getForm("action", "get")
dim created_at:created_at=now()
dim updated_at:updated_at=now()
'添加
if action="0" then
	if checkName(name)<=0 then
	insertSql = "insert into {pre}auth_item([name],[type],[created_at],[updated_at]) values ('"&name&"','"&type2&"','"&created_at&"','"&updated_at&"')"
	dbconn.db insertSql,"execute"
	echo "<script>$(function(){fun._alertMes()})</script>"
	else
	echo "<script>$(function(){fun._alertFail()})</script>"
	end if
end if
'修改
if action="1" then
	dim id : id = getForm("id", "get")
	if editCheckName(name,id)<=0 then
	sqlstr="[name]='"&name&"',[type]='"&type2&"',[updated_at]='"&updated_at&"'"
	updateSql = "update {pre}auth_item  set "&sqlstr&" where ID="&id
	dbconn.db updateSql,"execute"
	echo "<script>$(function(){fun._alertSuccess()})</script>"
	else
	echo "<script>$(function(){fun._alertFail()})</script>"
	end if

end if

'添加时检测名称
function checkName(str)
	Sql="select count(*) from {pre}auth_item where name='"&str&"'"
 	checkName = dbconn.db(Sql,"execute")(0)
end function
'修改时检测名称
function editCheckName(str,id)
	Sql="select count(*) from {pre}auth_item where name='"&str&"' and id<>"&id&""
 	editCheckName = dbconn.db(Sql,"execute")(0)
end function
%>

