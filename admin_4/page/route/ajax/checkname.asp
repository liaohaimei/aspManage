<!--#include file="../../../admin_inc.asp"-->
<%
str = getForm("str", "get")
echo checkName(str)
function checkName(str)
	where = " where 1=1"
	where = where&" and name='"&str&"'"
	Sql="select count(*) from {pre}auth_item "&where&""
 	checkName = dbconn.db(Sql,"execute")(0)
end function

%>

