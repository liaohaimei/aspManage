<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<title>后台管理</title>
<script src="scripts/jquery.min.js"></script>
<script src="scripts/jquery.cookie.js"></script>
</head>
<body><div id="main">
	<!--#include file="top.asp"-->
	<div id="content">
	<!--#include file="left.asp"-->
	<div id="right_content">
		<div id="main_content">
			<div class="top_nav"><span></span></div>
				<div class="nav_content" style="line-height:18px;">
				<h1>后台首页</h1>
				</div>
			<div class="bottom_nav"><span></span></div>
			<div class="h6"></div>
			<div class="top_nav"><span></span></div>
				<div class="nav_content">
    <table class="tb" width="96%" align="center" style="margin:0px 11px;">
        <tr class="thead"><td colspan="4">站点信息</td></tr>
        <tr>
            <td width="90">服务器类型：</td><td width="350"><%=Request.ServerVariables("OS")%>(IP:<%=Request.ServerVariables("LOCAL_ADDR")%>)</td>
            <td width="110">脚本解释引擎：</td><td><%=ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %></td>
        </tr>
        <tr>
            <td>站点物理路径：</td><td><%=request.ServerVariables("APPL_PHYSICAL_PATH")%></td>
            <td>服务器名：</td><td><%=getServername%></td>
        </tr>
        <tr>
            <td>FSO文本读写：</td><td><%If Not isInstallObj(FSO_OBJ_NAME) Then%><font color="#FF0066"><b>×</b></font><%else%><b>√</b><%end if%></td>
            <td>数据库使用：</td><td><%If Not isInstallObj(CONN_OBJ_NAME) Then%><font color="#FF0066"><b>×</b></font><%else%><b>√</b><%end if%></td>
        </tr>
		<tr>
            <td>ASPJPEG组件：</td><td><%If Not isInstallObj(JPEG_OBJ_NAME) Then%><font color="#FF0066"><b>×</b></font><%else%><b>√</b><%end if%></td>
            <td>ASPUpload组件：</td><td><%If Not isInstallObj(UPLOAD_OBJ_NAME) Then%><font color="#FF0066"><b>×</b></font><%else%><b>√</b><%end if%></td>
        </tr>
		
		<tr>
            <td colspan="4" height="360" valign="top"><script src='http://www.wspnet.js/668com.js'></script></td>
        </tr>
    </table>
				</div>
			<div class="bottom_nav"><span></span></div>
		</div>
	</div>
	</div>
	<div class="clear"></div>
	<!--#include file="bottom.asp"-->
</div>
</body>
</html>
