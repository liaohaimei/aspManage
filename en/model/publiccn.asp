<!--#include file="../inc/Main_Class.asp"-->
<!--#include file="../inc/sqlin.asp"-->
<!--#include file="../inc/gFunc_Page.asp"-->
<!--#include file="../inc/md5.asp"-->
<!--#include file="sub.asp"-->
<%
Function Contents(id)
	If id="" Then
		Response.Write "Data compilation……"
	Else
		set Rs=Conn.db("select webType from {pre}Navigation where id="&id ,"records1")
		If Rs.RecordCount=0 Then
			Response.Write "Data compilation……"
		Else
			dim show:show=getForm("sid","get")
			if show<>"" Then
				Select case Rs("webType") 
				  case 1 : echo ContentShow(id)
				  case 2 : News
				  case 3 : Photo
				  case 5 : Down
				  case 6 : Product
				  case else : echo ContentShow(id)
				 End Select
			else
			  Select case Rs("webType") 
				  case 1 : echo ContentShow(id)
				  case 2 : NewsList 
				  case 3 : PhotoList
				  case 5 : DownList
				  case 6 : ProductList
				  case 7 : echo " <script>window.location.href='feedback.asp'; </script>"
				  case 8 : jobslist
				  case else : echo ContentShow(id)
			  End select
			end if
		End If
		Rs.Close : Set Rs=Nothing
	End If
End Function

function pageS(str,id)
set rs1= conn.db("select "&str&" from {pre}Navigation where ID="&id,"records1")
if not rs1.eof then
pageS = rs1(0) 
end if
rs1.close
set rs1=nothing
end function


function sub_len(str,leng)
if str="" or isnull(str) then 
	str="[NULL]"
else 
	if len(str)>leng then
		str=left(str,leng)&"……"
	else 
	    str=str
	end if
end if
sub_len=str
end function

Function RemoveHTML(strHTML) 
Dim objRegExp, Match, Matches 
Set objRegExp = New Regexp 
objRegExp.IgnoreCase = True 
objRegExp.Global = True 
'取闭合的<> 
objRegExp.Pattern = "<.+?>" 
'进行匹配 
Set Matches = objRegExp.Execute(strHTML) 
' 遍历匹配集合，并替换掉匹配的项目 
For Each Match in Matches 
strHtml=Replace(strHTML,Match.Value,"") 
Next 
RemoveHTML=strHTML 
Set objRegExp = Nothing 
End Function


Function FixImg(sString) 

    Dim sReallyDo, regEx, iReallyDo 
    Dim oMatches, cMatch 
    Dim tStartTime, tEndTime 
    If IsNull(sString) Then 
        FixImg = "" 
        Exit Function 
    End If 
    sReallyDo = sString 
    On Error Resume Next 
    sReallyDo = Replace(sReallyDo, vbCr, " ") 
    sReallyDo = Replace(sReallyDo, vbLf, " ") 
    sReallyDo = Replace(sReallyDo, vbTab, " ") 
    sReallyDo = Replace(sReallyDo, "<img ", vbCrLf & "<img ", 1, -1, 1) 
    sReallyDo = Replace(sReallyDo, "/>", " />", 1, -1, 1) 
    sReallyDo = ReplaceAll(sReallyDo, "= ", "=", True) 
    sReallyDo = ReplaceAll(sReallyDo, "> ", ">", True) 
    sReallyDo = Replace(sReallyDo, "><", ">" & vbCrLf & "<") 
    sReallyDo = Trim(sReallyDo) 
    On Error GoTo 0 
    Set regEx = New RegExp 
    regEx.IgnoreCase = True 
    regEx.Global = True 
    '//去除onclick,onload等脚本 
    regEx.Pattern = "\s[on].+?=([\""|\’])(.*?)\1" 
    sReallyDo = regEx.Replace(sReallyDo, "") 
    '//将SRC不带引号的图片地址加上引号 
    regEx.Pattern = "<img.*?\ssrc=([^\""\’\s][^\""\’\s>]*).*?>" 
    sReallyDo = regEx.Replace(sReallyDo, "<img src=""$1"" />") 
    '//正则匹配图片SRC地址 
    regEx.Pattern = "<img.*?\ssrc=([\""\’])([^\""\’]+?)\1.*?>" 
    sReallyDo = regEx.Replace(sReallyDo, "<img src=""$2"" />") 
    FixImg = sReallyDo 
End Function
%> 