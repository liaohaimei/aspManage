<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<title>后台管理</title>
<script src="scripts/jquery.min.js"></script>
<script type="text/javascript" src="scripts/jqueryedit.js"></script>
<script language="javascript" type="text/javascript" src="scripts/WdatePicker.js"></script>
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
				<h1>后台首页» 幻灯片</h1>
				</div>
			<div class="bottom_nav"><span></span></div>
			<div class="h6"></div>
			<div class="top_nav"><span></span></div>
<div class="nav_content">
<div class="nav_tools"><span class="add"><a href="?editaction=EditUI&amp;typeUI=add">添加</a></span><span class="delete"><a href="javascript:document.datalist.action='?action=DeleteCheckedAll';document.datalist.submit();" onClick="return confirm('确定要删除选中数据')">批量删除</a></span><span class="nav_tools_right"></span></div>
</div>
			
            <div class="add_data">
<%
dim editaction : editaction = getForm("editaction", "get")
select case editaction
	case "EditUI" :EditUI
end select
dim action : action = getForm("action", "get")
dim vtype,order
Select  case action
	case "SaveData" : SaveData
	case "DeleteData" : DeleteData(getForm("id", "get"))
	case "DeleteCheckedAll" : DeleteCheckedAll
	case "UpdateOrder" : UpdateOrder
	case else ReadData
End Select 

%>            
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

'保存数据
Sub SaveData
	dim actType : actType = getForm("acttype","get")
	dim updateSql,insertSql
	dim Lan_name:Lan_name=ReplaceSymbols(getForm("Lan_name","post"))
	dim Lan_id:Lan_id=ReplaceSymbols(getForm("Lan_id","post"))
	dim Lan_order:Lan_order=ReplaceSymbols(getForm("Lan_order","post"))
	dim Lan_enable:Lan_enable=ReplaceSymbols(getForm("Lan_enable","post"))
	dim CreateDate:CreateDate=getForm("CreateDate","post")

	select case actType
	case "add"
	if isNul(Lan_order) or not isNumeric(Lan_order) then
	response.write"<script>alert('排序请勿填写非数字或空值！');history.back();</script>"
	exit sub
	end if
	insertSql = "insert into {pre}Language(Lan_name,Lan_id,Lan_enable,Lan_order,CreateDate) values ('"&Lan_name&"','"&Lan_id&"',"&Lan_enable&","&Lan_order&",'"&CreateDate&"')"
	'die insertsql
	conn.db  insertSql,"execute" 
	selectMsg "添加成功,是否继续添加","?editaction=EditUI&typeUI=add","?"

	case "edit"
	dim id:id=getForm("id","get")
	if isNul(Lan_order) or not isNumeric(Lan_order) then
	response.write"<script>alert('排序请勿填写非数字或空值！');history.back();</script>"
	exit sub
	end if
	updateSql = "Lan_name='"&Lan_name&"',Lan_id='"&Lan_id&"',Lan_order="&Lan_order&",Lan_enable="&Lan_enable&",CreateDate='"&CreateDate&"'"
	updateSql = "update {pre}Language set "&updateSql&" where ID="&id
	'die updateSql
	conn.db  updateSql,"execute"
	BackRefresh
	'selectMsg "修改成功","?action=SaveData&actType=edit&id="&id&"","?"
	end select
End Sub


'删除数据
sub DeleteData(id)
conn.db  "delete from {pre}Language where id="&id,"execute"
ReadData
end sub

'删除选中数据
sub DeleteCheckedAll
dim checkbox:checkbox=getForm("checkbox","get")
conn.db  "delete from {pre}Language where id in("&checkbox&")","execute"
ReadData
end sub


'编辑界面
sub EditUI
dim typeUI : typeUI = getForm("typeUI","get")
select case typeUI
case "add"
id=""
Lan_name=""
Lan_id=""
Lan_order=""
CreateDate=""
Lan_enable=1

case "edit"
paramet=getForm("id","get")
if paramet<>"" then
set rsObj=conn.db("select * from {pre}Language where ID="&paramet&" order by Lan_order asc,id desc","records1")
if rsObj.eof or rsObj.bof then
else
id=rsObj("id")
Lan_name=rsObj("Lan_name")
Lan_id=rsObj("Lan_id")
Lan_order=rsObj("Lan_order")
CreateDate=rsObj("CreateDate")
Lan_enable=rsObj("Lan_enable")
end if
rsObj.close : set rsObj=nothing
end if
end select

action="SaveData"
actType=getForm("typeUI","get")
posturl="?action="&action&""
if actType<>"" then
posturl=posturl&"&actType="&actType&""
end if
if paramet<>"" then
posturl=posturl&"&id="&paramet&""
end if

%>
              <form id="dataedit" name="dataedit" method="post" action="<%=posturl%>">
              <table width="100%" border="0" align="center" cellspacing="1" bgcolor="#CCCCCC">
                <tr>
                  <td width="20%" height="25" bgcolor="#FFFFFF">&nbsp;</td>
                  <td width="80%" height="25" bgcolor="#FFFFFF"></td>
                </tr>
                <tr>
                  <td height="25" align="right" valign="middle" bgcolor="#FFFFFF">语言名称：</td>
                  <td height="25" bgcolor="#FFFFFF"><label for="Lan_name"></label>
                  <input type="text" name="Lan_name" id="Lan_name" value="<%=Lan_name%>" /></td>
                </tr>
                <tr>
                  <td height="25" align="right" valign="middle" bgcolor="#FFFFFF">语言标识：</td>
                  <td height="25" bgcolor="#FFFFFF"><label for="Lan_id"></label>
                  <input type="text" name="Lan_id" id="Lan_id"  value="<%=Lan_id%>"/></td>
                </tr>
                <tr>
                  <td height="25" align="right" valign="middle" bgcolor="#FFFFFF">是否启用：</td>
                  <td height="25" bgcolor="#FFFFFF"><input name="Lan_enable" type="radio" id="radio" value="1" <%if Lan_enable=1 then%> checked="checked" <%end if%>/>
                  <label for="Lan_enable"></label>                    <label for="checkbox">是
                    <input type="radio" name="Lan_enable" id="radio2" value="0" <%if Lan_enable=0 then%> checked="checked" <%end if%>/>
                  否</label></td>
                </tr>
                <tr>
                  <td height="25" align="right" valign="middle" bgcolor="#FFFFFF">排序：</td>
                  <td height="25" bgcolor="#FFFFFF"><label for="Lan_order"></label>
                  <input type="text" name="Lan_order" id="Lan_order"  value="<%=Lan_order%>"/></td>
                </tr>
                <tr>
                  <td height="25" align="right" valign="middle" bgcolor="#FFFFFF">添加日期：</td>
                  <td height="25" bgcolor="#FFFFFF"><input id="CreateDate" name="CreateDate" size="30" value="<%if CreateDate<>"" then%> <%=CreateDate%> <%else%> <%=Date()%> <%end if%>" class="Wdate" onclick="WdatePicker()" /></td>
                </tr>
                <tr>
                  <td height="25" align="right" valign="middle" bgcolor="#FFFFFF">&nbsp;</td>
                  <td height="25" bgcolor="#FFFFFF"><input type="submit" name="button" id="button" value="保存" />
                  <input type="reset" name="button2" id="button2" value="取消" /></td>
                </tr>
              </table>
              </form>
<%end sub%>

<%
'Get提交的参数管理
sub GetParametersManager

	if getForm("Page","get")<>"" then
	page=getForm("Page","get")
	echo"<input type='hidden' name='Page' id='Page' value='"&page&"' />"
	end if

	if getForm("Lan_name","get")<>"" then
	Lan_name=getForm("Lan_name","get")
	echo"<input type='hidden' name='Lan_name' id='Lan_name' value='"&Lan_name&"' />"
	end if

end sub

sub GetParametersManager_page

	if getForm("Page","get")<>"" then
	page=getForm("Page","get")
	echo"<input type='hidden' name='Page' id='Page' value='"&page&"' />"
	end if

end sub

%>

<%
sub ReadData
%>
<form  id="datasearch" name="datasearch" action="?" method="get">
<%GetParametersManager_page%>
<select name="searchtype">
<option>--请选择筛选字段--</option>
<%
set rs=conn.db("select * from wspcms_Language","records1")
For i=0 To rs.fields.count-1 
fieldname=rs.fields(i).name
fieldtype=rs.fields(i).type
echo"<option  value='"&fieldtype&"' data-id='"&fieldname&"'>"&fieldname&"</option>"
Next 
rs.close
set rs=nothing
%>
</select>
<input name="" type="submit" value="查询" />
</form>

<form id="datalist" name="datalist" method="get" action="?action=DeleteCheckedAll">
<input type="hidden" name="action" id="action" value="DeleteCheckedAll" />
<%GetParametersManager%>
<table width="100%" border="0" align="center" cellspacing="1" bgcolor="#CCCCCC" id="MyTable">
          <tr>
                <td height="30" width="50" align="center" valign="middle" bgcolor="#666666">
 <a href="javascript:;" id="cb_all" style="color:#FFFFFF;">全部选择</a>
 <a href="javascript:;" id="cb_cancelAll" style="color:#FFFFFF;">取消选择</a>
 <a href="javascript:;" id="cb_antiAll" style="color:#FFFFFF;">反向选择</a></td>
                <td height="30" width="50" align="center" valign="middle" bgcolor="#666666">id</td>
                <td height="30" width="200" align="center" valign="middle" bgcolor="#666666">语言名称</td>
                <td height="30" width="200" align="center" valign="middle" bgcolor="#666666">语言标识</td>
                <td height="30" width="200" align="center" valign="middle" bgcolor="#666666">排序</td>
                <td height="30" width="200" align="center" valign="middle" bgcolor="#666666">添加时间</td>
                <td height="30" width="100" align="center" valign="middle" bgcolor="#666666">是否启用</td>
                <td height="30" align="center" valign="middle" bgcolor="#666666">操作</td>
              </tr>
<%
page=getForm("Page","get")
if getForm("Page","get")<>"" then
pages="&Page="&page&""
end if
sql="select * from {pre}Language where 1=1 "
Lan_name=getForm("Lan_name","get")
if Lan_name<>"" then
sql=sql&" and Lan_name like '%"&Lan_name&"%'"
end if
Lan_id=getForm("Lan_id","get")
if Lan_id<>"" then
sql=sql&" and Lan_id like '%"&Lan_id&"%'"
end if

set rsObj=conn.db(""&sql&" order by Lan_order asc,id desc","records1")
if rsObj.eof or rsObj.bof then
else
  int_RPP=5
	int_showNumberLink_=5 
	showMorePageGo_Type_ = 1 
	str_nonLinkColor_="#999999" 
	toF_="首页"   		
	toP10_="&lt;&lt;"		
	toP1_=" 上一页"		
	toN1_=" 下一页"			
	toN10_="&gt;&gt;"			
	toL_="尾页"				
	rsObj.PageSize=int_RPP
	cPageNo=request("Page")
	If cPageNo="" or not isnumeric(cPageNo) Then cPageNo = 1
	cPageNo = Clng(cPageNo)
	If cPageNo<1 Then cPageNo=1
	If cPageNo>rsObj.PageCount Then cPageNo=rsObj.PageCount 
	rsObj.AbsolutePage=cPageNo
count=0
do while not (rsObj.eof or rsObj.bof) and count<rsObj.PageSize
 %>             
              <tr>
                <td height="25" align="center" valign="middle" bgcolor="#FFFFFF"><input type="checkbox" name="checkbox" id="checkbox" value="<%=rsObj("id")%>"/></td>
                <td height="25" align="center" valign="middle" bgcolor="#FFFFFF" axis="id"><%=rsObj("id")%></td>
                <td height="25" bgcolor="#FFFFFF" class="caname" id="Lan_name"><%=rsObj("Lan_name")%></td>
                <td height="25" align="center" valign="middle" bgcolor="#FFFFFF" class="caname" id="Lan_id" axis="text"><%=rsObj("Lan_id")%></td>
                <td height="25" align="center" valign="middle" bgcolor="#FFFFFF" class="caname" id="Lan_order" axis="number"><%=rsObj("Lan_order")%></td>
                <td height="25" align="center" valign="middle" bgcolor="#FFFFFF" class="caname" id="CreateDate" axis="date"><%=rsObj("CreateDate")%></td>
                <td height="25" align="center" valign="middle" bgcolor="#FFFFFF" class="sel" id="Lan_enable" axis="number">
<select name="Lan_enable" id="Lan_enable">
  <option value="1" <%if rsObj("Lan_enable")=1 then echo"selected='selected'" end if%>>已启用</option>
  <option value="0" <%if rsObj("Lan_enable")=0 then echo"selected='selected'" end if%>>未启用</option>
</select></td>
                <td height="25" align="center" valign="middle" bgcolor="#FFFFFF"><a href="?editaction=EditUI&amp;typeUI=edit&amp;id=<%=rsObj("id")%><%=pages%>">修改</a>&nbsp;|&nbsp;<a href="?action=DeleteData&amp;id=<%=rsObj("id")%><%=pages%>" onClick="return confirm('确定要删除吗')">删除</a></td>
              </tr>
              
<%rsObj.movenext
  count=count+1
loop
end if
response.Write( fPageCount(rsObj,int_showNumberLink_,str_nonLinkColor_,toF_,toP10_,toP1_,toN1_,toN10_,toL_,showMorePageGo_Type_,cPageNo)  & vbcrlf )
rsObj.close : set rsObj=nothing
%>
            </table>

</form>

<%
end sub

'获取Access数据库的字段类型
Function AccessTypeName(num) 
    str=""
    Select Case num
        Case 3
            str = "自动编号/数字"
        Case 6
            str = "货币"
        Case 7
            str = "日期/时间"
        Case 11
            str = "是/否"
        Case 202
            str = "文本"
        Case 203
            str = "备注/超链接"
        Case 205
            str = "OLE对象"
        End Select
	AccessTypeName=str
End Function

set rs=conn.db("select * from wspcms_Language","records1")
response.write "字段名:" 
For i=0 To rs.fields.count-1 
fieldname=rs.fields(i).name
response.write fieldname &"&nbsp;:&nbsp;"
fieldtype=rs.fields(i).type
'response.write fieldtype 
response.write AccessTypeName(fieldtype)&"&nbsp;,&nbsp;"
Next 
rs.close
set rs=nothing


'set rs=server.CreateObject("adodb.recordset") 
'db="/wspcmsdata/wspcmsdata.mdb" 
'set conn=server.CreateObject("adodb.connection") 
'connstr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath(db) 
'conn.open connstr 
'Set rs=Conn.OpenSchema(20) 

'Set rs2=server.CreateObject("adodb.recordset") 
'sql="select * from wspcms_Language"
'Set rs2=conn.execute(sql) 
'response.write "字段名:" 
'For i=0 To rs2.fields.count-1 
'response.write rs2.fields(i).name&" " 
'Next 


'Do Until rs.EOF 
'If rs(3)="TABLE" Then 
'response.write "表名:"&rs(2)&"<br />" 
'Set rs1=server.CreateObject("adodb.recordset") 
'sql="select * from "&rs(2) 
'Set rs1=conn.execute(sql) 
'response.write "字段名:" 
'For i=0 To rs1.fields.count-1 
'response.write rs1.fields(i).name&" " 
'Next 
'response.write "<br />" 
'Do While Not rs1.eof 
'response.write " " 
'For i=0 To rs1.fields.count-1 
't=rs1.fields(i).name 
''response.write rs1(t)&" " 
'Next 
'response.write " " 
'rs1.movenext 
'Loop 
'response.write " " 
'End If 
'rs.MoveNext 
'Loop 
'Set rs2=Nothing 
'Set conn=nothing 
 
%>
