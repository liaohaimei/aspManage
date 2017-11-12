<!--#include file="admin_inc.asp"-->
<%checkPower%>
<!--#include file="FCKeditor/fckeditor.asp" -->
<div id="header">
	<div id="header_content"><a href="index.asp"><img src="images/headlogo.jpg" border="0" style="float:left;" /></a><span id="userinfo"> &nbsp;&nbsp;您好, <em><%=rCookie("UserName")%> <% if clng(rCookie("AdminPower"))=0 then %>[系统管理员]<% else %>[网站编辑]<%end if%></em> [  <a href="index.asp?action=logout" target="_top">退出</a> ][ <a href="../" target="_blank">网站首页</a> ]</span></div>
	<div id="nav">
		<div style="float:left; width:99%;"><div style="float:left; padding-left:12px; padding-top:3px;"><a id="switch" class="button" onfocus="this.blur();" href="javascript:ChangeMenu(0)">关闭菜单</a></div>
		<span style="font-size:12px; float:right; display:none;">语言版本：<select name="language" style="margin-top:2px;vertical-align:middle;">
		  <option value="1">(CN)版(CN)版</option>
		  <option value="2">(EN)版(EN)版</option>
		</select></span></div><span id="nav_right"></span>
	</div>
</div>