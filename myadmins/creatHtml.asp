<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<title>后台管理</title>
<script src="scripts/jquery.min.js"></script>
</head>
<body>
<!--#include file="admin_inc.asp"-->
<%checkPower%>
<% 

'常用函数 
'1、输入url目标网页地址，返回值getHTTPPage是目标网页的html代码 
function getHTTPPage(url) 
dim Http 
set Http=server.createobject("MSXML2.XMLHTTP") 
Http.open "GET",url,false 
Http.send() 
if Http.readystate<>4 then  
exit function 
end if 
getHTTPPage=bytesToBSTR(Http.responseBody,"utf-8") 
set http=nothing 
if err.number<>0 then err.Clear  
end function 
'2、转换乱玛，直接用xmlhttp调用有中文字符的网页得到的将是乱玛，可以通过adodb.stream组件进行转换 
Function BytesToBstr(body,Cset) 
dim objstream 
set objstream = Server.CreateObject("adodb.stream") 
objstream.Type = 1 
objstream.Mode =3 
objstream.Open 
objstream.Write body 
objstream.Position = 0 
objstream.Type = 2 
objstream.Charset = Cset 
BytesToBstr = objstream.ReadText  
objstream.Close 
set objstream = nothing 
End Function 
'下面试着调用http://www.3doing.com/earticle/的html内容 

HOSTURL=Request.ServerVariables("HTTP_HOST")
HTTP_HOST="http://"&HOSTURL&""
'response.Write(HTTP_HOST)

topnav_html=""&HTTP_HOST&"/"&sitePath&"topnav_html.asp" 
foot_html=""&HTTP_HOST&"/"&sitePath&"foot_html.asp" 
index_html=""&HTTP_HOST&"/"&sitePath&"index_html.asp" 
Html_topnav = getHTTPPage(topnav_html) 
Html_foot = getHTTPPage(foot_html) 
Html_index = getHTTPPage(index_html) 

topnav_html_en=""&HTTP_HOST&"/"&sitePath&"cn/topnav_html.asp" 
foot_html_en=""&HTTP_HOST&"/"&sitePath&"cn/foot_html.asp" 
index_html_en=""&HTTP_HOST&"/"&sitePath&"cn/index_html.asp" 
Html_topnav_en = getHTTPPage(topnav_html_en) 
Html_foot_en = getHTTPPage(foot_html_en) 
Html_index_en = getHTTPPage(index_html_en) 




'使用stream对象输出内容至文件
Function SaveTOFile(ByVal FileName,ByRef Content,ByVal Chrset)
	On Error Resume Next
	dim stm:set stm=Server.CreateObject("ADODB.Stream")
	stm.Type=2
	stm.Mode=3
	stm.CharSet=Chrset
	stm.Open
	stm.WriteText content
	stm.SaveToFile Server.MapPath(FileName),2 
	stm.Flush
	stm.Close
	Set stm=Nothing
   If Err Then
	 WriteTOFile = False
	 SaveTOFile = False
   Else
	 WriteTOFile = True
	 SaveTOFile = True
   End If
End Function

	if SaveTOFile ("../topnav.html",Html_topnav,"utf-8") = True then
	Response.write("<p>生成*topnav.html*成功</p>")
	else
	Response.write("<p style='color:red;'>生成*topnav.html*失败</p>")
	end if
	if  SaveTOFile ("../foot.html",Html_foot,"utf-8")= True then
	Response.write("<p>生成*foot.html*成功</p>")
	else
	Response.write("<p style='color:red;'>生成*foot.html*失败</p>")
	end if
	if  SaveTOFile ("../index.html",Html_index,"utf-8")= True then
	Response.write("<p>生成*index.html*成功</p>")
	else
	Response.write("<p style='color:red;'>生成*index.html*失败</p>")
	end if

	if SaveTOFile ("../cn/topnav.html",Html_topnav_en,"utf-8") = True then
	Response.write("<p>生成*cn/topnav.html*成功</p>")
	else
	Response.write("<p style='color:red;'>生成*topnav.html*失败</p>")
	end if
	if  SaveTOFile ("../cn/foot.html",Html_foot_en,"utf-8")= True then
	Response.write("<p>生成*cn/foot.html*成功</p>")
	else
	Response.write("<p style='color:red;'>生成*foot.html*失败</p>")
	end if
	if  SaveTOFile ("../cn/index.html",Html_index_en,"utf-8")= True then
	Response.write("<p>生成*cn/index.html*成功</p>")
	else
	Response.write("<p style='color:red;'>生成*index.html*失败</p>")
	end if

'Response.write Html
%>


</body>

</html>
