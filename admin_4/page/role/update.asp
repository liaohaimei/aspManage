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
sql = "select * from {pre}auth_item where ID = "&id
set rsObj = dbconn.db(sql,"records1")
if not rsObj.eof then
name  			= rsObj("name")
description  	= rsObj("description")
rule_name  		= rsObj("rule_name")
data  			= rsObj("data")
end if
rsObj.close : set rsObj=nothing
end if
%>
<!--#include file="models/_form.asp"-->
</div>
</body>
</html>
