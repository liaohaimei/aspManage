
<!--#include file="admin_inc.asp"-->

<%
dim id:id=getForm("id","post")
dim Lan_name:Lan_name=getForm("Lan_name","post")
dim field_name:field_name=getForm("field_name","post")
	updateSql = field_name&"='"&Lan_name&"'"
	updateSql = "update {pre}Language set "&updateSql&" where ID="&id
	'die updateSql
	conn.db  updateSql,"execute"
	response.write"修改成功！"
	%>
