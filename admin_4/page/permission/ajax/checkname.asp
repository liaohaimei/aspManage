<!--#include file="../../../admin_inc.asp"-->
<%
str = getForm("str", "get")
updateid = getForm("updateid", "get")
echo checkAdminuser(str,updateid)
function checkAdminuser(str,updateid)
	where = " where 1=1"
	where = where&" and username='"&str&"'"
	if varNull(updateid)=true then
		where = where&" and id<>"&updateid&""
	end if
	Sql="select count(*) from {pre}admin "&where&""
 	checkAdminuser = dbconn.db(Sql,"execute")(0)
end function

%>

