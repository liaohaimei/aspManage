<%

dim n_name:n_name=ReplaceSymbols(getForm("n_name","post")) : if isNul(n_name) then n_name="."
dim n_type:n_type = getForm("n_type","post")
dim parent_id:parent_id = getForm("parent_id","post")
dim n_cname:n_cname=ReplaceSymbols(getForm("n_cname","post"))
dim n_description:n_description=ReplaceSymbols(getForm("n_description","post"))

dim action : action = getForm("action", "get")
'添加
if action="0" then
insertSql = "insert into {pre}Category(parent_id,n_type,n_name,n_cname,n_description) values ("&parent_id&","&n_type&",'"&n_name&"','"&n_cname&"','"&n_description&"')"
dbconn.db insertSql,"execute"
echo "<script>$(function(){fun._alertMes()})</script>"
end if
'修改
if action="1" then
sqlstr="parent_id="&parent_id&",n_type="&n_type&",n_name='"&n_name&"',n_cname='"&n_cname&"',n_description='"&n_description&"'"
updateSql = "update {pre}Category  set "&sqlstr&" where ID="&getForm("id","get")
dbconn.db updateSql,"execute"
echo "<script>$(function(){fun._alertSuccess()})</script>"
end if




function getPar(id)
getPar=getForm(id,"get")
if varNull(getPar)=false then
getPar=0
end if 	
end function

'获得分类名称
function getName(id)
if id="" then id=0	end if	
if id=0 then
getName="顶级"
else
sql = "select n_name from {pre}Category where ID = "&id
getName = dbconn.db(sql,"records1")(0)
end if
end function

'删除一条数据
function delOneData(id)
sql="delete from {pre}Category where ID = "&id
delOneData = dbconn.db(sql,"execute")
end function

'参数LeftText可以很方便的区分父栏目与子栏目之间的'错位'关系
Function SelectList(ID,cid, LeftText)
Dim Rs, Sql, ChildCount
Sql= "select ID,n_name from {pre}Category where parent_id="&ID&" order by id"
set Rs = dbconn.db(Sql,"records1")
Do While Not Rs.EOF
Sql2 = "Select Count(*) from {pre}Category where parent_id = "&Rs(0)&""
ChildCount = dbconn.db(Sql2,"execute")(0) '子栏目数量
if Rs(0)=getParentId(cid) then selectedStr=" selected" else selectedStr="" end if '所属分类（父级）
if Rs(0)=cid+0 then disabled	= "disabled" else disabled="" end if '禁止选择当前分类
echo"<option value=""" & Rs(0) & """ "&selectedStr&" "&disabled&">" & LeftText & Rs(1) & "</option>" & vbCrLf
If ChildCount > 0 Then Call SelectList(Rs(0),cid, LeftText & "  ┣ ") '递归
Rs.MoveNext
Loop
Rs.Close
Set Rs = Nothing
End Function

'获取父级ID
function getParentId(id)
if id<>"" and id<>0 then
sql = "select parent_id from {pre}Category where ID = "&id
getParentId = dbconn.db(sql,"records1")(0)
else
getParentId=0
end if
end function

%>