<!--#include file="admin_inc.asp"-->
<%checkPower%>
<%
oid = request.QueryString("oid")
navord = request.QueryString("navord")
updateSql = "update {pre}Navigation Set Sequence="&navord&" Where ID="&oid	
conn.db updateSql,"execute"
%>