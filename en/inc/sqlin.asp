<%
Dim Idea_Post,Idea_Get,Idea_In,Idea_Inf,Idea_Xh,cssstr
Idea_In = "'|;|and|exec|insert|select|delete|update|count|*|%|chr|mid|master|truncate|char|declare" 
cssstr="<style>body{text-align:center}#msg{background-color:white;border:1px solid #1B76B7;margin:0 auto;width:400px;text-align:left}.msgtitle{padding:3px 3px;color:white;font-weight:700;line-height:21px;height:25px;font-size:12px;border-bottom:1px solid #1B76B7; text-indent:3px; background-color:#1B76B7}#msgbody{font-size:12px;padding:40px 8px 50px;line-height:25px}#msgbottom{text-align:center;height:20px;line-height:20px;font-size:12px;background-color:#1b76b7;color:#FFFFFF}</style>"
%>

<%
Idea_Inf = split(Idea_In,"|")
If Request.Form<>"" Then
  For Each Idea_Post In Request.Form
    For Idea_Xh=0 To Ubound(Idea_Inf)
      If Instr(LCase(Request.Form(Idea_Post)),Idea_Inf(Idea_Xh))<>0 Then
        die cssstr&"<div id='msg'><div class='msgtitle'>【警告】非法提交：</div><div id='msgbody'>你提交的数据有非法字符，你的IP【<b>"&getIp&"</b>】已被记录,操作时间:"&now()&"</div><div id='msgbottom'>Powered By "&siteName&"</div></div>"
      End If
    Next
  Next
End If

If Request.QueryString<>"" Then
  For Each Idea_Get In Request.QueryString
    For Idea_Xh=0 To Ubound(Idea_Inf)
      If Instr(LCase(Request.QueryString(Idea_Get)),Idea_Inf(Idea_Xh))<>0 Then
        die cssstr&"<div id='msg'><div class='msgtitle'>【警告】非法提交：</div><div id='msgbody'>你提交的数据有非法字符，你的IP【<b>"&getIp&"</b>】已被记录,操作时间:"&now()&"</div><div id='msgbottom'>Powered By "&siteName&"</div></div>"
      End If
    Next
  Next
End If
%>