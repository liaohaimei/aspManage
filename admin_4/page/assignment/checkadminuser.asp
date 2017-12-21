<!--#include file="../../admin_inc.asp"-->
<%
uname = getForm("uname", "get")
echo checkAdminuser(uname)
function checkAdminuser(uname)
	Sql="select count(*) from {pre}admin where username='"&uname&"'"
 	checkAdminuser = dbconn.db(Sql,"execute")(0)
end function

%>

