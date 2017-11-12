<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<title>后台管理</title>
<script src="excel/scripts/jquery.min.js"></script>
<script src="excel/scripts/jquery.cookie.js"></script>
</head>
<body>
<div id="main">
	<!--#include file="top.asp"-->
	<div id="content">
	<!--#include file="left.asp"-->
	<div id="right_content">
		<div id="main_content">
			<div class="top_nav"><span></span></div>
				<div class="nav_content" style="line-height:18px;">
				<h1>后台首页<%
				dim parentid : parentid = getForm("parentid","get")
				dim pid : pid = getForm("pid","get")
				if pid<>"" and pid<> "0" then
					echo " » " & conn.db("select NavName from {pre}Navigation where Id="&pid,"execute")(0)
				end if 
				%><%
				dim bid : bid = getForm("bid","get")
				if bid<>"" and bid<> "0" then
					echo " » " & conn.db("select NavName from {pre}Navigation where Id="&bid,"execute")(0)
				end if 
				%><%
				dim tid : tid = getForm("tid","get")
				if tid<>"" and tid<> "0" then
					echo " » " & conn.db("select NavName from {pre}Navigation where Id="&tid,"execute")(0)
				end if 
				%><%
				dim sid : sid = getForm("sid","get")
				if sid<>"" and sid<> "0" then
					echo " » " & conn.db("select NavName from {pre}Navigation where Id="&sid,"execute")(0)
				end if 
				%><%
				dim cid : cid = getForm("cid","get")
				if cid<>"" and cid <> "0"  then
					set rsc = conn.db("select WebType,NavName from {pre}Navigation where id="&cid,"records1")
					if not rsc.eof then
					echo " » " & rsc("NavName")
					dim webtype : webtype =  rsc("WebType")
					rsc.close
					set rsc=nothing
					end if
				end if 
				%>	
				</h1>
				</div>
			<div class="bottom_nav"><span></span></div>
			<div class="h6"></div>
			<div class="top_nav"><span></span></div>
<div class="nav_content">
			<div class="h7"></div>
<% 
addok=request("addok")
if addok="" or isnull(addok) then
id=request.QueryString("id")
%>
<table width="100%" border="0" cellspacing="1" cellpadding="0">
  <tr>
    <td height="25" colspan="2" align="center">上传EXCEL文件</td>
  </tr>
  <form action="importexcel.asp?addok=add&sortid=<%=id%>" method="post" name="myform" id="myform">
  <tr>
    <td height="25" align="right"></td>
    <td height="25"><input name="title" type="hidden" id="title" class=input></td>
  </tr>
  <tr>
    <td width="25%" height="25" align="right">上传文件：</td>
    <td width="75%" height="25"><input name="m_downfile" id="m_downfile" type="text" size="30" value="">&nbsp;←<input size="10" value="清除" type="button" onClick="javascript:document.addform.m_downfile.value=''" class="btn" />&nbsp;<iframe src="kindeditor-4.1.7/uploaddown.asp?inputname=m_downfile" scrolling="no" topmargin="0" width="300" height="24" marginwidth="0" marginheight="0" frameborder="0" align="center"></iframe></td>
  </tr>
  <tr>
    <td height="25" align="right">&nbsp;</td>
    <td height="25"><input type="submit" value="开始导入" class=input>&nbsp;<a style="margin-left:30px; color:#006666;" href="excel/security_model.xls">导入数据请下载表格模板</a></td>
  </tr>
  </form>
</table>
<%
end if
if addok="add" then
Set xlsconn = server.CreateObject("adodb.connection") 
set rs=server.CreateObject("adodb.recordset")
dbstr="../wspcmsdata/wspcmsdata.mdb"
Set conn = Server.CreateObject("ADODB.Connection")
DBPath = Server.MapPath(dbstr)
connstr="provider=microsoft.jet.oledb.4.0;data source=" &DBPath
conn.Open connstr
source1=server.mappath("..")&"/"&replace(request("m_downfile"),"../","")
myConn_Xsl="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" &source1& ";Extended Properties=Excel 8.0"
xlsconn.open myConn_Xsl'这里打开文件！

sql="select * from [Sheet1$]"
set rs=xlsconn.execute(sql)
if not rs.eof then
sortid=request.QueryString("sortid")
while not rs.eof
sql="insert into [wspcms_Security](NewsName,SortID,Source,Sourceen,Publisher,Publisheren,CreateDate) values ('"&Rs("防伪码")&"',"&sortid&",'"&Rs("项目名称")&"','"&Rs("项目名称EN")&"','"&Rs("委托单位")&"','"&Rs("委托单位EN")&"','"&Rs("报告时间")&"')"
conn.execute(sql)

rs.movenext
wend
response.Write(" <script> alert( '导入成功！ ');location.href='"&request.ServerVariables("HTTP_REFERER")&"';  </script> ")
xlsconn.close'用完后要关闭，数据库也是一样的！
filepath=server.mappath("../"&request.Form("m_downfile")&"")'这里是取得服务器的相对路经
            Set fso=Server.Createobject("Scripting.Filesystemobject")
              If fso.Fileexists (""&filepath&"") then'这里是查看文件是否存在
                 fso.deletefile ""&filepath&"", true'
				'Response.Write( " <script> alert( '"&filepath&"文件已成功删除！ ');location.href='"&request.ServerVariables("HTTP_REFERER")&"'; <'/script> ")  '弹出提示窗口，这里你就自己去搞
              Else
                 Response.Write( " <script> alert( '“"&filepath&"”文件不存在！ ');location.href='"&request.ServerVariables("HTTP_REFERER")&"'; </script> ")  '弹出提示窗口这里你就自己去搞
              End if 


end if
end if

%>
				<div class="h7"></div>
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



