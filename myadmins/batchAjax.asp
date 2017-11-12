<!--#include file="admin_inc.asp"-->
<%
cid=getForm("cid","get")
p_name=getForm("p_name","get")
p_img=getForm("p_img","get")
insertSql = "insert into {pre}Product(Bid,Tid,Sid,SortID,p_name,p_nameen,p_img,IsShow,IsShowen,IsShowjp) values ("&cid&","&cid&","&cid&","&cid&",'"&p_name&"','"&p_name&"','"&p_img&"',1,1,1)"
conn.db  insertSql,"execute"
echo "成功"
%>
