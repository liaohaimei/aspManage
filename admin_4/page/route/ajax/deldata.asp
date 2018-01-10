<!--#include file="../../../admin_inc.asp"-->
<%
str = getForm("str", "get")
echo deleteData(str)
function deleteData(str)
	where = " where 1=1"
	where = where&" and name='"&str&"'"
	Sql="delete from {pre}auth_item "&where&""
 	dbconn.db Sql,"execute"
 	if err  then err.clear : deleteData=0 else deleteData=1 end if
end function

%>


