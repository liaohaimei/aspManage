<!--#include file="admin_inc.asp"-->
<%checkPower%>
<%
oid = request.QueryString("oid")
orderval = request.QueryString("orderval")
updateSql = "update {pre}Product Set ord="&orderval&" Where ID="&oid	
conn.db updateSql,"execute"
%>