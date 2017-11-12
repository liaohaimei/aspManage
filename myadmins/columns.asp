<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<title>后台管理</title>
<script src="scripts/jquery.min.js"></script>
<script src="scripts/jquery.cookie.js"></script>
<script src="scripts/ord.js" type="text/javascript"></script>
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
							imageUrl : K('#m_class_pic').val(),
							clickFn : function(url, title, width, height, border, align) {
								K('#m_class_pic').val(url);
								editor.hideDialog();
							}
						});
					});
				});
				K('#image2').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							imageUrl : K('#m_Class_Picen').val(),
							clickFn : function(url, title, width, height, border, align) {
								K('#m_Class_Picen').val(url);
								editor.hideDialog();
							}
						});
					});
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
			<div class="top_nav"></div>
				<div class="nav_content" style="line-height:18px;">
				<h1>后台首页 » 栏目设置</h1>
				</div>
			<div class="bottom_nav"></div>
			<div class="h6"></div>
			<div class="top_nav"></div>
				<div class="nav_content">
				<div class="h7"></div>
<%
dim action : action = getForm("action", "get")

Select  case action
	case "del" : delColumnType
	case "delall" : delAll
	case "edit" : editColumnType
	case "hide" : hideColumnType
	case "nohide" : nohideColumnType
	case "hideen" : hideColumnTypeen
	case "nohideen" : nohideColumnTypeen
	case "hidejp" : hideColumnTypejp
	case "nohidejp" : nohideColumnTypejp
	case "add" : addColumnType
	case "addcolumn" : addColumn
	case "editcolumn" : editColumn
	case "editsave" : editSave
	case else : main
End Select

dim i,n : n=0
Sub main
%>
<form method="post"  name="editform" id="editform">
				<div class="nav_tools"><span class="add"><a href="?action=addcolumn">添加</a></span><span class="edit"><a href="javascript:document.editform.action='?action=edit';document.editform.submit();">批量修改</a></span><span class="nav_tools_right"></span></div>
<div class="table">
<table width="100%" cellpadding="0" cellspacing="0">
  <tr>
    <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;text-indent:10px;border-right:solid #e5e5e5 1px; border-left:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle">栏目列表</td>
  </tr>
  <tr>
    <td align="left">
	<table width="100%" cellpadding="0" cellspacing="0">
        <tbody>
          <tr bgcolor="#e5e5e5">
            <td width="66%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px; border-left:solid #bbbbbb 1px;">
			<table width="100%" cellpadding="0" cellspacing="0">
              <tbody>
                <tr>
					<td align="left">&nbsp;<input type="checkbox" name="chkall" id="chkall" onclick="checkAll(this.checked,'input','m_id')" />&nbsp;栏目名称</td>
                </tr>
              </tbody>
            </table></td>
            <td width="10%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">
			<table width="120" cellpadding="0" cellspacing="0">
			  <tbody>
				<tr>
				  <td align="center">所属频道</td>
				</tr>
			  </tbody>
			</table>
			</td>
            <td width="8%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">
			<table width="60" cellpadding="0" cellspacing="0">
			  <tbody>
				<tr>
				  <td align="center">排序</td>
				</tr>
			  </tbody>
			</table></td>
            <td width="7%" align="center" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">状态</td>
            <td width="9%" align="center" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">操作</td>
          </tr>
		  <%typeList(0)%>
		  </tbody>
      </table>
	</td>
  </tr>
  <tr>
    <td align="left" bgcolor="#e5e5e5" style="border:solid #bbbbbb 1px;">&nbsp;</td>
  </tr>
</table>
</div>

<div class="nav_tools leftbottom"><span class="add"><a href="?action=addcolumn">添加</a></span><span class="edit"><a href="javascript:document.editform.action='?action=edit';document.editform.submit();">批量修改</a></span><span class="nav_tools_right rightbottom"></span></div>
</form>
<%
End Sub


Sub addColumn
%>
<script type="text/JavaScript">
function InsertPoorSee(){
	randomid = Math.round(Math.random()*10000);
	document.getElementById("PoorSeeList").innerHTML += "<table width='100%' border='0' cellpadding='0' cellspacing='0'>\
	<tr>\
    	<td>&nbsp;<input name='m_PoorSee' id='m_PoorSee"+ randomid +"' type='text' size='20' value=''>\
		<a href='javascript:void(0)' onClick='this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode);'>\
	<img src='Images/del.gif' width='45' height='19' border='0'></a>\
		</td>\
    </tr>\
	</table>";
}


function InsertPoorSeeen(){
	randomid = Math.round(Math.random()*10000);
	document.getElementById("PoorSeeListen").innerHTML += "<table width='100%' border='0' cellpadding='0' cellspacing='0'>\
	<tr>\
    	<td>&nbsp;<input name='m_PoorSeeen' id='m_PoorSeeen"+ randomid +"' type='text' size='20' value=''>\
		<a href='javascript:void(0)' onClick='this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode);'>\
	<img src='Images/del.gif' width='45' height='19' border='0'></a>\
		</td>\
    </tr>\
	</table>";
}

</script>

<form action="?action=add" method="post"  name="addform" id="addform" onsubmit="return validateform()">
				<div class="nav_tools"><span class="save"><a href="javascript:ColumnsAdd();">保存</a></span><span class="back"><a href="columns.asp">返回</a></span><span class="nav_tools_right"></span></div>
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
            <td width="9%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px; border-left:solid #bbbbbb 1px;">&nbsp;

			</td>
            <td colspan="2" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;</td>
          </tr>
          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">名称(CN):</td>
                </tr>
            </table></td>
            <td width="61%" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <input type="text" size="38" name="NavName" />
            <font color='red'>＊</font> 别名(CN)：
            <input name="ClassName" type="text" id="ClassName" size="25" />
            不填则为栏目名称</td>
            <td width="30%" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; display:none;">新链接 (CN)：
              <input name="ClassUrl" type="text" id="ClassUrl" size="25" />
              <select name="target" id="target">
                <option value="_self">本窗口</option>
                <option value="_blank">新窗口</option>
              </select></td>
          </tr>

          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">名称(EN):</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <input type="text" size="38" name="NavNameen" />
            <font color='red'>＊</font>
            别名(EN)：
            <input name="ClassNameen" type="text" id="ClassNameen" size="25" />
            不填则为栏目名称</td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; display:none;">新链接 (EN)：
              <input name="ClassUrlen" type="text" id="ClassUrlen" size="25" />
              <select name="targeten" id="targeten">
                <option value="_self">本窗口</option>
                <option value="_blank">新窗口</option>
              </select></td>
          </tr>

          <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">名称(JP):</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <input type="text" size="38" name="NavNamejp" />
            <font color='red'>＊</font>
            别名(J P)：
            <input name="ClassNamejp" type="text" id="ClassNamejp" size="25" />
            不填则为栏目名称</td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">新链接 (J P)：
              <input name="ClassUrljp" type="text" id="ClassUrljp" size="25" />
              </td>
          </tr>

          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">所属栏目:</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			<select name="ParentID" onchange="cheak_colume(this.value)">
			<option value="0">顶级栏目</option>
			<%makeTypePOption(0),"&nbsp;|&nbsp;&nbsp;",0%>
			</select><font color='red'>＊</font>
            </td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">所属频道:</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			<select name="WebType" id="WebType">
			<option value="">请选择频道</option>
			  <%options(0)%>
			</select><font color='red'>＊</font>
            </td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">栏目图片(CN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <textarea name="m_class_pic"  type="text" id="m_class_pic" /></textarea> <input type="button" id="image1" value="选择图片" />
            </td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">栏目图片(EN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="m_Class_Picen"  type="text" id="m_Class_Picen" /></textarea> <input type="button" id="image2" value="选择图片" />
            </td>
          </tr>


		  <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">产品查看方式:</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<input name="m_PoorSee" id="m_PoorSee" type="text" size="20" value="">
		<div id="PoorSeeList"></div>
		&nbsp;<input type="button" name="PoorSee" value="添加方式" onclick="InsertPoorSee()" />
            </td>
          </tr>


		  <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">产品查看方式(EN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			&nbsp;<input name="m_PoorSeeen" id="m_PoorSeeen" type="text" size="20" value="">
		<div id="PoorSeeListen"></div>
		&nbsp;<input type="button" name="PoorSee" value="添加方式" onclick="InsertPoorSeeen()" />
            </td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">说明(CN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <textarea  name="Intro" id="Intro" style="width:98%;height:100px;"></textarea>
            </td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">说明(EN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <textarea  name="Introen" id="Introen" style="width:98%;height:100px;"></textarea>
            </td>
          </tr>


		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">栏目介绍(CN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <!--<textarea name="Introduction" cols="100" rows="5"></textarea>-->
            <textarea class="content" name="Introduction" id="Introduction" style="width:100%;height:300px;visibility:hidden;"></textarea>
            </td>
          </tr>

          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">栏目介绍(EN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
           <!-- <textarea name="Introductionen" cols="100" rows="5"></textarea>-->
             <textarea class="content1" name="Introductionen" id="Introductionen" style="width:100%;height:300px;visibility:hidden;"></textarea>
            </td>
          </tr>

          <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">栏目介绍(JP):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
           <!-- <textarea name="Introductionen" cols="100" rows="5"></textarea>-->
             <textarea class="content2" name="Introductionjp" id="Introductionjp" style="width:100%;height:300px;visibility:hidden;"></textarea>
            </td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">排序:</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			<input size="6" type="text" name="Sequence" /><font color='red'>自动请为空</font>
            </td>
          </tr>


		  <tr>
		    <td colspan="3" align="left" style="border-top:solid #dddddd 1px;"><span style="font-size:14px; font-weight:bold; color:green; padding-left:10px;">SEO优化</span></td>
		    </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">页面标题(CN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <input type="text" size="90" name="PageTitle" />
            <font color='red'>＊</font>
            </td>
          </tr>

          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">页面标题(EN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <input type="text" size="90" name="PageTitleen" />
            <font color='red'>＊</font>
            </td>
          </tr>

          <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">页面标题(JP):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <input type="text" size="90" name="PageTitlejp" />
            <font color='red'>＊</font>
            </td>
          </tr>

          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">关键词(CN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Keywords" cols="100" rows="3"></textarea></td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">关键词(EN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Keywordsen" cols="100" rows="3"></textarea></td>
          </tr>

		  <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">关键词(JP):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Keywordsjp" cols="100" rows="3"></textarea></td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">描述(CN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <textarea name="Descriptions" cols="100" rows="5"></textarea></td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">描述(EN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <textarea name="Descriptionsen" cols="100" rows="5"></textarea></td>
          </tr>

		  <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">描述(JP):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <textarea name="Descriptionsjp" cols="100" rows="5"></textarea></td>
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

<div class="nav_tools leftbottom"><span class="save"><a href="javascript:ColumnsAdd();">保存</a></span><span class="back"><a href="columns.asp">返回</a></span><span class="nav_tools_right rightbottom"></span></div>
</form>
<%
End Sub

Sub editColumn
	dim id,sqlStr,rsObj,m_color,playArray,downArray,playTypeCount,downTypeCount,i,j,m,n
	id=clng(getForm("m_id","get"))
	sqlStr = "select *  from {pre}Navigation where ID="&id
	set rsObj = conn.db(sqlStr,"records1")
	if rsObj.eof then die "没找到记录"
%>
<script type="text/JavaScript">
function InsertPoorSee(){
	randomid = Math.round(Math.random()*10000);
	document.getElementById("PoorSeeLists").innerHTML += "<table width='100%' border='0' cellpadding='0' cellspacing='0'>\
	<tr>\
    	<td>&nbsp;<input name='m_PoorSee' id='m_PoorSee"+ randomid +"' type='text' size='20' value=''>\
		<a href='javascript:void(0)' onClick='this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode);'>\
	<img src='Images/del.gif' width='45' height='19' border='0'></a>\
		</td>\
    </tr>\
	</table>";
}


function InsertPoorSeeen(){
	randomid = Math.round(Math.random()*10000);
	document.getElementById("PoorSeeListsen").innerHTML += "<table width='100%' border='0' cellpadding='0' cellspacing='0'>\
	<tr>\
    	<td>&nbsp;<input name='m_PoorSeeen' id='m_PoorSeeen"+ randomid +"' type='text' size='20' value=''>\
		<a href='javascript:void(0)' onClick='this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode);'>\
	<img src='Images/del.gif' width='45' height='19' border='0'></a>\
		</td>\
    </tr>\
	</table>";
}

</script>



<form action="?action=editsave" method="post"  name="editform" id="editform" onsubmit="return validateform()">
				<div class="nav_tools"><span class="save"><a href="javascript:ColumnsEdit();">保存</a></span><span class="back"><a href="columns.asp">返回</a></span><span class="nav_tools_right"></span></div>
<div class="table">
<table width="100%" cellpadding="0" cellspacing="0">
  <tr>
    <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;text-indent:10px;border-right:solid #e5e5e5 1px; border-left:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle">修改栏目</td>
  </tr>
  <tr>
    <td align="left">
	<table width="100%" cellpadding="0" cellspacing="0" id="RiseList">
        <tbody>
          <tr bgcolor="#e5e5e5">
            <td width="10%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px; border-left:solid #bbbbbb 1px;">&nbsp;

			</td>
            <td colspan="2" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;</td>
          </tr>
          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">名称(CN):</td>
                </tr>
            </table></td>
            <td width="61%" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <input type="text" size="38" name="NavName" value="<%=rsObj("NavName")%>" />
            <font color='red'>＊</font>
            别名(CN)：
            <input name="ClassName" type="text" id="ClassName" size="25"  value="<%=rsObj("ClassName")%>"/>
            不填则为栏目名称</td>
            <td width="29%" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; ">新链接 (CN)：
              <input name="ClassUrl" type="text" id="ClassUrl" value="<%=rsObj("ClassUrl")%>" size="25" />
              <select name="target" id="target">
                <option value="_self" <%if rsObj("target")="_self" then echo"selected='selected'" end if%>>本窗口</option>
                <option value="_blank" <%if rsObj("target")="_blank" then echo"selected='selected'" end if%>>新窗口</option>
              </select></td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">名称(EN):</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <input type="text" size="38" name="NavNameen" value="<%=rsObj("NavNameen")%>" />
            <font color='red'>＊</font>
            别名(EN)：
            <input name="ClassNameen" type="text" id="ClassNameen" size="25"  value="<%=rsObj("ClassNameen")%>"/>
            不填则为栏目名称</td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">新链接 (EN)：
              <input name="ClassUrlen" type="text" id="ClassUrlen" value="<%=rsObj("ClassUrlen")%>" size="25" />
              <select name="targeten" id="targeten">
                <option value="_self" <%if rsObj("targeten")="_self" then echo"selected='selected'" end if%>>本窗口</option>
                <option value="_blank" <%if rsObj("targeten")="_blank" then echo"selected='selected'" end if%>>新窗口</option>
              </select></td>
          </tr>

		  <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">名称(JP):</td>
                </tr>
            </table></td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <input type="text" size="38" name="NavNamejp" value="<%=rsObj("NavNamejp")%>" />
            <font color='red'>＊</font>
            别名(J P)：
            <input name="ClassNamejp" type="text" id="ClassNamejp" size="25"  value="<%=rsObj("ClassNamejp")%>"/>
            不填则为栏目名称</td>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">新链接 (J P)：
              <input name="ClassUrljp" type="text" id="ClassUrljp" value="<%=rsObj("ClassUrljp")%>" size="25" /></td>
          </tr>

          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">所属栏目:</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			<select name="ParentID" onchange="cheak_colume(this.value)" <%if rsObj("ParentID")=0 Then echo "disabled='disabled'"%> >
			<option value="0">顶级栏目</option>
			<%makeTypeOption(0),"&nbsp;|&nbsp;&nbsp;",rsObj("Id")%>
			</select><font color='red'>＊</font>
            </td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">所属频道:</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			<select name="WebType"  >
			<option value='0'>请选择频道</option>
			<%options(rsObj("WebType"))%>
		</select><font color='red'>＊</font>
            </td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">栏目图片(CN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><%if rsObj("Class_pic")<>"" then echo"<img src='"&rsObj("Class_pic")&"' width='100'/>" end if%>
            <textarea name="m_class_pic"  type="text" id="m_class_pic" /><%=rsObj("Class_pic")%></textarea> <input type="button" id="image1" value="选择图片" />
            </td>
          </tr>
		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">栏目图片(EN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><%if rsObj("Class_Picen")<>"" then echo"<img src='"&rsObj("Class_Picen")&"' width='100'/>" end if%>
			<textarea name="m_Class_Picen"  type="text" id="m_Class_Picen" /><%=rsObj("Class_Picen")%></textarea> <input type="button" id="image2" value="选择图片" />
            </td>
          </tr>

<tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">产品查看方式:</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
<%
if rsObj("PoorSee")<>"" then
PoorSee=split(rsObj("PoorSee"),",") '返回数组
for i=lbound(PoorSee) to ubound(PoorSee)	'输出内容
%><table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
    	<td>
			&nbsp;<input name="m_PoorSee" id="m_PoorSee<%=i%>" type="text" size="20" value="<%if rsObj("PoorSee")<>"" then%><%=PoorSee(i)%><%end if%>">
            <a href="javascript:void(0)" onClick="this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode);"><img src="Images/del.gif" width="45" height="19" border="0"></a>
		</td>
	</tr>
</table>
<%
next
end if
%>
		<div id="PoorSeeLists"></div>
		&nbsp;<input type="button" name="PoorSee" value="添加方式" onclick="InsertPoorSee()" />
            </td>
          </tr>

<tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">产品查看方式(EN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
<%
if rsObj("PoorSeeen")<>"" then
PoorSee=split(rsObj("PoorSeeen"),",") '返回数组
for i=lbound(PoorSee) to ubound(PoorSee)	'输出内容
%><table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
    	<td>
			&nbsp;<input name="m_PoorSeeen" id="m_PoorSee<%if rsObj("PoorSeeen")<>"" then%><%=i%><%end if%>" type="text" size="20" value="<%if rsObj("PoorSeeen")<>"" then%><%=PoorSee(i)%><%end if%>">
            <a href="javascript:void(0)" onClick="this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode);"><img src="Images/del.gif" width="45" height="19" border="0"></a>
		</td>
	</tr>
</table>
<%
next
end if
%>
		<div id="PoorSeeListsen"></div>
		&nbsp;<input type="button" name="PoorSee" value="添加方式" onclick="InsertPoorSeeen()" />
            </td>
          </tr>


		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">说明(CN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <textarea  name="Intro" id="Intro" style="width:98%;height:100px;"><%=rsObj("Intro")%></textarea>
            </td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">说明(EN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <textarea  name="Introen" id="Introen" style="width:98%;height:100px;"><%=rsObj("Introen")%></textarea>
            </td>
          </tr>


		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">栏目介绍(CN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <!--<textarea name="Introduction" cols="100" rows="5"><%'=rsObj("Introduction")%></textarea>-->
            <textarea class="content" name="Introduction" id="Introduction" style="width:100%;height:300px;visibility:hidden;"><%=rsObj("Introduction")%></textarea>
            </td>
          </tr>

          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">栏目介绍(EN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <!--<textarea name="Introductionen" cols="100" rows="5"><%'=rsObj("Introductionen")%></textarea>-->
            <textarea class="content1" name="Introductionen" id="Introductionen" style="width:100%;height:300px;visibility:hidden;"><%=rsObj("Introductionen")%></textarea>
            </td>
          </tr>

          <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">栏目介绍(JP):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <!--<textarea name="Introductionen" cols="100" rows="5"><%'=rsObj("Introductionen")%></textarea>-->
            <textarea class="content2" name="Introductionjp" id="Introductionjp" style="width:100%;height:300px;visibility:hidden;"><%=rsObj("Introductionjp")%></textarea>
            </td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">排序:</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
			<input size="6" type="text" name="Sequence" value="<%=rsObj("Sequence")%>" />
			<input type="hidden" name="m_id" value="<%=rsObj("ID")%>" />
		  	<input type="hidden" name="m_back" value="<%=request.ServerVariables("HTTP_REFERER")%>" />
            </td>
          </tr>


		  <tr>
		    <td colspan="3" align="left" style="border-top:solid #dddddd 1px;"><span style="font-size:14px; font-weight:bold; color:green; padding-left:10px;">SEO优化</span></td>
		    </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">页面标题(CN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <input type="text" size="90" name="PageTitle" value="<%=rsObj("PageTitle")%>" />
            <font color='red'>＊</font>
            </td>
          </tr>

          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">页面标题(EN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <input type="text" size="90" name="PageTitleen" value="<%=rsObj("PageTitleen")%>" />
            <font color='red'>＊</font>
            </td>
          </tr>

          <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">页面标题(JP):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <input type="text" size="90" name="PageTitlejp" value="<%=rsObj("PageTitlejp")%>" />
            <font color='red'>＊</font>
            </td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">关键词(CN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Keywords" cols="100" rows="3"><%=rsObj("Keywords")%></textarea></td>
          </tr>

          <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">关键词(EN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Keywordsen" cols="100" rows="3"><%=rsObj("Keywordsen")%></textarea></td>
          </tr>

          <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">关键词(JP):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"><textarea name="Keywordsjp" cols="100" rows="3"><%=rsObj("Keywordsjp")%></textarea></td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">描述(CN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <textarea name="Descriptions" cols="100" rows="5"><%=rsObj("Descriptions")%></textarea></td>
          </tr>

		  <tr>
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">描述(EN):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <textarea name="Descriptionsen" cols="100" rows="5"><%=rsObj("Descriptionsen")%></textarea></td>
          </tr>

		  <tr style="display:none;">
            <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
			<table width="80" cellpadding="0" cellspacing="0">
                <tr>
					<td align="right">描述(JP):</td>
                </tr>
            </table></td>
            <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
            <textarea name="Descriptionsjp" cols="100" rows="5"><%=rsObj("Descriptionsjp")%></textarea></td>
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

<div class="nav_tools leftbottom"><span class="save"><a href="javascript:ColumnsEdit();">保存</a></span><span class="back"><a href="columns.asp">返回</a></span><span class="nav_tools_right rightbottom"></span></div>
</form>
<%
set rsObj = nothing
End Sub
%>

<%
Sub addColumnType
	dim ChildPath,DeepPath,NavName,NavNameen,WebType,ParentID,OpenType,m_class_pic,m_Class_Picen,Sequence
	NavName =ReplaceSymbols(getForm("NavName","post"))
	NavNameen =ReplaceSymbols(getForm("NavNameen","post"))
	NavNamejp =ReplaceSymbols(getForm("NavNamejp","post"))
	dim ClassName:ClassName=ReplaceSymbols(getForm("ClassName","post"))
	dim ClassNameen:ClassNameen=ReplaceSymbols(getForm("ClassNameen","post"))
	dim ClassNamejp:ClassNamejp=ReplaceSymbols(getForm("ClassNamejp","post"))
	dim ClassUrl:ClassUrl=ReplaceSymbols(getForm("ClassUrl","post"))
	dim ClassUrlen:ClassUrlen=ReplaceSymbols(getForm("ClassUrlen","post"))
	dim ClassUrljp:ClassUrljp=ReplaceSymbols(getForm("ClassUrljp","post"))
	dim target:target=ReplaceSymbols(getForm("target","post"))
	dim targeten:targeten=ReplaceSymbols(getForm("targeten","post"))
	ParentID = getForm("ParentID","post")
	m_class_pic =ReplaceSymbols(getForm("m_class_pic","post"))
	m_Class_Picen =ReplaceSymbols(getForm("m_Class_Picen","post"))
	WebType = getForm("WebType","post")
	 if isNul(WebType) then
	 	if parentid=0 Then
			webType=0
		else
	 		webType= conn.db("select webType from {pre}Navigation where id="&parentid ,"execute")(0)
		end if
	end if
	Sequence = getForm("Sequence","post") : if isNul(Sequence) then Sequence=conn.db("select max(Sequence)+1 from {pre}Navigation","execute")(0)
	dim P_Title:P_Title =ReplaceSymbols(getForm("PageTitle","post"))
	dim P_Titleen:P_Titleen =ReplaceSymbols(getForm("PageTitleen","post"))
	dim P_Titlejp:P_Titlejp =ReplaceSymbols(getForm("PageTitlejp","post"))
	dim K_Key:K_Key =ReplaceSymbols(getForm("Keywords","post"))
	dim K_Keyen:K_Keyen =ReplaceSymbols(getForm("Keywordsen","post"))
	dim K_Keyjp:K_Keyjp =ReplaceSymbols(getForm("Keywordsjp","post"))
	dim D_Desc:D_Desc =ReplaceSymbols(getForm("Descriptions","post"))
	dim D_Descen:D_Descen =ReplaceSymbols(getForm("Descriptionsen","post"))
	dim D_Descjp:D_Descjp =ReplaceSymbols(getForm("Descriptionsjp","post"))
	dim Introduction:Introduction =ReplaceSymbols(getForm("Introduction","post"))
	dim Introductionen:Introductionen =ReplaceSymbols(getForm("Introductionen","post"))
	dim Introductionjp:Introductionjp =ReplaceSymbols(getForm("Introductionjp","post"))

	dim Intro:Intro =ReplaceSymbols(getForm("Intro","post"))
	dim Introen:Introen =ReplaceSymbols(getForm("Introen","post"))

	if not isNum(Sequence) then Sequence=1
	if isNul(NavName) then die "信息填写不完整，请检查"
	conn.db "insert into {pre}Navigation([NavName],[NavNameen],[NavNamejp],[ClassName],[ClassNameen],[ClassNamejp],[ClassUrl],[ClassUrlen],[ClassUrljp],[target],[targeten],[WebType],[ParentID],[Class_Pic],[Class_Picen],[Sequence],[PageTitle],[PageTitleen],[PageTitlejp],[Keywords],[Keywordsen],[Keywordsjp],[Descriptions],[Descriptionsen],[Descriptionsjp],[Introduction],[Introductionen],[Introductionjp],[Intro],[Introen])values('"&NavName&"','"&NavNameen&"','"&NavNamejp&"','"&ClassName&"','"&ClassNameen&"','"&ClassNamejp&"','"&ClassUrl&"','"&ClassUrlen&"','"&ClassUrljp&"','"&target&"','"&targeten&"',"&WebType&","&ParentID&",'"&m_class_pic&"','"&m_Class_Picen&"',"&Sequence&",'"&P_Title&"','"&P_Titleen&"','"&P_Titlejp&"','"&K_Key&"','"&K_Keyen&"','"&K_Keyjp&"','"&D_Desc&"','"&D_Descen&"','"&D_Descjp&"','"&Introduction&"','"&Introductionen&"','"&Introductionjp&"','"&Intro&"','"&Introen&"')","execute"
	conn.db "update {pre}Navigation set ChildPath=ID where ID=(select top 1 ID from {pre}Navigation order by ID desc)","execute"
	conn.db "update {pre}Navigation set DeepPath=1 where ID=(select top 1 ID from {pre}Navigation order by ID desc)","execute"
	if ParentID<>0 then
	    'conn.db "update {pre}Navigation set WebType=0 where ID="&ParentID&"","execute"
		addChildPath(ParentID)
		addDeepPath(ParentID)
		conn.db "update {pre}Navigation set DeepPath=DeepPath+1 where ID=(select top 1 ID from {pre}Navigation order by ID desc)","execute"
	end if
	alertMsg "","columns.asp"
End Sub

Sub addChildPath(ID)
    dim TemptStr,sqlStr,rsObj
	if ID<>0 then
		sqlStr= "select top 1 ID from {pre}Navigation order by ID desc"
		set rsObj = conn.db(sqlStr,"records1")
		TemptStr=rsObj("ID")
		rsObj.close
		set rsObj = nothing
		conn.db "update {pre}Navigation set ChildPath=ChildPath+','+'"&TemptStr&"' where ID="&ID&"","execute"
		sqlStr= "select ParentID from {pre}Navigation where ID="&ID&""
		set rsObj = conn.db(sqlStr,"records1")
		   if not rsObj.eof Then addChildPath(rsObj("ParentID"))
		rsObj.close
		set rsObj = nothing
	end if
End Sub

Sub addDeepPath(ID)
    dim sqlStr,rsObj
	if ID<>0 then
	    sqlStr= "select * from {pre}Navigation where ID="&ID&""
		set rsObj = conn.db(sqlStr,"records1")
		if not rsObj.eof Then
			if rsObj("ParentID")<>0 then
			   conn.db "update {pre}Navigation set DeepPath=DeepPath+1 where ID=(select top 1 ID from {pre}Navigation order by ID desc)","execute"
			   addDeepPath(rsObj("ParentID"))
			end if
		end if
		rsObj.close
	    set rsObj = nothing
	end if
End Sub

Sub hideColumnType
	dim id : id=getForm("m_id","get")
	conn.db "update {pre}Navigation set IsShow=0 where ID="&id, "execute"
	alertMsg "","columns.asp"
End Sub

Sub nohideColumnType
	dim id : id=getForm("m_id","get")
	conn.db "update {pre}Navigation set IsShow=1  where ID="&id, "execute"
	alertMsg "","columns.asp"
End Sub

Sub hideColumnTypeen
	dim id : id=getForm("m_id","get")
	conn.db "update {pre}Navigation set IsShowen=0 where ID="&id, "execute"
	alertMsg "","columns.asp"
End Sub

Sub nohideColumnTypeen
	dim id : id=getForm("m_id","get")
	conn.db "update {pre}Navigation set IsShowen=1  where ID="&id, "execute"
	alertMsg "","columns.asp"
End Sub


Sub hideColumnTypejp
	dim id : id=getForm("m_id","get")
	conn.db "update {pre}Navigation set IsShowjp=0 where ID="&id, "execute"
	alertMsg "","columns.asp"
End Sub

Sub nohideColumnTypejp
	dim id : id=getForm("m_id","get")
	conn.db "update {pre}Navigation set IsShowjp=1  where ID="&id, "execute"
	alertMsg "","columns.asp"
End Sub


Sub delAll
	dim ids,idArray,idsLen,i,filename
	ids = replaceStr(getForm("m_id","post")," ","")
	idArray=split(ids,",") : idsLen=ubound(idArray)
	for i=0 to idsLen
		delColumnTypeById idArray(i)
	next
	alertMsg "","columns.asp"
End Sub

Sub delColumnType
	dim id : id=getForm("m_id","get")
	delColumnTypeById id
	alertMsg "","columns.asp"
End Sub

Sub delColumnTypeById(id)
	dim DellArray,sqlStr,rsObj,rsObj1,ChildPath,IDStr,TempStr
	sqlStr="select * from {pre}Navigation where ID="&id
	set rsObj = conn.db(sqlStr,"records1")
	if not rsObj.eof then
	  if IsArray(split(rsObj("ChildPath"),",")) then
	      IDStr=rsObj("ChildPath")
	      TempStr=","+rsObj("ChildPath")
	      '删除数据
	      conn.db  "delete from {pre}Navigation where ID in ("&IDStr&")", "execute"
		  '删除父目录该节点
		  set rsObj1=conn.db("select ID,ChildPath from {pre}Navigation","records1")
		  do while not rsObj1.eof
		      ChildPath=replaceStr(rsObj1("ChildPath"),TempStr,"")
		      conn.db  "update {pre}Navigation set ChildPath='"&ChildPath&"' where ID="&rsObj1(0), "execute"
		      rsObj1.movenext
		  loop
		  rsObj1.close
		  set rsObj1=nothing
	  else
	      TempStr=","+id
	      conn.db  "delete from {pre}Navigation where ID="&id, "execute"
		  set rsObj1=conn.db("select ID,ChildPath from {pre}Navigation","records1")
		  do while not rsObj1.eof
		      ChildPath=replaceStr(rsObj1("ChildPath"),TempStr,"")
		      conn.db  "update {pre}Navigation set ChildPath='"&ChildPath&"' where ID="&rsObj1(0), "execute"
		      rsObj1.movenext
		  loop
		  rsObj1.close
		  set rsObj1=nothing
	  end if
	end if
	rsObj.close
	set rsObj=nothing
End Sub

Sub editSave
	dim updateSql,insertSql
	dim NavName:NavName=ReplaceSymbols(getForm("NavName","post")) : if isNul(NavName) then die "请填写栏目标题"
	dim NavNameen:NavNameen=ReplaceSymbols(getForm("NavNameen","post"))
	dim NavNamejp:NavNamejp=ReplaceSymbols(getForm("NavNamejp","post"))
	dim ClassName:ClassName=ReplaceSymbols(getForm("ClassName","post"))
	dim ClassNameen:ClassNameen=ReplaceSymbols(getForm("ClassNameen","post"))
	dim ClassNamejp:ClassNamejp=ReplaceSymbols(getForm("ClassNamejp","post"))
	dim ClassUrl:ClassUrl=ReplaceSymbols(getForm("ClassUrl","post"))
	dim ClassUrlen:ClassUrlen=ReplaceSymbols(getForm("ClassUrlen","post"))
	dim ClassUrljp:ClassUrljp=ReplaceSymbols(getForm("ClassUrljp","post"))

	dim target:target=ReplaceSymbols(getForm("target","post"))
	dim targeten:targeten=ReplaceSymbols(getForm("targeten","post"))


	dim WebType:WebType = getForm("WebType"&id,"post") : if isNul(WebType) then WebType=0
	dim ParentID:ParentID = getForm("ParentID","post") : if isNul(ParentID) Then ParentID=0
	dim Sequence:Sequence=getForm("Sequence","post")
	dim m_back:m_back=getForm("m_back","post")
	dim m_id:m_id=clng(getForm("m_id","post"))
	dim m_class_pic:m_class_pic = getForm("m_class_pic","post")
	dim m_Class_Picen:m_Class_Picen = getForm("m_Class_Picen","post")
	dim P_Title:P_Title =ReplaceSymbols(getForm("PageTitle","post"))
	dim P_Titleen:P_Titleen =ReplaceSymbols(getForm("PageTitleen","post"))
	dim P_Titlejp:P_Titlejp =ReplaceSymbols(getForm("PageTitlejp","post"))
	dim K_Key:K_Key =ReplaceSymbols(getForm("Keywords","post"))
	dim K_Keyen:K_Keyen =ReplaceSymbols(getForm("Keywordsen","post"))
	dim K_Keyjp:K_Keyjp =ReplaceSymbols(getForm("Keywordsjp","post"))
	dim D_Desc:D_Desc =ReplaceSymbols(getForm("Descriptions","post"))
	dim D_Descen:D_Descen =ReplaceSymbols(getForm("Descriptionsen","post"))
	dim D_Descjp:D_Descjp =ReplaceSymbols(getForm("Descriptionsjp","post"))
	dim Introduction:Introduction =ReplaceSymbols(getForm("Introduction","post"))
	dim Introductionen:Introductionen =ReplaceSymbols(getForm("Introductionen","post"))
	dim Introductionjp:Introductionjp =ReplaceSymbols(getForm("Introductionjp","post"))

	dim Intro:Intro =ReplaceSymbols(getForm("Intro","post"))
	dim Introen:Introen =ReplaceSymbols(getForm("Introen","post"))

	dim m_PoorSee:m_PoorSee=ReplaceSymbols(getForm("m_PoorSee","post"))
	dim m_PoorSeeen:m_PoorSeeen=ReplaceSymbols(getForm("m_PoorSeeen","post"))


	set rsObj = conn.db("select ParentID,ChildPath from {pre}Navigation where ID="&m_id,"records1")
	if not rsObj.eof then
		  set rs= conn.db("select ChildPath from {pre}Navigation where ID="&rsObj("ParentID") ,"records1")
		if not rs.eof Then
		if trim(m_id)<>trim(ParentID) then
	      conn.db  "update {pre}Navigation set ChildPath='"&REPLACE(rs("ChildPath"),","&m_id&"","")&"' where ID="&rsObj("ParentID") , "execute"
		  conn.db  "update {pre}Navigation set ChildPath=ChildPath+','+'"&m_id&"'  where ID="&ParentID , "execute"
		  else
		  ParentID = rsObj("ParentID")
		 end if
		 end if
		  rsObj.close : set rsObj=nothing
		  end if

	updateSql = "NavName='"&NavName&"',NavNameen='"&NavNameen&"',NavNamejp='"&NavNamejp&"',ClassName='"&ClassName&"',ClassNameen='"&ClassNameen&"',ClassNamejp='"&ClassNamejp&"',ClassUrl='"&ClassUrl&"',ClassUrlen='"&ClassUrlen&"',ClassUrljp='"&ClassUrljp&"',target='"&target&"',targeten='"&targeten&"',WebType="&WebType&",ParentID="&ParentID&",Class_pic='"&m_class_pic&"',Class_Picen='"&m_Class_Picen&"',PoorSee='"&m_PoorSee&"',PoorSeeen='"&m_PoorSeeen&"',Sequence="&Sequence&",PageTitle='"&P_Title&"',PageTitleen='"&P_Titleen&"',PageTitlejp='"&P_Titlejp&"',Keywords='"&K_Key&"',Keywordsen='"&K_Keyen&"',Keywordsjp='"&K_Keyjp&"',Descriptions='"&D_Desc&"',Descriptionsen='"&D_Descen&"',Descriptionsjp='"&D_Descjp&"',Introduction='"&Introduction&"',Introductionen='"&Introductionen&"',Introductionjp='"&Introductionjp&"',Intro='"&Intro&"',Introen='"&Introen&"'"
	updateSql = "update {pre}Navigation set "&updateSql&" where ID="&m_id

	conn.db  updateSql,"execute"
	alertMsg "","columns.asp"
End Sub


Sub editColumnType
	dim ids,id,NavName,NavUrl,WebType,OpenType,Sequence,sqlStr
	ids = split(replace(getForm("m_id","post")," ",""),",")
	For Each id In ids
		NavName = getForm("NavName"&id,"post")
	    WebType = getForm("WebType"&id,"post") : if isNul(WebType) then WebType=0
		Sequence = getForm("Sequence"&id,"post") : if isNul(Sequence) then Sequence=conn.db("select max(Sequence)+1 from {pre}Navigation","execute")(0)
		if isNul(id) or  isNul(NavName)  then  die "信息填写不完整，请检查"
		sqlStr = "update {pre}Navigation set NavName='"&NavName&"',Sequence="&Sequence&",WebType="&WebType&" where ID="&id
		conn.db sqlStr,"execute"
	Next
	alertMsg "","columns.asp"
End Sub


Sub typeList(topId)
	dim sqlStr,rsObj,i
	n = n+4
	sqlStr= "select * from {pre}Navigation where ParentID="&topId&" order by Sequence asc"
	set rsObj = conn.db(sqlStr,"records1")
	do while not rsObj.eof
%>
<tr class="move">
<td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
<table width="100%" cellpadding="0" cellspacing="0">
  <tbody>
	<tr>
		<td align="left"><%for i=0 to n-4%>&nbsp;<%next%><input type="checkbox" name="m_id" value="<%=rsObj("ID")%>" class="checkbox" />
		<input size="38" type="text" data-id="<%=rsObj("ID")%>" name="NavName<%=rsObj("ID")%>" value="<%=Replace(rsObj("NavName"),"""","&quot;")%>" onchange="navNameChange(this,<%=rsObj("ID")%>)"/><span class="status"></span>
		</td>
	</tr>
  </tbody>
</table></td>
<td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
<table width="120" cellpadding="0" cellspacing="0">
  <tbody>
	<tr>
	  <td align="center">
		<select name="WebType<%=rsObj("ID")%>">
			<option value='0'>请选择频道</option>
			<%options(rsObj("WebType"))%>
		</select>
	  </td>
	</tr>
  </tbody>
</table>
</td>
<td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
<table width="80" cellpadding="0" cellspacing="0">
  <tbody>
	<tr>
	  <td align="center"><input size="6" type="text" data-id="<%=rsObj("ID")%>"  name="Sequence<%=rsObj("ID")%>" value="<%=rsObj("Sequence")%>"  onchange="navOrdChange(this,<%=rsObj("ID")%>)" /><span class="status"></span></td>
	</tr>
  </tbody>
</table>
</td>
<td align="center" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
<table width="180" cellpadding="0" cellspacing="0">
  <tbody>
	<tr>
	  <td align="center">
	  <%if rsObj("IsShow")=0 then %>
	  <a href="javascript:location.href='?action=nohide&amp;m_id=<%=rsObj("ID")%>';" style="color:blue">未发布(CN)</a>
	  <%elseif rsObj("IsShow")=1 then%>
	  <a href="javascript:location.href='?action=hide&amp;m_id=<%=rsObj("ID")%>';" style="color:green">已发布(CN)</a>
	  <%end if%>
      &nbsp;|&nbsp;
	  <%if rsObj("IsShowen")=0 then %>
	  <a href="javascript:location.href='?action=nohideen&amp;m_id=<%=rsObj("ID")%>';" style="color:red">未发布(EN)</a>
	  <%elseif rsObj("IsShowen")=1 then%>
	  <a href="javascript:location.href='?action=hideen&amp;m_id=<%=rsObj("ID")%>';" style="color:#06F">已发布(EN)</a>
	  <%end if%>
     <!-- &nbsp;|&nbsp;
	  <%'if rsObj("IsShowjp")=0 then %>
	  <a href="javascript:location.href='?action=nohidejp&amp;m_id=<%'=rsObj("ID")%>';" style="color:blue">未发布(JP)</a>
	  <%'elseif rsObj("IsShowjp")=1 then%>
	  <a href="javascript:location.href='?action=hidejp&amp;m_id=<%'=rsObj("ID")%>';" style="color:green">已发布(JP)</a>
	  <%'end if%>-->


      </td>
	</tr>
  </tbody>
</table></td>
<td align="middle" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
<table width="80" cellpadding="0" cellspacing="0">
  <tbody>
	<tr>
	  <td align="center"><a href="javascript:location.href='?action=editcolumn&amp;m_id=<%=rsObj("ID")%>';">修改</a></td>
      <%
	set rs=conn.db("select * from {pre}Product where sortid in("&rsObj("ChildPath")&")","records1")
	if rs.eof or rs.bof then
	  %>
	  <%if rsObj("IsDel")=false then%><td align="center">|</td>
	  <td align="center"><a href="javascript:location.href='?action=del&amp;m_id=<%=rsObj("ID")%>';" onclick="return confirm('确定要删除吗')">删除<span style="color:green">(无)</span></a></td>

	<%end if%>
    <%else%>
      <td align="center">|</td>
	  <td align="center"><a href="#" onclick="return confirm('请先删除该分类下所有资料')">删除<span style="color:#F00">(有)</span></a></td>
    <%end if
	rs.close : set rs=nothing
	%>
    </tr>
  </tbody>
</table></td>
</tr>
<%
		typeList(rsObj("ID"))
		rsObj.movenext
	loop
	n = n-4
	rsObj.close
	set rsObj = nothing
End Sub

Sub options(num)
	dim arr(21)
	if num<>0 Then arr(num)="selected"
	echo "<option value='1' "&arr(1)&">简介信息类</option>"&vbcrlf
	echo "<option value='2' "&arr(2)&">新闻展示类</option>"&vbcrlf
	echo "<option value='3' "&arr(3)&">图片展示类</option>"&vbcrlf
	'echo "<option value='4' "&arr(4)&">图文展示类</option>"&vbcrlf
	'echo "<option value='5' "&arr(5)&">资料下载类</option>"&vbcrlf
	echo "<option value='6' "&arr(6)&">产品展示类</option>"&vbcrlf
	'echo "<option value='7' "&arr(7)&">客户留言</option>"&vbcrlf
	'echo "<option value='8' "&arr(8)&">招聘信息类</option>"&vbcrlf
	'echo "<option value='9' "&arr(9)&">常见问题类</option>"&vbcrlf
	'echo "<option value='10' "&arr(10)&">幻灯片类</option>"&vbcrlf
	'echo "<option value='11' "&arr(11)&">视频展示</option>"&vbcrlf
	'echo "<option value='12' "&arr(12)&">地名</option>"&vbcrlf
	'echo "<option value='13' "&arr(13)&">图片链接</option>"&vbcrlf
	echo "<option value='14' "&arr(14)&">文本链接</option>"&vbcrlf
	'echo "<option value='15' "&arr(15)&">职位申请</option>"&vbcrlf
	'echo "<option value='16' "&arr(16)&">基本信息配置</option>"&vbcrlf
	'echo "<option value='17' "&arr(17)&">防伪码</option>"&vbcrlf
	'echo "<option value='18' "&arr(18)&">产品详细参数</option>"&vbcrlf
	'echo "<option value='19' "&arr(19)&">文本展示</option>"&vbcrlf
	'echo "<option value='20' "&arr(20)&">类别简介</option>"&vbcrlf
	'echo "<option value='21' "&arr(21)&">分销渠道</option>"&vbcrlf
End Sub
%>
				<div class="h7"></div>
				</div>
			<div class="bottom_nav"></div>
		</div>
	</div>
	</div>
	<div class="clear"></div>
	<!--#include file="bottom.asp"-->
</div>
</body>
</html>
