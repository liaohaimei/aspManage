<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<title>后台管理</title>
<script src="scripts/jquery.min.js"></script>
<script language="javascript" type="text/javascript" src="scripts/WdatePicker.js"></script>
<script src="scripts/jquery.cookie.js"></script>
		<link rel="stylesheet" href="../TextEditor/UltraEdit/themes/default/default.css" />
		<script charset="utf-8" src="../TextEditor/UltraEdit/kindeditor-min.js"></script>
		<script charset="utf-8" src="../TextEditor/UltraEdit/lang/zh_CN.js"></script>
		<script src="../TextEditor/UltraEdit/kindeditor.js"></script>
<script>
  var editor,editor1,editor2;
  KindEditor.ready(function(K) {
 
	  editor = K.create('textarea[class="content"]', {
		  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
          fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
          allowFileManager : true,
		  filterMode : false,
		  newlineTag:"br" 
	  });
 
	  editor1 = K.create('textarea[class="content1"]', {
		  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
          fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
          allowFileManager : true,
		  filterMode : false,
		  newlineTag:"br" 
	  });
 
	  editor2 = K.create('textarea[class="content2"]', {
		  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
          fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
          allowFileManager : true,
		  filterMode : false,
		  newlineTag:"br" 
	  });
  }); 
</script>
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
			});
		</script>
</head>
<body>
<div id="main"> 
  <!--#include file="top.asp"-->
<%if request.QueryString("action")="ClearAll" then
conn.db "delete from {pre}Security","execute" 
set rs=conn.db ("select * from {pre}Security" ,"records1")
if rs.eof and rs.bof then
Response.Write( " <script> alert( '内容清除成功！');location.href='"&request.ServerVariables("HTTP_REFERER")&"';</script> ")
else
Response.Write( " <script> alert( '内容清除失败！');location.href='"&request.ServerVariables("HTTP_REFERER")&"';</script> ")
end if
end if%>
  <div id="content"> 
    <!--#include file="left.asp"-->
    <div id="right_content">
      <div id="main_content">
        <div class="top_nav"><span></span></div>
        <div class="nav_content" style="line-height:18px;">
          <h1>后台首页
            <%
				dim parentid : parentid = getForm("parentid","get")
				dim pid : pid = getForm("pid","get")
				if pid<>"" and pid<> "0" then
					echo " » " & conn.db("select NavName from {pre}Navigation where Id="&pid,"execute")(0)
				end if 
				%>
            <%
				dim bid : bid = getForm("bid","get")
				if bid<>"" and bid<> "0" then
					echo " » " & conn.db("select NavName from {pre}Navigation where Id="&bid,"execute")(0)
				end if 
				%>
            <%
				dim tid : tid = getForm("tid","get")
				if tid<>"" and tid<> "0" then
					echo " » " & conn.db("select NavName from {pre}Navigation where Id="&tid,"execute")(0)
				end if 
				%>
            <%
				dim sid : sid = getForm("sid","get")
				if sid<>"" and sid<> "0" then
					echo " » " & conn.db("select NavName from {pre}Navigation where Id="&sid,"execute")(0)
				end if 
				%>
            <%
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
dim playerArray,NewsArray
dim page,vtype,order
Select  case action
	case "add" : addNews
	case "delall" : delAll
	case "del" : delNews
	case "edit" : editNews
	case "save" : saveNews
	case "uorder" : UpdateOrder
	case else : main
End Select 

Sub main
	dim datalistObj,rsArray
	dim m,i,orderStr,whereStr,sqlStr,rsObj,allPage,allRecordset,numPerPage,searchStr
	numPerPage= 20
	order = getForm("order", "get")
	if isNul(order)  then order = "Id desc"
	orderStr= " order by isNew,ord,"&order&""
	keyword = getForm("keyword", "both")
	page = getForm("page", "get")
	if isNul(page) then page=1 else page=clng(page)
	if page=0 then page=1
	vtype = cid
	whereStr=" where"
	
	childpath  = conn.db("select ChildPath from {pre}Navigation where Id="&vtype&"","execute")(0)
	
	if not isNul(vtype) then  whereStr=whereStr&" and SortID in("& childpath &")"
	
	if not isNul(keyword) then 
		whereStr = whereStr&" and NewsName like '%"&keyword&"%'"
	end if
	sqlStr = replace(replace("select * from {pre}Security "&whereStr&orderStr,"where and","where"),"where order","order")
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
          <form method="post" name="Newslistform">
            <div class="nav_tools"><span class="add"><a href="?action=add&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>">添加</a></span><span class="edit"><a href="javascript:document.Newslistform.action='?action=uorder&page=<%=page%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>';document.Newslistform.submit();">更新排序</a></span><span class="delete"><a href="javascript:document.Newslistform.action='?action=delall&page=<%=page%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>';document.Newslistform.submit();" onClick="return confirm('确定要删除选中数据')">批量删除</a></span><span class="nav_tools_right"></span></div>
            <div class="table">
              <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                  <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;text-indent:10px;border-left:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle">资料列表</td>
                  <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;border-right:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle"><div style="float:right;">关键字&nbsp;
                      <input  name="keyword" type="text" id="keyword" size="20">
                      &nbsp;
                      <input type="submit" onclick="document.Newslistform.action='?parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>';" name="selectBtn"  value="查 询..." class="btn" />
                    </div></td>
                </tr>
                <tr>
                  <td colspan="2" align="right" bgcolor="#e5e5e5" style="border:solid #bbbbbb 1px;"><div class="cuspages">
                      <div class="pages"> 页次：<%=page%>/<%=allPage%> 每页<%=numPerPage %> 总收录数据<%=allRecordset%>条 <a href="?page=1&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">首页</a> <a href="?page=<%=(page-1)%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">上一页</a> <%=makePageNumber(page, 8, allPage, "Newslist","")%> <a href="?page=<%=(page+1)%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">下一页</a> <a href="?page=<%=allPage%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">尾页</a></div>
                    </div></td>
                </tr>
                <tr>
                  <td colspan="2" align="left"><%
if allRecordset=0 then
	%>
                    <table width="100%" cellpadding="0" cellspacing="0">
                      <tr>
                        <td align="center" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><%
			if not isNul(keyword) then 
				echo "关键字  <span  style='color:#FF0000;'>"& keyword &"</span>   没有记录"
			else
				echo "没有任何记录"
			end if
			%></td>
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
                        <td align="center" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"> 关键字 <span  style="color:#FF0000;"> <%=keyword%> </span> 的记录如下 </td>
                      </tr>
                        </tbody>
                      
                    </table>
                    <%
	end if
%>
                    <table width="100%" cellpadding="0" cellspacing="0">
                      <tbody>
                        <tr bgcolor="#e5e5e5">
                          <td width="8%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px; border-left:solid #bbbbbb 1px;"><table width="70" cellpadding="0" cellspacing="0">
                              <tbody>
                                <tr>
                                  <td width="20" align="middle"><input type="checkbox" name="chkall" id="chkall" onclick="checkAll(this.checked,'input','m_id')" /></td>
                                  <td width="48" valign="middle">全选<a href="?order=ID&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&page=<%=page%>"><img src="images/minus.gif" title="按ID排序" /></a></td>
                                </tr>
                              </tbody>
                            </table></td>
                          <!--<td width="10%" align="center" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">资料图片</td>-->
                          <td width="5%" align="center" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">排序</td>
                          <td width="48%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;防伪码</td>
                          <td width="20%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;资料类别</td>
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
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="70" cellpadding="0" cellspacing="0">
                              <tbody>
                                <tr>
                                  <td width="20" align="middle"><input type="checkbox" value="<%=m_id%>" name="m_id" /></td>
                                  <td width="48" valign="middle"><%=m_id%>.</td>
                                </tr>
                              </tbody>
                            </table></td>
                          <!--<td align="center" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
<table width="100" height="100" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td align="center" bgcolor="#ffffff"><a href="?action=edit&id=<%=m_id%>&type=<%=vtype%>&page=<%=page%>"><img src="images/loading2.gif"  border="0" onload="setimg(this,100,100,'../<%=rsObj("sNewsPic")%>')"/></a></td>
</tr>
</table>			</td>-->
                          <td align="center" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><table width="50" cellpadding="0" cellspacing="0">
                              <tbody>
                                <tr>
                                  <td align="center"><input class="o-input" data-id="<%=m_id%>" onchange="orderChange(this,<%=m_id%>)" type="text" name="order" value="<%=rsObj("ord")%>" style="width:40px; text-align:center;"/><span class="status"></span></td>
                                </tr>
                              </tbody>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=rsObj("NewsName")%>&nbsp;
                          <% if rsObj("IsNew")=true then response.Write("&nbsp;<font color='#ff0000'>[推荐]</font>") end if %></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=SortName(rsObj("SortID"))%></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <%isCurrentDay(formatdatetime(rsObj("CreateDate"),2))%></td>
                          <td align="middle" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tbody>
                                <tr>
                                  <td align="center"><a href="?action=edit&id=<%=m_id%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&page=<%=page%>">修改</a></td>
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
%></td>
                </tr>
                <tr>
                  <td colspan="2" align="right" bgcolor="#e5e5e5" style="border:solid #bbbbbb 1px;"><div class="cuspages">
                      <div class="pages"> 页次：<%=page%>/<%=allPage%> 每页<%=numPerPage %> 总收录数据<%=allRecordset%>条 <a href="?page=1&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">首页</a> <a href="?page=<%=(page-1)%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">上一页</a> <%=makePageNumber(page, 8, allPage, "Newslist","")%> <a href="?page=<%=(page+1)%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">下一页</a> <a href="?page=<%=allPage%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>">尾页</a></div>
                    </div></td>
                </tr>
              </table>
            </div>
            <div class="nav_tools leftbottom"><span class="add"><a href="?action=add&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>">添加</a></span><span class="edit"><a href="javascript:document.Newslistform.action='?action=uorder&page=<%=page%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>';document.Newslistform.submit();">更新排序</a></span><span class="delete"><a href="javascript:document.Newslistform.action='?action=delall&page=<%=page%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&keyword=<%=keyword%>';document.Newslistform.submit();" onClick="return confirm('确定要删除选中数据')">批量删除</a></span><span class="nav_tools_right rightbottom"></span><span class="delete"><a href="?action=ClearAll" onClick="return confirm('确定要清空表中所有数据吗')">清空表中所有数据（请谨慎！）</a></span></div>
          </form>
          <%
End Sub


Sub addNews
%>
          <form method="post" action="?action=save&acttype=add&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>"  name="addform" onSubmit="return validateform()">
            <div class="nav_tools"><span class="save"><a href="javascript:addsave();">保存</a></span><span class="back"><a href="<%=request.ServerVariables("HTTP_REFERER")%>">返回</a></span><span class="sc"><a href="importexcel.asp?parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&id=<%=cid%>" >导入</a></span><span class="nav_tools_right"></span></div>
            <div class="table">
              <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                  <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;text-indent:10px;border-right:solid #e5e5e5 1px; border-left:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle">添加资料</td>
                </tr>
                <tr>
                  <td align="left"><table width="100%" cellpadding="0" cellspacing="0" id="RiseList">
                      <tbody>
                        <tr bgcolor="#e5e5e5">
                          <td width="10%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px; border-left:solid #bbbbbb 1px;">&nbsp;</td>
                          <td width="90%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;</td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">防伪码:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_name" name="m_name" size="60" value="" />
                            &nbsp;<font color='red'>＊</font></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">(EN)防伪码:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_nameen" name="m_nameen" size="60" value="" />
                            &nbsp;<font color='red'>＊</font></td>
                        </tr>

                        <tr >
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">项目名称:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_Source" name="m_Source" size="60" value="" />
                            &nbsp;</td>
                        </tr>

                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">(EN)项目名称:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_Sourceen" name="m_Sourceen" size="60" value="" />
                            &nbsp;</td>
                        </tr>

                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">委托单位:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_Publisher" name="m_Publisher" size="60" value="" />
                            &nbsp;</td>
                        </tr>

                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">(EN)委托单位:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_Publisheren" name="m_Publisheren" size="60" value="" /></td>
                        </tr>

                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">high:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_high" name="m_high" size="60" value="" /></td>
                        </tr>


                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">(EN)high:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_highen" name="m_highen" size="60" value="" /></td>
                        </tr>

                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">二字码</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_erzm" name="m_erzm" size="60" value="" /></td>
                        </tr>

                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">(EN)二字码</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_erzmen" name="m_erzmen" size="60" value="" /></td>
                        </tr>

                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">Destination</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_Destination" name="m_Destination" size="60" value="" /></td>
                        </tr>

                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">(EN)Destination</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_Destinationen" name="m_Destinationen" size="60" value="" /></td>
                        </tr>


                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">
                                添加日期:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_createdate" name="m_createdate" size="30" value="<%=Date()%>" class="Wdate" onclick="WdatePicker()" />
                            &nbsp;<font color='red'>＊</font></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">所属资料:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <select name="m_type" id="m_type"  >
                              <option value="">请选择资料分类</option>
                              <%selectTypeEdit 17,Cint(getForm("cid","get")),parentid %>
                            </select>
                            &nbsp;&nbsp;<font color="red">＊</font> &nbsp;&nbsp;
                            <!--<input name="IsNew" type="checkbox" id="IsNew" value="yes">
                            是否推荐-->
                            &nbsp;&nbsp;排序
                            <input size="10" name="m_ord" value="100"/></td>
                        </tr>
                        <tr <%if parentid<>30 then%>style="display:none;"<%end if%>>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">资料图片:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                           <textarea name="m_pic"  type="text" id="m_pic" /></textarea> <input type="button" id="image1" value="选择图片" /></td>
                        </tr>
                        <tr <%if parentid<>30 then%>style="display:none;"<%end if%>>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">资料描述:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            </td>
                        </tr>                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">(EN)描述:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            </td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">资料说明:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
                          <textarea class="content" name="m_sm" id="m_sm" style="width:100%;height:400px;visibility:hidden;"></textarea></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">(EN)说明:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
                          <textarea class="content1" name="m_smen" id="m_smen" style="width:100%;height:400px;visibility:hidden;"></textarea></td>

                        </tr>
                      </tbody>
                    </table></td>
                </tr>
                <tr>
                  <td align="left" bgcolor="#e5e5e5" style="border:solid #bbbbbb 1px;">&nbsp;</td>
                </tr>
              </table>
            </div>
            <div class="nav_tools leftbottom"><span class="save"><a href="javascript:addsave();">保存</a></span><span class="back"><a href="<%=request.ServerVariables("HTTP_REFERER")%>">返回</a></span><span class="nav_tools_right rightbottom"></span></div>
          </form>
          <%	
End Sub

Sub editNews
	dim id,sqlStr,rsObj,m_color,playArray,NewsArray,playTypeCount,NewsTypeCount,i,j,m,n
	
	dim parentid : parentid = getForm("parentid","get")
	dim pid:pid=getForm("pid","get")
	dim bid:bid=getForm("bid","get")
	dim tid:tid=getForm("tid","get")
	dim sid:sid=getForm("sid","get")
	dim cid:cid=getForm("cid","get")
	
	id=clng(getForm("id","get"))
	sqlStr = "select *  from {pre}Security where ID="&id
	set rsObj = conn.db(sqlStr,"records1")
	if rsObj.eof then die "没找到记录"
	vtype = rsObj("SortID")
%>
          <form method="post" action="?action=save&acttype=edit&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>"  name="addform" onSubmit="return validateform()">
            <div class="nav_tools"><span class="save"><a href="javascript:addsave();">保存</a></span><span class="back"><a href="<%=request.ServerVariables("HTTP_REFERER")%>">返回</a></span><span class="nav_tools_right"></span></div>
            <div class="table">
              <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                  <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;text-indent:10px;border-right:solid #e5e5e5 1px; border-left:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle">编辑资料</td>
                </tr>
                <tr>
                  <td align="left"><table width="100%" cellpadding="0" cellspacing="0" id="RiseList">
                      <tbody>
                        <tr bgcolor="#e5e5e5">
                          <td width="10%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px; border-left:solid #bbbbbb 1px;">&nbsp;</td>
                          <td width="90%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;</td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">防伪码:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_name" name="m_name" size="60"  value="<%=rsObj("NewsName")%>" />
                            &nbsp;<font color='red'>＊</font></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">(EN)防伪码:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_nameen" name="m_nameen" size="60"  value="<%=rsObj("NewsNameen")%>" />
                            &nbsp;<font color='red'>＊</font></td>
                        </tr>
                        <tr>


                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">项目名称:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_Source" name="m_Source" size="60" value="<%=rsObj("Source")%>" />
                            &nbsp;</td>
                        </tr>

                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">(EN)项目名称:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_Sourceen" name="m_Sourceen" size="60" value="<%=rsObj("Sourceen")%>" />
                            &nbsp;</td>
                        </tr>

                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">委托单位:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_Publisher" name="m_Publisher" size="60" value="<%=rsObj("Publisher")%>" />
                            &nbsp;</td>
                        </tr>

                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">(EN)委托单位:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_Publisheren" name="m_Publisheren" size="60" value="<%=rsObj("Publisheren")%>" /></td>
                        </tr>

                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">high:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_high" name="m_high" size="60" value="<%=rsObj("high")%>" /></td>
                        </tr>


                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">(EN)high:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_highen" name="m_highen" size="60" value="<%=rsObj("highen")%>" /></td>
                        </tr>

                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">二字码</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_erzm" name="m_erzm" size="60" value="<%=rsObj("erzm")%>" /></td>
                        </tr>

                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">(EN)二字码</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_erzmen" name="m_erzmen" size="60" value="<%=rsObj("erzmen")%>" /></td>
                        </tr>

                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">Destination</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_Destination" name="m_Destination" size="60" value="<%=rsObj("Destination")%>" /></td>
                        </tr>

                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">(EN)Destination</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_Destinationen" name="m_Destinationen" size="60" value="<%=rsObj("Destinationen")%>" /></td>
                        </tr>



                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">添加日期:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_createdate" name="m_createdate" size="30" value="<%=rsObj("CreateDate")%>" class="Wdate" onClick="WdatePicker()"/>
                            &nbsp;<font color='red'>＊</font></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">所属资料:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <select name="m_type" id="m_type"  >
                              <option value="">请选择资料分类</option>
                              <%selectTypeEdit 17,Cint(vtype),parentid%>
                            </select>
                            &nbsp;&nbsp;<font color="red">＊</font> &nbsp;&nbsp;
                            <!--<input name="IsNew" type="checkbox" id="IsNew" value="yes" <% if rsObj("IsNew")=true then response.Write("checked") end if%>>
                            是否推荐-->
                            &nbsp;&nbsp;排序
                            <input size="10" name="m_ord" value="<%=rsObj("Ord")%>"/></td>
                        </tr>
                        <tr  <%if parentid<>30 then%>style="display:none;"<%end if%>>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">资料图片:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                           <textarea name="m_pic"  type="text" id="m_pic" /><%=rsObj("sNewsPic")%></textarea> <input type="button" id="image1" value="选择图片" /></td>
                        </tr>
                        <tr  <%if parentid<>30 then%>style="display:none;"<%end if%>>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">资料描述:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            </td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">(EN)描述:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            </td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">资料说明:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
                            <textarea class="content" name="m_sm" id="m_sm" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("Introduce")%></textarea>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">(EN)说明:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
                            <textarea class="content1" name="m_smen" id="m_smen" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("Introduceen")%></textarea>

                        </tr>
                      </tbody>
                    </table></td>
                </tr>
                <tr>
                  <td align="left" bgcolor="#e5e5e5" style="border:solid #bbbbbb 1px;">&nbsp;
                    <input type="hidden" name="m_id" value="<%=id%>">
                    <input type="hidden" name="m_back" value="<%=request.ServerVariables("HTTP_REFERER")%>" /></td>
                </tr>
              </table>
            </div>
            <div class="nav_tools leftbottom"><span class="save"><a href="javascript:addsave();">保存</a></span><span class="back"><a href="<%=request.ServerVariables("HTTP_REFERER")%>">返回</a></span><span class="nav_tools_right rightbottom"></span></div>
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
Sub saveNews
	dim actType : actType = getForm("acttype","get")
	dim updateSql,insertSql
	dim m_name:m_name=getForm("m_name","post") : if isNul(m_name) then die "请填写资料标题"
	dim m_nameen:m_nameen=getForm("m_nameen","post")
	dim m_Source:m_Source=getForm("m_Source","post")
	dim m_Sourceen:m_Sourceen=getForm("m_Sourceen","post")
	dim m_Publisher:m_Publisher=getForm("m_Publisher","post")
	dim m_Publisheren:m_Publisheren=getForm("m_Publisheren","post")
	dim m_high:m_high=getForm("m_high","post")
	dim m_highen:m_highen=getForm("m_highen","post")
	dim m_erzm:m_erzm=getForm("m_erzm","post")
	dim m_erzmen:m_erzmen=getForm("m_erzmen","post")
	dim m_Destination:m_Destination=getForm("m_Destination","post")
	dim m_Destinationen:m_Destinationen=getForm("m_Destinationen","post")
	dim m_back:m_back=getForm("m_back","post")
	dim m_type:m_type=getForm("m_type","post"):if isNul(m_type) then die "请选择分类" : if cint(m_type)=0 then die "你选择的是顶级目录" 
	dim m_key:m_key=getForm("m_key","post")
	dim m_pic:m_pic=getForm("m_pic","post")
	dim m_ord:m_ord=getForm("m_ord","post")
	dim m_createdate:m_createdate=getForm("m_createdate","post")
	dim vtype:vtype=getForm("type","get")
	dim page:page=getForm("page","get")
	
	dim parentid:parentid=Cint(getForm("parentid","get"))
	
	dim pid:pid=getForm("pid","get")
	dim bid:bid=getForm("bid","get")
	dim tid:tid=getForm("tid","get")
	dim sid:sid=getForm("sid","get")
	dim cid:cid=getForm("cid","get")
	
	dim m_bid,oldm_bid,oldm_tid,m_sid,m_tid
		
	m_sid  = conn.db("select ParentID from {pre}Navigation where Id="&m_type&"","execute")(0)
	if m_sid = parentid then
		m_bid = m_type
		m_tid = m_type
		m_sid = m_type
	else
		m_tid = conn.db("select ParentID from {pre}Navigation where Id="&parentid&"","execute")(0)
		oldm_tid = m_tid
		if m_tid = parentid then
			m_bid = m_sid
			m_tid = m_type
			m_sid = m_type
		else
			m_bid = conn.db("select ParentID from {pre}Navigation where Id="&parentid&"","execute")(0)
			oldm_bid = m_bid
			
			if m_bid = parentid  then
				m_bid = m_tid
				m_tid = m_sid
				m_sid = m_type
			else
				m_bid = parentid
				m_tid = parentid
				m_sid = parentid
			end if
		end if
	end if
	
	dim m_isnew
	if getForm("IsNew","post") = "yes" then
		m_isnew=1
	else
		m_isnew=0
	end if
	dim m_sm:m_sm=Replace(getForm("m_sm","post"),"'","''")
	dim m_smen:m_smen=Replace(getForm("m_smen","post"),"'","''")
	
	dim m_description:m_description=Replace(getForm("m_description","post"),"'","''")
	dim m_descriptionen:m_descriptionen=Replace(getForm("m_descriptionen","post"),"'","''")
	
	select case  actType
		case "edit"
			dim m_id:m_id=clng(getForm("m_id","post"))
			updateSql = "NewsName='"&m_name&"',NewsNameen='"&m_nameen&"',Source='"&m_Source&"',Sourceen='"&m_Sourceen&"',Publisher='"&m_Publisher&"',Publisheren='"&m_Publisheren&"',high='"&m_high&"',highen='"&m_highen&"',erzm='"&m_erzm&"',erzmen='"&m_erzmen&"',Destination='"&m_Destination&"',Destinationen='"&m_Destinationen&"',NewsKey='"&m_key&"',sNewsPic='"&m_pic&"',NewsPic='"&m_pic&"',[Introduce]='"&m_sm&"',[Introduceen]='"&m_smen&"',[Description]='"&m_description&"',[Descriptionen]='"&m_descriptionen&"',Bid="&m_bid&",Tid="&m_tid&",Sid="&m_sid&",SortID="&m_type&",Ord="&m_ord&",IsNew="&m_isnew&",CreateDate='"&m_createdate&"'"
			updateSql = "update {pre}Security set "&updateSql&" where ID="&m_id
			conn.db  updateSql,"execute"
			alertMsg "",m_back
		case "add" 
			insertSql = "insert into {pre}Security(NewsName,NewsNameen,Source,Sourceen,Publisher,Publisheren,high,highen,erzm,erzmen,Destination,Destinationen,NewsKey,sNewsPic,NewsPic,[Introduce],[Introduceen],[Description],[Descriptionen],Bid,Tid,Sid,SortID,Ord,IsNew,[CreateDate]) values ('"&m_name&"','"&m_nameen&"','"&m_Source&"','"&m_Sourceen&"','"&m_Publisher&"','"&m_Publisheren&"','"&m_high&"','"&m_highen&"','"&m_erzm&"','"&m_erzmen&"','"&m_Destination&"','"&m_Destinationen&"','"&m_key&"','"&m_pic&"','"&m_pic&"','"&m_sm&"','"&m_smen&"','"&m_description&"','"&m_descriptionen&"',"&m_bid&","&m_tid&","&m_sid&","&m_type&","&m_ord&","&m_isnew&",'"&m_createdate&"')"
			conn.db  insertSql,"execute" 
			selectMsg "添加成功,是否继续添加","?action=add&parentid="&parentid&"&pid="&pid&"&bid="&bid&"&tid="&tid&"&sid="&sid&"&cid="&cid&"&uid="&uid,"?parentid="&parentid&"&pid="&pid&"&bid="&bid&"&tid="&tid&"&sid="&sid&"&cid="&cid
	end select
End Sub

Sub delNews
	dim id,back,vtypeAndPic,vpic
	back = request.ServerVariables("HTTP_REFERER")
	id = getForm("id","get")
	on error resume next
	vtypeAndPic=conn.db("select sNewsPic from {pre}Security where ID="&id,"array")
	vpic=vtypeAndPic(0,0)
	if len(vpic)>0 then  delFile "../"&vpic
	conn.db  "delete from {pre}Security where id="&id,"execute"
	if err  then err.clear : die "图片已经删除,但删除静态文件或图片时发生错误，请手动删除相关文件" else  alertMsg "",back
End Sub

Sub UpdateOrder
	Dim ids			:	ids=split(getForm("m_id","post"),",")
	Dim orders		:	orders=split(getForm("order","post"),",")
	
	Dim i
	
	For i=0 To Ubound(ids)	
		updateSql = "update {pre}Security Set ord="&trim(orders(i))&" Where ID="&trim(ids(i))	
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
	conn.db  "delete from {pre}Security where id in("&ids&")","execute" 
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

