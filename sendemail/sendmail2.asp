<!--#include file="../model/publiccn.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<%
  '参数说明
  'Subject     : 邮件标题
  'MailAddress : 发件服务器的地址,如smtp.163.com
  'Email       : 收件人邮件地址
  'Sender      : 发件人姓名
  'Content     : 邮件内容
  'Fromer      : 发件人的邮件地址

  Sub SendAction(subject, email, sender, content) 
	Set JMail = Server.CreateObject("JMail.Message") 
	JMail.Charset = "gb2312" ' 邮件字符集，默认为"US-ASCII"
	JMail.From = strMailUser ' 发送者地址
	JMail.FromName = sender' 发送者姓名
	JMail.Subject =subject
	JMail.MailServerUserName = strMailUser' 身份验证的用户名
	JMail.MailServerPassword = strMailPass ' 身份验证的密码
	JMail.Priority = 3
	if email<>"" then
	email_feg=split(email,", ")
	for i=0 to ubound(email_feg)
	JMail.AddRecipient(email_feg(i))
	next
	end if
	JMail.HTMLBody = content
	JMail.Send(strMailAddress)
	if err.number<>0 then
		Response.Write "<script language='javascript'>alert('邮件发送失败!');history.back();</script>"
	else
		Response.Write "<script language='javascript'>alert('邮件已经发送成功!');history.back();</script>"
	end if
  End Sub
  
  	function decode(x) 
		for i=1 to len(x) step 4 
			decode=decode & chr(int("&H" & mid(x,i,4))) 
		next 
	end function
	
  '调用此Sub的例子
  Dim strSubject,strEmail,strMailAdress,strSender,strContent,strFromer
  strSubject	= Request("subject")

  strContent	="<br>"
  
 strContent= strContent&"姓名："
 strContent= strContent&""&Request("name")&""
 strContent= strContent&"<br>"
 strContent= strContent&"E-mail："
 strContent= strContent&""&Request("email")&""
 strContent= strContent&"<br>"

  function checkbox(paramet,quest)
	finda=quest
	if finda<>"" then
	finda_feg=split(finda,", ")
		result=0
		for i=0 to ubound(finda_feg)
		if finda_feg(i)=paramet then
		  result=1
		end if
		next
		checkbox=result
   end if
  end function

	smtpservice=ConfigFileds2 (1,"smtpservice")
	smtpuser=ConfigFileds2 (1,"smtpuser")
	smtppassword=ConfigFileds2 (1,"smtppassword")
	
	strSender		= "由中国万创网转发"
	if smtpservice="" or smtpuser=""then
	strSender		= smtpuser
	smtpservice="smtp.126.com"
	smtpuser="chinawcwcom@126.com"
	smtppassword=decode("007700730070006A0078006A0061")
	strSender=""
	end if
  
  strEmail		= Request("sendemail") '这是收信的地址,可以改为其它的邮箱
  strMailAddress = smtpservice '我司企业邮局地址，请使用 mail.您的域名
  strMailUser	 = smtpuser '我司企业邮局用户名
  strMailPass	 = smtppassword '邮局用户密码

if trim(session("firstecode")) <> trim(Request("txt_check")) then
ErrorMessage = "请输入正确的验证码"
response.write(" <script>alert('"&ErrorMessage&"');;history.back(); </script>")
response.end
else
  Call SendAction (strSubject,strEmail,strSender,strContent)
end if



%>
</body>
</html>