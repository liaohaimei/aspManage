<!--#include file="admin_inc.asp"-->
<%checkPower%>
<!--#include file="files/inc/session.asp"-->
<%
Mosession.Set "username",rCookie("UserName")
%>
<!DOCTYPE html>
<html lang="zh-cn">
    <head>
        <meta charset="utf-8" />
        <title>文件管理 - 后台管理系统</title>
        <link href="style/style.css" rel="stylesheet" type="text/css" />
		<link href="files/css/filemanager.css" type="text/css" rel="stylesheet" />
		<link href="files/css/ft.css" type="text/css" rel="stylesheet" />
		<link href="files/css/jui/jquery.ui.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="files/scripts/jui/jquery.js"></script>
        <script src="scripts/modernizr-2.0.6-development-only.js" type="text/javascript"></script>
        <script src="scripts/jquery.cookie.js" type="text/javascript"></script>

<script type="text/javascript">
var sessionid="<%=Mosession.SessionId%>";
$(function(){var ext=".min";$("#load_process").attr("src","files/images/loading.gif");$.loadImage("files/images/ico_actions.gif");$.loadResource("files/scripts/jo.ajax" + ext + ".js","files/scripts/mo.common" + ext + ".js","files/scripts/jui/jquery.ui.min.js","files/scripts/mo.filemanager" + ext + ".js",function(){$(".h24").bind("contextmenu",BlankBind);$(document).bind("contextmenu",BlankBind);currentpath = cookie("currentpath")||currentpath;$("#load_process").attr("src","files/images/right.gif");$(".h24 .w_name").bind("click",function(){DoSort(this,"name desc");});$(".h24 .w_size").bind("click",function(){DoSort(this,"size desc");});$(".h24 .w_createdate").bind("click",function(){DoSort(this,"create desc");});Init();});});

function deleteall(){
$("#dialog").html('你确定要删除文件/文件夹').dialog({
    minWidth: 280,
    minHeight: 140,
    resizable: false,
    modal: true,
    draggable: true,
    title: "删除文件/文件夹",
    buttons: {
        "立即删除": function() {
            $('input[name="filenames"]').each(function(i){
				if(this.checked){
					FileSystem.Dialog.DeleteAll($(this).val());
					alert('批量删除文件名:'+FileSystem.instance[$(this).val()].name);
				}
			});
			$(this).dialog("close");
			Init();
        },
        "取消": function() {
            $(this).dialog("close")
        }
    }
});
}
</script>
<script type="text/javascript" language="javascript">
    //图片按比例缩放
    function setimg(ImgD, w, h, url) {
        var image = new Image();
        var iwidth = w;
        var iheight = h;
        image.onload = function () {
            ImgD.onload = null;
            ImgD.src = url;
            if (image.width > 0 && image.height > 0) {
                if (image.width / image.height >= iwidth / iheight) {
                    if (image.width > iwidth) {
                        ImgD.width = iwidth;
                    }
                    else {
                        ImgD.width = image.width
                    }
                    //ImgD.alt=image.width+"×"+image.height; 
                }
                else {
                    if (image.height > iheight) {
                        ImgD.height = iheight;
                    }
                    else {
                        ImgD.width = image.width;
                    }
                    //ImgD.alt=image.width+"×"+image.height; 
                }
            }
        }
        image.src = url;
    }
</script>
        <meta name="viewport" content="width=device-width">
		</head>
    <body>
    <div id="main">
	    <div id="header">
			<div id="header_content"><a href="main.asp"><img src="images/headlogo.jpg" border="0" style="float:left;" /></a><span id="userinfo"> &nbsp;&nbsp;您好, <em><%=rCookie("UserName")%> <% if clng(rCookie("AdminPower"))=0 then %>[系统管理员]<% else %>[网站编辑]<%end if%></em> [  <a href="index.asp?action=logout" target="_top">退出</a> ][ <a href="../index.asp" target="_blank">网站首页</a> ]</span></div>
			<div id="nav">
				<div style="float:left; width:99%;"><div style="float:left; padding-left:12px; padding-top:3px;"><a id="switch" class="button" onfocus="this.blur();" href="javascript:ChangeMenu(0)">关闭菜单</a></div>
				<span style="font-size:12px; float:right; display:none;">语言版本：<select name="language" style="margin-top:2px;vertical-align:middle;">
				  <option value="1">(CN)版(CN)版</option>
				  <option value="2">(EN)版(EN)版</option>
				</select></span></div><span id="nav_right"></span>
			</div>
		</div>
	    <div id="content">
	    <!--#include file="left.asp"-->

	    <div id="right_content">
		    
            
<div id="main_content">
			<div class="top_nav"><span></span></div>
				<div class="nav_content" style="line-height:18px;">
				<h1>后台首页 » 系统 » 文件管理</h1>
				</div>
			<div class="bottom_nav"><span></span></div>
			<div class="h6"></div>
			<div class="top_nav"><span></span></div>
				<div class="nav_content">
				<div class="h7"></div>
				<div class="nav_tools"><span class="add"><a href="#" onClick="InitUpload();">上传</a></span><span class="delete"><a href="javascript:deleteall();" onClick="return confirm('确定要删除选中数据')">批量删除</a></span><span class="nav_tools_right"></span></div>
				<div class="table">
				
				<div id="filemanager">
					<div><img id="load_process" src="files/images/blank.gif" width="16" height="16" /> 当前路径：<span id="path">/</span></div>
					<div id="filelists" class="clearfix">
						<div class="list h24">
							<div class="checkbox"></div>
							<div class="w_name"><span class="filename">文件名</span><img src="files/images/blank.gif" class="ico16 ico_asc" /></div>
							<div class="w_size"><span class="filesize">大小<img src="files/images/blank.gif" class="ico16 ico_asc" /></span></div>
							<div class="w_createdate">创建时间<img src="files/images/blank.gif" class="ico16 ico_asc" /></div>
						</div>
					</div>
					<div id="page"></div>
				</div>
				<div id="upload" style="display:none" title="文件上传"></div><div id="dialog" title="文件上传"></div>
	
				</div>
				<div class="nav_tools leftbottom"><span class="add"><a href="#" onClick="InitUpload();">上传</a></span><span class="delete"><a href="javascript:deleteall();" onClick="return confirm('确定要删除选中数据')">批量删除</a></span><span class="nav_tools_right rightbottom"></span></div>
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