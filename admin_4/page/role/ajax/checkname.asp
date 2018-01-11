<!--#include file="../../../admin_inc.asp"-->
<%
str = getForm("str", "get")
updateid = getForm("updateid", "get")
echo checkName(str,updateid)
function checkName(str,updateid)
	where = " where 1=1"
	where = where&" and name='"&str&"'"
	if varNull(updateid)=true then
		where = where&" and id<>"&updateid&""
	end if
	Sql="select count(*) from {pre}auth_item "&where&""
 	checkName = dbconn.db(Sql,"execute")(0)
end function

%>

