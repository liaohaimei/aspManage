<!--#include file="admin_inc.asp"-->
<%checkPower%>
<%
oid = request.QueryString("oid")
navname = request.QueryString("navname")
updateSql = "update {pre}Navigation Set NavName='"&navname&"' Where ID="&oid	
conn.db updateSql,"execute"
%>