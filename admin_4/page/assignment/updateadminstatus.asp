<!--#include file="../../admin_inc.asp"-->
<%
str = getForm("str", "get")
updateid = getForm("updateid", "get")
echo updateAdminStatus(updateid,str)
function updateAdminStatus(updateid,status)
	dim updated_at:updated_at=now()
	where = " where 1=1"
	where = where&" and id="&updateid&""
	Sql="[status]='"&status&"',[updated_at]='"&updated_at&"'"
	updateSql = "update {pre}admin set "&Sql&" "&where&""
	dbconn.db updateSql,"execute"
 	if err  then err.clear : updateAdminStatus=0 else updateAdminStatus=1 end if
end function

%>

