<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<title>后台管理</title>
<script src="scripts/jquery.min.js"></script>
<script src="scripts/jquery.cookie.js"></script>
<script language="javascript" type="text/javascript" src="datepicker/WdatePicker.js"></script>
</head>
<body><div id="main">
	<!--#include file="top.asp"-->
	<div id="content">
	<!--#include file="left.asp"-->
	<div id="right_content">
		<div id="main_content">
			<div class="top_nav"><span></span></div>
				<div class="nav_content" style="line-height:18px;">
				<h1>后台首页 » 会员管理
				</h1>
				</div>
			<div class="bottom_nav"><span></span></div>
			<div class="h6"></div>
			<div class="top_nav"><span></span></div>
<div class="nav_content">
				<div class="h7"></div>
<%
dim typeArray,topicArray,typeDic,topicDic,keyword,m_state,m_commend,repeat,contentUrl,pTopic
dim action : action = getForm("action", "get")
dim playerArray,UsersArray
dim page,vtype,order
Select  case action
	case "add" : addUsers
	case "delall" : delAll
	case "del" : delUsers
	case "edit" : saveEdit
	case "save" : saveUsers
	case "uorder" : UpdateOrder
	case "adds" : add
	case "edits" : edit
	case else : main
End Select 

Sub main
	dim datalistObj,rsArray
	dim m,i,orderStr,whereStr,sqlStr,rsObj,allPage,allRecordset,numPerPage,searchStr
	numPerPage= 20
	order = getForm("order", "get")
	if isNul(order)  then order = "Id desc"
	orderStr= " order by "&order&""
	keyword = getForm("keyword", "both")
	page = getForm("page", "get")
	classid = getForm("classid", "both")
	if classid="" then
	classid=1
	end if
	if isNul(page) then page=1 else page=clng(page)
	if page=0 then page=1
	
	whereStr=" where SortID="&classid&""
		
	if not isNul(keyword) then 
		whereStr = whereStr&" and UserName like '%"&keyword&"%' or EMail like '%"&keyword&"%'"
	end if
	sqlStr = replace(replace("select * from {pre}Users "&whereStr&orderStr,"where and","where"),"where order","order")
	set rsObj = conn.db(sqlStr,"records1")
	rsObj.pagesize = numPerPage
	allRecordset = rsObj.recordcount : allPage= rsObj.pagecount
	if page>allPage then page=allPage
	
%>
<script language="javascript" type="text/javascript">
//图片按比例缩放
function setimg(ImgD,w,h,url)
{
	var image=new Image(); 
	var iwidth = w;
	var iheight = h;
	image.onload=function()
	{
		ImgD.onload=null;
		ImgD.src=url;	
		if(image.width>0 && image.height>0)
		{		
			if(image.width/image.height>= iwidth/iheight)
			{ 
				if(image.width>iwidth)
				{   
					ImgD.width=iwidth;
				}
				else
				{ 
					ImgD.width=image.width
				}
				//ImgD.alt=image.width+"×"+image.height; 
				} 
			else
			{ 
				if(image.height>iheight)
				{
					ImgD.height=iheight; 
				}
				else
				{ 
					ImgD.width=image.width;
				}
			//ImgD.alt=image.width+"×"+image.height; 
			}
		}
	}	
	image.src=url;
}
</script>
<form method="post" name="Userslistform">
				<div class="nav_tools"><span class="add"><a href="?action=adds&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&classid=<%=classid%>">添加</a></span><span class="delete"><a href="javascript:document.Userslistform.action='?action=delall&page=<%=page%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>&classid=<%=classid%>';document.Userslistform.submit();" onClick="return confirm('确定要删除选中数据')">批量删除</a></span><span class="nav_tools_right"></span></div>
				<div class="table">
<table width="100%" cellpadding="0" cellspacing="0">
  <tr>
    <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;text-indent:10px;border-left:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle">会员列表</td>
    <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;border-right:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle">
<div style="float:right;">关键字&nbsp;<input  name="keyword" type="text" id="keyword" size="20">&nbsp;<input type="submit" onclick="document.Userslistform.action='?parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&classid=<%=classid%>';" name="selectBtn"  value="查 询..." class="btn" /></div>
</td>
  </tr>
<tr>
    <td colspan="2" align="right" bgcolor="#e5e5e5" style="border:solid #bbbbbb 1px;">
<div class="cuspages"><div class="pages">
页次：<%=page%>/<%=allPage%>  每页<%=numPerPage %> 总收录数据<%=allRecordset%>条 <a href="?page=1&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>&classid=<%=classid%>">首页</a> <a href="?page=<%=(page-1)%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>&classid=<%=classid%>">上一页</a> 
<%=makePageNumber(page, 8, allPage, "Userslist","")%>
<a href="?page=<%=(page+1)%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>&classid=<%=classid%>">下一页</a> <a href="?page=<%=allPage%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>&classid=<%=classid%>">尾页</a></div></div>
	</td>
  </tr>
  <tr>
    <td colspan="2" align="left">
<%
if allRecordset=0 then
	%>
		<table width="100%" cellpadding="0" cellspacing="0">
		  <tr>
			<td align="center" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<%
			if not isNul(keyword) then 
				echo "关键字  <span  style='color:#FF0000;'>"& keyword &"</span>   没有记录"
			else
				echo "没有任何记录"
			end if
			%>
			</td>
		  </tr>
		</tbody>
		</table>
	<%
else  
	rsObj.absolutepage = page
	if not isNul(keyword) then 
	%>
	<table width="100%" cellpadding="0" cellspacing="0">
	  <tr>
		<td align="center" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
		关键字  <span  style="color:#FF0000;"> <%=keyword%> </span>   的记录如下		</td>
	  </tr>
	</tbody>
	</table>
	<%
	end if
%>
	<table width="100%" cellpadding="0" cellspacing="0">
        <tbody>
          <tr bgcolor="#e5e5e5">
            <td width="10%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px; border-left:solid #bbbbbb 1px;">
			<table width="70" cellpadding="0" cellspacing="0">
              <tbody>
                <tr>
					<td width="20" align="middle"><input type="checkbox" name="chkall" id="chkall" onclick="checkAll(this.checked,'input','m_id')" /></td>
					<td width="48" valign="middle">全选<a href="?order=ID&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&page=<%=page%>"><img src="images/minus.gif" title="按ID排序" /></a></td>
                </tr>
              </tbody>
            </table></td>
            <td width="18%" align="center" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">会员昵称</td>
			<td width="18%" align="center" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">电子邮箱</td>
			<td width="18%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;手机号码</td>
            <td width="18%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;公司名称</td>
            <td width="5%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                <tr>
					<td align="center">状态</td>
                </tr>
            </table></td>
            <td width="9%" align="center" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">操作</td>
          </tr>
		<%
			for i = 0 to numPerPage - 1	
				dim m_id : m_id = rsObj(0)
		%>
          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="70" cellpadding="0" cellspacing="0">
              <tbody>
                <tr>
					<td width="20" align="middle"><input type="checkbox" value="<%=m_id%>" name="m_id" /></td>
					<td width="48" valign="middle"><%=m_id%>.</td>
                </tr>
              </tbody>
            </table></td>
			<td align="center" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
<table width="100" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td align="center" bgcolor="#ffffff"><a href="?action=edit&id=<%=m_id%>&type=<%=vtype%>&page=<%=page%>"><%=rsObj("UserName")%></a></td>
</tr>
</table>			</td>
			<td align="center" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			<table width="50" cellpadding="0" cellspacing="0">
              <tbody>
                <tr>
                  <td align="center"><%=rsObj("Email")%></td>
                </tr>
              </tbody>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=rsObj("Mobile")%></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=rsObj("QQ")%></td>
            <td align="center" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=getUsersState(rsObj("Working"))%></td>
            <td align="middle" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
              <tbody>
                <tr>
                  <td align="center"><a href="?action=edits&id=<%=m_id%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&page=<%=page%>">修改</a></td>
                  <td align="center">|</td>
                  <td align="center"><a href="?action=del&id=<%=m_id%>" onClick="return confirm('确定要删除吗')">删除</a></td>
                </tr>
              </tbody>
            </table></td>
          </tr>
		<%
				rsObj.movenext
				if rsObj.eof then exit for
			next
		%>
        </tbody>
      </table>
	<%
	end if
	rsObj.close
	set rsObj = nothing
%>	</td>
  </tr>
  <tr>
    <td colspan="2" align="right" bgcolor="#e5e5e5" style="border:solid #bbbbbb 1px;">
<div class="cuspages"><div class="pages">
页次：<%=page%>/<%=allPage%>  每页<%=numPerPage %> 总收录数据<%=allRecordset%>条 <a href="?page=1&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>&classid=<%=classid%>">首页</a> <a href="?page=<%=(page-1)%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>&classid=<%=classid%>">上一页</a> 
<%=makePageNumber(page, 8, allPage, "Userslist","")%>
<a href="?page=<%=(page+1)%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>&classid=<%=classid%>">下一页</a> <a href="?page=<%=allPage%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>&classid=<%=classid%>">尾页</a></div></div>
	</td>
  </tr>
</table>
				</div>
				<div class="nav_tools leftbottom"><span class="add"><a href="?action=adds&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>">添加</a></span><span class="delete"><a href="javascript:document.Userslistform.action='?action=delall&page=<%=page%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>';document.Userslistform.submit();" onClick="return confirm('确定要删除选中数据')">批量删除</a></span><span class="nav_tools_right rightbottom"></span></div>
</form>
<%
End Sub


Sub add
%>
<form method="post" action="?action=add&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&classid=<%=classid%>"  name="addform" onSubmit="return validateform()">
				<div class="nav_tools"><span class="save"><a href="javascript:usersave();">保存</a></span><span class="back"><a href="<%=request.ServerVariables("HTTP_REFERER")%>">返回</a></span><span class="nav_tools_right"></span></div>
<div class="table">
<table width="100%" cellpadding="0" cellspacing="0">
  <tr>
    <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;text-indent:10px;border-right:solid #e5e5e5 1px; border-left:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle">添加会员</td>
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
					<td align="right">电子邮箱:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <input type="hidden" size="30" name="SortID" id="SortID" value="<%=getForm("classid","get")%>" />
            &nbsp;<input type="text" size="30" name="Email" id="Email" />&nbsp;<font color='red'>＊</font>
            </td>
          </tr>
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">会员昵称:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            &nbsp;<input type="text" size="30" name="UserName" id="UserName" />&nbsp;<font color='red'>＊</font>
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
			&nbsp;<input type="password" size="30" name="Password" />&nbsp;<font color='red'>＊</font>
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
					<td align="right">手机号码:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<input type="text" size="30" name="Mobile" id="Mobile" /><font color="red">＊</font></span>
            </td>
          </tr>
		  
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">电话:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<input type="text" size="30" name="Phone" id="Phone" />
            </td>
          </tr>
		  
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">传真:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<input type="text" size="30" name="Fax" id="Fax" />
            </td>
          </tr>
		  
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">公司名称:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<input type="text" size="30" name="Company" id="Company" />
            </td>
          </tr>
		  
		  <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">QQ:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<input type="text" size="30" name="QQ" id="QQ" />
            </td>
          </tr>
		  
		  <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">公司职位:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<input type="text" size="30" name="City" id="City" />
            </td>
          </tr>
		  
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">公司地址:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<input type="text" size="30" name="Address" id="Address" />
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

<div class="nav_tools leftbottom"><span class="save"><a href="javascript:usersave();">保存</a></span><span class="back"><a href="<%=request.ServerVariables("HTTP_REFERER")%>">返回</a></span><span class="nav_tools_right rightbottom"></span></div>
</form>
<%	
End Sub

Sub edit
	dim id,sqlStr,rsObj,m_color,playArray,UsersArray,playTypeCount,UsersTypeCount,i,j,m,n
	
	dim parentid : parentid = getForm("parentid","get")
	dim pid:pid=getForm("pid","get")
	dim bid:bid=getForm("bid","get")
	dim tid:tid=getForm("tid","get")
	dim sid:sid=getForm("sid","get")
	dim cid:cid=getForm("cid","get")
	
	id=clng(getForm("id","get"))
	sqlStr = "select *  from {pre}Users where ID="&id
	set rsObj = conn.db(sqlStr,"records1")
	if rsObj.eof then die "没找到记录"
%>
<form method="post" action="?action=edit&id=<%=id%>"  name="addform" onSubmit="return validateform()">
				<div class="nav_tools"><span class="save"><a href="javascript:usersave();">保存</a></span><span class="back"><a href="<%=request.ServerVariables("HTTP_REFERER")%>">返回</a></span><span class="nav_tools_right"></span></div>
<div class="table">
<table width="100%" cellpadding="0" cellspacing="0">
  <tr>
    <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;text-indent:10px;border-right:solid #e5e5e5 1px; border-left:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle">编辑会员</td>
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
					<td align="right">电子邮箱:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><input type="hidden" size="30" name="SortID" id="SortID" value="<%=rsObj("SortID")%>"/>
            &nbsp;<input type="text" size="30" name="Email" id="Email" value="<%=rsObj("EMail")%>"/>&nbsp;<font color='red'>＊</font>
            </td>
          </tr>
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">会员昵称:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            &nbsp;<input type="text" size="30" name="UserName" id="UserName" value="<%=rsObj("UserName")%>"/>&nbsp;<font color='red'>＊</font>
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
			&nbsp;<input type="password" size="30" name="Password" />&nbsp;<font color="red">＊不修改为空</font>
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
					<td align="right">手机号码:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<input type="text" size="30" name="Mobile" id="Mobile" value="<%=rsObj("Mobile")%>"/><font color="red">＊</font></span>
            </td>
          </tr>
		  
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">电话:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<input type="text" size="30" name="Phone" id="Phone" value="<%=rsObj("Phone")%>"/>
            </td>
          </tr>
		  
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">传真:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<input type="text" size="30" name="Fax" id="Fax" value="<%=rsObj("Fax")%>"/>
            </td>
          </tr>
		  
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">公司名称:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<input type="text" size="30" name="Company" id="Company" value="<%=rsObj("Company")%>"/>
            </td>
          </tr>
		  
		  <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">QQ:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<input type="text" size="30" name="QQ" id="QQ" value="<%=rsObj("QQ")%>"/>
            </td>
          </tr>
		  
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">公司职位:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<input type="text" size="30" name="City" id="City" value="<%=rsObj("City")%>"/>
            </td>
          </tr>
		  
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">公司地址:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<input type="text" size="30" name="Address" id="Address" value="<%=rsObj("Address")%>"/>
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
    <td align="left" bgcolor="#e5e5e5" style="border:solid #bbbbbb 1px;">&nbsp;<input type="hidden" name="m_id" value="<%=id%>">
      <input type="hidden" name="m_back" value="<%=request.ServerVariables("HTTP_REFERER")%>" /></td>
  </tr>
</table>
</div>

<div class="nav_tools leftbottom"><span class="save"><a href="javascript:usersave();">保存</a></span><span class="back"><a href="<%=request.ServerVariables("HTTP_REFERER")%>">返回</a></span><span class="nav_tools_right rightbottom"></span></div>
</form>
<%
set rsObj = nothing
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
	dim UserName,Password,Password2,AdminPower,Working,sqlStr,num,EMail,Mobile,Phone,Fax,Company,QQ,City,Address,strpass,SortID
	UserName = getForm("UserName","post"):Password = getForm("Password","post"): Password2 = getForm("Password2","post") :AdminPower = getForm("AdminPower","post") : Working=getForm("Working","post") : id=getForm("id","get") : EMail=getForm("EMail","post") : Mobile=getForm("Mobile","post") : Phone=getForm("Phone","post") : Fax=getForm("Fax","post")  : Company=getForm("Company","post") : QQ=getForm("QQ","post") : City=getForm("City","post") : Address=getForm("Address","post") : SortID=getForm("classid","post")
	if Password<>Password2 then die errorPwd
	if isNul(Password)  or isNul(Password2) then
		strpass = ""
	else
		strpass = "[Password]='"&md5(Password)&"',"
	end if
	
	if isNul(AdminPower) then AdminPower=0
	if isNul(Working) then Working=1
	num = conn.db("select count(*) from {pre}Users where ID<>"&id&" and UserName='"&UserName&"'","execute")(0)
	if num>0 then die "已经存在此会员，请更换名称"
	sqlStr = "update {pre}Users set "& strpass &"[Mobile]='"&Mobile&"',[Phone]='"&Phone&"',[Fax]='"&Fax&"',[Company]='"&Company&"',[QQ]='"&QQ&"',[City]='"&City&"',[Address]='"&Address&"',[Working]="&Working&" where ID="&id
	conn.db sqlStr,"execute" 
	alertMsg "编辑成功","users.asp?id="&id 
End Sub


Sub addUsers
	dim UserName,Password,Password2,AdminPower,sqlStr,num,EMail,Mobile,Phone,Fax,Company,QQ,City,Address,SortID
	UserName = getForm("UserName","post"):Password = getForm("Password","post"): Password2 = getForm("Password2","post") : AdminPower = getForm("AdminPower","post") : EMail=getForm("EMail","post") : Mobile=getForm("Mobile","post") : Phone=getForm("Phone","post") : Fax=getForm("Fax","post") : Company=getForm("Company","post")   : QQ=getForm("QQ","post") : City=getForm("City","post") : Address=getForm("Address","post") : SortID=getForm("SortID","post")
	if isNul(UserName) or isNul(Password) or isNul(Password2) then  die errorInfo
	if Password<>Password2 then die errorPwd
	if isNul(AdminPower) then AdminPower=0
	num = conn.db("select count(*) from {pre}Users where UserName='"&UserName&"'","execute")(0)
	if num>0 then die "已经存在此会员，请更换名称"
	sqlStr = "insert into {pre}Users ([EMail],[UserName],[Password],[Mobile],[Phone],[Fax],[Company],[QQ],[City],[Address],SortID,[Working]) values ('"&EMail&"','"&UserName&"','"&md5(Password)&"','"&Mobile&"','"&Phone&"','"&Fax&"','"&Company&"','"&QQ&"','"&City&"','"&Address&"',"&SortID&",1)"
	conn.db sqlStr,"execute" 
	alertMsg "添加成功","users.asp" 
End Sub

Sub delUsers
	dim UserName
	id=getForm("id","get")
	UserName = conn.db("select UserName from {pre}Users where ID="&id,"execute")(0)
	if UserName=rCookie("UserName") then 
		alertMsg "不能删除自身","users.asp?id="&id
	else
		conn.db "delete from {pre}Users where ID="&id,"execute" 
		alertMsg "","users.asp"
	end if
End Sub

Sub delAll
	dim ids,num,idsArray,idsArraylen,i,UserName : ids=replaceStr(getForm("m_id","post")," ","")
	idsArray=split(ids,",") : idsArraylen=ubound(idsArray)
	for i=0 to idsArrayLen
		UserName = conn.db("select UserName from {pre}Users where ID="&idsArray(i),"execute")(0)
		if UserName<>rCookie("UserName") then  conn.db "delete from {pre}Users where ID="&idsArray(i),"execute" 
	next
	alertMsg "","users.asp"
End Sub

Function getUsersState(id)
	if isNul(id) then getUsersState="未知" : Exit Function
	if id=0 then getUsersState="锁定" : Exit Function
	if id=1 then getUsersState="激活" : Exit Function
End Function
%>