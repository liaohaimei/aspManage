<!--#include file="../../../admin_inc.asp"-->
<%
delid = getForm("delid", "get")
echo delData(delid)
function delData(delid)
	where = " where 1=1"
	where = where&" and id="&delid&""
	Sql="delete from {pre}auth_item "&where&""
 	dbconn.db Sql,"execute"
 	if err  then err.clear : delData=0 else delData=1 end if
end function

%>

