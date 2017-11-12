<%
Sub nav_ul(topId)
%>
<ul <%if topId = 0 then%>class="nav_ul"<%end if%>><%
	dim sqlStr,rsObj,i
	n = n+5
if topId <> 0 then

 dim m_sid : m_sid = conn.db("select ParentID from {pre}Navigation where Id="&topId&"","execute")(0)
  if m_sid <> 0 then
	dim m_tid : m_tid = conn.db("select ParentID from {pre}Navigation where Id="&m_sid&"","execute")(0)
		if m_tid <> 0 then
			dim m_bid : m_bid = conn.db("select ParentID from {pre}Navigation where Id="&m_tid&"","execute")(0)
				if m_bid <> 0 then
					dim m_pid : m_pid = conn.db("select ParentID from {pre}Navigation where Id="&m_bid&"","execute")(0)
				end if
			end if
		end if
	  end if

	sqlStr= "select * from {pre}Navigation where ParentID="&topId&" order by Sequence asc"
	set rsObj = conn.db(sqlStr,"records1")
	do while not rsObj.eof
	select case rsObj("WebType")
	case 0
		lefturl = "infos.asp"
	case 1
		lefturl = "infos.asp"
	case 2
		lefturl = "news.asp"
	case 3
		lefturl = "photos.asp"
	case 4
		lefturl = "cases.asp"
	case 5
		lefturl = "downs.asp"
	case 6
		lefturl = "products.asp"
	case 7
		lefturl = "feedbacks.asp"
	case 8
		lefturl = "jobs.asp"
	case 9
		lefturl = "topics.asp"
	case 10
		lefturl = "slides.asp"
	case 11
		lefturl = "applications.asp"
	case 12
		lefturl = "parameter.asp"
	case 13
		lefturl = "Partners.asp"
	case 14
		lefturl = "links.asp"
	case 15
		lefturl = "application.asp"
	case 16
		lefturl = "configurationold.asp"
	case 17
		lefturl = "security.asp"	
	case 18
		lefturl = "detailpar.asp"	
	case 19
		lefturl = "history.asp"	
	case 20
		lefturl = "cateinfo.asp"	
	case 21
		lefturl = "fxqd.asp"	

	end select
		
	if topId = 0 then
		parentid = rsObj("ID")
	else
		parentid = Request("parentid")
	end if
	
	if rsObj("WebType") = 0 then
		on error resume next
		dim pcid : pcid = conn.db("select top 1 Id from {pre}Navigation where ParentID="& rsObj("ID") &"","execute")(0)
		lefturl = lefturl & "?parentid="& parentid &"&pid="& m_pid &"&bid="& m_bid &"&tid="& m_tid &"&sid="&m_sid&"&uid="& rsObj("ID")&"&cid="&pcid
	else
		lefturl = lefturl & "?parentid="& parentid &"&pid="& m_pid &"&bid="& m_bid &"&tid="& m_tid&"&sid="&m_sid&"&uid="& rsObj("ParentID") &"&cid="& rsObj("ID")
	end if
%><li><a href="<%=lefturl%>" <%if Request("pid") = trim(rsObj("ID")) or Request("bid") = trim(rsObj("ID")) or Request("tid") = trim(rsObj("ID")) or Request("sid") = trim(rsObj("ID")) or Request("uid") = trim(rsObj("ID")) or Request("cid") = trim(rsObj("ID")) then%>class="current"<%end if%>><div class="r1"><div class="r2"><div class="r3"><div class="content"><%=rsObj("NavName")%></div></div></div></div></a>
<%
		if Request("pid") = trim(rsObj("ID")) or Request("bid") = trim(rsObj("ID")) or Request("tid") = trim(rsObj("ID")) or Request("sid") = trim(rsObj("ID")) or Request("uid") = trim(rsObj("ID"))or  Request("cid") = trim(rsObj("ID")) then
		nav_ul(rsObj("ID"))
		end if
%></li>
	<%
		rsObj.movenext
	loop
	n = n-5
	rsObj.close
	set rsObj = nothing
%>
</ul>
<%
End Sub
%>

<div id="left_nav">
	
	<div class="top_nav"><span></span></div>
		<div class="nav_content">
		<%nav_ul(0)%>
		</div>
	<div class="bottom_nav"><span></span></div>
	<div class="h12"></div>
	<div class="top_nav"><span></span></div>
		<div class="nav_content">
		<ul class="nav_ul">
			<li><a href="configuration.asp?id=1" <%if instr(Request.ServerVariables("Script_Name"),"configuration.asp?id=1") <> 0 then%>class="current"<%end if%>><div class="r1"><div class="r2"><div class="r3"><div class="content columns">网站基本配置</div></div></div></div></a>
			</li>

			<li><a href="columns.asp" <%if instr(Request.ServerVariables("Script_Name"),"columns.asp") <> 0 then%>class="current"<%end if%>><div class="r1"><div class="r2"><div class="r3"><div class="content columns">栏目设置</div></div></div></div></a>
			</li>
            <li><a href="slides.asp" <%if instr(Request.ServerVariables("Script_Name"),"slides.asp") <> 0 then%>class="current"<%end if%>><div class="r1"><div class="r2"><div class="r3"><div class="content columns">幻灯片</div></div></div></div></a>
            </li>

            <!-- <li><a href="QQadd.asp" <%if instr(Request.ServerVariables("Script_Name"),"QQadd.asp") <> 0 then%>class="current"<%end if%>><div class="r1"><div class="r2"><div class="r3"><div class="content columns">客服管理</div></div></div></div></a>
            </li> -->


            <li><a href="files.asp" <%if instr(Request.ServerVariables("Script_Name"),"files.asp") <> 0 then%>class="current"<%end if%>><div class="r1"><div class="r2"><div class="r3"><div class="content columns">上传文件管理</div></div></div></div></a></li>

		</ul>
		</div>
	
  <div class="nav_content"></div>
	<div class="bottom_nav"><span></span></div>
	<div class="h16"></div>
	<%if checkManagerLevel = 0 then%>
	<div class="top_nav2"><span></span></div>
		<div class="nav_content2">
		<h1>系统管理</h1>
		<ul>
			<li><a href="manager.asp">管理员管理</a></li>
			<!--<li><a href="users.asp?classid=1">个人会员管理</a></li>-->
			<!--<li><a href="users.asp?classid=2">企业会员管理</a></li>-->
			<li class="fileupload" style="display:none;"><a href="#">上传文件管理</a></li>
			<li class="rarbackup" style="display:none;"><a href="#">备份、压缩、还原</a></li>
			<li class="fileupload" style="display:none;"><a href="language.asp">语言设置</a></li>
		</ul>
		</div>
	<div class="bottom_nav2"><span></span></div>
	<div class="h12"></div>
	<%end if%>
	<div class="top_nav2"><span></span></div>
		<div class="nav_content2">
		<h1>帮助资源</h1>
		<ul>
			<li class="rarbackup"><a href="http://www.wspnet.cn/121.html" target="_blank">操作流程</a></li>
			<li class="help"><a href="http://www.wspnet.cn/123.html" target="_blank">常见问题</a></li>
		</ul>
		</div>
        
        
        <div class="nav_content2">
		<h1>提交网站入口</h1>
		<ul>
	  <li class="rarbackup"><a href="http://zhanzhang.baidu.com/sitesubmit/index" target="_blank">百度免费登录入口</a></li>
      <li class="rarbackup"><a href="http://www.google.com/intl/zh-CN/add_url.html" target="_blank">Google免费登录入口</a></li>
      <li class="rarbackup"><a href="http://www.sogou.com/feedback/urlfeedback.php" target="_blank">搜狗搜索引擎登陆入口</a></li>
      <li class="rarbackup"><a href="http://cn.bing.com/webmaster/SubmitSitePage.aspx?mkt=zh-CN" target="_blank">Bing免费登录入口</a></li>
    
    
      <li class="rarbackup"><a href="http://search.help.cn.yahoo.com/h4_4.html" target="_blank">雅虎免费登录入口</a></li>
      <li class="rarbackup"><a href="http://tellbot.youdao.com/report?keyFrom=help" target="_blank">有道&lt;网易&gt;免费登录入口</a></li>
    
    
      <li class="rarbackup"><a href="http://www.soso.com/help/usb/urlsubmit.shtml" target="_blank">搜搜- 中文搜索</a></li>
      <li class="rarbackup"><a href="http://www.antso.com/apply.asp" target="_blank">蚁搜-网站登录入口</a></li>
      <li class="rarbackup"><a href="http://www.sunwukong.cn/add.php" target="_blank">孙悟空免费登录入口</a></li>
    
    
      <li class="rarbackup"><a href="http://hao.360.cn/url.html" target="_blank">360网站提交入口</a></li>
		</ul>
		</div>
	<div class="bottom_nav2"><span></span></div>
	
</div>