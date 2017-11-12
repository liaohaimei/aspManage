﻿<!--#include file="config.asp"-->
<!--#include file="inc/session.asp"-->
<%
if Mosession.get("username")="" then
	response.Write "请登录后再上传文件" 
	response.End()
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>文件上传</title>
<link href="css/mo.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="scripts/jui/jquery.js"></script>
<script type="text/javascript" src="scripts/swfupload.min.js"></script>
<script type="text/javascript" src="scripts/swfupload.handler.min.js"></script>
<script type="text/javascript" src="scripts/swfupload.callback.min.js"></script>
<script type="text/javascript">
var path="";
if(window.parent && window.parent.currentpath)path=window.parent.currentpath;
var Setting={
	debug:false,upload_url: "upload.asp?sessionid=<%=Mosession.SessionId%>&path=" + encodeURIComponent(path),file_post_name : "filedata",button_width: 24,button_height: 24,button_image_url:"images/btn16.png",charset: "gbk",auto:true,button_append : "divAddFiles",
	file_types : "<%=AllowExt%>",
	file_types_description : "选择文件",
	file_size_limit : "<%=AllowFileSizeLimit%>",
	file_upload_limit : 6
};
function DEBUG(msg){
	alert(msg);
}
//所有上传文件成功后的回调，全局变量Files（文件信息数组）包含所有上传成功的文件信息
function FinishedCallBack(result){	
	if(typeof window.parent.CallBack=="function")window.parent.CallBack.apply(Files,[result]);
}
window.onload=init;
</script>
</head>
<body>
	<div id="upload">
		<div id="btns"><span id="divAddFiles"></span><span id="message"> *选择文件后自动开始上传</span></div>
		<div id="moswf">
			<div class="filelist h24"><div class="process_bar h24"></div><div class="info_bar h24"><ul><li class="w_name"><span class="s_name">文件名</span></li><li class="w_process">进度</li><li class="w_size">速度</li><li class="w_act">操作</li></ul></div></div>
		</div>
	</div>
</body>
</html>