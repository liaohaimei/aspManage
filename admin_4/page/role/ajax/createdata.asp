<!--#include file="../../../admin_inc.asp"-->
<%
str = getForm("str", "get")
echo createData(str)
function createData(str)
	dim child:child=str
		parentid = getForm("parentid", "get")
		name = getForm("name", "get")
	insertSql = "insert into {pre}auth_item_child([parentid],[parent],[child]) values ('"&parentid&"','"&name&"','"&child&"')"
	dbconn.db insertSql,"execute"
	if err  then err.clear : createData=0 else createData=1 end if
end function

%>

