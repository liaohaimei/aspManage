
<%Function GetSiteInfo(colName)
GetSiteInfo = Conn.Execute("select top 1 "&colName&" from Web_Setting")(0)
End Function %>


<%
Sub ScriptAlert(str)
    Response.Write "<script>alert('"&str&"');</script>"
End Sub

Sub ScriptLocationTo(url)
    Response.Write "<script>location.href='"&url&"';</script>"
End Sub

Function char(s)
    s=trim(s)
    s=replace(s,"'","  ")
    s=replace(s," ","")
    s=replace(s,"""","&amp;quot;")
    s=replace(s,"<","&lt;")
    s=replace(s,">","&gt;")
    char=s
End function


''记录登录信息 
''AdminType： 1-登录；2-注销；重点人员>3-添加、4-删除、5-修改；案件>6-添加、7-删除、8-修改
Sub RecordAdminInfo(AdminType)
    Dim rs,temp_Time,UserName,AdminTime
    UserName = Session("Login_UserName")
    ip = getIP()
    AdminTime = GetFormatDate(Date()) & " " & Time()
    sql = "insert into Web_Record (UserName,AdminType,ip,AdminTime) values ('"&UserName&"','"&AdminType&"','"&ip&"','"&AdminTime&"')"
    conn.Execute( sql )
End Sub

Function GetFormatDate(s_Date)
    GetFormatDate=Split(s_Date)(0)
End function

Function GetDictionary_NameByDictionary_ID(s_Dictionary_ID)
    sql = "select Dictionary_Name from Web_Dictionary where Dictionary_ID="&(s_Dictionary_ID)
    set Rs = conn.Execute( sql )
    GetDictionary_NameByDictionary_ID = Rs("Dictionary_Name")
End function
 %>

 <%
Private Function getIP()
Dim strIPAddr
If Request.ServerVariables("HTTP_X_FORWARDED_FOR") = "" OR InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), "unknown") > 0 Then
strIPAddr = Request.ServerVariables("REMOTE_ADDR")
ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",") > 0 Then
strIPAddr = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",")-1)
ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";") > 0 Then
strIPAddr = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";")-1)
Else
strIPAddr = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
End If
getIP = Trim(Mid(strIPAddr, 1, 30))
End Function
%>


<%
Function closeHTML(strContent) 
Dim arrTags, i, OpenPos, ClosePos, re, strMatchs, j, Match 
Set re = New RegExp 
re.IgnoreCase = True 
re.Global = True 
arrTags = Array("p", "div", "span", "table", "ul", "font", "b", "u", "i", "h1", "h2", "h3", "h4", "h5", "h6") 
For i = 0 To UBound(arrTags) 
OpenPos = 0 
ClosePos = 0 


re.Pattern = "\<" + arrTags(i) + "( [^\<\>]+|)\>" 
Set strMatchs = re.Execute(strContent) 
For Each Match in strMatchs 
OpenPos = OpenPos + 1 
Next 
re.Pattern = "\</" + arrTags(i) + "\>" 
Set strMatchs = re.Execute(strContent) 
For Each Match in strMatchs 
ClosePos = ClosePos + 1 
Next 
For j = 1 To OpenPos - ClosePos 
strContent = strContent + "</" + arrTags(i) + ">" 
Next 
Next 
closeHTML = strContent 
End Function 
 %>

 <%
Private Sub getContent()
    dim Rs_0,Sql,arrContent
    Set Rs_0 = Server.CreateObject("ADODB.Recordset")      
    Sql="select content from Web_News order by Sort desc, News_ID desc "
    Rs_0.Open sql,conn,1,3
    content = Rs_0("content")

    splitTag = "<hr style=""page-break-after:always;"" class=""ke-pagebreak"" />"
    arrContent = split(content,splitTag)
    pageCounts = ubound(arrContent)
    If pageCounts>0 Then
%>
    <!-- item container -->
    <ul id="itemContainer" class="list-unstyle">
<%
        for i=0 to ubound(arrContent)
            'Response.Write "<li class='li'>"&(arrContent(i))&"</li>"&vbCrLf
            Response.Write "<li class='li'>"&closeHTML(arrContent(i))&"</li>"
        next
%>              
    </ul>
    <!-- navigation holder -->
    <div class="holder">
    </div> 
<%
    Else        
        Response.Write pageCounts&content
    End If
    Rs_0.Close

End Sub
%>

          