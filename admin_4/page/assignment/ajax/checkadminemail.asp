<!--#include file="../../../admin_inc.asp"-->
<%
str = getForm("str", "get")
updateid = getForm("updateid", "get")
echo checkAdminemail(str)
function checkAdminemail(str)
	where = " where 1=1"
	where = where&" and email='"&str&"'"
	if varNull(updateid)=true then
		where = where&" and id<>"&updateid&""
	end if
	Sql="select count(*) from {pre}admin "&where&""
 	checkAdminemail = dbconn.db(Sql,"execute")(0)
end function

%>

