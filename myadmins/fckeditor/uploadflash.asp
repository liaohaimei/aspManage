<!--#include file="../admin_inc.asp"-->
<%checkPower%>
<body bgcolor=#FFFFFF leftmargin=0 topmargin=0 style="font-size:11px">
<form name="form" enctype="multipart/form-data" action="uploaddflash.asp?act=up&inputname=<%=Request("inputname")%>" method=post>
    <input type=file name=file1 size="12">
    <input type=submit name=submit value="ÉÏ´«">
</form>