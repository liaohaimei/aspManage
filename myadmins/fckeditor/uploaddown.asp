<!--#include file="../admin_inc.asp"-->
<%checkPower%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<body bgcolor=#FFFFFF leftmargin=0 topmargin=0 style="font-size:11px">
<form name="form" enctype="multipart/form-data" action="uploadddown.asp?act=up&inputname=<%=Request("inputname")%>" method=post>
    <input type=file name=file1 size="12">
    <input type=submit name=submit value="上传">
</form>