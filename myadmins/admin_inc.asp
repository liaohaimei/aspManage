<!--#include file="../inc/Main_Class.asp"-->
<!--#include file="../inc/md5.asp"-->
<%
dim checkManagerLevel
'****************************************************
'Code for cms668com
'Vision : v2.0
'****************************************************
Sub clearPower
	wCookie "check"&rCookie("UserName"),""
	wCookie "UserName",""
	wCookie "UserID",""
	wCookie "AdminPower",""
	echo "<script>top.location.href='index.asp';</script>"
End Sub

Sub checkPower
	dim loginValidate,rsObj : loginValidate = "668cms"
	err.clear
	on error resume next
	set rsObj=conn.db("select M_Random,AdminPower from {pre}AdminUser where UserName='"&replaceStr(rCookie("UserName"),"'","")&"'","execute")
	loginValidate = md5(getAgent&rsObj(0))
	if err then wCookie "check"&rCookie("UserName"),"" : die "<script>top.location.href='index.asp';</script>"
	if rCookie("check"&rCookie("UserName"))<>loginValidate then wCookie "check"&rCookie("UserName"),"" : die "<script>top.location.href='index.asp?action=login';</script>"
	checkManagerLevel = rsObj(1)
	set rsObj=nothing
End Sub

%>