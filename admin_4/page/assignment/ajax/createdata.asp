<!--#include file="../../../admin_inc.asp"-->
<%
str = getForm("str", "get")
echo createData(str)
function createData(str)
	dim name:name	=	str
		parentid 	= 	getForm("parentid", "get")
		itemid 	= 	getForm("itemid", "get")
		created_at 	= 	now()
	insertSql = "insert into {pre}auth_assignment([item_id],[item_name],[user_id],[created_at]) values ("&itemid&",'"&name&"','"&parentid&"','"&created_at&"')"
	dbconn.db insertSql,"execute"
	if err  then err.clear : createData=0 else createData=1 end if
end function

%>

