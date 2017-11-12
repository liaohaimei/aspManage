<!DOCTYPE html>
<html lang="en">
<head><meta name="baidu-site-verification" content="o9BPYkfLYN" />
<meta name="renderer" content="webkit" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="model/publiccn.asp"-->
<%id=request.QueryString("id")
ids=request.QueryString("ids")
keyword=request.QueryString("keyword")
%>
<!--#include file="titlekeyword.asp"-->
<%
if ids<>"" then
  if  NextNavNull(ids)=0 then
  nid=ids
  end if
  if id="" then
  nid=GetDefaultNextID(ids)
  else
  if id<>"" and NextNavNull(id)=1 then
  nid=GetDefaultNextID(id)
  else
  nid=id
  end if
  end if
end if
%>
<title><%=pageTitle%></title>
<meta name="keywords" content="<%=pageKeyword%>" />
<meta name="description" content="<%=pageContent%>" />
<link type="text/css" rel="stylesheet" href="css/reset.css" />
<script src="js/jquery-1.10.2.min.js"></script>
</head>
<body>
    
<!--头部开始-->
<!--#include file="topnav.asp"--> 
<!--#include file="banner.asp"--> 
<div class="w1100" style="padding:15px 0;">
<!--#include file="left.asp"--> 
<!--cpleft-->
            <div class="cpright">
            <!--#include file="current.asp"--> 
            <div class="story">
                <div class="agent_con">
                <div class="contents" align="left">
    <form action="sendemail/sendmail.asp" method="post" name="submitform" id="submitform"  class="form-horizontal" >
                          <input type="hidden" value="<%=ContentMesEmail(1)%> " name="sendemail" />
                          <input type="hidden" value="<%=ContentTitle(nid)%>" name="subject" />        
                          <div class="col-sm-5" style="line-height:36px; color:#000">*Name:<br />
                            <input class="form-control" name="name" id="name" type="text" placeholder="Enter name" />
                          </div>
                          <div class="col-sm-2 hidden-xs">&nbsp;</div>
                          <div class="col-sm-5" style="line-height:36px;color:#000">*E-mail: <br />
                            <input class="form-control" name="email" id="email" type="text" placeholder="Enter your email" />
                          </div>
                          <div class="col-sm-5" style="line-height:36px;color:#000">*Country:<br />
                            <input class="form-control" name="country" id="country" type="text" placeholder="Input country" />
                          </div>
                          <div class="col-sm-2 hidden-xs">&nbsp;</div>
                          <div class="col-sm-5" style="line-height:36px;color:#000">*Tel: <br />
                            <input class="form-control" name="tel" id="tel" type="text" placeholder="enter phone number" />
                          </div>
                          <div class="clear"></div>
                          <div class="col-lg-12" style="line-height:36px;color:#000">*Message: <br />
                            <textarea name="message" id="message" class="form-control" rows="4" style="height:90px; width:99.9%"></textarea>
                            </div>
                          <div class="col-sm-5" style="line-height:36px;color:#000">*Verification code: <br />
                            <input name="txt_check" type="text" class="form-control" placeholder="Input validation code" size=6 maxlength=4 style="width:100px; float:left;">
                      <img src="checkcode.asp " alt="Verification code, can not see clearly? Please click refresh code" height="26" style="cursor : pointer; display:inline; padding-top:0; margin-left:10px;" onClick="this.src='checkcode.asp?t='+(new Date().getTime());" >
                          </div>
              <div class="clear"></div>

                          <div class="col-lg-12" style="text-align:right; padding-top:15px;">
                            <button type="button" class="btn btn-default"  onclick="javascript:check();">Submit</button>
                          </div>
        <script language="JavaScript" type="text/javascript">
        <!--
        function isEmail(vEMail)
        {
            var regInvalid=/(@.*@)|(\.\.)|(@\.)|(\.@)|(^\.)/;
            var regValid=/^.+\@(\[?)[a-zA-Z0-9\-\.]+\.([a-zA-Z]{2,3}|[0-9]{1,3})(\]?)$/;
            return (!regInvalid.test(vEMail)&&regValid.test(vEMail));
        }
        function check()
        {
        var obj=document.submitform;
        if(obj.name.value==''){
        alert('Fill in your name, please!');
        obj.name.focus();
        return false;}
        
        if(obj.tel.value==''){
        alert('Please fill in the telephone number!');
        obj.tel.focus();
        return false;}
        
        if(obj.email.value==''){
        alert('Please fill in the email!');
        obj.email.focus();
        return false;}
         if  (!(isEmail(obj.email.value )))
           {
            alert("Please fill in the correct email format!");
          obj.email.focus();
          return false;
            }
        
        if(obj.txt_check.value==''){
        alert('Please fill in the verification code!');
        obj.txt_check.focus();
        return false;}
        
        else
         {
            obj.submit();
        }
        }
        //-->
        </script> 
        
        </form>
  </div>
                </div>
            </div>
        </div>
            <div class=" clearfix"></div>
</div>



<!--#include file="foot.asp"--> 
</body>
</html>