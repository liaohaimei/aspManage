<!--#include file="../../../admin_inc.asp"-->
<%
delid = getForm("delid", "get")
echo delAdminuser(delid)
function delAdminuser(delid)
	where = " where 1=1"
	where = where&" and id="&delid&""
	Sql="delete from {pre}admin "&where&""
 	dbconn.db Sql,"execute"
 	if err  then err.clear : delAdminuser=0 else delAdminuser=1 end if
end function

%>

