<!--#include file="admin_inc.asp"-->
<%
dim pid:pid = getForm("pid","get")
if varNull(pid) then
echo delOneData(pid)
end if

'删除一条数据
function delOneData(id)
if nextNull(id)=false then
sql="delete from {pre}Category where ID = "&id
delOneData = dbconn.db(sql,"execute")
delOneData=true
else
delOneData=false
end if
end function

'否是有子类
function nextNull(id)
nextNull=false
sql = "Select Count(*) from {pre}Category where parent_id = "&id
ChildCount = dbconn.db(sql,"execute")(0) '子栏目数量
if ChildCount>0 then
nextNull=true
end if	
end function
%>