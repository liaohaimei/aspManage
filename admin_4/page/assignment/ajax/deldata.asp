<!--#include file="../../../admin_inc.asp"-->
<%
str = getForm("str", "get")
echo delData(str)
function delData(str)
	where = " where 1=1"
	where = where&" and item_name='"&str&"'"
	Sql="delete from {pre}auth_assignment "&where&""
 	dbconn.db Sql,"execute"
 	if err  then err.clear : delData=0 else delData=1 end if
end function

%>

