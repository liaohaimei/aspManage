<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%  
Response.Status = "404 Not Found"  
%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <title>404页面</title>
    <meta name="Description" content="404页面">
    <style type="text/css">*{margin:0px;padding:0px}body{background:#f7f7f7}.erro{width:100%;height:197px;background:url("images/page404.png") no-repeat center;display:block;margin:180px auto 20px auto}.txt{width:100%;height:30px;text-align:center;line-height:30px;font-size:26px;color:#8b8b8b}.fh{color:#eb7012;text-decoration:none}.fh:hover{text-decoration:underline}
    </style>
</head>
<body>
    <div class="erro"></div>
<div class="txt">抱歉，您所访问的页面不存在，<span id="ss" style="color:#FF0000">5</span> 秒钟之后将带您进入首页！<br/><br/>你可以点击进入<a href="/" class="fh">网站首页</a></div>
<script language="JavaScript"> 
var t = 5;//定义时间 
var url = "/";//定义URL 
var obj = document.getElementById('ss'); 
window.onload = function(){ 
	skip()//执行函数 
} 

function skip(){ //主函数 

	if(t<=0){ //已经到0秒 
  		return 0; 
} 

t-- 
obj.innerHTML = t; //页面显示数值 
if(t==0){ 
  	window.location.href=url;  //跳转页面 
} 
	window.setTimeout(skip,1*1000);  //一秒执行一次本函数 
} 
</script> 
</body>
</html>