<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<title>后台管理</title>
<script src="scripts/jquery.min.js"></script>
<script src="scripts/jquery.cookie.js"></script>

  <link rel="Stylesheet" type="text/css" href="ColorSelect/css/jpicker-1.1.6.min.css" />
  <link rel="Stylesheet" type="text/css" href="ColorSelect/jPicker.css" />
  <script src="ColorSelect/jpicker-1.1.6.min.js" type="text/javascript"></script>
  <script type="text/javascript">
    $(function()
      {
        $.fn.jPicker.defaults.images.clientPath='ColorSelect/images/';
        var LiveCallbackElement = $('#Live'),
            LiveCallbackButton = $('#LiveButton');
        $('#Binded').jPicker({window:{title:'Binded Example'},color:{active:new $.jPicker.Color({ahex:'993300ff'})}});

      });
  </script>

  <link rel="stylesheet" href="../TextEditor/UltraEdit/themes/default/default.css" />
		<script charset="utf-8" src="../TextEditor/UltraEdit/kindeditor-min.js"></script>
		<script charset="utf-8" src="../TextEditor/UltraEdit/lang/zh_CN.js"></script>
		<script src="../TextEditor/UltraEdit/kindeditor.js"></script>

<script>
			KindEditor.ready(function(K) {
				var editor = K.editor({
				  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
				  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					allowFileManager : true
				});
				K('#image1').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							imageUrl : K('#m_pic').val(),
							clickFn : function(url, title, width, height, border, align) {
								K('#m_pic').val(url);
								editor.hideDialog();
							}
						});
					});
				});
				K('#image2').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							imageUrl : K('#m_picen').val(),
							clickFn : function(url, title, width, height, border, align) {
								K('#m_picen').val(url);
								editor.hideDialog();
							}
						});
					});
				});
			});
		</script>
		<script>
			KindEditor.ready(function(K) {
				K.create('#content3', {
					pasteType : 2
				});
				K.create('#content4', {
					pasteType : 2
				});
			});
		</script>


</head>
<body><div id="main">
	<!--#include file="top.asp"-->
	<div id="content">
	<!--#include file="left.asp"-->
	<div id="right_content">
		<div id="main_content">
			<div class="top_nav"><span></span></div>
				<div class="nav_content" style="line-height:18px;">
				<h1>后台首页» 幻灯片</h1>
				</div>
			<div class="bottom_nav"><span></span></div>
			<div class="h6"></div>
			<div class="top_nav"><span></span></div>
<div class="nav_content">
				<div class="h7"></div>
<%
dim typeArray,topicArray,typeDic,topicDic,keyword,m_state,m_commend,repeat,contentUrl,pTopic
dim action : action = getForm("action", "get")
dim playerArray,SlideArray
dim page,vtype,order
Select  case action
	case "add" : addSlide
	case "delall" : delAll
	case "del" : delSlide
	case "edit" : editSlide
	case "save" : saveSlide
	case "uorder" : UpdateOrder
	case else : main
End Select

Sub main
	dim datalistObj,rsArray
	dim m,i,orderStr,whereStr,sqlStr,rsObj,allPage,allRecordset,numPerPage,searchStr
	numPerPage= 20
	order = getForm("order", "get")
	if isNul(order)  then order = "Id desc"
	orderStr= "  order by SlideNameen,ord,"&order&""
	keyword = getForm("keyword", "both")
	proclass = getForm("proclass", "both")
	page = getForm("page", "get")
	if isNul(page) then page=1 else page=clng(page)
	if page=0 then page=1

	whereStr=" where sortid=1"

	if not isNul(keyword) then
		whereStr = whereStr&" and SlideName like '%"&keyword&"%'"
	end if

	if not isNul(proclass) then
		whereStr = whereStr&" and ParentID="&proclass&" "
	end if

	sqlStr = replace(replace("select ID,ParentID,SlideName,SlideNameen,SlideType,SortID,CreateDate,ord,IsShow,sSlidePic from {pre}Slide "&whereStr&orderStr,"where and","where"),"where order","order")
	set rsObj = conn.db(sqlStr,"records1")
	rsObj.pagesize = numPerPage
	allRecordset = rsObj.recordcount : allPage= rsObj.pagecount
	if page>allPage then page=allPage

%>
<script language="javascript" type="text/javascript">
//按比例缩放
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
<form method="post" name="Slidelistform">
				<div class="nav_tools"><span class="add"><a href="?action=add&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>">添加</a></span><span class="edit"><a href="javascript:document.Slidelistform.action='?action=uorder&page=<%=page%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>';document.Slidelistform.submit();">更新排序</a></span><span class="delete"><a href="javascript:document.Slidelistform.action='?action=delall&page=<%=page%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>';document.Slidelistform.submit();" onClick="return confirm('确定要删除选中数据')">批量删除</a></span><span class="nav_tools_right"></span></div>
				<div class="table">
<table width="100%" cellpadding="0" cellspacing="0">
  <tr>
    <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;text-indent:10px;border-left:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle">幻灯片列表</td>
    <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;border-right:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle">
<div style="float:right;">关键字&nbsp;<input  name="keyword" type="text" id="keyword" size="20">&nbsp;<input type="submit" onclick="document.Slidelistform.action='?parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>';" name="selectBtn"  value="查 询..." class="btn" /></div>
</td>
  </tr>
  <tr>
                  <td colspan="2" align="left" valign="middle" bgcolor="#ffffff" style="color:#333333; font-weight:bold;text-indent:10px;border-left:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;"><div style="float:left;">按所属类别筛选&nbsp;
                      <select name="Proclass" id="Proclass">
                        <option value="">所有</option>
                        <%makeTypePOption(0),"&nbsp;|&nbsp;&nbsp;",0%>

                      </select>
                    &nbsp;
                    <input type="submit" onclick="document.Newslistform.action='?parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>';" name="selectBtn"  value="查 询..." class="btn" />
                  </div></td>
                </tr>


<tr>
    <td colspan="2" align="right" bgcolor="#e5e5e5" style="border:solid #bbbbbb 1px;">
                      <div class="pages"> 页次：<%=page%>/<%=allPage%> 每页<%=numPerPage %> 总收录数据<%=allRecordset%>条 <a href="?page=1&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">首页</a> <a href="?page=<%=(page-1)%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">上一页</a> <%=makePageNumber(page, 8, allPage, "Newslist","")%> <a href="?page=<%=(page+1)%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">下一页</a> <a href="?page=<%=allPage%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">尾页</a></div>
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
					<td width="48">全选<a href="?order=ID&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&page=<%=page%>"><img src="images/minus.gif" title="按ID排序" /></a></td>
                </tr>
              </tbody>
            </table></td>
            <td width="10%" align="center" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">幻灯片</td>
			<td width="5%" align="center" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">排序</td>
			<td width="38%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;幻灯片名称<a href="?order=SlideType&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&page=<%=page%>"><img src="images/minus.gif" title="按版本排序" /></td>
            <td width="20%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;幻灯片类别<a href="?order=ParentID&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&page=<%=page%>"><img src="images/minus.gif" title="按ID排序" /></td>
            <td width="10%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
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

          <tr >
            <td align="left"
            	<%if rsObj("SlideNameen")="English" Then %>
style="border-top:solid #f1f1f1 1px;border-right:solid #f1f1f1 1px; border-left:solid #f1f1f1 1px; background:#dddddd"
            	<%else%>
style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"
            	<%end if%>
             >
			<table width="70" cellpadding="0" cellspacing="0">
              <tbody>
                <tr>
					<td width="20" align="middle"><input type="checkbox" value="<%=m_id%>" name="m_id" /></td>
					<td width="48" valign="middle"><%=m_id%>.</td>
                </tr>
              </tbody>
            </table></td>
			<td align="center"
			<%if rsObj("SlideNameen")="English" Then %>
style="border-top:solid #f1f1f1 1px;border-right:solid #f1f1f1 1px; border-left:solid #f1f1f1 1px; background:#dddddd"
            	<%else%>
style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"
            	<%end if%>>
<table width="100" height="100" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td align="center"  ><a href="?action=edit&id=<%=m_id%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&page=<%=page%>"><img src="images/loading2.gif"  border="0" onload="setimg(this,221,100,'<%if rsObj("sSlidePic")<>"" then%><%=rsObj("sSlidePic")%><%else%>images/nopic.jpg<%end if%>')"/></a></td>
</tr>
</table>			</td>
			<td align="center"
			<%if rsObj("SlideNameen")="English" Then %>
style="border-top:solid #f1f1f1 1px;border-right:solid #f1f1f1 1px; border-left:solid #f1f1f1 1px; background:#dddddd"
            	<%else%>
style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"
            	<%end if%>>
			<table width="50" cellpadding="0" cellspacing="0">
              <tbody>
                <tr>
                  <td align="center"><input class="o-input" data-id="<%=m_id%>" onchange="orderChange(this,<%=m_id%>)" type="text" name="order" value="<%=rsObj("ord")%>" style="width:40px; text-align:center;"/><span class="status"></span></td>
                </tr>
              </tbody>
            </table></td>
            <td align="left"
            <%
			if rsObj("SlideType")="Chinese" Then
			styl="style='color:red; font-size:14px; font-weight:bold'"
			end if
			if rsObj("SlideType")="English" Then
			styl="style='color:green; font-size:14px; font-weight:bold'"
			end if
			if rsObj("SlideType")="Japanese" Then
			styl="style='color:blue; font-size:14px; font-weight:bold'"
			end if
			%>
            <%if rsObj("SlideNameen")="English" Then %>
style="border-top:solid #f1f1f1 1px;border-right:solid #f1f1f1 1px; border-left:solid #f1f1f1 1px; background:#dddddd"
            	<%else%>
style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"
            	<%end if%>>&nbsp;<%=rsObj("SlideName")%><br/><span <%=styl%>>【<%=rsObj("SlideType")%>】</span>&nbsp;<% if rsObj("IsShow")=true then response.Write("&nbsp;<font color='#ff0000'>[隐藏]</font>") end if %></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=SortName(rsObj("ParentID"))%></td>
            <td align="left"
            <%if rsObj("SlideNameen")="English" Then %>
style="border-top:solid #f1f1f1 1px;border-right:solid #f1f1f1 1px; border-left:solid #f1f1f1 1px; background:#dddddd"
            	<%else%>
style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"
            	<%end if%>>&nbsp;<%isCurrentDay(formatdatetime(rsObj("CreateDate"),2))%></td>
            <td align="middle"
            <%if rsObj("SlideNameen")="English" Then %>
style="border-top:solid #f1f1f1 1px;border-right:solid #f1f1f1 1px; border-left:solid #f1f1f1 1px; background:#dddddd"
            	<%else%>
style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"
            	<%end if%>>
			<table width="80" cellpadding="0" cellspacing="0">
              <tbody>
                <tr>
                  <td align="center"><a href="?action=edit&id=<%=m_id%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&page=<%=page%>">修改</a></td>
                  <td align="center">|</td>
                  <td align="center"><a href="?action=del&id=<%=m_id%>" onClick="return confirm('确定要删除吗')">删除</a></td>
                </tr>
              </tbody>
            </table></td>
          </tr>
		<%	'end if
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
                      <div class="pages"> 页次：<%=page%>/<%=allPage%> 每页<%=numPerPage %> 总收录数据<%=allRecordset%>条 <a href="?page=1&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">首页</a> <a href="?page=<%=(page-1)%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">上一页</a> <%=makePageNumber(page, 8, allPage, "Newslist","")%> <a href="?page=<%=(page+1)%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">下一页</a> <a href="?page=<%=allPage%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">尾页</a></div>

	</td>
  </tr>
</table>
				</div>
				<div class="nav_tools leftbottom"><span class="add"><a href="?action=add&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>">添加</a></span><span class="edit"><a href="javascript:document.Slidelistform.action='?action=uorder&page=<%=page%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>';document.Slidelistform.submit();">更新排序</a></span><span class="delete"><a href="javascript:document.Slidelistform.action='?action=delall&page=<%=page%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>';document.Slidelistform.submit();" onClick="return confirm('确定要删除选中数据')">批量删除</a></span><span class="nav_tools_right rightbottom"></span></div>
</form>
<%
End Sub


Sub addSlide
%>
<form method="post" action="?action=save&acttype=add&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>"  name="addform" onSubmit="return validateform()">
            <div class="nav_tools"><span class="save"><input type="submit" value="保存" class="but" onclick="addsave()"/></span><span class="back"><a href="<%=request.ServerVariables("HTTP_REFERER")%>">返回</a></span><span class="nav_tools_right"></span></div>
<div class="table">
<table width="100%" cellpadding="0" cellspacing="0">
  <tr>
    <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;text-indent:10px;border-right:solid #e5e5e5 1px; border-left:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle">添加幻灯片</td>
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
					<td align="right">幻灯片名称:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            &nbsp;<input id="m_name" name="m_name" size="60"  value="" />&nbsp;<font color='red'>＊</font>
            </td>
          </tr>
		  <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">(EN)名称:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            &nbsp;<input id="m_nameen" name="m_nameen" size="60"  value="" />&nbsp;<font color='red'>＊</font>
            </td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">网址链接:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
&nbsp;<input id="m_slideurl" name="m_slideurl" size="60"  value="#" />
&nbsp;格式：http://www.baidu.com
            </td>
          </tr>

		  <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">背景颜色:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
&nbsp;<input name="m_bcolor"  id="Binded" value="ffffff" size="60" />
&nbsp;格式：ff0000
            </td>
          </tr>

          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">所属栏目:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<select name="ParentID" onchange="cheak_colume(this.value)">
			<option value="0">顶级栏目</option>
			<%makeTypePOption(0),"&nbsp;|&nbsp;&nbsp;",0%>
			</select><font color='red'>＊</font>
            <!--<input name="ParentID"  type="hidden" value="1"/>-->
            </td>
          </tr>

          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">所属类别:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<select name="m_type" id="m_type"  >
    <option value="Chinese"> Chinese </option>
    <option value="English"> English </option>
    <option value="m"> 手机(CN) </option>
    <option value="men"> 手机(EN) </option>
    <!--<option value="Japanese"> Japanese </option>-->
	</select>&nbsp;&nbsp;<font color="red">＊</font>
	  &nbsp;&nbsp;<input name="IsShow" type="checkbox" id="IsShow" value="yes">是否隐藏
	  &nbsp;&nbsp;排序<input size="10" name="m_ord" value="100"/>
            </td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">幻灯片图片:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<textarea name="m_pic"  type="text" id="m_pic" /></textarea> <input type="button" id="image1" value="选择图片" />
			首页1920px*600px内页1920*301</td>
          </tr>

		  <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">(EN)图片:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<textarea name="m_picen"  type="text" id="m_picen" /></textarea> <input type="button" id="image2" value="选择图片" />
            </td>
          </tr>
                        <tr style="display:none">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">描述(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
                          <textarea id="content3" name="m_p_spec" style="width:100%;height:200px;visibility:hidden;"></textarea>
                         </td>
                        </tr>

                        <tr style="display:none">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">描述(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
                           <textarea id="content4" name="m_p_specen" style="width:100%;height:200px;visibility:hidden;"></textarea>
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

            <div class="nav_tools"><span class="save"><input type="submit" value="保存" class="but" onclick="addsave()"/></span><span class="back"><a href="<%=request.ServerVariables("HTTP_REFERER")%>">返回</a></span><span class="nav_tools_right"></span></div>
</form>
<%
End Sub

Sub editSlide
	dim id,sqlStr,rsObj,m_color,playArray,SlideArray,playTypeCount,SlideTypeCount,i,j,m,n

	dim parentid : parentid = getForm("parentid","get")
	dim pid:pid=getForm("pid","get")
	dim bid:bid=getForm("bid","get")
	dim tid:tid=getForm("tid","get")
	dim sid:sid=getForm("sid","get")
	dim cid:cid=getForm("cid","get")

	id=clng(getForm("id","get"))
	sqlStr = "select *  from {pre}Slide where ID="&id
	set rsObj = conn.db(sqlStr,"records1")
	if rsObj.eof then die "没找到记录"
	vtype = rsObj("SortID")
%>
<form method="post" action="?action=save&acttype=edit&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>"  name="addform" onSubmit="return validateform()">
            <div class="nav_tools"><span class="save"><input type="submit" value="保存" class="but" onclick="addsave()"/></span><span class="back"><a href="<%=request.ServerVariables("HTTP_REFERER")%>">返回</a></span><span class="nav_tools_right"></span></div>
<div class="table">
<table width="100%" cellpadding="0" cellspacing="0">
  <tr>
    <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;text-indent:10px;border-right:solid #e5e5e5 1px; border-left:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle">编辑幻灯片</td>
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
					<td align="right">幻灯片名称:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            &nbsp;<input id="m_name" name="m_name" size="60"  value="<%=rsObj("SlideName")%>" />&nbsp;<font color='red'>＊</font>
            </td>
          </tr>
		  <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">(EN)名称:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            &nbsp;<input id="m_nameen" name="m_nameen" size="60"  value="<%=rsObj("SlideNameen")%>" />&nbsp;<font color='red'>＊</font>
            </td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">网址链接:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            &nbsp;<input id="m_slideurl" name="m_slideurl" size="60"  value="<%=rsObj("SlideUrl")%>" />
            &nbsp;格式：http://www.baidu.com
            </td>
          </tr>

		  <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">背景颜色:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
&nbsp;<input id="Binded" name="m_bcolor" size="60"  value="<%=rsObj("bcolor")%>" />
&nbsp;格式：ff0000
            </td>
          </tr>

          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">所属栏目:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			 &nbsp;<select name="ParentID" onchange="cheak_colume(this.value)" <%if rsObj("ParentID")=0 Then echo ""%> >
			<option value="0">顶级栏目</option>
			<%makeTypeOption(0),"&nbsp;|&nbsp;&nbsp;",rsObj("ParentID")%>
			</select><font color='red'>＊</font>
          <!--<input name="ParentID"  type="hidden" value="1"/>-->
            </td>
          </tr>

          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">所属类别:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<select name="m_type" id="m_type"  >
    <option value="Chinese" <% if rsObj("SlideType")="Chinese" Then echo "selected"%>> Chinese </option>
    <option value="English" <% if rsObj("SlideType")="English" Then echo "selected"%>> English </option>
    <option value="m" <% if rsObj("SlideType")="m" Then echo "selected"%>> 手机(CN) </option>
    <option value="men" <% if rsObj("SlideType")="men" Then echo "selected"%>> 手机(EN) </option>
    <!--<option value="Japanese" <%' if rsObj("SlideType")="Japanese" Then echo "selected"%>> Japanese </option>-->
	</select>&nbsp;&nbsp;<font color="red">＊</font>
	  &nbsp;&nbsp;<input name="IsShow" type="checkbox" id="IsShow" value="yes" <% if rsObj("IsShow")=true then response.Write("checked") end if%>>是否隐藏
	  &nbsp;&nbsp;排序<input size="10" name="m_ord" value="<%=rsObj("Ord")%>"/>
            </td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">幻灯片图片:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<textarea name="m_pic"  type="text" id="m_pic" /><%=rsObj("sSlidePic")%></textarea>
			<input type="button" id="image1" value="选择图片" />
			首页1920px*600px内页1920*301</td>
          </tr>
		  <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">(EN)图片:</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<textarea name="m_picen"  type="text" id="m_picen" /><%=rsObj("sSlidePicen")%></textarea> <input type="button" id="image2" value="选择图片" />
            </td>
          </tr>


                        <tr style="display:none">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">描述(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
                          <textarea id="content3" name="m_p_spec" style="width:100%;height:200px;visibility:hidden;"><%=rsObj("p_spec")%></textarea>
                         </td>
                        </tr>

                        <tr style="display:none">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">描述(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
                           <textarea id="content4" name="m_p_specen" style="width:100%;height:200px;visibility:hidden;"><%=rsObj("p_specen")%></textarea>
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

            <div class="nav_tools"><span class="save"><input type="submit" value="保存" class="but" onclick="addsave()"/></span><span class="back"><a href="<%=request.ServerVariables("HTTP_REFERER")%>">返回</a></span><span class="nav_tools_right"></span></div>
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
Sub saveSlide
	dim actType : actType = getForm("acttype","get")
	dim updateSql,insertSql
	dim m_name:m_name=getForm("m_name","post") : if isNul(m_name) then die "请填写幻灯片标题"
	dim m_nameen:m_nameen=getForm("m_nameen","post")
	dim m_slideurl:m_slideurl=getForm("m_slideurl","post")
	dim m_back:m_back=getForm("m_back","post")
	dim m_type:m_type=1'getForm("m_type","post"):if isNul(m_type) then die "请选择分类" : if cint(m_type)=0 then die "你选择的是顶级目录"
	dim m_key:m_key=getForm("m_key","post")
	dim m_pic:m_pic=getForm("m_pic","post")
	dim m_picen:m_picen=getForm("m_picen","post")
	dim m_ord:m_ord=getForm("m_ord","post")
	dim SlideType:SlideType=getForm("m_type","post")
	dim page:page=getForm("page","get")
	dim m_bcolor:m_bcolor=getForm("m_bcolor","post")
	dim ParentID:ParentID=getForm("ParentID","post")
	dim m_p_spec:m_p_spec=ReplaceSymbols(getForm("m_p_spec","post"))
	dim m_p_specen:m_p_specen=ReplaceSymbols(getForm("m_p_specen","post"))

	'dim parentid:parentid=1'Cint(getForm("parentid","get"))


	dim m_isshow
	if getForm("IsShow","post") = "yes" then
		m_isshow=1
	else
		m_isshow=0
	end if

	select case  actType
		case "edit"
			dim m_id:m_id=clng(getForm("m_id","post"))
			updateSql = "SlideName='"&m_name&"',SlideNameen='"&m_nameen&"',ParentID='"&ParentID&"',SlideType='"&SlideType&"',sSlidePic='"&m_pic&"',bcolor='"&m_bcolor&"',SlidePic='',sSlidePicen='"&m_picen&"',SlidePicen='',SlideUrl='"&m_slideurl&"',p_spec='"&m_p_spec&"',p_specen='"&m_p_specen&"',Ord="&m_ord&",IsShow="&m_isshow&",sortid=1"
			updateSql = "update {pre}Slide set "&updateSql&" where ID="&m_id
			'die updateSql
			conn.db  updateSql,"execute"
			alertMsg "",m_back
		case "add"
			insertSql = "insert into {pre}Slide(SlideName,SlideNameen,ParentID,SlideType,sSlidePic,SlidePic,bcolor,sSlidePicen,SlidePicen,SlideUrl,p_spec,p_specen,Ord,IsShow,sortid) values ('"&m_name&"','"&m_nameen&"','"&ParentID&"','"&SlideType&"','"&m_pic&"','','"&m_bcolor&"','"&m_picen&"','','"&m_slideurl&"','"&m_p_spec&"','"&m_p_specen&"',"&m_ord&","&m_isshow&",1)"
			'die insertsql
			conn.db  insertSql,"execute"
			selectMsg "添加成功,是否继续添加","?action=add","?"
	end select
End Sub

Sub delSlide
	dim id,back,vtypeAndPic,vpic
	back = request.ServerVariables("HTTP_REFERER")
	id = getForm("id","get")
	on error resume next
	vtypeAndPic=conn.db("select sSlidePic from {pre}Slide where ID="&id,"array")
	vpic=vtypeAndPic(0,0)
	if len(vpic)>0 then  delFile "../"&vpic
	conn.db  "delete from {pre}Slide where id="&id,"execute"
	if err  then err.clear : die "幻灯片已经删除,但删除静态文件或幻灯片时发生错误，请手动删除相关文件" else  alertMsg "",back
End Sub

Sub UpdateOrder
	Dim ids			:	ids=split(getForm("m_id","post"),",")
	Dim orders		:	orders=split(getForm("order","post"),",")

	Dim i

	For i=0 To Ubound(ids)
		updateSql = "update {pre}Slide Set ord="&trim(orders(i))&" Where ID="&trim(ids(i))
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
	conn.db  "delete from {pre}Slide where id in("&ids&")","execute"
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
