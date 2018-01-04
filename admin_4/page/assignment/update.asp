<!--#include file="../../admin_inc.asp"-->
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>后台管理系统</title>
    <link rel="stylesheet" href="../../layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="../../css/news.css" media="all" />
</head>
<body>

<div class="layui-fluid">
<%
btnName="更新"
sty=""
typ=1
id=getForm("id","get")              '当前ID
if id<>"" then
sql = "select * from {pre}admin where ID = "&id
set rsObj = dbconn.db(sql,"records1")
if not rsObj.eof then
username  = rsObj("username")
email     = rsObj("email")
password  = rsObj("password")
status    = rsObj("status")
end if
rsObj.close : set rsObj=nothing
end if
%>
<!--#include file="_form.asp"-->
</div>
</body>
</html>
