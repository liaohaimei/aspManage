<!--#include file="../../../admin_inc.asp"-->
<%
str = getForm("str", "get")
echo delData(str)
function delData(str)
	where = " where 1=1"
	where = where&" and child='"&str&"'"
	Sql="delete from {pre}auth_item_child "&where&""
 	dbconn.db Sql,"execute"
 	if err  then err.clear : delData=0 else delData=1 end if
end function

%>

