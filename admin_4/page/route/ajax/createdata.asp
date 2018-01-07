<!--#include file="../../../admin_inc.asp"-->
<%
str = getForm("str", "get")
echo createData(str)
function createData(str)
	dim name:name=str
	dim type2 : type2 = 1
	dim created_at:created_at=now()
	dim updated_at:updated_at=now()
	insertSql = "insert into {pre}auth_item([name],[type],[created_at],[updated_at]) values ('"&name&"','"&type2&"','"&created_at&"','"&updated_at&"')"
	dbconn.db insertSql,"execute"
	if err  then err.clear : createData=0 else createData=1 end if
end function

%>

