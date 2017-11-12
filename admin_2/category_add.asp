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
sqlstr="n_type="&n_type&",n_name='"&n_name&"',n_cname='"&n_cname&"',n_description='"&n_description&"'"
updateSql = "update {pre}Category  set "&sqlstr&" where ID="&getForm("id","get")
dbconn.db updateSql,"execute"
echo "<script>$(function(){fun._alertMes()})</script>"
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

%>