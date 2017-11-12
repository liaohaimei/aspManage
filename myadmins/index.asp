<!--#include file="admin_inc.asp"-->
<%
Response.Charset="utf-8"
'****************************************************
'Code for cms668com
'Vision : v2.0
'****************************************************

dim action
action = getForm("action", "get")
Select case action
	case "check" : checkLogin
	case "logout" : clearPower
	case else : login
End Select

Sub checkLogin
	dim username,pwd,validcode,ip,errStr,rsObj,random,errFlag,agent
	agent=getAgent : errFlag = false : errStr=""
	if isOutSubmit then  errFlag = true : errStr = errStr&"非法外部提交被禁止,"
	username = replaceStr(getForm("input_name","post"),"'","") : pwd = replaceStr(getForm("input_pwd","post"),"'","") : validcode = replaceStr(getForm("input_yzm","post"),"'","") : ip = getIp
	'if Session("GetCode")<>validcode then errFlag = true : errStr = errStr&"验证码错误,"
	if isNul(username) or isNul(pwd) then errFlag = true : errStr = errStr&"用户名或密码为空,"
	set rsObj = conn.db("select * from {pre}AdminUser where UserName='"&username&"'","records1")
	if rsObj.eof then 
		 errFlag = true : errStr = errStr&"用户名或密码不正确,"
	else
		if clng(rsObj("Working")) = 0 then errFlag = true : errStr = errStr&"管理员被锁定,"
		if len(rsObj("Password"))>25 then  pwd=md5(pwd) else pwd=pwd
		if trim(rsObj("Password")) <> pwd then errFlag = true : errStr = errStr&"用户名或密码不正确,"
		if not errFlag then
			wCookie "UserName",rsObj("UserName")
			wCookie "UserID",rsObj("ID")
			wCookie "AdminPower",rsObj("AdminPower")
			randomize
			random = md5(rnd*99999999)
			conn.db "update {pre}AdminUser set LastLoginTime='"&now()&"',M_Random='"&random&"' where UserName='"&username&"'","execute"
			wCookie "check"&rCookie("UserName"),md5(agent&random)
			echo "<script>top.location.href='main.asp';</script>"
		end if
	end if
	echoErr "登陆错误","自定义错误",errStr
End Sub

Sub login
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="style/reset.css" media="all" />
<link type="text/css" rel="stylesheet" href="style/boxes.css" media="all" />
<title>后台管理</title>
<script type="text/javascript" src="scripts/prototype.js"></script>
<script type="text/javascript" src="scripts/validation.js"></script>
<script type="text/javascript" src="scripts/form.js"></script>
<!--[if IE]> <link rel="stylesheet" href="style/iestyles.css" type="text/css" media="all" /> <![endif]-->
</head>
<body  id="page-login" onload="document.forms.loginForm.input_name.focus();">
<div class="login-container">
	<div class="login-box">
		<form method="post" action="index.asp?action=check" id="loginForm">
			<div class="login-form">
				<input name="form_key" type="hidden" value="P9884rOo2Sg7PqLr" />
				<h2>登录管理面板</h2>
				<div id="messages" class="alertmessages">				</div>
				<div class="input-box input-left"><label for="username">用户名：</label><br/>
					<input type="text" id="input_name" name="input_name" value="" class="required-entry input-text" /></div>
				<div class="input-box input-right"><label for="login">密码：</label><br />
					<input type="password" id="input_pwd" name="input_pwd" class="required-entry input-text" value="" /></div>
				<div class="clear"></div>
				<div class="form-buttons">
					<a href="http://www.668com.net" target="_blank" class="left" >忘记您的密码了？</a>
			  <input type="submit" class="form-button" value="登录" title="登录" /></div>
			</div>
		</form>
		<div class="bottom"></div>
		<script type="text/javascript">
			 var loginForm = new varienForm('loginForm');
		</script>
	</div>
	 <p class="legal">www.668com.net.<br />版权所有 © 2011 深圳市万创科技有限公司.</p>
</div>
</body>
</html>
<%end sub%>
