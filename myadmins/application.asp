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
				<h1>后台首页<%
				dim parentid : parentid = getForm("parentid","get")
				dim pid : pid = getForm("pid","get")
				if pid<>"" and pid<> "0" then
					echo " » " & conn.db("select NavName from {pre}Navigation where Id="&pid,"execute")(0)
				end if 
				%><%
				dim bid : bid = getForm("bid","get")
				if bid<>"" and bid<> "0" then
					echo " » " & conn.db("select NavName from {pre}Navigation where Id="&bid,"execute")(0)
				end if 
				%><%
				dim tid : tid = getForm("tid","get")
				if tid<>"" and tid<> "0" then
					echo " » " & conn.db("select NavName from {pre}Navigation where Id="&tid,"execute")(0)
				end if 
				%><%
				dim sid : sid = getForm("sid","get")
				if sid<>"" and sid<> "0" then
					echo " » " & conn.db("select NavName from {pre}Navigation where Id="&sid,"execute")(0)
				end if 
				%><%
				dim cid : cid = getForm("cid","get")
				if cid<>"" and cid <> "0"  then
					set rsc = conn.db("select WebType,NavName from {pre}Navigation where id="&cid,"records1")
					if not rsc.eof then
					echo " » " & rsc("NavName")
					dim webtype : webtype =  rsc("WebType")
					rsc.close
					set rsc=nothing
					end if
				end if 
				%>
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
dim playerArray,GuestBookArray
dim page,vtype,order
Select  case action
	case "delall" : delAll
	case "del" : delGuestBook
	case "edit" : editGuestBook
	case "save" : saveGuestBook
	case "uorder" : UpdateOrder
	case else : main
End Select 

Sub main
	dim datalistObj,rsArray
	dim m,i,orderStr,whereStr,sqlStr,rsObj,allPage,allRecordset,numPerPage,searchStr
	numPerPage= 20
	order = getForm("order", "get")
	if isNul(order)  then order = "Id desc"
	orderStr= " order by IsShow,"&order&""
	keyword = getForm("keyword", "both")
	page = getForm("page", "get")
	if isNul(page) then page=1 else page=clng(page)
	if page=0 then page=1
	vtype = cid
	whereStr=" where"
	
	if not isNul(keyword) then 
		whereStr = whereStr&" and MesTitle like '%"&keyword&"%' or  LinkName like '%"&keyword&"%' or  Email like '%"&keyword&"%'"
	end if
	sqlStr = replace(replace("select * from {pre}application "&whereStr&orderStr,"where and","where"),"where order","order")
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
<form method="post" name="GuestBooklistform">
				<div class="nav_tools"><span class="delete"><a href="javascript:document.GuestBooklistform.action='?action=delall&page=<%=page%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>';document.GuestBooklistform.submit();" onClick="return confirm('确定要删除选中数据')">批量删除</a></span><span class="nav_tools_right"></span></div>
				<div class="table">
<table width="100%" cellpadding="0" cellspacing="0">
  <tr>
    <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;text-indent:10px;border-left:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle">职位申请列表</td>
    <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;border-right:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle">
<div style="float:right;">关键字&nbsp;<input  name="keyword" type="text" id="keyword" size="20">&nbsp;<input type="submit" onclick="document.GuestBooklistform.action='?parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>';" name="selectBtn"  value="查 询..." class="btn" /></div>
</td>
  </tr>
<tr>
    <td colspan="2" align="right" bgcolor="#e5e5e5" style="border:solid #bbbbbb 1px;">
<div class="cuspages"><div class="pages">
页次：<%=page%>/<%=allPage%>  每页<%=numPerPage %> 总收录数据<%=allRecordset%>条 <a href="?page=1&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">首页</a> <a href="?page=<%=(page-1)%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">上一页</a> 
<%=makePageNumber(page, 8, allPage, "GuestBooklist","")%>
<a href="?page=<%=(page+1)%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">下一页</a> <a href="?page=<%=allPage%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">尾页</a></div></div>
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
            <td width="8%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px; border-left:solid #bbbbbb 1px;">
			<table width="70" cellpadding="0" cellspacing="0">
              <tbody>
                <tr>
					<td width="20" align="middle"><input type="checkbox" name="chkall" id="chkall" onclick="checkAll(this.checked,'input','m_id')" /></td>
					<td width="48" valign="middle">全选<a href="?order=ID&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&page=<%=page%>"><img src="images/minus.gif" title="按ID排序" /></a></td>
                </tr>
              </tbody>
            </table></td>
			<td width="8%" align="center" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;姓名</td>
			<td width="45%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;[回复][审核]标题</td>
            <td width="20%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;E-mail</td>
            <td width="10%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                <tr>
					<td>添加时间<a href="?order=CreateDate&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&page=<%=page%>"><img src="images/minus.gif" title="按时间排序" /></a></td>
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
			<table width="60" cellpadding="0" cellspacing="0">
              <tbody>
                <tr>
                  <td align="center"><%=rsObj("LinkName")%></td>
                </tr>
              </tbody>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><% if trim(rsObj("ReplyContent"))="" then response.Write"<img src='images/lock.gif'>" : else response.Write"<img src='images/yes.gif'>" %>
              &nbsp;<% if rsObj("IsShow")=0 then response.Write"<img src='images/lock.gif'>" : else response.Write"<img src='images/yes.gif'>" %>&nbsp;<%=rsObj("MesTitle")%></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=rsObj("Email")%></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%isCurrentDay(formatdatetime(rsObj("CreateDate"),2))%></td>
            <td align="middle" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			<table width="120" cellpadding="0" cellspacing="0">
              <tbody>
                <tr>
                  <td align="center"><a href="?action=edit&id=<%=m_id%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&page=<%=page%>">查看/回复</a></td>
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
页次：<%=page%>/<%=allPage%>  每页<%=numPerPage %> 总收录数据<%=allRecordset%>条 <a href="?page=1&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">首页</a> <a href="?page=<%=(page-1)%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">上一页</a> 
<%=makePageNumber(page, 8, allPage, "GuestBooklist","")%>
<a href="?page=<%=(page+1)%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">下一页</a> <a href="?page=<%=allPage%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">尾页</a></div></div>
	</td>
  </tr>
</table>
				</div>
				<div class="nav_tools leftbottom"><span class="delete"><a href="javascript:document.GuestBooklistform.action='?action=delall&page=<%=page%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>';document.GuestBooklistform.submit();" onClick="return confirm('确定要删除选中数据')">批量删除</a></span><span class="nav_tools_right rightbottom"></span></div>
</form>
<%
End Sub

Sub editGuestBook
	dim id,sqlStr,rsObj,m_color,playArray,GuestBookArray,playTypeCount,GuestBookTypeCount,i,j,m,n
	
	dim parentid : parentid = getForm("parentid","get")
	dim pid:pid=getForm("pid","get")
	dim bid:bid=getForm("bid","get")
	dim tid:tid=getForm("tid","get")
	dim sid:sid=getForm("sid","get")
	dim cid:cid=getForm("cid","get")
	
	id=clng(getForm("id","get"))
	sqlStr = "select *  from {pre}application where ID="&id
	set rsObj = conn.db(sqlStr,"records1")
	if rsObj.eof then die "没找到记录"
%>
<form method="post" action="?action=save&acttype=edit&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>"  name="addform" onSubmit="return validateform()">
				<div class="nav_tools"><span class="save"><a href="javascript:document.getElementsByName('addform')[0].submit();">保存</a></span><span class="back"><a href="<%=request.ServerVariables("HTTP_REFERER")%>">返回</a></span><span class="nav_tools_right"></span></div>
<div class="table">
<table width="100%" cellpadding="0" cellspacing="0">
  <tr>
    <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;text-indent:10px;border-right:solid #e5e5e5 1px; border-left:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle">编辑职位申请</td>
  </tr>
  <tr>
    <td align="left">
	<table width="100%" cellpadding="0" cellspacing="0" id="RiseList">
        <tbody>
          <tr bgcolor="#e5e5e5">
            <td width="10%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px; border-left:solid #bbbbbb 1px;">&nbsp;			</td>
            <td width="90%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;</td>
          </tr>
          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">职　　位:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=rsObj("MesTitle")%>&nbsp;</td>
          </tr>
          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">姓　　名:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=rsObj("LinkName")%>&nbsp;</td>
          </tr>
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">性　　别:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=rsObj("sex")%>&nbsp;</td>
          </tr>
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">出生日期:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=rsObj("birthday")%>&nbsp;</td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">婚姻状况:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=rsObj("marriage")%>&nbsp;</td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">毕业院校:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=rsObj("Graduate")%>&nbsp;</td>
          </tr>
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">专　　业:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=rsObj("professional")%>&nbsp;</td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">学　　历:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=rsObj("degree")%>&nbsp;</td>
          </tr>
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">毕业时间:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=rsObj("GraduationTime")%>&nbsp;</td>
          </tr>
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">E-mail:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=rsObj("Email")%>&nbsp;</td>
          </tr>
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">电　　话:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=rsObj("Telephone")%>&nbsp;</td>
          </tr>
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">即时通讯:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=rsObj("QQ")%>&nbsp;</td>
          </tr>
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">住　　址:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=rsObj("Address")%>&nbsp;</td>
          </tr>
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">个人简历:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=rsObj("MesContent")%>&nbsp;</td>
          </tr>
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">水平与能力:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=rsObj("skills")%>&nbsp;</td>
          </tr>
		  
          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">是否审核:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<input name="IsShow" type="checkbox" id="IsShow" value="yes" <% if rsObj("IsShow")=1 then response.Write("checked") end if%>></td>
          </tr>
		  <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">主　　题:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            &nbsp;<%=rsObj("MesTitle")%>&nbsp;</td>
          </tr>
		  
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">职位申请内容:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;&nbsp;<%=rsObj("MesContent")%>
			</td>
          </tr>
		  <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">回复内容:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			<textarea cols="70" rows="8" name="rcontent"><% if rsObj("ReplyContent")<>"" then response.Write codeTextarea(rsObj("ReplyContent"),"de") : else response.Write ""%></textarea>
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

<div class="nav_tools leftbottom"><span class="save"><a href="javascript:document.getElementsByName('addform')[0].submit();">保存</a></span><span class="back"><a href="<%=request.ServerVariables("HTTP_REFERER")%>">返回</a></span><span class="nav_tools_right rightbottom"></span></div>
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
Sub saveGuestBook
	dim actType : actType = getForm("acttype","get")
	dim updateSql,insertSql
	dim m_back:m_back=getForm("m_back","post")
	dim page:page=getForm("page","get")
	
	dim parentid:parentid=Cint(getForm("parentid","get"))
	
	dim pid:pid=getForm("pid","get")
	dim bid:bid=getForm("bid","get")
	dim tid:tid=getForm("tid","get")
	dim sid:sid=getForm("sid","get")
	dim cid:cid=getForm("cid","get")
	
	dim m_bid,oldm_bid,oldm_tid,m_sid,m_tid
			
	isshow = getForm("isshow","post")
	if isshow<>"" then rdate=1 : else rdate=0
	
	rcontent = getForm("rcontent","post")
	
	select case  actType
		case "edit"
			dim m_id:m_id=clng(getForm("m_id","post"))
			
			conn.db  "update {pre}application set ReplyContent='"&rcontent&"',isshow="&rdate&",ReplyTime='"&now()&"' where id="&m_id,"execute"
			
			alertMsg "",m_back
	end select
End Sub

Sub delGuestBook
	dim id,back,vtypeAndPic,vpic
	back = request.ServerVariables("HTTP_REFERER")
	id = getForm("id","get")
	on error resume next
	conn.db  "delete from {pre}application where id="&id,"execute"
	if err  then err.clear : die "图片已经删除,但删除静态文件或图片时发生错误，请手动删除相关文件" else  alertMsg "",back
End Sub

Sub UpdateOrder
	Dim ids			:	ids=split(getForm("m_id","post"),",")
	Dim orders		:	orders=split(getForm("order","post"),",")
	
	Dim i
	
	For i=0 To Ubound(ids)	
		updateSql = "update {pre}application Set ord="&trim(orders(i))&" Where ID="&trim(ids(i))	
		conn.db updateSql,"execute" 	
	Next
	
	parentid = getForm("parentid","get")
	pid=getForm("pid","get")
	bid=getForm("bid","get")
	tid=getForm("tid","get")
	sid=getForm("sid","get")
	cid=getForm("cid","get")
	
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")
	
	alertMsg "更新排序成功","?page="&page&"&order="&order&"&parentid="&parentid&"&pid="&pid&"&bid="&bid&"&tid="&tid&"&sid="&sid&"&cid="&cid&"&keyword="&keyword
End Sub

Sub delAll
	dim ids,idsLen,i
	ids = replaceStr(getForm("m_id","post")," ","")
	if ids<>"" Then
	conn.db  "delete from {pre}application where id in("&ids&")","execute" 
	end if
	parentid = getForm("parentid","get")
	
	pid=getForm("pid","get")
	bid=getForm("bid","get")
	tid=getForm("tid","get")
	sid=getForm("sid","get")
	cid=getForm("cid","get")
	
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")
	
	alertMsg "","?page="&page&"&order="&order&"&parentid="&parentid&"&pid="&pid&"&bid="&bid&"&tid="&tid&"&sid="&sid&"&cid="&cid&"&keyword="&keyword
End Sub
%>
