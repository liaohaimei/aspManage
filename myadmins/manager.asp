<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<title>后台管理</title>
<script src="scripts/jquery.min.js"></script>
<script src="scripts/jquery.cookie.js"></script>
</head>
<body><div id="main">
	<!--#include file="top.asp"-->
	<div id="content">
	<!--#include file="left.asp"-->
	<div id="right_content">
		<div id="main_content">
			<div class="top_nav"><span></span></div>
				<div class="nav_content" style="line-height:18px;">
				<h1>后台首页 » 系统 » 管理员管理</h1>
				</div>
			<div class="bottom_nav"><span></span></div>
			<div class="h6"></div>
			<div class="top_nav"><span></span></div>
				<div class="nav_content">
				<div class="h7"></div>
<%
dim action : action = getForm("action", "get")
dim errorInfo : errorInfo="信息填写不完整，请检查"
Select  case action
	case "del" : delmanager
	case "delall" : delAll
	case "edit" : edit
	case "save" : saveEdit
	case "add" : addmanager
	case "adds" : add
	case else : main
End Select

dim id
Sub main
	dim dataListObj,managerArray,i,n,m_id
	id=getForm("id","get")
	set dataListObj =  mainClassobj.createObject("MainClass.DataList")
	dataListObj.orderStr = "ID asc"
	dataListObj.tableStr = "{pre}AdminUser"
	managerArray = dataListObj.getDataList()
%>
				<div class="nav_tools"><span class="add"><a href="?action=adds">添加</a></span><span class="nav_tools_right"></span></div>
				<div class="table">
<table width="100%" cellpadding="0" cellspacing="0">
  <tr>
    <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;text-indent:10px;border-right:solid #e5e5e5 1px; border-left:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle">管理员列表</td>
  </tr>
  <tr>
    <td align="left">
	<table width="100%" cellpadding="0" cellspacing="0">
        <tbody>
          <tr bgcolor="#e5e5e5">
            <td width="8%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px; border-left:solid #bbbbbb 1px;">
			<table width="70" cellpadding="0" cellspacing="0">
              <tbody>
                <tr>
					<td width="20" align="middle">&nbsp;</td>
					<td width="48">ID</td>
                </tr>
              </tbody>
            </table></td>
            <td width="18%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;用户名</td>
            <td width="15%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;最近登录时间</td>
            <td width="15%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;最近登陆IP</td>
			<td width="15%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;管理员级别</td>
            <td width="5%" align="center" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">状态</td>
            <td width="9%" align="center" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">操作</td>
          </tr>
		<%
			if isArray(managerArray) then  
				n=ubound(managerArray,2)
			for i=0 to n
				m_id= trim(managerArray(0,i))
		%>
          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="70" cellpadding="0" cellspacing="0">
              <tbody>
                <tr>
					<td width="20" align="middle">&nbsp;</td>
					<td width="48" valign="middle"><%=m_id%>.</td>
                </tr>
              </tbody>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=managerArray(1,i)%></td>
			<td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%isCurrentDay(managerArray(10,i))%></td>
			<td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=managerArray(9,i)%></td>
			<td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=getManagerLevel(managerArray(6,i))%></td>
            <td align="center" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			<table width="50" cellpadding="0" cellspacing="0">
              <tbody>
                <tr>
                  <td align="center"><%=getManagerState(managerArray(7,i))%></td>
                </tr>
              </tbody>
            </table></td>
            <td align="middle" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
              <tbody>
                <tr>
                  <td align="center"><a href="?action=edit&id=<%=m_id%>">修改</a></td>
                  <td align="center">|</td>
                  <td align="center"><a onclick="if(confirm('确定要删除吗')){return true;}else{return false;}" href="?action=del&id=<%=m_id%>">删除</a></td>
                </tr>
              </tbody>
            </table></td>
          </tr>
		<%
			next
			else
				echo "<tr><td style='border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;' colspan='6' align='center'><font color='red'>没有任何记录</font></td></tr>"
			end if
		%>
        </tbody>
      </table>
	</td>
  </tr>
  <tr>
    <td align="left" bgcolor="#e5e5e5" style="border:solid #bbbbbb 1px;">&nbsp;</td>
  </tr>
</table>
				</div>
				<div class="nav_tools leftbottom"><span class="add"><a href="?action=adds">添加</a></span><span class="nav_tools_right rightbottom"></span></div>
<%
	set dataListObj = nothing
End Sub

Sub add
%>
<form method="post" action="?action=add"  name="addform" onSubmit="return validateform()">
				<div class="nav_tools"><span class="save"><a href="javascript:document.addform.submit();">保存</a></span><span class="back"><a href="manager.asp">返回</a></span><span class="nav_tools_right"></span></div>
<div class="table">
<table width="100%" cellpadding="0" cellspacing="0">
  <tr>
    <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;text-indent:10px;border-right:solid #e5e5e5 1px; border-left:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle">添加栏目</td>
  </tr>
  <tr>
    <td align="left">
	<table width="100%" cellpadding="0" cellspacing="0" id="RiseList">
        <tbody>
          <tr bgcolor="#e5e5e5">
            <td width="10%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px; border-left:solid #bbbbbb 1px;">&nbsp;
			
			</td>
            <td width="90%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;</td>
          </tr>
          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">用户名:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            &nbsp;<input type="text" size="30" name="UserName" id="UserName" /><font color='red'>＊</font>
            </td>
          </tr>
          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">密码:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<input type="password" size="30" name="Password" /><font color='red'>＊</font>
            </td>
          </tr>
		  
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">密码确认:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<input type="password" size="30" name="Password2" /><font color="red">＊</font>
            </td>
          </tr>
		  
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">管理员级别:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<label><input type="radio" size="20" name="AdminPower"  value="0" checked class="radio"/>系统管理员(<font color="red">拥有全部权限</font>)</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label><input type="radio" size="20" name="AdminPower" value="1" class="radio" />网站编辑(<font color="red">只拥有数据管理权限</font>)</label><font color="red">＊</font>
            </td>
          </tr>
		  
        </tbody>
      </table>

	</td>
  </tr>
  <tr>
    <td align="left" bgcolor="#e5e5e5" style="border:solid #bbbbbb 1px;">&nbsp;</td>
  </tr>
</table>
</div>

<div class="nav_tools leftbottom"><span class="save"><a href="javascript:document.addform.submit();">保存</a></span><span class="back"><a href="manager.asp">返回</a></span><span class="nav_tools_right rightbottom"></span></div>
</form>
<%
End Sub

Sub edit
	id=getForm("id","get")
	dim rsObj : set rsObj=conn.db("select * from {pre}AdminUser where ID="&id,"execute")
%>
<form method="post" action="?action=save&id=<%=id%>"  name="addform" onSubmit="return validateform()">
				<div class="nav_tools"><span class="save"><a href="javascript:document.addform.submit();">保存</a></span><span class="back"><a href="manager.asp">返回</a></span><span class="nav_tools_right"></span></div>
<div class="table">
<table width="100%" cellpadding="0" cellspacing="0">
  <tr>
    <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;text-indent:10px;border-right:solid #e5e5e5 1px; border-left:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle">添加栏目</td>
  </tr>
  <tr>
    <td align="left">
	<table width="100%" cellpadding="0" cellspacing="0" id="RiseList">
        <tbody>
          <tr bgcolor="#e5e5e5">
            <td width="10%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px; border-left:solid #bbbbbb 1px;">&nbsp;
			
			</td>
            <td width="90%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;</td>
          </tr>
          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">用户名:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            &nbsp;<input type="text" size="30" name="UserName" id="UserName" value="<%=rsObj("UserName")%>"/><font color='red'>＊</font>
            </td>
          </tr>
          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">密码:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<input type="password" size="30" name="Password" /><font color="red">为空不修改</font>
            </td>
          </tr>
		  
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">密码确认:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<input type="password" size="30" name="Password2" /><font color="red">＊</font>
            </td>
          </tr>
		  
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">管理员级别:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<label><input type="radio" size="20" name="AdminPower" class="radio"  value="0" <% if rsObj("AdminPower")=0 then %> checked <%end if%>/>系统管理员(<font color="red">拥有全部权限</font>)</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label><input type="radio" class="radio" size="20" name="AdminPower" value="1"  <% if rsObj("AdminPower")=1 then %> checked <%end if%> />网站编辑(<font color="red">只拥有内容管理权限</font>)</label><font color="red">＊</font>
            </td>
          </tr>
		  
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">是否锁定:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<label><input type="radio" class="radio" size="20" name="Working"  value="1" <% if rsObj("Working")=1 then %> checked <%end if%>/>激活</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label><input type="radio" class="radio" size="20" name="Working" value="0"  <% if rsObj("Working")=0 then %> checked <%end if%> />锁定</label><font color="red">＊</font>
            </td>
          </tr>
		  
        </tbody>
      </table>

	</td>
  </tr>
  <tr>
    <td align="left" bgcolor="#e5e5e5" style="border:solid #bbbbbb 1px;">&nbsp;</td>
  </tr>
</table>
</div>

<div class="nav_tools leftbottom"><span class="save"><a href="javascript:document.addform.submit();">保存</a></span><span class="back"><a href="manager.asp">返回</a></span><span class="nav_tools_right rightbottom"></span></div>
</form>
<%
End Sub
%>
				<div class="h7"></div>
				</div>
			<div class="bottom_nav"><span></span></div>
		</div>
	</div>
	</div>
	<div class="clear"></div>
	<!--#include file="bottom.asp"-->
</div>
</body>
</html>
<%

Sub saveEdit
	dim UserName,Password,Password2,AdminPower,Working,sqlStr,num,strpass
	UserName = getForm("UserName","post"):Password = getForm("Password","post"): Password2 = getForm("Password2","post") :AdminPower = getForm("AdminPower","post") : Working=getForm("Working","post") : id=getForm("id","get")
	if   isNul(UserName) then  die errorInfo
	if Password<>Password2 then die errorPwd
	if isNul(Password)  or isNul(Password2) then
		strpass = ""
	else
		strpass = "[Password]='"&md5(Password)&"',"
	end if
	if isNul(AdminPower) then AdminPower=0
	if isNul(Working) then Working=1
	num = conn.db("select count(*) from {pre}AdminUser where ID<>"&id&" and UserName='"&UserName&"'","execute")(0)
	if num>0 then die "已经存在此管理员，请更换名称"
	sqlStr = "update {pre}AdminUser set [UserName]='"&UserName&"',"& strpass &"[AdminPower]="&AdminPower&",[Working]="&Working&" where ID="&id
	conn.db sqlStr,"execute" 
	alertMsg "编辑成功","manager.asp?id="&id 
End Sub


Sub addManager
	dim UserName,Password,Password2,AdminPower,sqlStr,num
	UserName = getForm("UserName","post"):Password = getForm("Password","post"): Password2 = getForm("Password2","post") :AdminPower = getForm("AdminPower","post")
	if isNul(UserName) or isNul(Password) or isNul(Password2) then  die errorInfo
	if Password<>Password2 then die errorPwd
	if isNul(AdminPower) then AdminPower=0
	num = conn.db("select count(*) from {pre}AdminUser where UserName='"&UserName&"'","execute")(0)
	if num>0 then die "已经存在此管理员，请更换名称"
	sqlStr = "insert into {pre}AdminUser ([UserName],[Password],[AdminPower],[Working]) values ('"&UserName&"','"&md5(Password)&"',"&AdminPower&",1)"
	conn.db sqlStr,"execute" 
	alertMsg "添加成功","manager.asp" 
End Sub

Sub delmanager
	dim UserName
	id=getForm("id","get")
	UserName = conn.db("select UserName from {pre}AdminUser where ID="&id,"execute")(0)
	if UserName=rCookie("UserName") then 
		alertMsg "不能删除自身","manager.asp?id="&id
	else
		conn.db "delete from {pre}AdminUser where ID="&id,"execute" 
		alertMsg "","manager.asp"
	end if
End Sub

Sub delAll
	dim ids,num,idsArray,idsArraylen,i,UserName : ids=replaceStr(getForm("m_id","post")," ","")
	idsArray=split(ids,",") : idsArraylen=ubound(idsArray)
	for i=0 to idsArrayLen
		UserName = conn.db("select UserName from {pre}AdminUser where ID="&idsArray(i),"execute")(0)
		if UserName<>rCookie("UserName") then  conn.db "delete from {pre}AdminUser where ID="&idsArray(i),"execute" 
	next
	alertMsg "","manager.asp"
End Sub

Function getManagerLevel(id)
	if isNul(id) then getManagerLevel="未知" : Exit Function
	if id=0 then getManagerLevel="系统管理员" : Exit Function
	if id=1 then getManagerLevel="网站编辑" : Exit Function
End Function

Function getManagerState(id)
	if isNul(id) then getManagerState="未知" : Exit Function
	if id=0 then getManagerState="锁定" : Exit Function
	if id=1 then getManagerState="激活" : Exit Function
End Function
%>
