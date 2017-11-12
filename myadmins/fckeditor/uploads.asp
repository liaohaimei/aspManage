<!--#include file="../admin_inc.asp"-->
<%checkPower%>
<body bgcolor=#FFFFFF leftmargin=0 topmargin=0 style="font-size:11px">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<form name="form" enctype="multipart/form-data" action="upload.asp?act=up&inputname=<%=Request("inputname")%>&isthumbnail=<%=Request("isthumbnail")%>&maxwidth=<%=Request("maxwidth")%>&maxheight=<%=Request("maxheight")%>" method=post>
    <input type=file name=file1 size="12">
    <input type=submit name=submit value="上传">
</form>