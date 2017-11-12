<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<title>后台管理</title>
<script src="scripts/jquery.min.js"></script>
<script language="javascript" type="text/javascript" src="scripts/WdatePicker.js"></script>
<script src="scripts/jquery.cookie.js"></script>
<script src="scripts/ord.js" type="text/javascript"></script>
<script src="scripts/jTabs.js"></script>
<script>
$(document).ready(function(){
    $("ul.tabs").jTabs({content: ".tabs_content", animate: true});                       
});
</script>
<link rel="stylesheet" href="../TextEditor/UltraEdit/themes/default/default.css" />
<script charset="utf-8" src="../TextEditor/UltraEdit/kindeditor-min.js"></script>
<script charset="utf-8" src="../TextEditor/UltraEdit/lang/zh_CN.js"></script>
<script src="../TextEditor/UltraEdit/kindeditor.js"></script>
<script>
  var editor1,editor;
  KindEditor.ready(function(K) {
 
	  editor1 = K.create('textarea[class="content1"]', {
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
				K.create('#content3', {
					pasteType : 2
				});
				K.create('#content4', {
					pasteType : 2
				});
			});
		</script>
<script src="../TextEditor/UltraEdit/jquery-ui.js"></script>
<script>
  $(function() {
    $( "#J_imageView" ).sortable();
    $( "#J_imageView" ).disableSelection();
    $( "#J_imageViewen" ).sortable();
    $( "#J_imageViewen" ).disableSelection();
    $( "#J_colorimageView" ).sortable();
    $( "#J_colorimageView" ).disableSelection();
    $( "#J_colorimageViewen" ).sortable();
    $( "#J_colorimageViewen" ).disableSelection();
    $( "#J_enantiomersView" ).sortable();
    $( "#J_enantiomersView" ).disableSelection();
  });
  </script>
<style>
#J_imageView div, #J_imageViewen div, #J_colorimageView div, #J_colorimageViewen div, #J_enantiomersView div { float:left; }
</style>
</head>
<body>
<div id="main"> 
  <!--#include file="top.asp"-->
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
				dim uid : uid = getForm("uid","get")
				if uid<>"" and uid<> "0" then
					echo " » " & conn.db("select NavName from {pre}Navigation where Id="&uid,"execute")(0)
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
dim playerArray,ProductArray
dim page,vtype,order
Select  case action
	case "add" : addProduct
	case "delall" : delAll
	case "del" : delProduct
	case "edit" : editProduct
	case "editadd" : editaddProduct
	case "save" : saveProduct
	case "uorder" : UpdateOrder
	case else : main
End Select 

Sub main
	dim datalistObj,rsArray
	dim m,i,orderStr,whereStr,sqlStr,rsObj,allPage,allRecordset,numPerPage,searchStr
	numPerPage= 20
	order = getForm("order", "get")
	if isNul(order)  then order = "Id desc"
	orderStr= " order by isNew,ord ,"&order&""
	keyword = getForm("keyword", "both")
	page = getForm("page", "get")
	if isNul(page) then page=1 else page=clng(page)
	if page=0 then page=1
	vtype = cid
	whereStr=" where"
	childpath  = conn.db("select ChildPath from {pre}Navigation where Id="&vtype&"","execute")(0)
	if not isNul(vtype) then  whereStr=whereStr&" and SortID in("& childpath &")"
	
	if not isNul(keyword) then 
		whereStr = whereStr&" and p_name like '%"&keyword&"%'"
	end if
	sqlStr = replace(replace("select ID,p_name,Hits,p_ID,SortID,CreateDate,ord,isnew,ishot,isShow,IsShowen,IsShowjp,CreateDate,p_img from {pre}Product "&whereStr&orderStr,"where and","where"),"where order","order")
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
          <form method="post" name="Productlistform">
            <div class="nav_tools"><span class="add"><a href="?action=add&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>">添加</a></span><span class="edit"><a href="javascript:document.Productlistform.action='?action=uorder&page=<%=page%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>&keyword=<%=keyword%>';document.Productlistform.submit();">更新排序</a></span><span class="delete"><a href="javascript:document.Productlistform.action='?action=delall&page=<%=page%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>&keyword=<%=keyword%>';document.Productlistform.submit();" onClick="return confirm('确定要删除选中数据')">批量删除</a></span><span class="nav_tools_right"></span></div>
            <div class="table">
              <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                  <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;text-indent:10px;border-left:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle">资料列表</td>
                  <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;border-right:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle"><div style="float:right;">关键字&nbsp;
                      <input  name="keyword" type="text" id="keyword" size="20">
                      &nbsp;
                      <input type="submit" onclick="document.Productlistform.action='?parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>';" name="selectBtn"  value="查 询..." class="btn" />
                    </div></td>
                </tr>
                <tr>
                  <td colspan="2" align="right" bgcolor="#e5e5e5" style="border:solid #bbbbbb 1px;"><div class="cuspages">
                      <div class="pages"> 页次：<%=page%>/<%=allPage%> 每页<%=numPerPage %> 总收录数据<%=allRecordset%>条 <a href="?page=1&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>&keyword=<%=keyword%>">首页</a> <a href="?page=<%=(page-1)%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>&keyword=<%=keyword%>">上一页</a> <%=makePageNumber(page, 8, allPage, "Productlist","")%> <a href="?page=<%=(page+1)%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>&keyword=<%=keyword%>">下一页</a> <a href="?page=<%=allPage%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>&keyword=<%=keyword%>">尾页</a></div>
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
                                  <td width="48">全选<a href="?order=ID&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>&page=<%=page%>"><img src="images/minus.gif" title="按ID排序" /></a></td>
                                </tr>
                              </tbody>
                            </table></td>
                          <td width="10%" align="center" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px; display:none;">资料图片</td>
                          <td width="5%" align="center" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">排序</td>
                          <td width="38%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;名称</td>
                          <td width="20%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;资料类别</td>
                          <td width="10%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td>添加时间<a href="?order=CreateDate&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>&page=<%=page%>"><img src="images/minus.gif" title="按时间排序" /></a></td>
                              </tr>
                            </table></td>
                          <td width="9%" align="center" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">操作</td>
                        </tr>
                        <%
			for i = 0 to numPerPage - 1	
				dim m_id : m_id = rsObj(0)
				if rsObj("p_img")<>"" then
				img = split(rsObj("p_img"),",")
				end if
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
                          <td align="center" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; display:none;"><table width="100" height="100" border="0" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="center" bgcolor="#ffffff"><a href="?action=edit&id=<%=m_id%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>&page=<%=page%>"><img src="images/loading2.gif"  border="0" onload="setimg(this,100,100,'<%if rsObj("p_img")<>"" then%><%=img(Lbound(img))%><%else%>images/nopic.jpg<%end if%>')"/></a></td>
                              </tr>
                            </table></td>
                          <td align="center" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><table width="50" cellpadding="0" cellspacing="0">
                              <tbody>
                                <tr>
                                  <td align="center"><input class="o-input" data-id="<%=m_id%>" onchange="orderChange(this,<%=m_id%>)" type="text" name="order" value="<%=rsObj("ord")%>" style="width:40px; text-align:center;"/><span class="status"></span></td>
                                </tr>
                              </tbody>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=rsObj("p_name")%> &nbsp;
                            <% if rsObj("IsNew")=true then response.Write("&nbsp;<font color='#ff0000'>[推荐]</font>") end if %>
                            &nbsp;
                            <% if rsObj("IsHot")=true then response.Write("&nbsp;<font color='#0000ff'>[最新]</font>") end if %>
                            &nbsp;
                            <% if rsObj("IsShow")=true then response.Write("&nbsp;<font color='green'>[(CN)发布]</font>") end if %>
                            &nbsp;
                            <% if rsObj("IsShowen")=true then response.Write("&nbsp;<font color='blue'>[(EN)发布]</font>") end if %>
                            &nbsp;
                            <%' if rsObj("IsShowjp")=true then response.Write("&nbsp;<font color='green'>[(JP)发布]</font>") end if %></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;<%=SortName(rsObj("SortID"))%></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <%isCurrentDay(formatdatetime(rsObj("CreateDate"),2))%></td>
                          <td align="middle" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tbody>
                                <tr>
                                  <td align="center" colspan="3"><a href="?action=editadd&id=<%=m_id%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>&page=<%=page%>">添加相似资料</a></td>
                                </tr>
                                <tr>
                                  <td align="center"><a href="?action=edit&id=<%=m_id%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>&page=<%=page%>">修改</a></td>
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
                      <div class="pages"> 页次：<%=page%>/<%=allPage%> 每页<%=numPerPage %> 总收录数据<%=allRecordset%>条 <a href="?page=1&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>&keyword=<%=keyword%>">首页</a> <a href="?page=<%=(page-1)%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>&keyword=<%=keyword%>">上一页</a> <%=makePageNumber(page, 8, allPage, "Productlist","")%> <a href="?page=<%=(page+1)%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>&keyword=<%=keyword%>">下一页</a> <a href="?page=<%=allPage%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>&keyword=<%=keyword%>">尾页</a></div>
                    </div></td>
                </tr>
              </table>
            </div>
            <div class="nav_tools leftbottom"><span class="add"><a href="?action=add&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>">添加</a></span><span class="edit"><a href="javascript:document.Productlistform.action='?action=uorder&page=<%=page%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>&keyword=<%=keyword%>';document.Productlistform.submit();">更新排序</a></span><span class="delete"><a href="javascript:document.Productlistform.action='?action=delall&page=<%=page%>&order=<%=order%>&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>&keyword=<%=keyword%>';document.Productlistform.submit();" onClick="return confirm('确定要删除选中数据')">批量删除</a></span><span class="nav_tools_right rightbottom"></span></div>
          </form>
          <%
End Sub


Sub addProduct
%>
          <form method="post" action="?action=save&acttype=add&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>"  name="addform" onSubmit="return validateform()">
            <div class="nav_tools"><span class="save">
              <input type="submit" value="保存" class="but" onclick="addsave()"/>
              </span><span class="back"><a href="<%=request.ServerVariables("HTTP_REFERER")%>">返回</a></span><span class="nav_tools_right"></span></div>
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
                          <td width="90%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;"></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">名称(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_name" name="m_name" size="60"  value="" />
                            &nbsp;<font color='red'>＊</font></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">名称(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_nameen" name="m_nameen" size="60"  value="" />
                            &nbsp;<font color='red'>＊</font></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">名称(JP):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_namejp" name="m_namejp" size="60"  value="" />
                            &nbsp;<font color='red'>＊</font></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">所属类别:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <select name="m_type" id="m_type"  >
                              <option value="">请选择资料分类</option>
                              <%selectTypeEdit 14,Cint(getForm("cid","get")),parentid%>
                            </select>
                            &nbsp;&nbsp;<font color="red">＊</font> &nbsp;&nbsp; 
                            <!--<input name="IsNew" type="checkbox" id="IsNew" value="yes">
                            是否推荐--> 
                            <!--&nbsp;&nbsp;
                            <input name="IsHot" type="checkbox" id="IsHot" value="yes">
                            是否新推--> 
                            
                            &nbsp;&nbsp;
                            <input name="IsShow" type="checkbox" id="IsShow" value="yes" checked="checked">
                            (CN)发布
                            &nbsp;&nbsp;
                            <input name="IsShowen" type="checkbox" id="IsShowen" value="yes" checked="checked">
                            (EN)发布 
                            <!--&nbsp;&nbsp;
                            <input name="IsShowjp" type="checkbox" id="IsShowjp" value="yes" checked="checked">
                            (JP)发布--> 
                            
                            &nbsp;&nbsp;排序
                            <input size="10" name="m_ord" value="100"/></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right"> 添加日期:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_createdate" name="m_createdate" size="30" value="<%=Date()%>" class="Wdate" onclick="WdatePicker()" />
                            &nbsp;<font color='red'>＊</font></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">相关资料名称相关文章标签:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <textarea name="m_pid" cols="100%" id="m_pid"></textarea>
                            注意：名称之间用逗号（,）分开</td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">链接地址(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input name="m_p_links" id="m_p_links" value="javascript:;" size="36" />
                            如：http://www.baidu.com</td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">链接地址(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input name="m_p_linksen" id="m_p_linksen" value="javascript:;" size="36" />
                            如：http://www.baidu.com</td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">型号(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_model" name="m_p_model" size="36" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">型号(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_modelen" name="m_p_modelen" size="36" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">类型(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_type" name="m_p_type" size="36" />
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">类型(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_typeen" name="m_p_typeen" size="36" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">材料(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!--<input id="m_p_material" name="m_p_material" size="36" />-->
                            
                            <select name="m_p_material" id="m_p_material">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 10,0
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">材料(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!--<input id="m_p_materialen" name="m_p_materialen" size="36" />-->
                            
                            <select name="m_p_materialen" id="m_p_materialen">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 10,0
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">尺寸(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!--<input id="m_p_size" name="m_p_size" size="36" />-->
                            
                            <select name="m_p_size" id="m_p_size">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 11,0
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">尺寸(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!--<input id="m_p_sizeen" name="m_p_sizeen" size="36" />-->
                            
                            <select name="m_p_sizeen" id="m_p_sizeen">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 11,0
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">特征(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_features" name="m_p_features" size="36" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">特征(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_featuresen" name="m_p_featuresen" size="36" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">项目编号(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_number" name="m_p_number" size="36" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">项目编号(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_numberen" name="m_p_numberen" size="36" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">价格(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_price" name="m_p_price" size="36" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">价格(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input name="m_p_priceen" id="m_p_priceen" size="36"/></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">价格范围(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!--<input id="m_p_priceRange" name="m_p_priceRange" size="36" />-->
                            
                            <select name="m_p_priceRange" id="m_p_priceRange">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 12,0
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">价格范围(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!--<input id="m_p_priceRangeen" name="m_p_priceRangeen" size="36" />-->
                            
                            <select name="m_p_priceRangeen" id="m_p_priceRangeen">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 12,0
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">collection(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!--<input id="m_p_collection" name="m_p_collection" size="36" />-->
                            
                            <select name="m_p_collection" id="m_p_collection">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 13,0
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">collection(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!--<input id="m_p_collectionen" name="m_p_collectionen" size="36" />-->
                            
                            <select name="m_p_collectionen" id="m_p_collectionen">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 13,0
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">颜色(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_class" name="m_p_class" size="36" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">颜色(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_classen" name="m_p_classen" size="36" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">资料简述(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea id="content3" name="m_p_spec" style="width:100%;height:200px;visibility:hidden;"></textarea></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">资料简述(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea id="content4" name="m_p_specen" style="width:100%;height:200px;visibility:hidden;"></textarea></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">首页推荐小图:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><script>
	KindEditor.ready(function(K) {
		var editor = K.editor({
		  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
		  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
			allowFileManager : true
		});
		K('#image1').click(function() {
			editor.loadPlugin('image', function() {
				editor.plugin.imageDialog({
					imageUrl : K('#m_p_smallimg').val(),
					clickFn : function(url, title, width, height, border, align) {
						K('#m_p_smallimg').val(url);
						editor.hideDialog();
					}
				});
			});
		});
	});
</script> 
                            &nbsp;
                            <textarea name="m_p_smallimg"  type="text" id="m_p_smallimg"  /></textarea>
                            <input type="button" id="image1" value="选择图片" />
                            尺寸:171*83</td>
                        </tr>
                        <tr style="display:none;">
                          <td class="tbtr tbl" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">颜色图片列表(CN):</td>
                              </tr>
                            </table></td>
                          <td class="tbtr" style="padding:0px 8px 8px 8px;border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><fieldset class="images_box" style="padding:5px 5px 0px 5px;">
                              <legend>图片列表</legend>
                              <div id="J_colorimageView"> </div>
                            </fieldset>
                            <input type="button" id="J_selectcolorImage" value="批量上传" />
                            <script>
			KindEditor.ready(function(K) {
				var editor = K.editor({
				  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
				  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					allowFileManager : true
				});
				K('#J_selectcolorImage').click(function() {
					editor.loadPlugin('multiimage', function() {
						editor.plugin.multiImageDialog({
							clickFn : function(urlList) {
								var div = K('#J_colorimageView');
								K.each(urlList, function(i, data) {
			                            div.append('<div style="position:relative;border:#666666 1px solid;float:left;;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '" height="60" border="0"><input type="hidden"  name="m_p_colorimg"  value="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '"/></div>');
										
								});
								editor.hideDialog();
							}
						});
					});
				});
			});
		</script>
                            <input type="button" id="colorimagesv" value="网络图片+本地图片" />
                            <script>
			KindEditor.ready(function(K) {
				var editor = K.editor({
				  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
				  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					allowFileManager : true
				});
				K('#colorimagesv').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							imageUrl : K('#m_p_colorimg').val(),
							clickFn : function(url, title, width, height, border, align) {
		                      var div = K('#J_colorimageView');
		                     div.append('<div style="position:relative;border:#666666 1px solid;float:left;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + url + '" height="60" border="0"><input type="hidden"  name="m_p_colorimg"  value="' + url + '"/></div>');
								editor.hideDialog();

							}
						});
					});
				});
			});
		</script></td>
                        </tr>
                        <tr style="display:none;">
                          <td class="tbtr tbl" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">颜色图片列表(EN):</td>
                              </tr>
                            </table></td>
                          <td class="tbtr" style="padding:0px 8px 8px 8px;border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><fieldset class="images_box" style="padding:5px 5px 0px 5px;">
                              <legend>图片列表</legend>
                              <div id="J_colorimageViewen"> </div>
                            </fieldset>
                            <input type="button" id="J_selectcolorImageen" value="批量上传" />
                            <script>
			KindEditor.ready(function(K) {
				var editor = K.editor({
				  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
				  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					allowFileManager : true
				});
				K('#J_selectcolorImageen').click(function() {
					editor.loadPlugin('multiimage', function() {
						editor.plugin.multiImageDialog({
							clickFn : function(urlList) {
								var div = K('#J_colorimageViewen');
								K.each(urlList, function(i, data) {
			                            div.append('<div style="position:relative;border:#666666 1px solid;float:left;;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '" height="60" border="0"><input type="hidden"  name="m_p_colorimgen"  value="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '"/></div>');
										
								});
								editor.hideDialog();
							}
						});
					});
				});
			});
		</script>
                            <input type="button" id="colorimagesven" value="网络图片+本地图片" />
                            <script>
			KindEditor.ready(function(K) {
				var editor = K.editor({
				  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
				  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					allowFileManager : true
				});
				K('#colorimagesven').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							imageUrl : K('#m_p_colorimgen').val(),
							clickFn : function(url, title, width, height, border, align) {
		                      var div = K('#J_colorimageViewen');
		                     div.append('<div style="position:relative;border:#666666 1px solid;float:left;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + url + '" height="60" border="0"><input type="hidden"  name="m_p_colorimgen"  value="' + url + '"/></div>');
								editor.hideDialog();

							}
						});
					});
				});
			});
		</script></td>
                        </tr>
                        <tr style="display:none;">
                          <td class="tbtr tbl" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">图片列表(CN):</td>
                              </tr>
                            </table></td>
                          <td class="tbtr" style="padding:0px 8px 8px 8px;border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><fieldset class="images_box" style="padding:5px 5px 0px 5px;">
                              <legend>图片列表</legend>
                              <div id="J_imageView"> </div>
                            </fieldset>
                            <input type="button" id="J_selectImage" value="批量上传" />
                            <script>
                                KindEditor.ready(function(K) {
                                    var editor = K.editor({
                                      uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
                                      fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
                                        allowFileManager : true
                                    });
                                    K('#J_selectImage').click(function() {
                                        editor.loadPlugin('multiimage', function() {
                                            editor.plugin.multiImageDialog({
                                                clickFn : function(urlList) {
                                                    var div = K('#J_imageView');
                                                    K.each(urlList, function(i, data) {
                                                            div.append('<div style="position:relative;border:#666666 1px solid;float:left;;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '" height="60" border="0"><input type="hidden"  name="m_p_img"  value="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '"/></div>');
                                                            
                                                    });
                                                    editor.hideDialog();
                                                }
                                            });
                                        });
                                    });
                                });
                            </script>
                            <input type="button" id="imagesv" value="网络图片+本地图片" />
                            <!--<input name="issy" type="checkbox" id="issy" value="yes" checked="checked" />是否添加水印--> 
                            <script>
                                KindEditor.ready(function(K) {
                                    var editor = K.editor({
                                      uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
                                      fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
                                        allowFileManager : true
                                    });
                                    K('#imagesv').click(function() {
                                        editor.loadPlugin('image', function() {
                                            editor.plugin.imageDialog({
                                                imageUrl : K('#m_p_img').val(),
                                                clickFn : function(url, title, width, height, border, align) {
                                                  var div = K('#J_imageView');
                                                 div.append('<div style="position:relative;border:#666666 1px solid;float:left;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + url + '" height="60" border="0"><input type="hidden"  name="m_p_img"  value="' + url + '"/></div>');
                                                    editor.hideDialog();
                    
                                                }
                                            });
                                        });
                                    });
                                });
                            </script> 
                            生成缩略图
                            （
                            <input name="small_img" type="radio" id="radio5" value="1" />
                            <label for="small_img">是
                              <input name="small_img" type="radio" id="radio6" value="0" checked="checked" />
                            </label>
                            否(删除缩略图)）&nbsp;&nbsp;&nbsp;&nbsp;最大宽高
                            <input name="m_p_max_wh" type="text" id="m_p_max_wh" value="250" size="10" maxlength="4" />
                            px（请输入数字）
                            建设尺寸220*80px</td>
                        </tr>
                        <tr style="display:none;">
                          <td class="tbtr tbl" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">图片列表(EN):</td>
                              </tr>
                            </table></td>
                          <td class="tbtr" style="padding:0px 8px 8px 8px;border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><fieldset class="images_box" style="padding:5px 5px 0px 5px;">
                              <legend>图片列表</legend>
                              <div id="J_imageViewen"> </div>
                            </fieldset>
                            <input type="button" id="J_selectImageen" value="批量上传" />
                            <script>
                                KindEditor.ready(function(K) {
                                    var editor = K.editor({
                                      uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
                                      fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
                                        allowFileManager : true
                                    });
                                    K('#J_selectImageen').click(function() {
                                        editor.loadPlugin('multiimage', function() {
                                            editor.plugin.multiImageDialog({
                                                clickFn : function(urlList) {
                                                    var div = K('#J_imageViewen');
                                                    K.each(urlList, function(i, data) {
                                                            div.append('<div style="position:relative;border:#666666 1px solid;float:left;;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '" height="60" border="0"><input type="hidden"  name="m_p_imgen"  value="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '"/></div>');
                                                            
                                                    });
                                                    editor.hideDialog();
                                                }
                                            });
                                        });
                                    });
                                });
                            </script>
                            <input type="button" id="imagesven" value="网络图片+本地图片" />
                            <script>
                                KindEditor.ready(function(K) {
                                    var editor = K.editor({
                                      uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
                                      fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
                                        allowFileManager : true
                                    });
                                    K('#imagesven').click(function() {
                                        editor.loadPlugin('image', function() {
                                            editor.plugin.imageDialog({
                                                imageUrl : K('#m_p_imgen').val(),
                                                clickFn : function(url, title, width, height, border, align) {
                                                  var div = K('#J_imageViewen');
                                                 div.append('<div style="position:relative;border:#666666 1px solid;float:left;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + url + '" height="60" border="0"><input type="hidden"  name="m_p_imgen"  value="' + url + '"/></div>');
                                                    editor.hideDialog();
                    
                                                }
                                            });
                                        });
                                    });
                                });
                            </script></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">PDF文件:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <script>
				//文件上传
				KindEditor.ready(function(K) {
					var editor = K.editor({
					  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
					  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					  allowFileManager : true
					});
					K('#insertfile').click(function() {
						editor.loadPlugin('insertfile', function() {
							editor.plugin.fileDialog({
								fileUrl : K('#m_p_filepath').val(),
								clickFn : function(url, title) {
									K('#m_p_filepath').val(url);
									editor.hideDialog();
								}
							});
						});
					});

				});
		</script>
                            <input type="text" name="m_p_filepath" id="m_p_filepath" value="" />
                            <input type="button" id="insertfile" value="选择文件" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">(EN)PDF:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <script>
				//文件上传
				KindEditor.ready(function(K) {
					var editor = K.editor({
					  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
					  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					  allowFileManager : true
					});
					K('#insertfile2').click(function() {
						editor.loadPlugin('insertfile', function() {
							editor.plugin.fileDialog({
								fileUrl : K('#m_p_filepathen').val(),
								clickFn : function(url, title) {
									K('#m_p_filepathen').val(url);
									editor.hideDialog();
								}
							});
						});
					});

				});
		</script>
                            <input type="text" name="m_p_filepathen" id="m_p_filepathen" value="" />
                            <input type="button" id="insertfile2" value="选择文件" /></td>
                        </tr>
                        <tr style="display:none">
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><div class="wrap">
                              <ul class="tabs">
                                <li class="active"><a href="#" title="详细描述(CN)">详细描述(CN)</a></li>
                                <!--<li><a href="#" title="包装尺寸(CN)">包装尺寸(CN)</a></li>
                                <li><a href="#" title="功能(CN)">功能(CN)</a></li>
                                <li><a href="#" title="备注(CN)">备注(CN)</a></li>-->
                                <li><a href="#" title="详细描述(EN)">详细描述(EN)</a></li>
                                <!--<li><a href="#" title="包装尺寸(EN)">包装尺寸(EN)</a></li>
                                <li><a href="#" title="功能(EN)">功能(EN)</a></li>
                                <li><a href="#" title="备注(EN)">备注(EN)</a></li>--> 
                                <!-- <li><a href="#" title="详细描述(JP)">详细描述(JP)</a></li>-->
                              </ul>
                              <div class="clear"></div>
                              <div class="tabs_content">
                                <div>
                                  <textarea class="content1" name="m_p_description" id="m_p_description" style="width:100%;height:400px;visibility:hidden;"></textarea>
                                </div>
                                <!--<div>
                <textarea class="content1" name="m_p_introduce" id="m_p_introduce" style="width:100%;height:400px;visibility:hidden;"></textarea>                                
                                </div>
                                <div>
                <textarea class="content1" name="m_p_introduce2" id="m_p_introduce2" style="width:100%;height:400px;visibility:hidden;"></textarea>                                
                                </div>
                                 <div>
                <textarea class="content1" name="m_p_introduce3" id="m_p_introduce3" style="width:100%;height:400px;visibility:hidden;"></textarea>                                
                                </div>-->
                                
                                <div>
                                  <textarea class="content1" name="m_p_descriptionen" id="m_p_descriptionen" style="width:100%;height:400px;visibility:hidden;"></textarea>
                                </div>
                                <!--<div>
                <textarea class="content1" name="m_p_introduceen" id="m_p_introduceen" style="width:100%;height:400px;visibility:hidden;"></textarea>                                
                                </div>
                                 <div>
                <textarea class="content1" name="m_p_introduce2en" id="m_p_introduce2en" style="width:100%;height:400px;visibility:hidden;"></textarea>                                
                                </div>
                                 <div>
                <textarea class="content1" name="m_p_introduce3en" id="m_p_introduce3en" style="width:100%;height:400px;visibility:hidden;"></textarea>                                
                                </div>--> 
                                
                                <!--<div>
                <textarea class="content1" name="m_p_descriptionjp" id="m_p_descriptionjp" style="width:100%;height:400px;visibility:hidden;"></textarea>                                
                                </div>--> 
                                
                              </div>
                              <!-- tabs content --> 
                            </div></td>
                        </tr>
                        <tr>
                          <td colspan="3" align="left" style="border-top:solid #dddddd 1px;"><span style="font-size:14px; font-weight:bold; color:green; padding-left:10px;">SEO优化</span></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">页面标题(CN):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><input type="text" size="90" name="PageTitle" />
                            <font color='red'>＊</font></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">页面标题(EN):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><input type="text" size="90" name="PageTitleen" />
                            <font color='red'>＊</font></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">页面标题(JP):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><input type="text" size="90" name="PageTitlejp" />
                            <font color='red'>＊</font></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">关键词(CN):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Keywords" cols="100" rows="3"></textarea></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">关键词(EN):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Keywordsen" cols="100" rows="3"></textarea></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">关键词(JP):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Keywordsjp" cols="100" rows="3"></textarea></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">描述(CN):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Descriptions" cols="100" rows="5"></textarea></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">描述(EN):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Descriptionsen" cols="100" rows="5"></textarea></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">描述(JP):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Descriptionsjp" cols="100" rows="5"></textarea></td>
                        </tr>
                      </tbody>
                    </table></td>
                </tr>
                <tr>
                  <td align="left" bgcolor="#e5e5e5" style="border:solid #bbbbbb 1px;">&nbsp;</td>
                </tr>
              </table>
            </div>
            <div class="nav_tools leftbottom"><span class="save">
              <input type="submit" value="保存" class="but" onclick="addsave()"/>
              </span><span class="back"><a href="<%=request.ServerVariables("HTTP_REFERER")%>">返回</a></span><span class="nav_tools_right rightbottom"></span></div>
          </form>
          <%	
End Sub

Sub editProduct
	dim id,sqlStr,rsObj,m_color,playArray,ProductArray,playTypeCount,ProductTypeCount,i,j,m,n
	
	dim parentid : parentid = getForm("parentid","get")
	dim pid:pid=getForm("pid","get")
	dim bid:bid=getForm("bid","get")
	dim tid:tid=getForm("tid","get")
	dim sid:sid=getForm("sid","get")
	dim cid:cid=getForm("cid","get")
	
	id=clng(getForm("id","get"))
	sqlStr = "select *  from {pre}Product where ID="&id
	set rsObj = conn.db(sqlStr,"records1")
	if rsObj.eof then die "没找到记录"
	vtype = rsObj("SortID")
%>
          <form method="post" action="?action=save&acttype=edit&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>"  name="addform" onSubmit="return validateform()">
            <div class="nav_tools"><span class="save">
              <input type="submit" value="保存" class="but" onclick="addsave()"/>
              </span><span class="back"><a href="<%=request.ServerVariables("HTTP_REFERER")%>">返回</a></span><span class="nav_tools_right"></span></div>
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
                                <td align="right">名称(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_name" name="m_name" size="60"  value="<%=rsObj("p_name")%>" />
                            &nbsp;<font color='red'>＊</font></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">名称(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_nameen" name="m_nameen" size="60"  value="<%=rsObj("p_nameen")%>" />
                            &nbsp;<font color='red'>＊</font></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">名称(JP):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_namejp" name="m_namejp" size="60"  value="<%=rsObj("p_namejp")%>" />
                            &nbsp;<font color='red'>＊</font></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">所属类别:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <select name="m_type" id="m_type"  >
                              <option value="">请选择资料分类</option>
                              <%selectTypeEdit 14,Cint(vtype),parentid%>
                            </select>
                            &nbsp;&nbsp;<font color="red">＊</font> &nbsp;&nbsp; 
                            <!--<input name="IsNew" type="checkbox" id="IsNew" value="yes" <% if rsObj("IsNew")=true then response.Write("checked") end if%>>
                            是否推荐--> 
                            <!--&nbsp;&nbsp;
                            <input name="IsHot" type="checkbox" id="IsHot" value="yes" <% if rsObj("IsHot")=true then response.Write("checked") end if%>>
                            是否新推--> 
                            
                            &nbsp;&nbsp;
                            <input name="IsShow" type="checkbox" id="IsShow" value="yes" <% if rsObj("IsShow")=true then response.Write("checked") end if%>>
                            (CN)发布
                            &nbsp;&nbsp;
                            <input name="IsShowen" type="checkbox" id="IsShowen" value="yes" <% if rsObj("IsShowen")=true then response.Write("checked") end if%>>
                            (EN)发布 
                            <!--&nbsp;&nbsp;
                            <input name="IsShowjp" type="checkbox" id="IsShowjp" value="yes" <%' if rsObj("IsShowjp")=true then response.Write("checked") end if%>>
                            (JP)发布--> 
                            
                            &nbsp;&nbsp;排序
                            <input size="10" name="m_ord" value="<%=rsObj("Ord")%>"/></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">添加日期:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_createdate" name="m_createdate" size="30" value="<%=rsObj("CreateDate")%>" class="Wdate" onClick="WdatePicker()"/>
                            &nbsp;<font color='red'>＊</font></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">相关资料名称相关文章标签:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <textarea name="m_pid" cols="100%" id="m_pid"><%=rsObj("p_ID")%></textarea>
                            注意：名称之间用逗号（,）分开</td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">链接地址(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_links" name="m_p_links" size="36" value="<%=rsObj("p_links")%>" />
                            如：http://www.baidu.com</td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">链接地址(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_linksen" name="m_p_linksen" size="36" value="<%=rsObj("p_linksen")%>" />
                            如：http://www.baidu.com</td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">型号(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_model" name="m_p_model" size="36" value="<%=rsObj("p_model")%>" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">型号(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_modelen" name="m_p_modelen" size="36" value="<%=rsObj("p_modelen")%>" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">类型(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_type" name="m_p_type" size="36" value="<%=rsObj("p_type")%>" />
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">类型(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_typeen" name="m_p_typeen" size="36" value="<%=rsObj("p_typeen")%>" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">材料(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!--<input id="m_p_material" name="m_p_material" size="36" value="<%'=rsObj("p_material")%>" />-->
                            
                            <select name="m_p_material" id="m_p_material">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 10,rsObj("p_material")
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">材料(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!--<input id="m_p_materialen" name="m_p_materialen" size="36" value="<%'=rsObj("p_materialen")%>" />-->
                            
                            <select name="m_p_materialen" id="m_p_materialen">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 10,rsObj("p_materialen")
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">尺寸(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!--<input id="m_p_size" name="m_p_size" size="36" value="<%'=rsObj("p_size")%>" />-->
                            
                            <select name="m_p_size" id="m_p_size">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 11,rsObj("p_size")
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">尺寸(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!--<input id="m_p_sizeen" name="m_p_sizeen" size="36" value="<%'=rsObj("p_sizeen")%>" />-->
                            
                            <select name="m_p_sizeen" id="m_p_sizeen">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 11,rsObj("p_sizeen")
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">特征(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_features" name="m_p_features" size="36" value="<%=rsObj("p_features")%>" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">特征(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_featuresen" name="m_p_featuresen" size="36" value="<%=rsObj("p_featuresen")%>" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">项目编号(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_number" name="m_p_number" size="36" value="<%=rsObj("p_number")%>" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">项目编号(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_numberen" name="m_p_numberen" size="36" value="<%=rsObj("p_numberen")%>" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">价格(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_price" name="m_p_price" size="36" value="<%=rsObj("p_price")%>" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">价格(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input name="m_p_priceen" id="m_p_priceen" value="<%=rsObj("p_priceen")%>" size="36"/></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">价格范围(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!--<input id="m_p_priceRange" name="m_p_priceRange" size="36" value="<%'=rsObj("p_priceRange")%>" />-->
                            
                            <select name="m_p_priceRange" id="m_p_priceRange">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 12,rsObj("p_priceRange")
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">价格范围(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!--<input id="m_p_priceRangeen" name="m_p_priceRangeen" size="36" value="<%'=rsObj("p_priceRangeen")%>" />-->
                            
                            <select name="m_p_priceRangeen" id="m_p_priceRangeen">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 12,rsObj("p_priceRangeen")
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">collection(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!--<input id="m_p_collection" name="m_p_collection" size="36" value="<%'=rsObj("p_collection")%>" />-->
                            
                            <select name="m_p_collection" id="m_p_collection">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 13,rsObj("p_collection")
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">collection(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!-- <input id="m_p_collectionen" name="m_p_collectionen" size="36" value="<%'=rsObj("p_collectionen")%>" />-->
                            
                            <select name="m_p_collectionen" id="m_p_collectionen">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 13,rsObj("p_collectionen")
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">颜色(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_class" name="m_p_class" size="36" value="<%=rsObj("p_class")%>" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">颜色(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_classen" name="m_p_classen" size="36" value="<%=rsObj("p_classen")%>" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">资料简述(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea id="content3" name="m_p_spec" style="width:100%;height:200px;visibility:hidden;"><%=rsObj("p_spec")%></textarea></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">资料简述(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea id="content4" name="m_p_specen" style="width:100%;height:200px;visibility:hidden;"><%=rsObj("p_specen")%></textarea></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">首页推荐小图:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><script>
	KindEditor.ready(function(K) {
		var editor = K.editor({
		  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
		  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
			allowFileManager : true
		});
		K('#image1').click(function() {
			editor.loadPlugin('image', function() {
				editor.plugin.imageDialog({
					imageUrl : K('#m_p_smallimg').val(),
					clickFn : function(url, title, width, height, border, align) {
						K('#m_p_smallimg').val(url);
						editor.hideDialog();
					}
				});
			});
		});
	});
</script> 
                            &nbsp;
                            <div style=" float:left; margin-right:5px; margin-left:8px;"><img src="<%if rsObj("p_smallimg")<>"" then%><%=rsObj("p_smallimg")%><%else%>images/nopic.jpg<%end if%> " width='55'/></div>
                            <textarea name="m_p_smallimg"  type="text" id="m_p_smallimg"  /><%=rsObj("p_smallimg")%></textarea>
                            <input type="button" id="image1" value="选择图片" />
                            尺寸:171*83 </td>
                        </tr>
                        <tr style="display:none;">
                          <td class="tbtr tbl" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">颜色图片列表(CN):</td>
                              </tr>
                            </table></td>
                          <td class="tbtr" style="padding:0px 8px 8px 8px;border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><fieldset class="images_box" style="padding:5px 5px 0px 5px;">
                              <legend>图片列表</legend>
                              <div id="J_colorimageView">
                                <%
if not isnul(rsObj("p_colorimg")) then 
	images=split(rsObj("p_colorimg"),",")
	for j=0 to ubound(images)
	echo"<div style='position:relative;border:#666666 1px solid;float:left;;margin-right:5px;margin-bottom:5px;'><a href='javascript:void(0)' onClick='this.parentNode.parentNode.removeChild(this.parentNode);' style='position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;'><img src='images/del.gif' width='45' height='19' border='0'></a><img src='"&images(j)&"' height='60' border='0'><input type='hidden'  name='m_p_colorimg'  value='"&images(j)&"'/></div>"
	next
end if
%>
                              </div>
                            </fieldset>
                            <input type="button" id="J_selectcolorImage" value="批量上传" />
                            <script>
			KindEditor.ready(function(K) {
				var editor = K.editor({
				  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
				  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					allowFileManager : true
				});
				K('#J_selectcolorImage').click(function() {
					editor.loadPlugin('multiimage', function() {
						editor.plugin.multiImageDialog({
							clickFn : function(urlList) {
								var div = K('#J_colorimageView');
								K.each(urlList, function(i, data) {
			                            div.append('<div style="position:relative;border:#666666 1px solid;float:left;;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '" height="60" border="0"><input type="hidden"  name="m_p_colorimg"  value="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '"/></div>');
										
								});
								editor.hideDialog();
							}
						});
					});
				});
			});
		</script>
                            <input type="button" id="colorimagesv" value="网络图片+本地图片" />
                            <script>
			KindEditor.ready(function(K) {
				var editor = K.editor({
				  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
				  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					allowFileManager : true
				});
				K('#colorimagesv').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							imageUrl : K('#m_p_colorimg').val(),
							clickFn : function(url, title, width, height, border, align) {
		                      var div = K('#J_colorimageView');
		                     div.append('<div style="position:relative;border:#666666 1px solid;float:left;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + url + '" height="60" border="0"><input type="hidden"  name="m_p_colorimg"  value="' + url + '"/></div>');
								editor.hideDialog();

							}
						});
					});
				});
			});
		</script></td>
                        </tr>
                        <tr style="display:none;">
                          <td class="tbtr tbl" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">颜色图片列表(EN):</td>
                              </tr>
                            </table></td>
                          <td class="tbtr" style="padding:0px 8px 8px 8px;border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><fieldset class="images_box" style="padding:5px 5px 0px 5px;">
                              <legend>图片列表</legend>
                              <div id="J_colorimageViewen">
                                <%
if not isnul(rsObj("p_colorimgen")) then 
	images=split(rsObj("p_colorimgen"),",")
	for j=0 to ubound(images)
	echo"<div style='position:relative;border:#666666 1px solid;float:left;;margin-right:5px;margin-bottom:5px;'><a href='javascript:void(0)' onClick='this.parentNode.parentNode.removeChild(this.parentNode);' style='position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;'><img src='images/del.gif' width='45' height='19' border='0'></a><img src='"&images(j)&"' height='60' border='0'><input type='hidden'  name='m_p_colorimgen'  value='"&images(j)&"'/></div>"
	next
end if
%>
                              </div>
                            </fieldset>
                            <input type="button" id="J_selectcolorImageen" value="批量上传" />
                            <script>
			KindEditor.ready(function(K) {
				var editor = K.editor({
				  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
				  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					allowFileManager : true
				});
				K('#J_selectcolorImageen').click(function() {
					editor.loadPlugin('multiimage', function() {
						editor.plugin.multiImageDialog({
							clickFn : function(urlList) {
								var div = K('#J_colorimageViewen');
								K.each(urlList, function(i, data) {
			                            div.append('<div style="position:relative;border:#666666 1px solid;float:left;;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '" height="60" border="0"><input type="hidden"  name="m_p_colorimgen"  value="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '"/></div>');
										
								});

								editor.hideDialog();
							}
						});
					});
				});
			});
		</script>
                            <input type="button" id="colorimagesven" value="网络图片+本地图片" />
                            <script>
			KindEditor.ready(function(K) {
				var editor = K.editor({
				  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
				  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					allowFileManager : true
				});
				K('#colorimagesven').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							imageUrl : K('#m_p_colorimgen').val(),
							clickFn : function(url, title, width, height, border, align) {
		                      var div = K('#J_colorimageViewen');
		                     div.append('<div style="position:relative;border:#666666 1px solid;float:left;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + url + '" height="60" border="0"><input type="hidden"  name="m_p_colorimgen"  value="' + url + '"/></div>');
								editor.hideDialog();

							}
						});
					});
				});
			});
		</script></td>
                        </tr>
                        <tr style="display:none;">
                          <td class="tbtr tbl" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">图片列表(CN):</td>
                              </tr>
                            </table></td>
                          <td class="tbtr" style="padding:0px 8px 8px 8px;border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><fieldset class="images_box" style="padding:5px 5px 0px 5px;">
                              <legend>图片列表</legend>
                              <div id="J_imageView">
                                <%
if not isnul(rsObj("p_img")) then 
	images=split(rsObj("p_img"),",")
	for j=0 to ubound(images)
	echo"<div style='position:relative;border:#666666 1px solid;float:left;;margin-right:5px;margin-bottom:5px;'><a href='javascript:void(0)' onClick='this.parentNode.parentNode.removeChild(this.parentNode);' style='position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;'><img src='images/del.gif' width='45' height='19' border='0'></a><img src='"&images(j)&"' height='60' border='0'><input type='hidden'  name='m_p_img'  value='"&images(j)&"'/></div>"
	next
end if
%>
                              </div>
                            </fieldset>
                            <input type="button" id="J_selectImage" value="批量上传" />
                            <script>
			KindEditor.ready(function(K) {
				var editor = K.editor({
				  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
				  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					allowFileManager : true
				});
				K('#J_selectImage').click(function() {
					editor.loadPlugin('multiimage', function() {
						editor.plugin.multiImageDialog({
							clickFn : function(urlList) {
								var div = K('#J_imageView');
								K.each(urlList, function(i, data) {
			                            div.append('<div style="position:relative;border:#666666 1px solid;float:left;;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '" height="60" border="0"><input type="hidden"  name="m_p_img"  value="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '"/></div>');
										
								});
								editor.hideDialog();
							}
						});
					});
				});
			});
		</script>
                            <input type="button" id="imagesv" value="网络图片+本地图片" />
                            <!--<input name="issy" type="checkbox" id="issy" value="yes" checked="checked" />是否添加水印--> 
                            <script>
			KindEditor.ready(function(K) {
				var editor = K.editor({
				  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
				  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					allowFileManager : true
				});
				K('#imagesv').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							imageUrl : K('#m_p_img').val(),
							clickFn : function(url, title, width, height, border, align) {
		                      var div = K('#J_imageView');
		                     div.append('<div style="position:relative;border:#666666 1px solid;float:left;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + url + '" height="60" border="0"><input type="hidden"  name="m_p_img"  value="' + url + '"/></div>');
								editor.hideDialog();

							}
						});
					});
				});
			});
		</script> 
                            生成缩略图
                            （
                            <input name="small_img" type="radio" id="radio3" value="1" <%if rsObj("small_img")=1 then%> checked="checked" <%end if%>/>
                            <label for="small_img">是
                              <input type="radio" name="small_img" id="radio4" value="0" <%if rsObj("small_img")=0 then%> checked="checked" <%end if%>/>
                            </label>
                            否(删除缩略图)）&nbsp;&nbsp;&nbsp;&nbsp;最大宽高
                            <input name="m_p_max_wh" type="text" id="m_p_max_wh" value="<%=rsObj("p_max_wh")%>" size="10" maxlength="4" />
                            px（请输入数字）
                            建设尺寸220*80px</td>
                        </tr>
                        <tr style="display:none;">
                          <td class="tbtr tbl" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">图片列表(EN):</td>
                              </tr>
                            </table></td>
                          <td class="tbtr" style="padding:0px 8px 8px 8px;border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><fieldset class="images_box" style="padding:5px 5px 0px 5px;">
                              <legend>图片列表</legend>
                              <div id="J_imageViewen">
                                <%
if not isnul(rsObj("p_imgen")) then 
	images=split(rsObj("p_imgen"),",")
	for j=0 to ubound(images)
	echo"<div style='position:relative;border:#666666 1px solid;float:left;;margin-right:5px;margin-bottom:5px;'><a href='javascript:void(0)' onClick='this.parentNode.parentNode.removeChild(this.parentNode);' style='position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;'><img src='images/del.gif' width='45' height='19' border='0'></a><img src='"&images(j)&"' height='60' border='0'><input type='hidden'  name='m_p_imgen'  value='"&images(j)&"'/></div>"
	next
end if
%>
                              </div>
                            </fieldset>
                            <input type="button" id="J_selectImageen" value="批量上传" />
                            <script>
			KindEditor.ready(function(K) {
				var editor = K.editor({
				  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
				  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					allowFileManager : true
				});
				K('#J_selectImageen').click(function() {
					editor.loadPlugin('multiimage', function() {
						editor.plugin.multiImageDialog({
							clickFn : function(urlList) {
								var div = K('#J_imageViewen');
								K.each(urlList, function(i, data) {
			                            div.append('<div style="position:relative;border:#666666 1px solid;float:left;;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '" height="60" border="0"><input type="hidden"  name="m_p_imgen"  value="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '"/></div>');
										
								});
								editor.hideDialog();
							}
						});
					});
				});
			});
		</script>
                            <input type="button" id="imagesven" value="网络图片+本地图片" />
                            <script>
			KindEditor.ready(function(K) {
				var editor = K.editor({
				  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
				  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					allowFileManager : true
				});
				K('#imagesven').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							imageUrl : K('#m_p_imgen').val(),
							clickFn : function(url, title, width, height, border, align) {
		                      var div = K('#J_imageViewen');
		                     div.append('<div style="position:relative;border:#666666 1px solid;float:left;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + url + '" height="60" border="0"><input type="hidden"  name="m_p_imgen"  value="' + url + '"/></div>');
								editor.hideDialog();

							}
						});
					});
				});
			});
		</script></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">PDF文件:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <script>
				//文件上传
				KindEditor.ready(function(K) {
					var editor = K.editor({
					  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
					  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					  allowFileManager : true
					});
					K('#insertfile').click(function() {
						editor.loadPlugin('insertfile', function() {
							editor.plugin.fileDialog({
								fileUrl : K('#m_p_filepath').val(),
								clickFn : function(url, title) {
									K('#m_p_filepath').val(url);
									editor.hideDialog();
								}
							});
						});
					});

				});
		</script>
                            <input type="text" name="m_p_filepath" id="m_p_filepath" value="<%=rsObj("p_filepath")%>" />
                            <input type="button" id="insertfile" value="选择文件" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">(EN)PDF:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <script>
				//文件上传
				KindEditor.ready(function(K) {
					var editor = K.editor({
					  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
					  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					  allowFileManager : true
					});
					K('#insertfile2').click(function() {
						editor.loadPlugin('insertfile', function() {
							editor.plugin.fileDialog({
								fileUrl : K('#m_p_filepathen').val(),
								clickFn : function(url, title) {
									K('#m_p_filepathen').val(url);
									editor.hideDialog();
								}
							});
						});
					});

				});
		</script>
                            <input type="text" name="m_p_filepathen" id="m_p_filepathen" value="<%=rsObj("p_filepathen")%>" />
                            <input type="button" id="insertfile2" value="选择文件" /></td>
                        </tr>
                        <tr style="display:none">
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><div class="wrap">
                              <ul class="tabs">
                                <li class="active"><a href="#" title="详细描述(CN)">详细描述(CN)</a></li>
                                <!--<li><a href="#" title="包装尺寸(CN)">包装尺寸(CN)</a></li>
                                <li><a href="#" title="功能(CN)">功能(CN)</a></li>
                                <li><a href="#" title="备注(CN)">备注(CN)</a></li>-->
                                <li><a href="#" title="详细描述(EN)">详细描述(EN)</a></li>
                                <!--<li><a href="#" title="包装尺寸(EN)">包装尺寸(EN)</a></li>
                                <li><a href="#" title="功能(EN)">功能(EN)</a></li>
                                <li><a href="#" title="备注(EN)">备注(EN)</a></li>--> 
                                <!--<li><a href="#" title="详细描述(JP)">详细描述(JP)</a></li>-->
                              </ul>
                              <div class="clear"></div>
                              <div class="tabs_content">
                                <div>
                                  <textarea class="content1" name="m_p_description" id="m_p_description" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("p_description")%></textarea>
                                </div>
                                <!--<div>
                <textarea class="content1" name="m_p_introduce" id="m_p_introduce" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("p_introduce")%></textarea>                                
                                </div>
                                <div>
                <textarea class="content1" name="m_p_introduce2" id="m_p_introduce2" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("p_introduce2")%></textarea>                                
                                </div>
                                
                                <div>
                <textarea class="content1" name="m_p_introduce3" id="m_p_introduce3" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("p_introduce3")%></textarea>                                
                                </div>-->
                                
                                <div>
                                  <textarea class="content1" name="m_p_descriptionen" id="m_p_descriptionen" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("p_descriptionen")%></textarea>
                                </div>
                                <!--<div>
                <textarea class="content1" name="m_p_introduceen" id="m_p_introduceen" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("p_introduceen")%></textarea>                                
                                </div>
                                <div>
                <textarea class="content1" name="m_p_introduce2en" id="m_p_introduce2en" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("p_introduce2en")%></textarea>                                
                                </div>

                                 <div>
                <textarea class="content1" name="m_p_introduce3en" id="m_p_introduce3en" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("p_introduce3en")%></textarea>                                
                                </div>--> 
                                
                                <!--<div>
                <textarea class="content1" name="m_p_descriptionjp" id="m_p_descriptionjp" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("p_descriptionjp")%></textarea>                                
                                </div>--> 
                                
                              </div>
                              <!-- tabs content --> 
                            </div></td>
                        </tr>
                        <tr>
                          <td colspan="3" align="left" style="border-top:solid #dddddd 1px;"><span style="font-size:14px; font-weight:bold; color:green; padding-left:10px;">SEO优化</span></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">页面标题(CN):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><input type="text" size="90" name="PageTitle" value="<%=rsObj("PageTitle")%>" />
                            <font color='red'>＊</font></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">页面标题(EN):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><input type="text" size="90" name="PageTitleen" value="<%=rsObj("PageTitleen")%>" />
                            <font color='red'>＊</font></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">页面标题(JP):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><input type="text" size="90" name="PageTitlejp" value="<%=rsObj("PageTitlejp")%>" />
                            <font color='red'>＊</font></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">关键词(CN):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Keywords" cols="100" rows="3"><%=rsObj("Keywords")%></textarea></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">关键词(EN):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Keywordsen" cols="100" rows="3"><%=rsObj("Keywordsen")%></textarea></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">关键词(JP):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Keywordsjp" cols="100" rows="3"><%=rsObj("Keywordsjp")%></textarea></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">描述(CN):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Descriptions" cols="100" rows="5"><%=rsObj("Descriptions")%></textarea></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">描述(EN):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Descriptionsen" cols="100" rows="5"><%=rsObj("Descriptionsen")%></textarea></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">描述(JP):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Descriptionsjp" cols="100" rows="5"><%=rsObj("Descriptionsjp")%></textarea></td>
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
            <div class="nav_tools leftbottom"><span class="save">
              <input type="submit" value="保存" class="but" onclick="addsave()"/>
              </span><span class="back"><a href="<%=request.ServerVariables("HTTP_REFERER")%>">返回</a></span><span class="nav_tools_right rightbottom"></span></div>
          </form>
          <%
set rsObj = nothing
End Sub

Sub editaddProduct
	dim id,sqlStr,rsObj,m_color,playArray,ProductArray,playTypeCount,ProductTypeCount,i,j,m,n
	
	dim parentid : parentid = getForm("parentid","get")
	dim pid:pid=getForm("pid","get")
	dim bid:bid=getForm("bid","get")
	dim tid:tid=getForm("tid","get")
	dim sid:sid=getForm("sid","get")
	dim cid:cid=getForm("cid","get")
	
	id=clng(getForm("id","get"))
	sqlStr = "select *  from {pre}Product where ID="&id
	set rsObj = conn.db(sqlStr,"records1")
	if rsObj.eof then die "没找到记录"
	vtype = rsObj("SortID")
%>
          <form method="post" action="?action=save&acttype=add&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>&uid=<%=uid%>"  name="addform" onSubmit="return validateform()">
            <div class="nav_tools"><span class="save">
              <input type="submit" value="保存" class="but" onclick="addsave()"/>
              </span><span class="back"><a href="<%=request.ServerVariables("HTTP_REFERER")%>">返回</a></span><span class="nav_tools_right"></span></div>
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
                                <td align="right">名称(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_name" name="m_name" size="60"  value="<%=rsObj("p_name")%>" />
                            &nbsp;<font color='red'>＊</font></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">名称(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_nameen" name="m_nameen" size="60"  value="<%=rsObj("p_nameen")%>" />
                            &nbsp;<font color='red'>＊</font></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">名称(JP):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_namejp" name="m_namejp" size="60"  value="<%=rsObj("p_namejp")%>" />
                            &nbsp;<font color='red'>＊</font></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">所属类别:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <select name="m_type" id="m_type"  >
                              <option value="">请选择资料分类</option>
                              <%selectTypeEdit 14,Cint(vtype),parentid%>
                            </select>
                            &nbsp;&nbsp;<font color="red">＊</font> &nbsp;&nbsp; 
                            <!--<input name="IsNew" type="checkbox" id="IsNew" value="yes" <% if rsObj("IsNew")=true then response.Write("checked") end if%>>
                            是否推荐--> 
                            <!--&nbsp;&nbsp;
                            <input name="IsHot" type="checkbox" id="IsHot" value="yes" <% if rsObj("IsHot")=true then response.Write("checked") end if%>>
                            是否新推--> 
                            
                            &nbsp;&nbsp;
                            <input name="IsShow" type="checkbox" id="IsShow" value="yes" <% if rsObj("IsShow")=true then response.Write("checked") end if%>>
                            (CN)发布
                            &nbsp;&nbsp;
                            <input name="IsShowen" type="checkbox" id="IsShowen" value="yes" <% if rsObj("IsShowen")=true then response.Write("checked") end if%>>
                            (EN)发布 
                            <!--&nbsp;&nbsp;
                            <input name="IsShowjp" type="checkbox" id="IsShowjp" value="yes" <%' if rsObj("IsShowjp")=true then response.Write("checked") end if%>>
                            (JP)发布--> 
                            
                            &nbsp;&nbsp;排序
                            <input size="10" name="m_ord" value="<%=rsObj("Ord")%>"/></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">添加日期:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_createdate" name="m_createdate" size="30" value="<%=rsObj("CreateDate")%>" class="Wdate" onClick="WdatePicker()"/>
                            &nbsp;<font color='red'>＊</font></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">相关资料名称相关文章标签:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <textarea name="m_pid" cols="100%" id="m_pid"><%=rsObj("p_ID")%></textarea>
                            注意：名称之间用逗号（,）分开</td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">链接地址(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_links" name="m_p_links" size="36" value="<%=rsObj("p_links")%>" />
                            如：http://www.baidu.com</td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">链接地址(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_linksen" name="m_p_linksen" size="36" value="<%=rsObj("p_linksen")%>" />
                            如：http://www.baidu.com</td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">型号(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_model" name="m_p_model" size="36" value="<%=rsObj("p_model")%>" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">型号(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_modelen" name="m_p_modelen" size="36" value="<%=rsObj("p_modelen")%>" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">类型(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_type" name="m_p_type" size="36" value="<%=rsObj("p_type")%>" />
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">类型(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_typeen" name="m_p_typeen" size="36" value="<%=rsObj("p_typeen")%>" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">材料(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!--<input id="m_p_material" name="m_p_material" size="36" value="<%'=rsObj("p_material")%>" />-->
                            
                            <select name="m_p_material" id="m_p_material">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 10,rsObj("p_material")
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">材料(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!--<input id="m_p_materialen" name="m_p_materialen" size="36" value="<%'=rsObj("p_materialen")%>" />-->
                            
                            <select name="m_p_materialen" id="m_p_materialen">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 10,rsObj("p_materialen")
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">尺寸(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!--<input id="m_p_size" name="m_p_size" size="36" value="<%'=rsObj("p_size")%>" />-->
                            
                            <select name="m_p_size" id="m_p_size">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 11,rsObj("p_size")
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">尺寸(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!--<input id="m_p_sizeen" name="m_p_sizeen" size="36" value="<%'=rsObj("p_sizeen")%>" />-->
                            
                            <select name="m_p_sizeen" id="m_p_sizeen">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 11,rsObj("p_sizeen")
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">特征(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_features" name="m_p_features" size="36" value="<%=rsObj("p_features")%>" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">特征(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_featuresen" name="m_p_featuresen" size="36" value="<%=rsObj("p_featuresen")%>" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">项目编号(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_number" name="m_p_number" size="36" value="<%=rsObj("p_number")%>" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">项目编号(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_numberen" name="m_p_numberen" size="36" value="<%=rsObj("p_numberen")%>" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">价格(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_price" name="m_p_price" size="36" value="<%=rsObj("p_price")%>" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">价格(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input name="m_p_priceen" id="m_p_priceen" value="<%=rsObj("p_priceen")%>" size="36"/></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">价格范围(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!--<input id="m_p_priceRange" name="m_p_priceRange" size="36" value="<%'=rsObj("p_priceRange")%>" />-->
                            
                            <select name="m_p_priceRange" id="m_p_priceRange">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 12,rsObj("p_priceRange")
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">价格范围(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!--<input id="m_p_priceRangeen" name="m_p_priceRangeen" size="36" value="<%'=rsObj("p_priceRangeen")%>" />-->
                            
                            <select name="m_p_priceRangeen" id="m_p_priceRangeen">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 12,rsObj("p_priceRangeen")
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">collection(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!--<input id="m_p_collection" name="m_p_collection" size="36" value="<%'=rsObj("p_collection")%>" />-->
                            
                            <select name="m_p_collection" id="m_p_collection">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 13,rsObj("p_collection")
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">collection(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <!-- <input id="m_p_collectionen" name="m_p_collectionen" size="36" value="<%'=rsObj("p_collectionen")%>" />-->
                            
                            <select name="m_p_collectionen" id="m_p_collectionen">
                              <option value="0" selected="selected">请选择</option>
                              <%
Otherselect 13,rsObj("p_collectionen")
%>
                            </select></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">颜色(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_class" name="m_p_class" size="36" value="<%=rsObj("p_class")%>" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">颜色(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_p_classen" name="m_p_classen" size="36" value="<%=rsObj("p_classen")%>" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">资料简述(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea id="content3" name="m_p_spec" style="width:100%;height:200px;visibility:hidden;"><%=rsObj("p_spec")%></textarea></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">资料简述(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea id="content4" name="m_p_specen" style="width:100%;height:200px;visibility:hidden;"><%=rsObj("p_specen")%></textarea></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">首页推荐小图:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><script>
	KindEditor.ready(function(K) {
		var editor = K.editor({
		  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
		  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
			allowFileManager : true
		});
		K('#image1').click(function() {
			editor.loadPlugin('image', function() {
				editor.plugin.imageDialog({
					imageUrl : K('#m_p_smallimg').val(),
					clickFn : function(url, title, width, height, border, align) {
						K('#m_p_smallimg').val(url);
						editor.hideDialog();
					}
				});
			});
		});
	});
</script> 
                            &nbsp;
                            <div style=" float:left; margin-right:5px; margin-left:8px;"><img src="<%if rsObj("p_smallimg")<>"" then%><%=rsObj("p_smallimg")%><%else%>images/nopic.jpg<%end if%> " width='55'/></div>
                            <textarea name="m_p_smallimg"  type="text" id="m_p_smallimg"  /><%=rsObj("p_smallimg")%></textarea>
                            <input type="button" id="image1" value="选择图片" />
                            尺寸:171*83 </td>
                        </tr>
                        <tr style="display:none;">
                          <td class="tbtr tbl" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">颜色图片列表(CN):</td>
                              </tr>
                            </table></td>
                          <td class="tbtr" style="padding:0px 8px 8px 8px;border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><fieldset class="images_box" style="padding:5px 5px 0px 5px;">
                              <legend>图片列表</legend>
                              <div id="J_colorimageView">
                                <%
if not isnul(rsObj("p_colorimg")) then 
	images=split(rsObj("p_colorimg"),",")
	for j=0 to ubound(images)
	echo"<div style='position:relative;border:#666666 1px solid;float:left;;margin-right:5px;margin-bottom:5px;'><a href='javascript:void(0)' onClick='this.parentNode.parentNode.removeChild(this.parentNode);' style='position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;'><img src='images/del.gif' width='45' height='19' border='0'></a><img src='"&images(j)&"' height='60' border='0'><input type='hidden'  name='m_p_colorimg'  value='"&images(j)&"'/></div>"
	next
end if
%>
                              </div>
                            </fieldset>
                            <input type="button" id="J_selectcolorImage" value="批量上传" />
                            <script>
			KindEditor.ready(function(K) {
				var editor = K.editor({
				  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
				  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					allowFileManager : true
				});
				K('#J_selectcolorImage').click(function() {
					editor.loadPlugin('multiimage', function() {
						editor.plugin.multiImageDialog({
							clickFn : function(urlList) {
								var div = K('#J_colorimageView');
								K.each(urlList, function(i, data) {
			                            div.append('<div style="position:relative;border:#666666 1px solid;float:left;;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '" height="60" border="0"><input type="hidden"  name="m_p_colorimg"  value="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '"/></div>');
										
								});
								editor.hideDialog();
							}
						});
					});
				});
			});
		</script>
                            <input type="button" id="colorimagesv" value="网络图片+本地图片" />
                            <script>
			KindEditor.ready(function(K) {
				var editor = K.editor({
				  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
				  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					allowFileManager : true
				});
				K('#colorimagesv').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							imageUrl : K('#m_p_colorimg').val(),
							clickFn : function(url, title, width, height, border, align) {
		                      var div = K('#J_colorimageView');
		                     div.append('<div style="position:relative;border:#666666 1px solid;float:left;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + url + '" height="60" border="0"><input type="hidden"  name="m_p_colorimg"  value="' + url + '"/></div>');
								editor.hideDialog();

							}
						});
					});
				});
			});
		</script></td>
                        </tr>
                        <tr style="display:none;">
                          <td class="tbtr tbl" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">颜色图片列表(EN):</td>
                              </tr>
                            </table></td>
                          <td class="tbtr" style="padding:0px 8px 8px 8px;border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><fieldset class="images_box" style="padding:5px 5px 0px 5px;">
                              <legend>图片列表</legend>
                              <div id="J_colorimageViewen">
                                <%
if not isnul(rsObj("p_colorimgen")) then 
	images=split(rsObj("p_colorimgen"),",")
	for j=0 to ubound(images)
	echo"<div style='position:relative;border:#666666 1px solid;float:left;;margin-right:5px;margin-bottom:5px;'><a href='javascript:void(0)' onClick='this.parentNode.parentNode.removeChild(this.parentNode);' style='position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;'><img src='images/del.gif' width='45' height='19' border='0'></a><img src='"&images(j)&"' height='60' border='0'><input type='hidden'  name='m_p_colorimgen'  value='"&images(j)&"'/></div>"
	next
end if
%>
                              </div>
                            </fieldset>
                            <input type="button" id="J_selectcolorImageen" value="批量上传" />
                            <script>
			KindEditor.ready(function(K) {
				var editor = K.editor({
				  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
				  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					allowFileManager : true
				});
				K('#J_selectcolorImageen').click(function() {
					editor.loadPlugin('multiimage', function() {
						editor.plugin.multiImageDialog({
							clickFn : function(urlList) {

								var div = K('#J_colorimageViewen');
								K.each(urlList, function(i, data) {
			                            div.append('<div style="position:relative;border:#666666 1px solid;float:left;;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '" height="60" border="0"><input type="hidden"  name="m_p_colorimgen"  value="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '"/></div>');
										
								});
								editor.hideDialog();
							}
						});
					});
				});
			});
		</script>
                            <input type="button" id="colorimagesven" value="网络图片+本地图片" />
                            <script>
			KindEditor.ready(function(K) {
				var editor = K.editor({
				  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
				  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					allowFileManager : true
				});
				K('#colorimagesven').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							imageUrl : K('#m_p_colorimgen').val(),
							clickFn : function(url, title, width, height, border, align) {
		                      var div = K('#J_colorimageViewen');
		                     div.append('<div style="position:relative;border:#666666 1px solid;float:left;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + url + '" height="60" border="0"><input type="hidden"  name="m_p_colorimgen"  value="' + url + '"/></div>');
								editor.hideDialog();

							}
						});
					});
				});
			});
		</script></td>
                        </tr>
                        <tr style="display:none;">
                          <td class="tbtr tbl" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">图片列表(CN):</td>
                              </tr>
                            </table></td>
                          <td class="tbtr" style="padding:0px 8px 8px 8px;border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><fieldset class="images_box" style="padding:5px 5px 0px 5px;">
                              <legend>图片列表</legend>
                              <div id="J_imageView">
                                <%
if not isnul(rsObj("p_img")) then 
	images=split(rsObj("p_img"),",")
	for j=0 to ubound(images)
	echo"<div style='position:relative;border:#666666 1px solid;float:left;;margin-right:5px;margin-bottom:5px;'><a href='javascript:void(0)' onClick='this.parentNode.parentNode.removeChild(this.parentNode);' style='position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;'><img src='images/del.gif' width='45' height='19' border='0'></a><img src='"&images(j)&"' height='60' border='0'><input type='hidden'  name='m_p_img'  value='"&images(j)&"'/></div>"
	next
end if
%>
                              </div>
                            </fieldset>
                            <input type="button" id="J_selectImage" value="批量上传" />
                            <script>
			KindEditor.ready(function(K) {
				var editor = K.editor({
				  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
				  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					allowFileManager : true
				});
				K('#J_selectImage').click(function() {
					editor.loadPlugin('multiimage', function() {
						editor.plugin.multiImageDialog({
							clickFn : function(urlList) {
								var div = K('#J_imageView');
								K.each(urlList, function(i, data) {
			                            div.append('<div style="position:relative;border:#666666 1px solid;float:left;;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '" height="60" border="0"><input type="hidden"  name="m_p_img"  value="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '"/></div>');
										
								});
								editor.hideDialog();
							}
						});
					});
				});
			});
		</script>
                            <input type="button" id="imagesv" value="网络图片+本地图片" />
                            <!--<input name="issy" type="checkbox" id="issy" value="yes" checked="checked" />是否添加水印--> 
                            <script>
			KindEditor.ready(function(K) {
				var editor = K.editor({
				  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
				  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					allowFileManager : true
				});
				K('#imagesv').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							imageUrl : K('#m_p_img').val(),
							clickFn : function(url, title, width, height, border, align) {
		                      var div = K('#J_imageView');
		                     div.append('<div style="position:relative;border:#666666 1px solid;float:left;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + url + '" height="60" border="0"><input type="hidden"  name="m_p_img"  value="' + url + '"/></div>');
								editor.hideDialog();

							}
						});
					});
				});
			});
		</script> 
                            生成缩略图
                            （
                            <input name="small_img" type="radio" id="radio3" value="1" <%if rsObj("small_img")=1 then%> checked="checked" <%end if%>/>
                            <label for="small_img">是
                              <input type="radio" name="small_img" id="radio4" value="0" <%if rsObj("small_img")=0 then%> checked="checked" <%end if%>/>
                            </label>
                            否(删除缩略图)）&nbsp;&nbsp;&nbsp;&nbsp;最大宽高
                            <input name="m_p_max_wh" type="text" id="m_p_max_wh" value="<%=rsObj("p_max_wh")%>" size="10" maxlength="4" />
                            px（请输入数字）
                            建设尺寸220*80px</td>
                        </tr>
                        <tr style="display:none;">
                          <td class="tbtr tbl" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">图片列表(EN):</td>
                              </tr>
                            </table></td>
                          <td class="tbtr" style="padding:0px 8px 8px 8px;border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><fieldset class="images_box" style="padding:5px 5px 0px 5px;">
                              <legend>图片列表</legend>
                              <div id="J_imageViewen">
                                <%
if not isnul(rsObj("p_imgen")) then 
	images=split(rsObj("p_imgen"),",")
	for j=0 to ubound(images)
	echo"<div style='position:relative;border:#666666 1px solid;float:left;;margin-right:5px;margin-bottom:5px;'><a href='javascript:void(0)' onClick='this.parentNode.parentNode.removeChild(this.parentNode);' style='position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;'><img src='images/del.gif' width='45' height='19' border='0'></a><img src='"&images(j)&"' height='60' border='0'><input type='hidden'  name='m_p_imgen'  value='"&images(j)&"'/></div>"
	next
end if
%>
                              </div>
                            </fieldset>
                            <input type="button" id="J_selectImageen" value="批量上传" />
                            <script>
			KindEditor.ready(function(K) {
				var editor = K.editor({
				  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
				  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					allowFileManager : true
				});
				K('#J_selectImageen').click(function() {
					editor.loadPlugin('multiimage', function() {
						editor.plugin.multiImageDialog({
							clickFn : function(urlList) {
								var div = K('#J_imageViewen');
								K.each(urlList, function(i, data) {
			                            div.append('<div style="position:relative;border:#666666 1px solid;float:left;;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '" height="60" border="0"><input type="hidden"  name="m_p_imgen"  value="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '"/></div>');
										
								});
								editor.hideDialog();
							}
						});
					});
				});
			});
		</script>
                            <input type="button" id="imagesven" value="网络图片+本地图片" />
                            <script>
			KindEditor.ready(function(K) {
				var editor = K.editor({
				  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
				  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					allowFileManager : true
				});
				K('#imagesven').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							imageUrl : K('#m_p_imgen').val(),
							clickFn : function(url, title, width, height, border, align) {
		                      var div = K('#J_imageViewen');
		                     div.append('<div style="position:relative;border:#666666 1px solid;float:left;margin-right:5px;margin-bottom:5px;"><a href="javascript:void(0)" onClick="this.parentNode.parentNode.removeChild(this.parentNode);" style="position:absolute;float:left;top:2px;left:2px; background:#FFFFFF; color:#FF0000;"><img src="images/del.gif" width="45" height="19" border="0"></a><img src="' + url + '" height="60" border="0"><input type="hidden"  name="m_p_imgen"  value="' + url + '"/></div>');
								editor.hideDialog();

							}
						});
					});
				});
			});
		</script></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">PDF文件:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <script>
				//文件上传
				KindEditor.ready(function(K) {
					var editor = K.editor({
					  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
					  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					  allowFileManager : true
					});
					K('#insertfile').click(function() {
						editor.loadPlugin('insertfile', function() {
							editor.plugin.fileDialog({
								fileUrl : K('#m_p_filepath').val(),
								clickFn : function(url, title) {
									K('#m_p_filepath').val(url);
									editor.hideDialog();
								}
							});
						});
					});

				});
		</script>
                            <input type="text" name="m_p_filepath" id="m_p_filepath" value="<%=rsObj("p_filepath")%>" />
                            <input type="button" id="insertfile" value="选择文件" /></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">(EN)PDF:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp; 
                            <script>
				//文件上传
				KindEditor.ready(function(K) {
					var editor = K.editor({
					  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
					  fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
					  allowFileManager : true
					});
					K('#insertfile2').click(function() {
						editor.loadPlugin('insertfile', function() {
							editor.plugin.fileDialog({
								fileUrl : K('#m_p_filepathen').val(),
								clickFn : function(url, title) {
									K('#m_p_filepathen').val(url);
									editor.hideDialog();
								}
							});
						});
					});

				});
		</script>
                            <input type="text" name="m_p_filepathen" id="m_p_filepathen" value="<%=rsObj("p_filepathen")%>" />
                            <input type="button" id="insertfile2" value="选择文件" /></td>
                        </tr>
                        <tr style="display:none">
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><div class="wrap">
                              <ul class="tabs">
                                <li class="active"><a href="#" title="详细描述(CN)">详细描述(CN)</a></li>
                                <!--<li><a href="#" title="包装尺寸(CN)">包装尺寸(CN)</a></li>
                                <li><a href="#" title="功能(CN)">功能(CN)</a></li>
                                <li><a href="#" title="备注(CN)">备注(CN)</a></li>-->
                                <li><a href="#" title="详细描述(EN)">详细描述(EN)</a></li>
                                <!--<li><a href="#" title="包装尺寸(EN)">包装尺寸(EN)</a></li>
                                <li><a href="#" title="功能(EN)">功能(EN)</a></li>
                                <li><a href="#" title="备注(EN)">备注(EN)</a></li>--> 
                                <!--<li><a href="#" title="详细描述(JP)">详细描述(JP)</a></li>-->
                              </ul>
                              <div class="clear"></div>
                              <div class="tabs_content">
                                <div>
                                  <textarea class="content1" name="m_p_description" id="m_p_description" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("p_description")%></textarea>
                                </div>
                                <!--<div>
                <textarea class="content1" name="m_p_introduce" id="m_p_introduce" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("p_introduce")%></textarea>                                
                                </div>
                                <div>
                <textarea class="content1" name="m_p_introduce2" id="m_p_introduce2" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("p_introduce2")%></textarea>                                
                                </div>
                                
                                <div>
                <textarea class="content1" name="m_p_introduce3" id="m_p_introduce3" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("p_introduce3")%></textarea>                                
                                </div>-->
                                
                                <div>
                                  <textarea class="content1" name="m_p_descriptionen" id="m_p_descriptionen" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("p_descriptionen")%></textarea>
                                </div>
                                <!--<div>
                <textarea class="content1" name="m_p_introduceen" id="m_p_introduceen" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("p_introduceen")%></textarea>                                
                                </div>
                                <div>
                <textarea class="content1" name="m_p_introduce2en" id="m_p_introduce2en" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("p_introduce2en")%></textarea>                                
                                </div>

                                 <div>
                <textarea class="content1" name="m_p_introduce3en" id="m_p_introduce3en" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("p_introduce3en")%></textarea>                                
                                </div>--> 
                                
                                <!--<div>
                <textarea class="content1" name="m_p_descriptionjp" id="m_p_descriptionjp" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("p_descriptionjp")%></textarea>                                
                                </div>--> 
                                
                              </div>
                              <!-- tabs content --> 
                            </div></td>
                        </tr>
                        <tr>
                          <td colspan="3" align="left" style="border-top:solid #dddddd 1px;"><span style="font-size:14px; font-weight:bold; color:green; padding-left:10px;">SEO优化</span></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">页面标题(CN):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><input type="text" size="90" name="PageTitle" value="<%=rsObj("PageTitle")%>" />
                            <font color='red'>＊</font></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">页面标题(EN):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><input type="text" size="90" name="PageTitleen" value="<%=rsObj("PageTitleen")%>" />
                            <font color='red'>＊</font></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">页面标题(JP):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><input type="text" size="90" name="PageTitlejp" value="<%=rsObj("PageTitlejp")%>" />
                            <font color='red'>＊</font></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">关键词(CN):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Keywords" cols="100" rows="3"><%=rsObj("Keywords")%></textarea></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">关键词(EN):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Keywordsen" cols="100" rows="3"><%=rsObj("Keywordsen")%></textarea></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">关键词(JP):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Keywordsjp" cols="100" rows="3"><%=rsObj("Keywordsjp")%></textarea></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">描述(CN):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Descriptions" cols="100" rows="5"><%=rsObj("Descriptions")%></textarea></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">描述(EN):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Descriptionsen" cols="100" rows="5"><%=rsObj("Descriptionsen")%></textarea></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="80" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">描述(JP):</td>
                              </tr>
                            </table></td>
                          <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Descriptionsjp" cols="100" rows="5"><%=rsObj("Descriptionsjp")%></textarea></td>
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
            <div class="nav_tools leftbottom"><span class="save">
              <input type="submit" value="保存" class="but" onclick="addsave()"/>
              </span><span class="back"><a href="<%=request.ServerVariables("HTTP_REFERER")%>">返回</a></span><span class="nav_tools_right rightbottom"></span></div>
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
Sub saveProduct
	dim actType : actType = getForm("acttype","get")
	dim updateSql,insertSql
	dim m_name:m_name=ReplaceSymbols(getForm("m_name","post")) : if isNul(m_name) then die "请填写资料标题"
	dim m_nameen:m_nameen=ReplaceSymbols(getForm("m_nameen","post"))
	dim m_namejp:m_namejp=ReplaceSymbols(getForm("m_namejp","post"))
	
	dim m_p_filepath:m_p_filepath=ReplaceSymbols(getForm("m_p_filepath","post"))
	dim m_p_filepathen:m_p_filepathen=ReplaceSymbols(getForm("m_p_filepathen","post"))
	
	dim m_back:m_back=getForm("m_back","post")
	dim m_type:m_type=getForm("m_type","post"):if isNul(m_type) then die "请选择分类" : if cint(m_type)=0 then die "你选择的是顶级目录" 
	dim m_pid:m_pid=getForm("m_pid","post")
	dim m_p_size:m_p_size=ReplaceSymbols(getForm("m_p_size","post"))
	dim m_p_sizeen:m_p_sizeen=ReplaceSymbols(getForm("m_p_sizeen","post"))
	dim m_p_links:m_p_links=ReplaceSymbols(getForm("m_p_links","post"))
	dim m_p_linksen:m_p_linksen=ReplaceSymbols(getForm("m_p_linksen","post"))
	dim m_p_model:m_p_model=ReplaceSymbols(getForm("m_p_model","post"))
	dim m_p_modelen:m_p_modelen=ReplaceSymbols(getForm("m_p_modelen","post"))
	dim m_p_spec:m_p_spec=ReplaceSymbols(getForm("m_p_spec","post"))
	dim m_p_specen:m_p_specen=ReplaceSymbols(getForm("m_p_specen","post"))

	dim m_p_type:m_p_type=ReplaceSymbols(getForm("m_p_type","post"))
	dim m_p_typeen:m_p_typeen=ReplaceSymbols(getForm("m_p_typeen","post"))
	dim m_p_material:m_p_material=ReplaceSymbols(getForm("m_p_material","post"))
	dim m_p_class:m_p_class=ReplaceSymbols(getForm("m_p_class","post"))
	dim m_p_classen:m_p_classen=ReplaceSymbols(getForm("m_p_classen","post"))
	dim m_p_materialen:m_p_materialen=ReplaceSymbols(getForm("m_p_materialen","post"))
	dim m_p_features:m_p_features=ReplaceSymbols(getForm("m_p_features","post"))
	dim m_p_featuresen:m_p_featuresen=ReplaceSymbols(getForm("m_p_featuresen","post"))
	dim m_p_number:m_p_number=ReplaceSymbols(getForm("m_p_number","post"))
	dim m_p_numberen:m_p_numberen=ReplaceSymbols(getForm("m_p_numberen","post"))

	dim m_p_price:m_p_price=ReplaceSymbols(getForm("m_p_price","post"))
	dim m_p_priceen:m_p_priceen=ReplaceSymbols(getForm("m_p_priceen","post"))
	dim m_p_collection:m_p_collection=ReplaceSymbols(getForm("m_p_collection","post"))
	dim m_p_collectionen:m_p_collectionen=ReplaceSymbols(getForm("m_p_collectionen","post"))
	dim m_p_priceRange:m_p_priceRange=ReplaceSymbols(getForm("m_p_priceRange","post"))
	dim m_p_priceRangeen:m_p_priceRangeen=ReplaceSymbols(getForm("m_p_priceRangeen","post"))
	
	dim m_p_img:m_p_img=ReplaceSymbols(getForm("m_p_img","post"))
	dim m_p_imgen:m_p_imgen=ReplaceSymbols(getForm("m_p_imgen","post"))
	dim m_p_colorimg:m_p_colorimg=ReplaceSymbols(getForm("m_p_colorimg","post"))
	dim m_p_colorimgen:m_p_colorimgen=ReplaceSymbols(getForm("m_p_colorimgen","post"))
	dim m_p_smallimg:m_p_smallimg=ReplaceSymbols(getForm("m_p_smallimg","post"))
	dim small_img:small_img=ReplaceSymbols(getForm("small_img","post"))
	dim m_p_max_wh:m_p_max_wh=ReplaceSymbols(getForm("m_p_max_wh","post"))
	dim m_ord:m_ord=getForm("m_ord","post")
	dim vtype:vtype=getForm("type","get")
	dim page:page=getForm("page","get")
	
	dim m_createdate:m_createdate=getForm("m_createdate","post")
	
	dim parentid:parentid=Cint(getForm("parentid","get"))
	
	dim pid:pid=getForm("pid","get")
	dim bid:bid=getForm("bid","get")
	dim tid:tid=getForm("tid","get")
	dim sid:sid=getForm("sid","get")
	dim cid:cid=getForm("cid","get")
	dim uid:uid=getForm("uid","get")
	
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
			m_bid = parentid
			m_tid = m_type
			m_sid = m_type
		else
			m_bid = conn.db("select ParentID from {pre}Navigation where Id="&parentid&"","execute")(0)
			oldm_bid = m_bid
			
			if m_bid = parentid  then
				m_bid = m_tid
				m_tid = parentid
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
	dim m_isHot
	if getForm("IsHot","post") = "yes" then
		m_isHot=1
	else
		m_isHot=0
	end if
	
	dim m_isShow
	if getForm("IsShow","post") = "yes" then
		m_isShow=1
	else
		m_isShow=0
	end if
	
	dim m_isShowen
	if getForm("IsShowen","post") = "yes" then
		m_isShowen=1
	else
		m_isShowen=0
	end if
	
	dim m_isShowjp
	if getForm("IsShowjp","post") = "yes" then
		m_isShowjp=1
	else
		m_isShowjp=0
	end if
	

	dim m_p_description:m_p_description=ReplaceSymbols(getForm("m_p_description","post"))
	dim m_p_descriptionen:m_p_descriptionen=ReplaceSymbols(getForm("m_p_descriptionen","post"))
	dim m_p_descriptionjp:m_p_descriptionjp=ReplaceSymbols(getForm("m_p_descriptionjp","post"))
	
	dim m_p_introduce:m_p_introduce=ReplaceSymbols(getForm("m_p_introduce","post"))
	dim m_p_introduceen:m_p_introduceen=ReplaceSymbols(getForm("m_p_introduceen","post"))
	
	dim m_p_introduce2:m_p_introduce2=ReplaceSymbols(getForm("m_p_introduce2","post"))
	dim m_p_introduce2en:m_p_introduce2en=ReplaceSymbols(getForm("m_p_introduce2en","post"))
	
	dim m_p_introduce3:m_p_introduce3=ReplaceSymbols(getForm("m_p_introduce3","post"))
	dim m_p_introduce3en:m_p_introduce3en=ReplaceSymbols(getForm("m_p_introduce3en","post"))



	dim P_Title:P_Title =ReplaceSymbols(getForm("PageTitle","post"))
	dim P_Titleen:P_Titleen =ReplaceSymbols(getForm("PageTitleen","post"))
	dim P_Titlejp:P_Titlejp =ReplaceSymbols(getForm("PageTitlejp","post"))
	dim K_Key:K_Key =ReplaceSymbols(getForm("Keywords","post"))
	dim K_Keyen:K_Keyen =ReplaceSymbols(getForm("Keywordsen","post"))
	dim K_Keyjp:K_Keyjp =ReplaceSymbols(getForm("Keywordsjp","post"))
	dim D_Desc:D_Desc =ReplaceSymbols(getForm("Descriptions","post"))
	dim D_Descen:D_Descen =ReplaceSymbols(getForm("Descriptionsen","post"))
	dim D_Descjp:D_Descjp =ReplaceSymbols(getForm("Descriptionsjp","post"))



if getForm("small_img","post")=1 then
PathFieldCreate m_p_img,getForm("m_p_max_wh","post")
else
PathFieldDelete(m_p_img)
end if
	
	if getForm("issy","post") = "yes" then
		if m_p_img <> "" then
		'LocalFile="" & m_p_img

    LocalFile=split(m_p_img,", ")
	for j=0 to ubound(LocalFile)
		Dim Jpeg 
		Set Jpeg = Server.CreateObject("Persits.Jpeg") 
		If -2147221005=Err then 
		Response.write "没有这个组件，请安装!" '检查是否安装AspJpeg组件 
		Response.End() 
		End If 
		Jpeg.Open Server.MapPath(LocalFile(j)) '打开图片 
		If err.number then 
		Response.write"打开图片失败,请检查路径！" 
		Response.End() 
		End if 

		Dim aa 
		aa=Jpeg.Binary '将原始数据赋给aa 
		'=========加文字水印================= 
		Jpeg.Canvas.Font.Color = &Hffffff '水印文字颜色 
		Jpeg.Canvas.Font.Family = "Arial" '字体 
		Jpeg.Canvas.Font.Bold = True '是否加粗 
		Jpeg.Canvas.Font.Size = 30 '字体大小 
		Jpeg.Canvas.Font.ShadowColor = &H000000 '阴影色彩 
		Jpeg.Canvas.Font.ShadowYOffset = 1 
		Jpeg.Canvas.Font.ShadowXOffset = 1 
		Jpeg.Canvas.Brush.Solid = True 
		Jpeg.Canvas.Font.Quality = 4 ' '输出质量 
		Jpeg.Canvas.PrintText Jpeg.OriginalWidth/2-90,Jpeg.OriginalHeight/2-10,"www.mcoti.com" '水印位置及文字 
		bb=Jpeg.Binary '将文字水印处理后的值赋给bb，这时，文字水印没有不透明度 
		'============调整文字透明度================ 
		Set MyJpeg = Server.CreateObject("Persits.Jpeg") 
		MyJpeg.OpenBinary aa 
		Set Logo = Server.CreateObject("Persits.Jpeg") 
		Logo.OpenBinary bb 
		MyJpeg.DrawImage 0,0, Logo, 0.5 '0.3是透明度 
		cc=MyJpeg.Binary '将最终结果赋值给cc,这时也可以生成目标图片了 
		'response.BinaryWrite cc '将二进输出给浏览器 
		MyJpeg.Save Server.MapPath(LocalFile(j)) 
		set aa=nothing 
		set bb=nothing 
		set cc=nothing 
		Jpeg.close 
		MyJpeg.Close 
		Logo.Close
	next
		end if

	end if
	
	select case  actType
		case "edit"
			dim m_id:m_id=clng(getForm("m_id","post"))
			updateSql = "p_name='"&m_name&"',p_nameen='"&m_nameen&"',p_namejp='"&m_namejp&"',p_ID='"&m_pid&"',p_size='"&m_p_size&"',p_sizeen='"&m_p_sizeen&"',p_links='"&m_p_links&"',p_linksen='"&m_p_linksen&"',p_model='"&m_p_model&"',p_modelen='"&m_p_modelen&"',p_spec='"&m_p_spec&"',p_specen='"&m_p_specen&"',p_type='"&m_p_type&"',p_typeen='"&m_p_typeen&"',p_material='"&m_p_material&"',p_class='"&m_p_class&"',p_classen='"&m_p_classen&"',p_materialen='"&m_p_materialen&"',p_features='"&m_p_features&"',p_featuresen='"&m_p_featuresen&"',p_number='"&m_p_number&"',p_numberen='"&m_p_numberen&"',p_smallimg='"&m_p_smallimg&"',p_img='"&m_p_img&"',p_imgen='"&m_p_imgen&"',p_enantiomers='"&m_p_enantiomers&"',p_colorimg='"&m_p_colorimg&"',p_colorimgen='"&m_p_colorimgen&"',p_filepath='"& m_p_filepath &"',p_filepathen='"& m_p_filepathen &"',p_price='"&m_p_price&"',p_priceen='"&m_p_priceen&"',p_collection='"&m_p_collection&"',p_collectionen='"&m_p_collectionen&"',p_priceRange='"&m_p_priceRange&"',p_priceRangeen='"&m_p_priceRangeen&"',[p_introduce]='"&m_p_introduce&"',[p_introduceen]='"&m_p_introduceen&"',[p_description]='"&m_p_description&"',[p_descriptionen]='"&m_p_descriptionen&"',[p_descriptionjp]='"&m_p_descriptionjp&"',[p_introduce2]='"&m_p_introduce2&"',[p_introduce2en]='"&m_p_introduce2en&"',[p_introduce3]='"&m_p_introduce3&"',[p_introduce3en]='"&m_p_introduce3en&"',PageTitle='"&P_Title&"',PageTitleen='"&P_Titleen&"',PageTitlejp='"&P_Titlejp&"',Keywords='"&K_Key&"',Keywordsen='"&K_Keyen&"',Keywordsjp='"&K_Keyjp&"',Descriptions='"&D_Desc&"',Descriptionsen='"&D_Descen&"',Descriptionsjp='"&D_Descjp&"',Bid="&m_bid&",Tid="&m_tid&",Sid="&m_sid&",SortID="&m_type&",Ord="&m_ord&",IsNew="&m_isnew&",IsHot="&m_ishot&",IsShow="&m_isShow&",IsShowen="&m_isShowen&",IsShowjp="&m_isShowjp&",CreateDate='"&m_createdate&"',small_img="&small_img&",p_max_wh='"&m_p_max_wh&"'"
			updateSql = "update {pre}Product set "&updateSql&" where ID="&m_id
			conn.db  updateSql,"execute"
			alertMsg "",m_back
		case "add" 
			insertSql = "insert into {pre}Product(p_name,p_nameen,p_namejp,p_ID,p_size,p_sizeen,p_links,p_linksen,p_model,p_modelen,p_spec,p_specen,p_type,p_typeen,p_material,p_class,p_classen,p_materialen,p_features,p_featuresen,p_number,p_numberen,p_smallimg,p_img,p_imgen,p_enantiomers,p_colorimg,p_colorimgen,p_filepath,p_filepathen,p_price,p_priceen,p_collection,p_collectionen,p_priceRange,p_priceRangeen,[p_introduce],[p_introduceen],[p_description],[p_descriptionen],[p_descriptionjp],[p_introduce2],[p_introduce2en],[p_introduce3],[p_introduce3en],[PageTitle],[PageTitleen],[PageTitlejp],[Keywords],[Keywordsen],[Keywordsjp],[Descriptions],[Descriptionsen],[Descriptionsjp],Bid,Tid,Sid,SortID,Ord,IsNew,IsHot,IsShow,IsShowen,IsShowjp,CreateDate,small_img,p_max_wh) values ('"&m_name&"','"&m_nameen&"','"&m_namejp&"','"&m_pid&"','"&m_p_size&"','"&m_p_sizeen&"','"&m_p_links&"','"&m_p_linksen&"','"&m_p_model&"','"&m_p_modelen&"','"&m_p_spec&"','"&m_p_specen&"','"&m_p_type&"','"&m_p_typeen&"','"&m_p_material&"','"&m_p_class&"','"&m_p_classen&"','"&m_p_materialen&"','"&m_p_features&"','"&m_p_featuresen&"','"&m_p_number&"','"&m_p_numberen&"','"&m_p_smallimg&"','"&m_p_img&"','"&m_p_imgen&"','"&m_p_enantiomers&"','"&m_p_colorimg&"','"&m_p_colorimgen&"','"& m_p_filepath &"','"& m_p_filepathen &"','"&m_p_price&"','"&m_p_priceen&"','"&m_p_collection&"','"&m_p_collectionen&"','"&m_p_priceRange&"','"&m_p_priceRangeen&"','"&m_p_introduce&"','"&m_p_introduceen&"','"&m_p_description&"','"&m_p_descriptionen&"','"&m_p_descriptionjp&"','"&m_p_introduce2&"','"&m_p_introduce2en&"','"&m_p_introduce3&"','"&m_p_introduce3en&"','"&P_Title&"','"&P_Titleen&"','"&P_Titlejp&"','"&K_Key&"','"&K_Keyen&"','"&K_Keyjp&"','"&D_Desc&"','"&D_Descen&"','"&D_Descjp&"',"&m_bid&","&m_tid&","&m_sid&","&m_type&","&m_ord&","&m_isnew&","&m_ishot&","&m_isShow&","&m_isShowen&","&m_isShowjp&",'"&m_createdate&"',"&small_img&",'"&m_p_max_wh&"')"
			conn.db  insertSql,"execute" 
			selectMsg "添加成功,是否继续添加","?action=add&parentid="&parentid&"&pid="&pid&"&bid="&bid&"&tid="&tid&"&sid="&sid&"&cid="&cid&"&uid="&uid,"?parentid="&parentid&"&pid="&pid&"&bid="&bid&"&tid="&tid&"&sid="&sid&"&cid="&cid&"&uid="&uid
	end select
End Sub

Sub delProduct
	dim id,back,vtypeAndPic,vpic
	back = request.ServerVariables("HTTP_REFERER")
	id = getForm("id","get")
	on error resume next
	vtypeAndPic=conn.db("select p_smallimg from {pre}Product where ID="&id,"array")
	vpic=vtypeAndPic(0,0)
	if len(vpic)>0 then  delFile "../"&vpic
	conn.db  "delete from {pre}Product where id="&id,"execute"
	if err  then err.clear : die "图片已经删除,但删除静态文件或图片时发生错误，请手动删除相关文件" else  alertMsg "",back
End Sub

Sub UpdateOrder
	Dim ids			:	ids=split(getForm("m_id","post"),",")
	Dim orders		:	orders=split(getForm("order","post"),",")
	
	Dim i
	
	For i=0 To Ubound(ids)	
		updateSql = "update {pre}Product Set ord="&trim(orders(i))&" Where ID="&trim(ids(i))	
		conn.db updateSql,"execute" 	
	Next
	
	parentid = getForm("parentid","get")
	pid=getForm("pid","get")
	bid=getForm("bid","get")
	tid=getForm("tid","get")
	sid=getForm("sid","get")
	cid=getForm("cid","get")
	uid=getForm("uid","get")
	
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")
	
	alertMsg "更新排序成功","?page="&page&"&order="&order&"&parentid="&parentid&"&pid="&pid&"&bid="&bid&"&tid="&tid&"&sid="&sid&"&cid="&cid&"&uid="&uid&"&keyword="&keyword
End Sub

Sub delAll
	dim ids,idsLen,i
	ids = replaceStr(getForm("m_id","post")," ","")
	if ids<>"" Then
	conn.db  "delete from {pre}Product where id in("&ids&")","execute" 
	end if
	parentid = getForm("parentid","get")
	pid=getForm("pid","get")
	bid=getForm("bid","get")
	tid=getForm("tid","get")
	sid=getForm("sid","get")
	cid=getForm("cid","get")
	uid=getForm("uid","get")
	
	keyword=getForm("keyword","get")
	page=getForm("page","get")
	order=getForm("order","get")
	
	alertMsg "","?page="&page&"&order="&order&"&parentid="&parentid&"&pid="&pid&"&bid="&bid&"&tid="&tid&"&sid="&sid&"&cid="&cid&"&uid="&uid&"&keyword="&keyword
End Sub

sub Otherselect(pm,nowvalue)
set rsa=conn.db("select * from {pre}Navigation where id="&pm&" ","records1")
if rsa.recordcount>0 then
set rs=conn.db("select * from {pre}News where SortID in("&rsa("ChildPath")&") and isShowen=true   order by Ord asc,id desc","records1")
if rs.eof or rs.bof then
else
do while not rs.eof
if ""&rs("id")&""=""&nowvalue&"" then
sel=" selected='selected'"
else
sel=""
end if
echo"<option value='"&rs("id")&"' "&sel&">"&rs("NewsName")&"</option>"
rs.movenext
loop
end if
rs.close : set rs=nothing
end if
rsa.close : set rsa=nothing
end sub
%>
