<%
'表中字段
dim DB_FIELD,DB_LANGUAGE,DB_RE_FIELD,toF,toP10,toP1,toN1,toN10,toL
DB_FIELD="en" '字段加后缀
DB_LANGUAGE="English" '字段修改
DB_RE_FIELD="" '字段加后缀

int_showNumberLink=5
toF="&laquo;"
toP10="···"
toP1=" &lt;"
toN1=" &gt;"
toN10="···"
toL="&raquo;"

'Url路由
function WebtypeUrl(par)
select case par'rsObj("WebType")
	case 1'简介信息类
		lefturl = "about.asp"
	case 2'新闻展示类
		lefturl = "news.asp"
	case 3'图片展示类
		lefturl = "honor.asp"
	case 4'图文展示类
		lefturl = "case.asp"
	case 5'资料下载类
		lefturl = "download.asp"
	case 6'产品展示类
		lefturl = "products.asp"
	case 7'客户留言
		lefturl = "#"
	case 8'招聘信息类
		lefturl = "job.asp"
	case 9'常见问题类
		lefturl = "faq.asp"
	case 10'幻灯片类
		lefturl = "#"
	case 11'相片展示类
		lefturl = "video.asp"
	case 12'员工信息
		lefturl = "#"
	case 13'合作伙伴
		lefturl = "#"
	case 14'友情链接
		lefturl = "#"
	case 15'职位申请
		lefturl = "#"
	case 16'基本信息配置
		lefturl = "#"
	case 17'防伪验证
		lefturl = "#"
	case 19'发展历史
		lefturl = "contact.asp"
	case 20'类别简介
		lefturl = "cateinfo.asp"
	case 21'类别简介
		lefturl = "distribution.asp"
	case else
		lefturl = "index.asp"
	end select
	WebtypeUrl=lefturl
end function


'当前ID字段值
function ContentFileds(id,fileds)
set rsObj= conn.db("select * from {pre}Navigation where ID="&id,"records1")
if not rsObj.eof then
ContentFileds=rsObj(""&fileds&""&DB_FIELD&"")
end if
rsObj.close
set rsObj=nothing
end Function

'当前ID字段值
function ContentFileds2(id,fileds)
set rsObj= conn.db("select * from {pre}Navigation where ID="&id,"records1")
if not rsObj.eof then
ContentFileds2=rsObj(""&fileds&"")
end if
rsObj.close
set rsObj=nothing
end Function
'当前ID字段值
function ConfigFileds(id,fileds)
set rsObj= conn.db("select * from {pre}Configuration where ID="&id,"records1")
if not rsObj.eof then
ConfigFileds=rsObj(""&fileds&""&DB_FIELD&"")
end if
rsObj.close
set rsObj=nothing
end Function

'当前ID字段值
function ConfigFileds2(id,fileds)
set rsObj= conn.db("select * from {pre}Configuration where ID="&id,"records1")
if not rsObj.eof then
ConfigFileds2=rsObj(""&fileds&"")
end if
rsObj.close
set rsObj=nothing
end Function


'单篇信息内容
function ContentShow(id)

set rsObj= conn.db("select * from {pre}Navigation where ID="&id&"","records1")
if not rsObj.eof then
ContentShow=rsObj("Describe"&DB_FIELD&"")
end if
rsObj.close
set rsObj=nothing
end Function

'基本配置内容
function ConfigurationContent(id)
set rsObj= conn.db("select * from {pre}Configuration where ID="&id&"","records1")
if not rsObj.eof then
ConfigurationContent=rsObj("Describe"&DB_FIELD&"")
end if
rsObj.close
set rsObj=nothing
end Function

'基本配置页面标题
function ConfigurationTitle(id)
set rsObj= conn.db("select * from {pre}Configuration where ID="&id&"","records1")
if not rsObj.eof then
ConfigurationTitle=rsObj("PageTitle"&DB_FIELD&"")
end if
rsObj.close
set rsObj=nothing
end Function

'基本配置页面关键字
function ConfigurationKeyword(id)
set rsObj= conn.db("select * from {pre}Configuration where ID="&id&"","records1")
if not rsObj.eof then
ConfigurationKeyword=rsObj("Keywords"&DB_FIELD&"")
end if
rsObj.close
set rsObj=nothing
end Function

'基本配置页面描述
function ConfigurationDescriptions(id)
set rsObj= conn.db("select * from {pre}Configuration where ID="&id&"","records1")
if not rsObj.eof then
ConfigurationDescriptions=rsObj("Descriptions"&DB_FIELD&"")
end if
rsObj.close
set rsObj=nothing
end Function


'文章页面的页面标题
function ArticleTitle(id)
set rsObj= conn.db("select * from {pre}Product where ID="&id&"","records1")
if not rsObj.eof then
ArticleTitle=rsObj("PageTitle"&DB_FIELD&"")
end if
rsObj.close
set rsObj=nothing
end Function

'文章页面的页面关键字
function ArticleKeyword(id)
set rsObj= conn.db("select * from {pre}Product where ID="&id&"","records1")
if not rsObj.eof then
ArticleKeyword=rsObj("Keywords"&DB_FIELD&"")
end if
rsObj.close
set rsObj=nothing
end Function

'文章页面的页面描述
function ArticleDescriptions(id)
set rsObj= conn.db("select * from {pre}Product where ID="&id&"","records1")
if not rsObj.eof then
ArticleDescriptions=rsObj("Descriptions"&DB_FIELD&"")
end if
rsObj.close
set rsObj=nothing
end Function


'当前位置
sub CurrentPosition(id,ids)
dim current
set rss= conn.db("select * from {pre}Navigation where id="&id&" order by sequence,id desc","records1")
if rss.eof or rss.bof then
else
set rsw= conn.db("select * from {pre}Navigation where id="&rss("parentid")&" order by sequence,id desc","records1")
if rsw.eof or rsw.bof then
else
	Set Rsls = Conn.db("SELECT ID FROM {pre}Navigation  where ParentID="&rsw("id")&" Order By Sequence Asc","records1")
	If Not Rsls.Eof Then
		prourl = "productsclass.asp"
	else
		prourl = "products.asp"
	end if
	webtype = rsw("webType")
	lefturl=WebtypeUrl(webtype)

	if rsw("ParentID")<>0 then
		if rsw("ClassUrl"&DB_FIELD&"")<>"" then
		url=""&rsw("ClassUrl"&DB_FIELD&"")&""
		else
		url=CurrentUrl(rsw("id"))
		url=RewriteRule(url)
		end if
	else
		if rsw("ClassUrl"&DB_FIELD&"")<>"" then
		url=""&rsw("ClassUrl"&DB_FIELD&"")&""
		else
		url=""&lefturl&"?ids="&ids&""
		url=RewriteRule(url)
		end if
	end if

current="<a href="&url&"  class='wzys'>"&rsw("NavName"&DB_FIELD&"")&"</a> » "
CurrentPosition rsw("id"),ids
end if
rsw.close
set rsw=nothing
echo current
end if
rss.close
set rss=nothing
end sub


function CurrentUrl(id)
set rs= conn.db("select * from {pre}Navigation where id="&id&" and isShow"&DB_FIELD&"=1  order by sequence,id desc","records1")
	if rs.recordCount=0 Then
	Response.Write""
	else
	i=1
	do while not rs.eof
	Set Rsls = Conn.db("SELECT ID FROM {pre}Navigation  where ParentID="&rs("id")&" Order By Sequence Asc","records1")
	If Not Rsls.Eof Then
		prourl = "productsclass.asp"
	else
		prourl = "products.asp"
	end if

	webtype = rs("webType")
	lefturl=WebtypeUrl(webtype)
	n=GetPrintIDtop(rs("id"))
	previd=GetPrevID(rs("id"))
	if rs("ClassUrl"&DB_FIELD&"")<>"" then
	url=""&rs("ClassUrl"&DB_FIELD&"")&""
	CurrentUrl=url
	else
	url=""&lefturl&"?id="&rs("id")&"&WebType="&rs("WebType")&"&ids="&n&"&f_1="&previd&""
	CurrentUrl=url
	end if
	rs.movenext
	i=i+1
	loop
	end if
	rs.close
	set rs=nothing
end function


function ImgName(id)
set rsObj= conn.db("select * from {pre}Navigation where ID="&id&"","records1")
if not rsObj.eof then
if rsObj("Class_Pic"&DB_FIELD&"")<>"" then
ImgName= "<img src='"&rsObj("Class_Pic"&DB_FIELD&"")&"' />"
else
ImgName=rsObj("NavName"&DB_FIELD&"")
end if
rsObj.close
set rsObj=nothing
end if
end function

function GetDefaultNextID(id)
set rs= conn.db("select * from {pre}Navigation where ParentID="&id&" order by sequence","records1")
if rs.eof or rs.bof then
GetDefaultNextID=id
else
GetDefaultNextID=GetDefaultNextID(rs("id"))
end if
rs.close
set rs=nothing
end function

function TextName(id)
set rsObj= conn.db("select * from {pre}Navigation where ID="&id&"","records1")
if not rsObj.eof then
TextName=rsObj("NavName"&DB_FIELD&"")
rsObj.close
set rsObj=nothing
end if
end function


'单篇信息标题
function ContentTitle(id)

set rsObj= conn.db("select * from {pre}Navigation where ID="&id&"","records1")
if not rsObj.eof then
ContentTitle=rsObj("NavName"&DB_FIELD&"")
end if
rsObj.close
set rsObj=nothing
end Function

'单篇信息标题2
function ContentTitle2(id)
set rsObj= conn.db("select * from {pre}Navigation where ID="&id&"","records1")
ContentTitle2=""
if not rsObj.eof then
ContentTitle2=rsObj("NavName"&DB_FIELD&"")
end if
rsObj.close
set rsObj=nothing
end Function


function ContentTitleen(id)

set rsObj= conn.db("select * from {pre}Navigation where ID="&id&"","records1")
if not rsObj.eof then
ContentTitleen=rsObj("NavName"&DB_RE_FIELD&"")
end if
rsObj.close
set rsObj=nothing
end Function


'栏目分类名称
function ContentTitleClass(id)

set rsObj= conn.db("select * from {pre}Navigation where ID="&id&"","records1")
if rsObj.eof or rsObj.bof then
else
if rsObj("ClassName"&DB_FIELD&"")<>"" then
ContentTitleClass=rsObj("ClassName"&DB_FIELD&"")
else
ContentTitleClass=rsObj("NavName"&DB_FIELD&"")
end if
end if
rsObj.close
set rsObj=nothing
end Function


function ContentTitleClassen(id)

set rsObj= conn.db("select * from {pre}Navigation where ID="&id&"","records1")
if rsObj.eof or rsObj.bof then
else
if rsObj("ClassName"&DB_RE_FIELD&"")<>"" then
ContentTitleClassen=rsObj("ClassName"&DB_RE_FIELD&"")
else
ContentTitleClassen=rsObj("NavName"&DB_RE_FIELD&"")
end if
end if
rsObj.close
set rsObj=nothing
end Function

'电话
function ContentTel(id)

set rsObj= conn.db("select * from {pre}Configuration where ID="&id&"","records1")
if not rsObj.eof then
ContentTel=rsObj("Tel")
end if
rsObj.close
set rsObj=nothing
end Function

'地址
function ContentAddress(id)

set rsObj= conn.db("select * from {pre}Configuration where ID="&id&"","records1")
if not rsObj.eof then
ContentAddress=rsObj("Address")
end if
rsObj.close
set rsObj=nothing
end Function


'传真
function ContentFax(id)

set rsObj= conn.db("select * from {pre}Configuration where ID="&id&"","records1")
if not rsObj.eof then
ContentFax=rsObj("Fax")
end if
rsObj.close
set rsObj=nothing
end Function

'Email
function ContentEmail(id)

set rsObj= conn.db("select * from {pre}Configuration where ID="&id&"","records1")
if not rsObj.eof then
ContentEmail=rsObj("Email")
end if
rsObj.close
set rsObj=nothing
end Function

'报价Email
function ContentBjEmail(id)

set rsObj= conn.db("select * from {pre}Configuration where ID="&id&"","records1")
if not rsObj.eof then
ContentBjEmail=rsObj("BjEmail")
end if
rsObj.close
set rsObj=nothing
end Function

'留言Email
function ContentMesEmail(id)

set rsObj= conn.db("select * from {pre}Configuration where ID="&id&"","records1")
if not rsObj.eof then
ContentMesEmail=rsObj("MesEmail")
end if
rsObj.close
set rsObj=nothing
end Function


'基本配置图片
function ContentImg(id)

set rsObj= conn.db("select * from {pre}Configuration where ID="&id&"","records1")
if not rsObj.eof then
if rsObj("Class_Pic")<>"" then
ContentImg= "<img src='"&rsObj("Class_Pic")&"' />"
end if
end if
rsObj.close
set rsObj=nothing
end Function


'网站标题
function ContentPageTitle(id)
set rsObj= conn.db("select * from {pre}Navigation where ID="&id&"","records1")
if not rsObj.eof then
ContentPageTitle=rsObj("PageTitle"&DB_FIELD&"")
end if
rsObj.close
set rsObj=nothing
end Function



'网站关键字
function ContentKeywords(id)
set rsObj= conn.db("select * from {pre}Navigation where ID="&id&"","records1")
if not rsObj.eof then
ContentKeywords=rsObj("Keywords"&DB_FIELD&"")
end if
rsObj.close
set rsObj=nothing
end Function


'网站描述
function ContentDescriptions(id)
set rsObj= conn.db("select * from {pre}Navigation where ID="&id&"","records1")
if not rsObj.eof then
ContentDescriptions=rsObj("Descriptions"&DB_FIELD&"")
end if
rsObj.close
set rsObj=nothing
end function


'栏目介绍
function ContentIntroduction(id)
set rsObj= conn.db("select * from {pre}Navigation where ID="&id,"records1")
if not rsObj.eof then
ContentIntroduction=rsObj("Introduction"&DB_FIELD&"")
end if
rsObj.close
set rsObj=nothing
end Function


'版权
function ContentCopyright(id)
set rsObj= conn.db("select * from {pre}Navigation where ID="&id,"records1")
if not rsObj.eof then
ContentCopyright=rsObj("Copyright"&DB_FIELD&"")
end if
rsObj.close
set rsObj=nothing
end Function

'导读
function ContentIntro(id)
set rsObj= conn.db("select * from {pre}Navigation where ID="&id&"","records1")
if not rsObj.eof then
ContentIntro=rsObj("Intro"&DB_FIELD&"")
end if
rsObj.close
set rsObj=nothing
end Function



 '默认二级标题显示
sub DefaultImg(id)
	set rsObj= conn.db("select * from {pre}Navigation where ID="&id&" order by sequence,id desc","records1")
	set rs2= conn.db("select * from {pre}Navigation where ParentID="&rsObj("id")&"","records1")
	if not rs2.eof then
	if rs2("Class_Pic")<>"" then
	echo"<img src='"&rs2("Class_Pic")&"' width='650' height='529' />"
	end if
	end if
	rs2.close
	set rs2=nothing
	rsObj.close
	set rsObj=nothing
 end sub


'获取当前ID链接地址
function GetCurrentIdUrl(id)
	set rs= conn.db("select * from {pre}Navigation where id="&id&" and isShow"&DB_FIELD&"=1  order by sequence,id desc","records1")
	if rs.recordCount=0 Then
	Response.Write""
	else
	i=1
	do while not rs.eof
	Set Rsls = Conn.db("SELECT ID FROM {pre}Navigation  where ParentID="&rs("id")&" Order By Sequence Asc","records1")
	If Not Rsls.Eof Then
		prourl = "photosclass.asp"
	else
		prourl = "photos.asp"
	end if

	webtype = rs("webType")
	lefturl=WebtypeUrl(webtype)

	n=GetPrintIDtop(rs("id"))
	grade=GetGrade(rs("id"))
	previd=GetPrevID(rs("id"))
	previd2=GetPrevID(previd)
	previd3=GetPrevID(previd2)
	previd4=GetPrevID(previd3)
	previd5=GetPrevID(previd4)
if rs("ClassUrl"&DB_FIELD&"")<>"" then
GetCurrentIdUrl=""&rs("ClassUrl"&DB_FIELD&"")&""
else
select case grade
case 2
parm="&f_1="&previd&""
case 3
parm="&f_1="&previd&"&f_2="&previd2&""
case 4
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&""
case 5
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&"&f_4="&previd4&""
case 6
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&"&f_4="&previd4&"&f_5="&previd5&""
end select
getvalue="?id="&rs("id")&"&WebType="&rs("WebType")&"&ids="&n&""&parm&""

GetCurrentIdUrl=""&lefturl&""&getvalue&""
GetCurrentIdUrl=RewriteRule(GetCurrentIdUrl)
end if

	rs.movenext
	i=i+1
	loop
	end if
	rs.close
	set rs=nothing
end function



 '导航
function GetTopIdUrl(id)
	set RsObj=conn.db("select * from {pre}navigation where NavName"&DB_FIELD&"<>'' and id="&id&" and isShow"&DB_FIELD&"=1  order by sequence,id desc","records1")
	if RsObj.recordCount=0 Then
	Response.Write""
	else
	m=2
	while not RsObj.eof

	Set Rsls = Conn.db("SELECT ID FROM {pre}Navigation  where ParentID="&RsObj("id")&" Order By Sequence Asc","records1")
	If Not Rsls.Eof Then
		prourl = "productsclass.asp"
	else
		prourl = "products.asp"
	end if

	webtype = RsObj("webType")
	lefturl=WebtypeUrl(webtype)
	if RsObj("ClassUrl"&DB_FIELD&"")<>"" then
	GetTopIdUrl=""&RsObj("ClassUrl"&DB_FIELD&"")&""
	else
	GetTopIdUrl=""&lefturl&"?ids="&RsObj("id")&""
	GetTopIdUrl=RewriteRule(GetTopIdUrl)
	end if
	RsObj.movenext
	m=m+1
	wend
	end if
	RsObj.close : set RsObj=nothing
end function

function NavTarget(id)
	set RsObj=conn.db("select * from {pre}navigation where NavName"&DB_FIELD&"<>'' and id="&id&" and deeppath=1 and isShow"&DB_FIELD&"=1  order by sequence,id desc","records1")
	if RsObj.recordCount=0 Then
	Response.Write""
	else
	m=2
	while not RsObj.eof
	Set Rsls = Conn.db("SELECT ID FROM {pre}Navigation  where ParentID="&RsObj("id")&" Order By Sequence Asc","records1")
	If Not Rsls.Eof Then
		prourl = "productsclass.asp"
	else
		prourl = "products.asp"
	end if

	webtype = RsObj("webType")
	lefturl=WebtypeUrl(webtype)
	if RsObj("target"&DB_FIELD&"")<>"" then
	NavTarget="target='"&RsObj("target"&DB_FIELD&"")&"'"
	else
	NavTarget=""
	end if
	RsObj.movenext
	m=m+1
	wend
	end if
	RsObj.close : set RsObj=nothing
end function


'判断是否有下级
function NextNavNull(id)
set rsnull= conn.db("select * from {pre}Navigation where parentid="&id&" and isShow"&DB_FIELD&"=1  order by sequence,id desc","records1")
if rsnull.eof or rsnull.bof then
	NextNavNull=0
	else
	NextNavNull=1
	end if
rsnull.close : set rsnull=nothing
end function

'头部下拉
sub TopNavabout(id,top)
	set rs= conn.db("select "&top&" * from {pre}Navigation where parentid="&id&" and isShow"&DB_FIELD&"=1  order by sequence,id desc","records1")
	if rs.recordCount=0 Then
	Response.Write""
	else
	i=1
	do while not rs.eof
	Set Rsls = Conn.db("SELECT ID FROM {pre}Navigation  where ParentID="&rs("id")&" Order By Sequence Asc","records1")
	If Not Rsls.Eof Then
		prourl = "productsclass.asp"
	else
		prourl = "products.asp"
	end if

	webtype = rs("webType")
	lefturl=WebtypeUrl(webtype)
	n=GetPrintIDtop(rs("id"))
	previd=GetPrevID(rs("id"))
	if rs("ClassUrl"&DB_FIELD&"")<>"" then
	url=""&rs("ClassUrl"&DB_FIELD&"")&""
	else
	url=""&lefturl&"?id="&rs("id")&"&WebType="&rs("WebType")&"&ids="&n&"&f_1="&previd&""
	url=RewriteRule(url)
	end if
	if i=rs.recordcount then
	sty=" class='last'"
	else
	sty=""
	end if
	echo"<dd><a href='"&url&"' target='"&rs("target"&DB_FIELD&"")&"' title='"&rs("NavName"&DB_FIELD&"")&"'>"&rs("NavName"&DB_FIELD&"")&"</a></dd>"
	'if NextNavNull(rs("id"))=1 then
	'TopNavabout rs("id"),""
	'end if
	rs.movenext
	i=i+1
	loop
	end if
	rs.close
	set rs=nothing
end sub

sub TopNavabout2(id,top)
	set rs= conn.db("select "&top&" * from {pre}Navigation where parentid="&id&" and isShow"&DB_FIELD&"=1  order by sequence,id desc","records1")
	if rs.recordCount=0 Then
	Response.Write""
	else

	i=1
	do while not rs.eof
	Set Rsls = Conn.db("SELECT ID FROM {pre}Navigation  where ParentID="&rs("id")&" Order By Sequence Asc","records1")
	If Not Rsls.Eof Then
		prourl = "productsclass.asp"
	else
		prourl = "products.asp"
	end if

	webtype = rs("webType")
	lefturl=WebtypeUrl(webtype)
	n=GetPrintIDtop(rs("id"))
	previd=GetPrevID(rs("id"))
	if rs("ClassUrl"&DB_FIELD&"")<>"" then
	url=""&rs("ClassUrl"&DB_FIELD&"")&""
	else
	url=""&lefturl&"?id="&rs("id")&"&WebType="&rs("WebType")&"&ids="&n&"&f_1="&previd&""
	url=RewriteRule(url)
	end if
	echo"<li><a href='"&url&"' target='"&rs("target"&DB_FIELD&"")&"' title='"&rs("NavName"&DB_FIELD&"")&"' >"&rs("NavName"&DB_FIELD&"")&"</a></li>"
	rs.movenext
	i=i+1
	loop
	end if
	rs.close
	set rs=nothing
end sub

sub TopNavabout3(id,top,typ)
	set rs= conn.db("select "&top&" * from {pre}Navigation where parentid="&id&" and isShow"&DB_FIELD&"=1  order by sequence,id desc","records1")
	if rs.recordCount=0 Then
	Response.Write""
	else

	i=1
	do while not rs.eof
	Set Rsls = Conn.db("SELECT ID FROM {pre}Navigation  where ParentID="&rs("id")&" Order By Sequence Asc","records1")
	If Not Rsls.Eof Then
		prourl = "productsclass.asp"
	else
		prourl = "products.asp"
	end if

	webtype = rs("webType")
	lefturl=WebtypeUrl(webtype)
	n=GetPrintIDtop(rs("id"))
	previd=GetPrevID(rs("id"))
	if rs("ClassUrl"&DB_FIELD&"")<>"" then
	url=""&rs("ClassUrl"&DB_FIELD&"")&""
	else
	url=""&lefturl&"?id="&rs("id")&"&WebType="&rs("WebType")&"&ids="&n&"&f_1="&previd&""
	url=RewriteRule(url)
	end if
	if i=rs.recordcount then
	sty=" class='last'"
	else
	sty=""
	end if
	select case typ
	case 1
	echo"<li id='s"&rs("id")&"'><a  href='"&url&"' target='"&rs("target"&DB_FIELD&"")&"' title='"&rs("NavName"&DB_FIELD&"")&"'>"&rs("NavName"&DB_FIELD&"")&"</a></li>"
	case 2
	echo"<dt><a href='"&url&"' target='"&rs("target"&DB_FIELD&"")&"' title='"&rs("NavName"&DB_FIELD&"")&"'>"&rs("NavName"&DB_FIELD&"")&"</a></dt>"
	case 3
	echo"<li><a  href='"&url&"' target='"&rs("target"&DB_FIELD&"")&"' title='"&rs("NavName"&DB_FIELD&"")&"'>"&rs("NavName"&DB_FIELD&"")&"</a></li>"
	end select
	rs.movenext
	i=i+1
	loop
	end if
	rs.close
	set rs=nothing
end sub


'头部下拉
sub TopNavProNew(id,top)
	set rs= conn.db("select "&top&" * from {pre}Navigation where parentid="&id&" and isShow"&DB_FIELD&"=1  order by sequence,id desc","records1")
	if rs.recordCount=0 Then
	Response.Write""
	else

	i=1
	do while not rs.eof
	Set Rsls = Conn.db("SELECT ID FROM {pre}Navigation  where ParentID="&rs("id")&" Order By Sequence Asc","records1")
	If Not Rsls.Eof Then
		prourl = "productsclass.asp"
	else
		prourl = "products.asp"
	end if

	webtype = rs("webType")
	lefturl=WebtypeUrl(webtype)
	n=GetPrintIDtop(rs("id"))
	previd=GetPrevID(rs("id"))
	if rs("ClassUrl"&DB_FIELD&"")<>"" then
	url=""&rs("ClassUrl"&DB_FIELD&"")&""
	else
	url=""&lefturl&"?id="&rs("id")&"&WebType="&rs("WebType")&"&ids="&n&"&f_1="&previd&""
	url=RewriteRule(url)
	end if
	if i=rs.recordcount then
	sty=" class='last'"
	else
	sty=""
	end if
echo"<li><span><a href='"&url&"' target='"&rs("target"&DB_FIELD&"")&"' title='"&rs("NavName"&DB_FIELD&"")&"'><img src='"&rs("Class_Pic"&DB_FIELD&"")&"' alt='"&rs("NavName"&DB_FIELD&"")&"'/></a></span>"
echo"<p><a href='"&url&"' target='"&rs("target"&DB_FIELD&"")&"' title='"&rs("NavName"&DB_FIELD&"")&"'>"&rs("NavName"&DB_FIELD&"")&"</a></p>"
echo"</li>"
	rs.movenext
	i=i+1
	loop
	end if
	rs.close
	set rs=nothing
end sub




sub LeftMenu2(id)
	set rs= conn.db("select * from {pre}Navigation where  parentid="&id&" and NavName"&DB_FIELD&"<>''  and isShow"&DB_FIELD&"=1 order by sequence,id desc","records1")
	if rs.recordCount=0 Then
	Response.Write""
	else
	k=1
	do while not rs.eof

	Set Rsls = Conn.db("SELECT ID FROM {pre}Navigation  where ParentID="&rs("id")&" Order By Sequence Asc","records1")
	If Not Rsls.Eof Then
		prourl = "productsclass.asp"
	else
		prourl = "products.asp"
	end if

	webtype = rs("webType")
	lefturl=WebtypeUrl(webtype)
	n=GetPrintIDtop(rs("id"))
	previd=GetPrevID(rs("id"))
	if rs("ClassUrl"&DB_FIELD&"")<>"" then
	url=""&rs("ClassUrl"&DB_FIELD&"")&""
	else
	url=""&lefturl&"?id="&rs("id")&"&WebType="&rs("WebType")&"&ids="&n&"&f_1="&previd&""
	url=RewriteRule(url)
	end if
	echo"<dt id='s"&rs("id")&"'><a href='"&url&"' target='"&rs("target"&DB_FIELD&"")&"' title='"&rs("NavName"&DB_FIELD&"")&"'>"&rs("NavName"&DB_FIELD&"")&"</a>"
	echo"</dt>"
	LeftMenuNext2 rs("id"),rs("parentid")
rs.movenext
k=k+1
loop
end if
rs.close:set rs=nothing
end sub

sub LeftMenuNext2(parm,parentid)
'if parm<>"" and  trim(parm)=request.QueryString("id")  or trim(parm)=request.QueryString("f_1")  or  trim(parm)=request.QueryString("f_2") or  trim(parm)=request.QueryString("f_3")  or  trim(parm)=request.QueryString("f_4") or  trim(parm)=request.QueryString("f_5") then
set rsa= conn.db("select * from {pre}Navigation where  parentid="&parm&" and NavName"&DB_FIELD&"<>'' and isShow"&DB_FIELD&"=1 order by sequence,id desc","records1")
if rsa.eof or rsa.bof then
else
echo"<dd>"
	do while not rsa.eof

	Set Rsls = Conn.db("SELECT ID FROM {pre}Navigation  where ParentID="&rsa("id")&" Order By Sequence Asc","records1")
	If Not Rsls.Eof Then
		prourl = "productsclass.asp"
	else
		prourl = "products.asp"
	end if

	webtype = rsa("webType")
	lefturl=WebtypeUrl(webtype)
	n=GetPrintIDtop(rsa("id"))
	grade=GetGrade(rsa("id"))
	previd=GetPrevID(rsa("id"))
	previd2=GetPrevID(previd)
	previd3=GetPrevID(previd2)
	previd4=GetPrevID(previd3)
	previd5=GetPrevID(previd4)
	if rsa("ClassUrl"&DB_FIELD&"")<>"" then
	url2=""&rsa("ClassUrl"&DB_FIELD&"")&""
	else
select case grade
case 2
parm="&f_1="&previd&""
case 3
parm="&f_1="&previd&"&f_2="&previd2&""
case 4
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&""
case 5
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&"&f_4="&previd4&""
case 6
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&"&f_4="&previd4&"&f_5="&previd5&""
end select
getvalue="?id="&rsa("id")&"&WebType="&rsa("WebType")&"&ids="&n&""&parm&""

	url2=""&lefturl&""&getvalue&""
	url2=RewriteRule(url2)
	end if
    if NextNavNull(rsa("id"))=1 then
	jia="<span class='close' style='background-position: 100% 9px;'></span>"
	else
	jia=""
	end if


Symbol = LevelSymbol(rsa("DeepPath"))
echo"<a id='t"&rsa("id")&"' href='"&url2&"'  target='"&rsa("target"&DB_FIELD&"")&"' title='"&rsa("NavName"&DB_FIELD&"")&"'>"&rsa("NavName"&DB_FIELD&"")&"</a>"
LeftMenuNext2 rsa("id"),rsa("parentid")
rsa.movenext
loop
echo"</dd>"
end if
rsa.close : set rsa=nothing
'end if

end sub

sub LeftNone(id)
	set rs=conn.db("select  * from {pre}navigation where NavName"&DB_FIELD&"<>'' and id="&id&" and deeppath=1 and isShow"&DB_FIELD&"=1  order by sequence,id desc","records1")
	if rs.recordCount=0 Then
	Response.Write""
	else
	m=2
	while not rs.eof
	Set Rsls = Conn.db("SELECT ID FROM {pre}Navigation  where ParentID="&rs("id")&" Order By Sequence Asc","records1")
	If Not Rsls.Eof Then
		prourl = "productsclass.asp"
	else
		prourl = "products.asp"
	end if

	webtype = rs("webType")
	lefturl=WebtypeUrl(webtype)
	if rs("ClassUrl"&DB_FIELD&"")<>"" then
	url=""&rs("ClassUrl"&DB_FIELD&"")&""
	else
	url=""&lefturl&"?ids="&rs("id")&""
	url=RewriteRule(url)
	end if
	echo"<dt id='s"&rs("id")&"'><a class='current' href='"&url&"' target='"&rs("target"&DB_FIELD&"")&"' title='"&rs("NavName"&DB_FIELD&"")&"'>"&rs("NavName"&DB_FIELD&"")&"</a></dt>"
	rs.movenext
	m=m+1
	wend
	end if
	rs.close : set rs=nothing
end sub

'leftNav图片
sub NyBannerImg(ids)
	select case ids'rsObj("WebType")
	case 3
		leftimg = "<img src='images/about.jpg'/>"
	case 4
		leftimg = "<img src='images/news.jpg'/>"
	case 5
		leftimg = "<img src='images/products.jpg'/>"
	case 6
		leftimg = "<img src='images/fashion.jpg'/>"
	case 7
		leftimg = "<img src='images/inter.jpg'/>"
	case 8
		leftimg = "<img src='images/contact.jpg'/>"
	case else
		leftimg = "<img src='images/about.jpg'/>"
	end select
	echo""&leftimg&""
end sub



'leftNav图片
sub LeftNavimg(ids)
	select case ids'rsObj("WebType")
	case 3
		leftimg = "<img src='images/about.jpg' width='220' height='47' style='margin-bottom:5px;' />"
	case 4
		leftimg = "<img src='images/pro2.jpg' width='220' height='47' style='margin-bottom:5px;' />"
	case 5
		leftimg = "<img src='images/leftclass3.jpg' width='220' height='47' style='margin-bottom:5px;' />"
	case 6
		leftimg = "<img src='images/leftclass4.jpg' width='220' height='47' style='margin-bottom:5px;' />"
	case 7
		leftimg = "<img src='images/leftclass5.jpg' width='220' height='47' style='margin-bottom:5px;' />"
	case 8
		leftimg = "<img src='images/leftclass6.jpg' width='220' height='47' style='margin-bottom:5px;' />"
	case 9
		leftimg = "<img src='images/leftclass7.jpg' width='220' height='47' style='margin-bottom:5px;' />"
	case 10
		leftimg = "<img src='images/leftclass9.jpg' width='220' height='47' style='margin-bottom:5px;' />"
	end select
	echo""&leftimg&""
end sub


sub LeftMenu(id)
	set rs= conn.db("select * from {pre}Navigation where  parentid="&id&" and NavName"&DB_FIELD&"<>''  and isShow"&DB_FIELD&"=1 order by sequence,id desc","records1")
	if rs.recordCount=0 Then
	Response.Write""
	else
	k=1
	do while not rs.eof

	Set Rsls = Conn.db("SELECT ID FROM {pre}Navigation  where ParentID="&rs("id")&" Order By Sequence Asc","records1")
	If Not Rsls.Eof Then
		prourl = "productsclass.asp"
	else
		prourl = "products.asp"
	end if

	webtype = rs("webType")
	lefturl=WebtypeUrl(webtype)
	n=GetPrintIDtop(rs("id"))
	previd=GetPrevID(rs("id"))
	if rs("ClassUrl"&DB_FIELD&"")<>"" then
	url=""&rs("ClassUrl"&DB_FIELD&"")&""
	else
	url=""&lefturl&"?id="&rs("id")&"&WebType="&rs("WebType")&"&ids="&n&"&f_1="&previd&""
	url=RewriteRule(url)
	end if
	sty=""
	if k=rs.recordcount then
	sty="style='border-bottom-style:none;'"
	end if
	echo"<dt id='s"&rs("id")&"'><a href='"&url&"' target='"&rs("target"&DB_FIELD&"")&"' title='"&rs("NavName"&DB_FIELD&"")&"'>"&rs("NavName"&DB_FIELD&"")&"</a>"
	LeftMenuNext rs("id"),rs("parentid")
	echo"</dt>"
rs.movenext
k=k+1
loop
end if
rs.close:set rs=nothing
end sub

sub LeftMenuNext(parm,parentid)
if parm<>"" and  trim(parm)=request.QueryString("id")  or trim(parm)=request.QueryString("f_1")  or  trim(parm)=request.QueryString("f_2") or  trim(parm)=request.QueryString("f_3")  or  trim(parm)=request.QueryString("f_4") or  trim(parm)=request.QueryString("f_5") then
set rsa= conn.db("select * from {pre}Navigation where  parentid="&parm&" and NavName"&DB_FIELD&"<>'' and isShow"&DB_FIELD&"=1 order by sequence,id desc","records1")
if rsa.eof or rsa.bof then
else
echo"<dd><ul>"
	do while not rsa.eof

	Set Rsls = Conn.db("SELECT ID FROM {pre}Navigation  where ParentID="&rsa("id")&" Order By Sequence Asc","records1")
	If Not Rsls.Eof Then
		prourl = "productsclass.asp"
	else
		prourl = "products.asp"
	end if

	webtype = rsa("webType")
	lefturl=WebtypeUrl(webtype)
	n=GetPrintIDtop(rsa("id"))
	grade=GetGrade(rsa("id"))
	previd=GetPrevID(rsa("id"))
	previd2=GetPrevID(previd)
	previd3=GetPrevID(previd2)
	previd4=GetPrevID(previd3)
	previd5=GetPrevID(previd4)
	if rsa("ClassUrl"&DB_FIELD&"")<>"" then
	url2=""&rsa("ClassUrl"&DB_FIELD&"")&""
	else
select case grade
case 2
parm="&f_1="&previd&""
case 3
parm="&f_1="&previd&"&f_2="&previd2&""
case 4
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&""
case 5
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&"&f_4="&previd4&""
case 6
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&"&f_4="&previd4&"&f_5="&previd5&""
end select
getvalue="?id="&rsa("id")&"&WebType="&rsa("WebType")&"&ids="&n&""&parm&""

	url2=""&lefturl&""&getvalue&""
	url2=RewriteRule(url2)
	end if
    if NextNavNull(rsa("id"))=1 then
	jia="<span class='close' style='background-position: 100% 9px;'></span>"
	else
	jia=""
	end if

Symbol = LevelSymbol(rsa("DeepPath"))
echo"<li id='s"&rsa("id")&"' class='a1'><a href='"&url2&"'  target='"&rsa("target"&DB_FIELD&"")&"' title='"&rsa("NavName"&DB_FIELD&"")&"'>"&Symbol&""&rsa("NavName"&DB_FIELD&"")&"</a>"
LeftMenuNext rsa("id"),rsa("parentid")
echo"</li>"
rsa.movenext
loop
	echo"</ul></dd>"
end if
rsa.close : set rsa=nothing
end if

end sub


function LevelSymbol(n)
symbol=""
for i=3 to n
LevelSymbol=LevelSymbol&symbol
next
end function


'产品图片栏目
sub ProNav(id,ncount)
company=request.QueryString("company")
if company<>"" then
ulink="&company="&company&""
end if
	set rs= conn.db("select  * from {pre}Navigation where parentid="&id&" and isShow"&DB_FIELD&"=true order by sequence,id desc","records1")
	if rs.recordCount=0 Then
	Response.Write""
	else
	int_RPP=ncount
	int_showNumberLink_=int_showNumberLink
	showMorePageGo_Type_ = 1
	str_nonLinkColor_="#999999"
	toF_=toF
	toP10_=toP10
	toP1_=toP1
	toN1_=toN1
	toN10_=toN10
	toL_=toL
	rs.PageSize=int_RPP
	cPageNo=request("Page")
	If cPageNo="" or not isnumeric(cPageNo) Then cPageNo = 1
	cPageNo = Clng(cPageNo)
	If cPageNo<1 Then cPageNo=1
	If cPageNo>rs.PageCount Then cPageNo=rs.PageCount
	rs.AbsolutePage=cPageNo
count=0
i=1
do while not (rs.eof or rs.bof) and count<rs.PageSize

	Set Rsls = Conn.db("SELECT ID FROM {pre}Navigation  where ParentID="&rs("id")&" Order By Sequence Asc","records1")
	If Not Rsls.Eof Then
		prourl = "productsclass.asp"
	else
		prourl = "products.asp"
	end if

	webtype = rs("webType")
	lefturl=WebtypeUrl(webtype)
	if rs("ClassUrl"&DB_FIELD&"")<>"" then
	url=""&rs("ClassUrl"&DB_FIELD&"")&""
	else
	n=GetPrintIDtop(rs("id"))
	url=""&lefturl&"?id="&rs("id")&"&idrs="&rs("parentid")&"&WebType="&rs("WebType")&"&ids="&n&""&ulink&""
	url=RewriteRule(url)
	end if
echo"<li>"
echo"<a href='"&url&"' target='"&rs("target"&DB_FIELD&"")&"' title='"&rs("NavName"&DB_FIELD&"")&"'><img src='"&rs("Class_Pic")&"' width='180' height='135'  onload='AutoResizeImage(180,193,this)'/></a><br />"
echo"<div class='font'>"&rs("NavName"&DB_FIELD&"")&"</div>"
	m=GetPrintIDtop(rs("id"))
	ProNavNext rs("id"),m,url
echo"</li>"
if (i mod 3)=0 then
echo"<div class='clear'></div>"
end if

	rs.movenext
	count=count+1
	i=i+1
	loop
	end if
	rs.close
	set rs=nothing
end sub

sub ProNavNext(id,ids,path)
company=request.QueryString("company")
if company<>"" then
ulink="&company="&company&""
end if
	set rsn= conn.db("select top 4 * from {pre}Navigation where parentid="&id&" and isShow"&DB_FIELD&"=1  order by sequence,id desc","records1")
	if rsn.recordCount=0 Then
	Response.Write""
	else

	i=1
	echo"<div style='margin:7px;'>"
	do while not rsn.eof
	Set Rsls = Conn.db("SELECT ID FROM {pre}Navigation  where ParentID="&rsn("id")&" Order By Sequence Asc","records1")
	If Not Rsls.Eof Then
		prourl = "productsclass.asp"
	else
		prourl = "products.asp"
	end if

	webtype = rsn("webType")
	select case webtype'rsnObj("WebType")
	case 1'简介信息类
		lefturl = "about.asp"
	case 2'新闻展示类
		lefturl = "news.asp"
	case 3'图片展示类
		lefturl = "factory.asp"
	case 4'图文展示类
		lefturl = "cases.asp"
	case 5'资料下载类
		lefturl = "download.asp"
	case 6'产品展示类
		lefturl = "products.asp"
	case 7'客户留言
		lefturl = "#"
	case 8'招聘信息类
		lefturl = "job.asp"
	case 9'常见问题类
		lefturl = "solutions.asp"
	case 10'幻灯片类
		lefturl = "#"
	case 11'相片展示类
		lefturl = "core.asp"
	case 12'员工信息
		lefturl = "team.asp"
	case 13'合作伙伴
		lefturl = "partner.asp"
	case 14'友情链接
		lefturl = "links.asp"
	case 15'职位申请
		lefturl = "#"
	case 16'基本信息配置
		lefturl = "#"
	case 17'防伪验证
		lefturl = "#"
	case else
		lefturl = "index.asp"
	end select
	if rsn("ClassUrl"&DB_FIELD&"")<>"" then
	url=""&rsn("ClassUrl"&DB_FIELD&"")&""
	else
	url=""&lefturl&"?id="&rsn("id")&"&idrs="&rsn("parentid")&"&WebType="&rsn("WebType")&"&ids="&ids&""&ulink&""
	url=RewriteRule(url)
	end if

	echo"<p><a href='"&url&"' target='"&rsn("target"&DB_FIELD&"")&"' title='"&rsn("NavName"&DB_FIELD&"")&"'>"&rsn("NavName"&DB_FIELD&"")&"</a></p>"
	rsn.movenext
	i=i+1
	loop
	if rsn.recordcount >4 then
	echo"<a href='"&path&"'>&gt;&gt;More</a><br />"
	end if
	echo" </div>"
	end if
	rsn.close
	set rsn=nothing
end sub


sub ProNavPage(id,ncount)
	set rs= conn.db("select  * from {pre}Navigation where parentid="&id&" and isShow"&DB_FIELD&"=true order by sequence,id desc","records1")
	if rs.recordCount=0 Then
	Response.Write""
	else
	int_RPP=ncount
	int_showNumberLink_=int_showNumberLink
	showMorePageGo_Type_ = 1
	str_nonLinkColor_="#999999"
	toF_=toF
	toP10_=toP10
	toP1_=toP1
	toN1_=toN1
	toN10_=toN10
	toL_=toL
	rs.PageSize=int_RPP
	cPageNo=request("Page")
	If cPageNo="" or not isnumeric(cPageNo) Then cPageNo = 1
	cPageNo = Clng(cPageNo)
	If cPageNo<1 Then cPageNo=1
	If cPageNo>rs.PageCount Then cPageNo=rs.PageCount
	rs.AbsolutePage=cPageNo
count=0
do while not (rs.eof or rs.bof) and count<rs.PageSize
	Set Rsls = Conn.db("SELECT ID FROM {pre}Navigation  where ParentID="&rs("id")&" Order By Sequence Asc","records1")
	If Not Rsls.Eof Then
		prourl = "productsclass.asp"
	else
		prourl = "products.asp"
	end if

	webtype = rs("webType")
	lefturl=WebtypeUrl(webtype)

	if rs("ClassUrl"&DB_FIELD&"")<>"" then
	url=""&rs("ClassUrl"&DB_FIELD&"")&""
	else
	url=""&lefturl&"?id="&rs("id")&"&idid="&rs("parentid")&"&WebType="&rs("WebType")&"&ids="&request.QueryString("ids")&""
	end if
	rs.movenext
	count=count+1
	loop
	end if
	if rs.recordcount > ncount then
    response.Write( fPageCount(rs,int_showNumberLink_,str_nonLinkColor_,toF_,toP10_,toP1_,toN1_,toN10_,toL_,showMorePageGo_Type_,cPageNo)  & vbcrlf )
	end if
	rs.close
	set rs=nothing
end sub


 '默认二级标题显示
sub DefaultTitle(id)
	set rsObj= conn.db("select * from {pre}Navigation where ID="&id&" order by sequence,id desc","records1")
	set rs2= conn.db("select * from {pre}Navigation where ParentID="&rsObj("id")&" order by sequence,id desc","records1")
	if not rs2.eof then
	response.Write rs2("NavName"&DB_FIELD&"")
	end if
	rs2.close
	set rs2=nothing
	rsObj.close
	set rsObj=nothing
 end sub


 '默认二级标题显示
sub DefaultTitleen(id)
	set rsObj= conn.db("select * from {pre}Navigation where ID="&id&" order by sequence,id desc","records1")
	set rs2= conn.db("select * from {pre}Navigation where ParentID="&rsObj("id")&" order by sequence,id desc","records1")
	if not rs2.eof then
	response.Write rs2("NavName"&DB_RE_FIELD&"")
	end if
	rs2.close
	set rs2=nothing
	rsObj.close
	set rsObj=nothing
 end sub

 '默认二级内容显示
sub DefaultContent(id)
	set rsObj= conn.db("select * from {pre}Navigation where ID="&id,"records1")
	set rs2= conn.db("select * from {pre}Navigation where ParentID="&rsObj("id")&" order by Sequence","records1")
	if not rs2.eof then
	response.Write rs2("Describe"&DB_FIELD&"")
	end if
	rs2.close
	set rs2=nothing
	rsObj.close
	set rsObj=nothing
end sub


'资料列表
'ncount每页显示个数
'typ 显示类型
sub List(ids,id,ncount,typ)
if request.Form("keyword")<>"" then
keyword=request.Form("keyword")
end if
if request.QueryString("keyword")<>"" then
keyword=request.QueryString("keyword")
end if

company=request.QueryString("company")
if company<>"" then
ulink="&company="&company&""
where=" and p_material"&DB_FIELD&"="&company&""
end if

proclass=request.QueryString("proclass")

if id<>"" then
Paramet=id
else
Paramet=ids
end if


if keyword<>"" then
where=where&" and p_name"&DB_FIELD&" like '%"&keyword&"%' "
end if

if proclass<>"" then
Paramet=proclass
end if

set rsa=conn.db("select * from {pre}Navigation where id="&Paramet&" ","records1")
set rs=conn.db("select * from {pre}Product where SortID in("&rsa("ChildPath")&") "&where&" and p_name"&DB_FIELD&"<>'' and isShow"&DB_FIELD&"=true   order by Ord asc,Createdate desc,id desc","records1")
  if rs.eof or rs.bof then
  response.Write("")
  else
	if ncount=0 then
	ncount=rs.recordcount
	end if
  int_RPP=ncount
	int_showNumberLink_=int_showNumberLink
	showMorePageGo_Type_ = 1
	str_nonLinkColor_="#999999"
	toF_=toF
	toP10_=toP10
	toP1_=toP1
	toN1_=toN1
	toN10_=toN10
	toL_=toL
	rs.PageSize=int_RPP
	cPageNo=request("Page")
	If cPageNo="" or not isnumeric(cPageNo) Then cPageNo = 1
	cPageNo = Clng(cPageNo)
	If cPageNo<1 Then cPageNo=1
	If cPageNo>rs.PageCount Then cPageNo=rs.PageCount
	rs.AbsolutePage=cPageNo
count=0
k=1
	n=GetPrintIDtop(rs("id"))
	grade=GetGrade(rs("SortID"))
	previd=GetPrevID(rs("SortID"))
	previd2=GetPrevID(previd)
	previd3=GetPrevID(previd2)
	previd4=GetPrevID(previd3)
	previd5=GetPrevID(previd4)
do while not (rs.eof or rs.bof) and count<rs.PageSize

			s_imgs=rs("p_img")
			if rs("p_img"&DB_FIELD&"")<>"" then
			s_imgs=rs("p_img"&DB_FIELD&"")
			end if
			if s_imgs<>"" then
			img_arr=split(s_imgs,", ")
			for i=0 to ubound(img_arr)
			p_img=img_arr(0)
			next
			else
			p_img="default/default.png"
			end if


'获取路径文件对应的路径
aspUrl = left(p_img, InStrRev(p_img, "/"))
'获取路径对应的文件的文件名
strFilename=mid(p_img,instrrev(p_img,"/")+1)

small_img=p_img
if isUrl(aspUrl)=false then
small_img= aspUrl&"small/"&strFilename
if FileTrueOrFalse(small_img)=false then
small_img=p_img
end if
end if

select case grade
case 2
parm="&f_1="&previd&""
case 3
parm="&f_1="&previd&"&f_2="&previd2&""
case 4
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&""
case 5
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&"&f_4="&previd4&""
case 6
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&"&f_4="&previd4&"&f_5="&previd5&""
end select
getvalue="?idd="&rs("id")&"&ids="&ids&"&SortID="&rs("SortID")&"&id="&rs("SortID")&"&ord="&rs("ord")&""&parm&""
getvalue=RewriteRule(getvalue)

select case typ


case"news"
if rs("p_smallimg")<>"" then
small_img=rs("p_smallimg")
end if
con=""
if rs("p_spec"&DB_FIELD&"")<>"" then
con=CutStr(RemoveHTML(rs("p_spec"&DB_FIELD&"")),200)
else
if rs("p_description"&DB_FIELD&"")<>"" then
con=CutStr(RemoveHTML(rs("p_description"&DB_FIELD&"")),200)
end if
end if
url=DelAspExt("newshow.asp")&getvalue
title=rs("p_name"&DB_FIELD&"")
y=year(rs("Createdate"))
m=fillzero(month(rs("Createdate")))
d=fillzero(day(rs("Createdate")))
ymd=y&"-"&m&"-"&d
echo"<li><a href='"&url&"' title='"&title&"'>"&title&"</a><span class='last'>"&ymd&"</span></li>"

case "xgnews"
if rs("id")+0<>request.QueryString("idd")+0 then
url=DelAspExt("proshow.asp")&getvalue
title=rs("p_name"&DB_FIELD&"")
y=year(rs("Createdate"))
m=fillzero(month(rs("Createdate")))
d=fillzero(day(rs("Createdate")))
ymd=y&"-"&m&"-"&d
echo"<li><a  href='"&p_img&"' title='"&title&"'>"&title&"</a><span>"&ymd&"</span></li>"
end if


case"products"
if rs("p_smallimg")<>"" then
small_img=rs("p_smallimg")
end if
con=""
if rs("p_spec"&DB_FIELD&"")<>"" then
con=CutStr(RemoveHTML(rs("p_spec"&DB_FIELD&"")),100)
else
if rs("p_description"&DB_FIELD&"")<>"" then
con=CutStr(RemoveHTML(rs("p_description"&DB_FIELD&"")),100)
end if
end if
url=DelAspExt("proshow.asp")&getvalue
title=rs("p_name"&DB_FIELD&"")
echo"<li><div class='pic'><a href='"&url&"' title='"&title&"'><img src='"&small_img&"' alt='"&title&"'></a></div><p>"&title&"</p></li>"


case"video"
if rs("p_smallimg")<>"" then
small_img=rs("p_smallimg")
end if
con=""
if rs("p_spec"&DB_FIELD&"")<>"" then
con=rs("p_spec"&DB_FIELD&"")
'else
'if rs("p_description"&DB_FIELD&"")<>"" then
'con=CutStr(RemoveHTML(rs("p_description"&DB_FIELD&"")),100)
'end if
end if
url=DelAspExt("videoshow.asp")&getvalue
title=rs("p_name"&DB_FIELD&"")
video="<img src='"&small_img&"' alt='"&title&"'/>"
if rs("p_links"&DB_FIELD&"")<>"" then
url="javascript:void(0)"
video="<embed src='"&rs("p_links"&DB_FIELD&"")&"' allowFullScreen='true' quality='high' align='middle' allowScriptAccess='always' type='application/x-shockwave-flash'></embed>"
end if
echo"<li><a href='"&url&"' title='"&title&"'>"&video&"<span>"&title&"</span></a></li>"


case "xgproducts"
if rs("id")+0<>request.QueryString("idd")+0 then
url=DelAspExt("proshow.asp")&getvalue
title=rs("p_name"&DB_FIELD&"")
y=year(rs("Createdate"))
m=fillzero(month(rs("Createdate")))
d=fillzero(day(rs("Createdate")))
ymd=y&"-"&m&"-"&d
echo"<li><div class='pic'><a href='"&url&"' title='"&title&"'><img src='"&small_img&"' alt='"&title&"'></a></div><p>"&title&"</p></li>"
end if

case "factory"
if rs("p_smallimg")<>"" then
small_img=rs("p_smallimg")
end if
title=rs("p_name"&DB_FIELD&"")
echo"<li><a href='"&p_img&"' title='"&title&"' rel='example_group' target='_blank'><img src='"&small_img&"' alt='"&title&"'></a><p>"&title&"</p></li>"

case "honor"
if rs("p_smallimg")<>"" then
small_img=rs("p_smallimg")
end if
title=rs("p_name"&DB_FIELD&"")
echo"<li><a href='"&p_img&"' title='"&title&"' rel='example_group' target='_blank'><img src='"&small_img&"' alt='"&title&"'></a><span>"&title&"</span></li>"

case "download"

FullPath =rs("p_filepath"&DB_FIELD&"")
f = mid(FullPath,InStrRev(FullPath, ".")+1)

select case f
case "pdf"
timg="<img src='images/pdf_32.png' />"
case "rar"
timg="<img src='images/rar_32.png' />"
case "zip","tar","cab","uue","jar","iso"
timg="<img src='images/rar_32.png' />"
case "doc","docx"
timg="<img src='images/word_32.png' />"
case "xls","xlsx"
timg="<img src='images/excel_32.png' />"
case "ppt"
timg="<img src='images/excel_32.png' />"
case else
timg="<img src='images/none_32.png' />"
end select
y=year(rs("Createdate"))
m=fillzero(month(rs("Createdate")))
d=fillzero(day(rs("Createdate")))
ymd=y&"-"&m&"-"&d

%>
<ul>
                        <li class="download_wz"><a href="<%=rs("p_filepath"&DB_FIELD&"")%>" title="<%=rs("p_name"&DB_FIELD&"")%>" target="_blank"><%=rs("p_name"&DB_FIELD&"")%></a></li>
                        <li><%=ymd%></li>
                        <div style="clear:both"></div>
                    </ul>
                	<div style="clear:both"></div>

<%


case "partners"
echo"<li><a href='"&rs("p_links"&DB_FIELD&"")&"' target='_blank' title='"&rs("p_name"&DB_FIELD&"")&"'><img src='"&small_img&"' alt='"&rs("p_name"&DB_FIELD&"")&"' /><p></p></a></li>"

case "links"
echo"<li><a href='"&rs("p_links"&DB_FIELD&"")&"' title='"&rs("p_name"&DB_FIELD&"")&"'><img src='"&small_img&"' width='131' height='48'  onload='AutoResizeImage(131,48,this)'/></a></li>"
if (k mod 5)=0 then
echo"<div class='clear'></div>"
end if

case "jobs"
%>
<dl>
                    <dt class="clearfix">
                        <span><%=rs("p_name"&DB_FIELD&"")%></span>
                        <span><%=rs("p_type"&DB_FIELD&"")%></span>
                        <span><%=rs("p_features"&DB_FIELD&"")%></span>
                        <span><%=rs("p_number"&DB_FIELD&"")%></span>
                        <span><a>了解详情</a></span>
                    </dt>
                    <dd>
                        <h2>	任职要求</h2>
                        <div><%=rs("p_description"&DB_FIELD&"")%></div>

                        <a href="mailto:<%=ContentBjEmail(1)%>">应聘该职位</a>
                    </dd>
                </dl>



<%
case else
end  select

  rs.movenext
  count=count+1
  k=k+1
  loop
  end if
end sub


function Fid(id)
set rsfid= conn.db("select parentid  from {pre}Navigation where ID="&id,"records1")
if rsfid.eof or rsfid.bof then
else
Fid=rsfid("parentid")
end if
rsfid.close
set rsfid=nothing
end Function



'资料列表分页
sub Listpage(ids,id,ncount,typ)
if request.Form("keyword")<>"" then
keyword=request.Form("keyword")
end if
if request.QueryString("keyword")<>"" then
keyword=request.QueryString("keyword")
end if

company=request.QueryString("company")
if company<>"" then
ulink="&company="&company&""
where=" and p_material"&DB_FIELD&"="&company&""
end if

proclass=request.QueryString("proclass")

if id<>"" then
Paramet=id
else
Paramet=ids
end if


if keyword<>"" then
where=where&" and p_name"&DB_FIELD&" like '%"&keyword&"%' "
end if

if proclass<>"" then
Paramet=proclass
end if

set rsa=conn.db("select * from {pre}Navigation where id="&Paramet&" ","records1")
set rs=conn.db("select * from {pre}Product where SortID in("&rsa("ChildPath")&") "&where&" and p_name"&DB_FIELD&"<>'' and isShow"&DB_FIELD&"=true   order by Ord asc,Createdate desc,id desc","records1")
  if rs.eof or rs.bof then
  response.Write("")
  else
if ncount=0 then
ncount=rs.recordcount
end if
  int_RPP=ncount
	int_showNumberLink_=int_showNumberLink
	showMorePageGo_Type_ = 1
	str_nonLinkColor_="#999999"
	toF_=toF
	toP10_=toP10
	toP1_=toP1
	toN1_=toN1
	toN10_=toN10
	toL_=toL
	rs.PageSize=int_RPP
	cPageNo=request("Page")
	If cPageNo="" or not isnumeric(cPageNo) Then cPageNo = 1
	cPageNo = Clng(cPageNo)
	If cPageNo<1 Then cPageNo=1
	If cPageNo>rs.PageCount Then cPageNo=rs.PageCount
	rs.AbsolutePage=cPageNo
count=0
do while not (rs.eof or rs.bof) and count<rs.PageSize

			s_imgs=rs("p_img")
			if rs("p_img"&DB_FIELD&"")<>"" then
			s_imgs=rs("p_img"&DB_FIELD&"")
			end if
			if s_imgs<>"" then
			img_arr=split(s_imgs,", ")
			for i=0 to ubound(img_arr)
			p_img=img_arr(0)
			next
			else
			p_img="default/default.png"
			end if


  rs.movenext
  count=count+1
  loop
  end if
	if rs.recordcount > ncount then
    response.Write( fPageCount(rs,int_showNumberLink_,str_nonLinkColor_,toF_,toP10_,toP1_,toN1_,toN10_,toL_,showMorePageGo_Type_,cPageNo)  & vbcrlf )
	end if
end sub



sub FxItme(ids,id,ncount,typ)
if id<>"" then
Paramet=id
else
Paramet=ids
end if
if fxid<>"" then
where=where&" and p_material"&DB_FIELD&" = "&fxid&" "
end if
if fx_1<>"" then
where=where&" and fx_1 = true "
end if
if fx_2<>"" then
where=where&" and fx_2 = true "
end if
if fx_3<>"" then
where=where&" and fx_3 = true "
end if
if fx_4<>"" then
where=where&" and fx_4 = true "
end if
if fx_5<>"" then
where=where&" and fx_5 = true "
end if
if fx_6<>"" then
where=where&" and fx_6 = true "
end if
if fx_7<>"" then
where=where&" and fx_7 = true "
end if
if fx_8<>"" then
where=where&" and fx_8 = true "
end if
if fx_9<>"" then
where=where&" and fx_9 = true "
end if
if fx_10<>"" then
where=where&" and fx_10 = true "
end if


set rsa=conn.db("select * from {pre}Navigation where id="&Paramet&" ","records1")
set rs=conn.db("select * from {pre}Fxqd where SortID in("&rsa("ChildPath")&") "&where&" and p_name"&DB_FIELD&"<>'' and isShow"&DB_FIELD&"=true   order by Ord asc,Createdate desc,id desc","records1")
  if rs.eof or rs.bof then
  response.Write("")
  else
	if ncount=0 then
	ncount=rs.recordcount
	end if
  int_RPP=ncount
	int_showNumberLink_=int_showNumberLink
	showMorePageGo_Type_ = 1
	str_nonLinkColor_="#999999"
	toF_=toF
	toP10_=toP10
	toP1_=toP1
	toN1_=toN1
	toN10_=toN10
	toL_=toL
	rs.PageSize=int_RPP
	cPageNo=request("Page")
	If cPageNo="" or not isnumeric(cPageNo) Then cPageNo = 1
	cPageNo = Clng(cPageNo)
	If cPageNo<1 Then cPageNo=1
	If cPageNo>rs.PageCount Then cPageNo=rs.PageCount
	rs.AbsolutePage=cPageNo
count=0
k=1
	n=GetPrintIDtop(rs("id"))
	grade=GetGrade(rs("SortID"))
	previd=GetPrevID(rs("SortID"))
	previd2=GetPrevID(previd)
	previd3=GetPrevID(previd2)
	previd4=GetPrevID(previd3)
	previd5=GetPrevID(previd4)
do while not (rs.eof or rs.bof) and count<rs.PageSize

			s_imgs=rs("p_img")
			if rs("p_img"&DB_FIELD&"")<>"" then
			s_imgs=rs("p_img"&DB_FIELD&"")
			end if
			if s_imgs<>"" then
			img_arr=split(s_imgs,", ")
			for i=0 to ubound(img_arr)
			p_img=img_arr(0)
			next
			else
			p_img="default/default.png"
			end if


'获取路径文件对应的路径
aspUrl = left(p_img, InStrRev(p_img, "/"))
'获取路径对应的文件的文件名
strFilename=mid(p_img,instrrev(p_img,"/")+1)

small_img=p_img
if isUrl(aspUrl)=false then
small_img= aspUrl&"small/"&strFilename
if FileTrueOrFalse(small_img)=false then
small_img=p_img
end if
end if

select case grade
case 2
parm="&f_1="&previd&""
case 3
parm="&f_1="&previd&"&f_2="&previd2&""
case 4
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&""
case 5
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&"&f_4="&previd4&""
case 6
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&"&f_4="&previd4&"&f_5="&previd5&""
end select
getvalue="?idd="&rs("id")&"&ids="&ids&"&SortID="&rs("SortID")&"&id="&rs("SortID")&"&ord="&rs("ord")&""&parm&""
getvalue=RewriteRule(getvalue)

select case typ

case"fx"
if rs("p_smallimg")<>"" then
small_img=rs("p_smallimg")
end if
con=""
if rs("p_spec"&DB_FIELD&"")<>"" then
con=rs("p_spec"&DB_FIELD&"")
'else
'if rs("p_description"&DB_FIELD&"")<>"" then
'con=CutStr(RemoveHTML(rs("p_description"&DB_FIELD&"")),100)
'end if
end if
url=DelAspExt("proshow.asp")&getvalue
title=rs("p_name"&DB_FIELD&"")

fx_1="交流/直流电源"
fx_2="轨道式"
fx_3="模块型"
fx_4="LED 电源"
fx_5="19”机箱式"
fx_6="基板型"
fx_7="适配器"
fx_8="直流/直流转换器 "
fx_9="充电器"
fx_10="直流/交流逆变器"

if rs("fx_1")=true then
cl_1=" class='q'"
end if
if rs("fx_2")=true then
cl_2=" class='q'"
end if
if rs("fx_3")=true then
cl_3=" class='q'"
end if
if rs("fx_4")=true then
cl_4=" class='q'"
end if
if rs("fx_5")=true then
cl_5=" class='q'"
end if
if rs("fx_6")=true then
cl_6=" class='q'"
end if
if rs("fx_7")=true then
cl_7=" class='q'"
end if
if rs("fx_8")=true then
cl_8=" class='q'"
end if
if rs("fx_9")=true then
cl_9=" class='q'"
end if
if rs("fx_10")=true then
cl_10=" class='q'"
end if
echo"<li><div class='tp'>"
echo"<h3 class='fxs_logo'><img src='"&small_img&"' alt='"&title&"'></h3>"
echo"<div class='qnmd'> <b>"&title&"</b>"&rs("p_spec"&DB_FIELD&"")&"</div>"
echo"</div>"
echo"<dl>"
echo"<dt>Product lines</dt>"
echo"<dd "&cl_1&"><p>"&fx_1&"</p></dd>"
echo"<dd "&cl_2&"><p>"&fx_2&"</p></dd>"
echo"<dd "&cl_3&"><p>"&fx_3&"</p></dd>"
echo"<dd "&cl_4&"><p>"&fx_4&"</p></dd>"
echo"<dd "&cl_5&"><p>"&fx_5&"</p></dd>"
echo"<dd "&cl_6&"><p>"&fx_6&"</p></dd>"
echo"<dd "&cl_7&"><p>"&fx_7&"</p></dd>"
echo"<dd "&cl_8&"><p>"&fx_8&"</p></dd>"
echo"<dd "&cl_9&"><p>"&fx_9&"</p></dd>"
echo"<dd "&cl_01&"><p>"&fx_0&"</p></dd>"
echo"</dl>"
echo"</li>"

case else
end  select

  rs.movenext
  count=count+1
  k=k+1
  loop
  end if
end sub

sub List2(id,ncount,typ)
ids=request.QueryString("ids")
if id<>"" then
Paramet=id
else
Paramet=ids
end if
set rsa=conn.db("select * from {pre}Navigation where id="&Paramet&" ","records1")
set rs=conn.db("select * from {pre}Product where SortID in("&rsa("ChildPath")&") and p_name"&DB_FIELD&"<>'' and isShow"&DB_FIELD&"=true   order by Ord asc,Createdate desc,id desc","records1")
  if rs.eof or rs.bof then
  response.Write("")
  else
if ncount=0 then
ncount=rs.recordcount
end if
  int_RPP=ncount
	int_showNumberLink_=int_showNumberLink
	showMorePageGo_Type_ = 1
	str_nonLinkColor_="#999999"
	toF_=toF
	toP10_=toP10
	toP1_=toP1
	toN1_=toN1
	toN10_=toN10
	toL_=toL
	rs.PageSize=int_RPP
	cPageNo=request("Page")
	If cPageNo="" or not isnumeric(cPageNo) Then cPageNo = 1
	cPageNo = Clng(cPageNo)
	If cPageNo<1 Then cPageNo=1
	If cPageNo>rs.PageCount Then cPageNo=rs.PageCount
	rs.AbsolutePage=cPageNo
count=0
k=1
idid=Fid(rs("SortID"))
do while not (rs.eof or rs.bof) and count<rs.PageSize

			s_imgs=rs("p_img")
			if rs("p_img"&DB_FIELD&"")<>"" then
			s_imgs=rs("p_img"&DB_FIELD&"")
			end if
			if s_imgs<>"" then
			img_arr=split(s_imgs,", ")
			for i=0 to ubound(img_arr)
			p_img=img_arr(0)
			next
			else
			p_img="default/default.png"
			end if


'获取路径文件对应的路径
aspUrl = left(p_img, InStrRev(p_img, "/"))
'获取路径对应的文件的文件名
strFilename=mid(p_img,instrrev(p_img,"/")+1)

small_img=p_img
if isUrl(aspUrl)=false then
small_img= aspUrl&"small/"&strFilename
if FileTrueOrFalse(small_img)=false then
small_img=p_img
end if
end if

select case typ

case "news"

case "products"

case "links"
if k<>1 then
echo" | "
end if
echo"<a href='"&rs("p_links"&DB_FIELD&"")&"' title='"&rs("p_name"&DB_FIELD&"")&"' target='_blank'>"&rs("p_name"&DB_FIELD&"")&"</a>"

case "piclinks"
if rs("p_smallimg")<>"" then
small_img=rs("p_smallimg")
end if
con=""
if rs("p_spec"&DB_FIELD&"")<>"" then
con=CutStr(RemoveHTML(rs("p_spec"&DB_FIELD&"")),100)
else
if rs("p_description"&DB_FIELD&"")<>"" then
con=CutStr(RemoveHTML(rs("p_description"&DB_FIELD&"")),100)
end if
end if
title=rs("p_name"&DB_FIELD&"")
sty=""
if (k mod 2)=0 then
sty=" index-ys2"
end if
echo"<div class='col-sm-4 index-ys1 "&sty&"'>"
if (k mod 2)=1 then
echo"<a class='index-ysimg2' href='"&rs("p_links"&DB_FIELD&"")&"' title='"&rs("p_name"&DB_FIELD&"")&"'><img src='"&small_img&"' alt='"&title&"'></a>"
end if
echo"<div class='index-ys-textbox'>"
echo"<a class='index-yslinks index-ystitle' href='"&rs("p_links"&DB_FIELD&"")&"' title='"&rs("p_name"&DB_FIELD&"")&"'><b>"&rs("p_name"&DB_FIELD&"")&"</b></a>"
echo"<p>"&con&"</p>"
echo"</div>"
if (k mod 2)=0 then
echo"<a class='index-ysimg2' href='"&rs("p_links"&DB_FIELD&"")&"' title='"&rs("p_name"&DB_FIELD&"")&"'><img src='"&small_img&"' alt='"&title&"'></a>"
end if
echo"</div>"


case "partners"
title=rs("p_name"&DB_FIELD&"")
echo"<li><a href='"&rs("p_links"&DB_FIELD&"")&"' title='"&title&"' target='_blank'><img src='"&small_img&"' alt='"&title&"' /><span>"&title&"</span></a></li>"
case "jobs"

case else
end  select

  rs.movenext
  count=count+1
  k=k+1
  loop
  end if
end sub


'资料列表分页
sub Listpage2(id,ncount,typ)
ids=request.QueryString("ids")
if id<>"" then
Paramet=id
else
Paramet=ids
end if
set rsa=conn.db("select * from {pre}Navigation where id="&Paramet&" ","records1")
set rs=conn.db("select * from {pre}Product where SortID in("&rsa("ChildPath")&") and p_name"&DB_FIELD&"<>'' and isShow"&DB_FIELD&"=true   order by Ord asc,Createdate desc,id desc","records1")
  if rs.eof or rs.bof then
  response.Write("")
  else
if ncount=0 then
ncount=rs.recordcount
end if
  int_RPP=ncount
	int_showNumberLink_=int_showNumberLink
	showMorePageGo_Type_ = 1
	str_nonLinkColor_="#999999"
	toF_=toF
	toP10_=toP10
	toP1_=toP1
	toN1_=toN1
	toN10_=toN10
	toL_=toL
	rs.PageSize=int_RPP
	cPageNo=request("Page")
	If cPageNo="" or not isnumeric(cPageNo) Then cPageNo = 1
	cPageNo = Clng(cPageNo)
	If cPageNo<1 Then cPageNo=1
	If cPageNo>rs.PageCount Then cPageNo=rs.PageCount
	rs.AbsolutePage=cPageNo
count=0
do while not (rs.eof or rs.bof) and count<rs.PageSize

			s_imgs=rs("p_img")
			if rs("p_img"&DB_FIELD&"")<>"" then
			s_imgs=rs("p_img"&DB_FIELD&"")
			end if
			if s_imgs<>"" then
			img_arr=split(s_imgs,", ")
			for i=0 to ubound(img_arr)
			p_img=img_arr(0)
			next
			else
			p_img="default/default.png"
			end if


  rs.movenext
  count=count+1
  loop
  end if
	if rs.recordcount > ncount then
    response.Write( fPageCount(rs,int_showNumberLink_,str_nonLinkColor_,toF_,toP10_,toP1_,toN1_,toN10_,toL_,showMorePageGo_Type_,cPageNo)  & vbcrlf )
	end if
end sub



'资料推荐
'idsr顶级ID
'topn显示前多少条
'ncount每页显示几条
sub ListIsNew(id,idsr,typ,topn,ncount)
if id<>"" then
Paramet=id
else
Paramet=ids
end if
set rsa=conn.db("select * from {pre}Navigation where id="&Paramet&" ","records1")
set rs=conn.db("select "&topn&" * from {pre}Product where SortID in("&rsa("ChildPath")&") and p_name"&DB_FIELD&"<>'' and IsNew=true and isShow"&DB_FIELD&"=true   order by Ord asc, Createdate desc,id desc","records1")
  if rs.eof or rs.bof then
  response.Write("")
  else
  k=1
	n=GetPrintIDtop(rs("id"))
	grade=GetGrade(rs("SortID"))
	previd=GetPrevID(rs("SortID"))
	previd2=GetPrevID(previd)
	previd3=GetPrevID(previd2)
	previd4=GetPrevID(previd3)
	previd5=GetPrevID(previd4)

if ncount=0 then
ncount=rs.recordcount
end if
  int_RPP=ncount
	int_showNumberLink_=int_showNumberLink
	showMorePageGo_Type_ = 1
	str_nonLinkColor_="#999999"
	toF_=toF
	toP10_=toP10
	toP1_=toP1
	toN1_=toN1
	toN10_=toN10
	toL_=toL
	rs.PageSize=int_RPP
	cPageNo=request("Page")
	If cPageNo="" or not isnumeric(cPageNo) Then cPageNo = 1
	cPageNo = Clng(cPageNo)
	If cPageNo<1 Then cPageNo=1
	If cPageNo>rs.PageCount Then cPageNo=rs.PageCount
	rs.AbsolutePage=cPageNo
count=0
do while not (rs.eof or rs.bof) and count<rs.PageSize
            s_imgs=rs("p_img")
			if rs("p_img"&DB_FIELD&"")<>"" then
			s_imgs=rs("p_img"&DB_FIELD&"")
			end if
			if s_imgs<>"" then
			img_arr=split(s_imgs,", ")
			for i=0 to ubound(img_arr)
			p_img=img_arr(0)
			next
			else
			p_img="default/default.png"
			end if


'获取路径文件对应的路径
aspUrl = left(p_img, InStrRev(p_img, "/"))
'获取路径对应的文件的文件名
strFilename=mid(p_img,instrrev(p_img,"/")+1)

small_img=p_img
if isUrl(aspUrl)=false then
small_img= aspUrl&"small/"&strFilename
if FileTrueOrFalse(small_img)=false then
small_img=p_img
end if
end if

select case grade
case 2
parm="&f_1="&previd&""
case 3
parm="&f_1="&previd&"&f_2="&previd2&""
case 4
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&""
case 5
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&"&f_4="&previd4&""
case 6
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&"&f_4="&previd4&"&f_5="&previd5&""
end select
getvalue="?idd="&rs("id")&"&ids="&idsr&"&SortID="&rs("SortID")&"&id="&rs("SortID")&"&ord="&rs("ord")&""&parm&""
getvalue=RewriteRule(getvalue)

select case typ

case"newsfirst"
if k=1 then
if rs("p_smallimg")<>"" then
small_img=rs("p_smallimg")
end if
con=""
if rs("p_spec"&DB_FIELD&"")<>"" then
con=CutStr(RemoveHTML(rs("p_spec"&DB_FIELD&"")),50)
else
if rs("p_description"&DB_FIELD&"")<>"" then
con=CutStr(RemoveHTML(rs("p_description"&DB_FIELD&"")),50)
end if
end if
url=DelAspExt("newshow.asp")&getvalue
title=rs("p_name"&DB_FIELD&"")
y=year(rs("Createdate"))
m=fillzero(month(rs("Createdate")))
d=fillzero(day(rs("Createdate")))
ymd=y&"-"&m&"-"&d
echo"<div class='index-news-right-tt'>"
echo"<div class='fl index-news-right-tu'><img src='"&small_img&"' alt='"&title&"' width='215' height='132'></div>"
echo"<div class='fr index-news-right-nt'>"
echo"   <div class='index-news-right-title'><a href='"&url&"' title='"&title&"'>"&title&"</a></div>"
echo"   <div class='index-news-right-content lineheight'>"&con&"</div>"
echo"   <div class='index-news-right-more'><a href='"&url&"' title='"&title&"'>View details&gt;&gt;</a></div>"
echo"</div>"
echo"</div>"
end if


case"news"
if k>1 then
if rs("p_smallimg")<>"" then
small_img=rs("p_smallimg")
end if
con=""
if rs("p_spec"&DB_FIELD&"")<>"" then
con=CutStr(RemoveHTML(rs("p_spec"&DB_FIELD&"")),50)
else
if rs("p_description"&DB_FIELD&"")<>"" then
con=CutStr(RemoveHTML(rs("p_description"&DB_FIELD&"")),50)
end if
end if
url=DelAspExt("newshow.asp")&getvalue
title=rs("p_name"&DB_FIELD&"")
y=year(rs("Createdate"))
m=fillzero(month(rs("Createdate")))
d=fillzero(day(rs("Createdate")))
ymd=y&"-"&m&"-"&d
echo"<li><span class='fr rq1'>"&ymd&"</span><a title='"&title&"' href='"&url&"' title='"&title&"'>"&title&" </a></li>"
end if


case"products"
if rs("p_smallimg")<>"" then
small_img=rs("p_smallimg")
end if
con=""
if rs("p_spec"&DB_FIELD&"")<>"" then
con=CutStr(RemoveHTML(rs("p_spec"&DB_FIELD&"")),30)
else
if rs("p_description"&DB_FIELD&"")<>"" then
con=CutStr(RemoveHTML(rs("p_description"&DB_FIELD&"")),30)
end if
end if
url=DelAspExt("proshow.asp")&getvalue
title=rs("p_name"&DB_FIELD&"")
y=year(rs("Createdate"))
m=fillzero(month(rs("Createdate")))
d=fillzero(day(rs("Createdate")))
ymd=y&"-"&m&"-"&d
echo"<li>"
echo"<a href='"&url&"' title='"&title&"'>"
echo"<img src='"&small_img&"' alt='"&title&"' width='275' height='217' />"
echo"<span class='so'></span>"
echo"</a>"
echo"</li>"


case"faq"
if rs("p_smallimg")<>"" then
small_img=rs("p_smallimg")
end if
con=""
if rs("p_spec"&DB_FIELD&"")<>"" then
con=CutStr(RemoveHTML(rs("p_spec"&DB_FIELD&"")),50)
else
if rs("p_description"&DB_FIELD&"")<>"" then
con=CutStr(RemoveHTML(rs("p_description"&DB_FIELD&"")),50)
end if
end if
url=DelAspExt("newshow.asp")&getvalue
title=rs("p_name"&DB_FIELD&"")
y=year(rs("Createdate"))
m=fillzero(month(rs("Createdate")))
d=fillzero(day(rs("Createdate")))
ymd=y&"-"&m&"-"&d
echo"<div class='index-news-left-hz'>"
echo"<div class='index-news-left-wen'><img src='images/index_30.jpg' width='15' height='15'> <a href='"&url&"' title='"&title&"'>"&title&"</a></div>"
echo"<div class='index-news-left-da lineheight'><img src='images/index_36.jpg' width='15' height='15'>"&con&"</div>"
echo"</div> "

case "download"

FullPath =rs("p_filepath"&DB_FIELD&"")
f = mid(FullPath,InStrRev(FullPath, ".")+1)

select case f
case "pdf"
timg="<img src='images/pdf_32.png' />"
case "rar"
timg="<img src='images/rar_32.png' />"
case "zip","tar","cab","uue","jar","iso"
timg="<img src='images/rar_32.png' />"
case "doc","docx"
timg="<img src='images/word_32.png' />"
case "xls","xlsx"
timg="<img src='images/excel_32.png' />"
case "ppt"
timg="<img src='images/excel_32.png' />"
case else
timg="<img src='images/none_32.png' />"
end select
%>
 <tr>
            <td height="38" align="center" bgcolor="#FFFFFF"><%=rs("p_name"&DB_FIELD&"")%></td>
            <td height="38" align="center" bgcolor="#FFFFFF"><span><span style="line-height:normal;"><%=rs("p_description"&DB_FIELD&"")%></span></span></td>
            <td height="38" align="center" bgcolor="#FFFFFF"><a href="<%=rs("p_filepath"&DB_FIELD&"")%>" target="_blank"><img src="images/down.gif" width="23" height="20" border="0"></a></td>
          </tr>
<%


case "honor"
title=rs("p_name"&DB_FIELD&"")
echo"<li><img src='"&small_img&"' alt='"&title&"'></li>"

case "factory"
title=rs("p_name"&DB_FIELD&"")
echo"<td align=center>"
echo"<div class='index-about-tu'>"
echo"<a href='"&GetCurrentIdUrl(rs("sortId"))&"' title='"&title&"'>"
echo"<img src='"&small_img&"' alt='"&title&"' width='241' height='190' /><br />"&title&"</a>"
echo"</div>"
echo"</td>"

case "partners"
echo"<li><a href='"&rs("p_links"&DB_FIELD&"")&"' target='_blank' title='"&rs("p_name"&DB_FIELD&"")&"'><img src='"&small_img&"' alt='"&rs("p_name"&DB_FIELD&"")&"'/></a></li>"

case else
end select

 rs.movenext
 count=count+1
  k=k+1
  loop
  end if
end sub

'资料推荐
'idsr顶级ID
'topn显示前多少条
'ncount每页显示几条
sub ListIsNewPage(id,idsr,typ,topn,ncount)
if id<>"" then
Paramet=id
else
Paramet=ids
end if
set rsa=conn.db("select * from {pre}Navigation where id="&Paramet&" ","records1")
set rs=conn.db("select "&topn&" * from {pre}Product where SortID in("&rsa("ChildPath")&") and p_name"&DB_FIELD&"<>'' and IsNew=true and isShow"&DB_FIELD&"=true   order by Ord asc,Createdate desc,id desc","records1")
  if rs.eof or rs.bof then
  response.Write("")
  else
  k=1

idid=Fid(rs("SortID"))

if ncount=0 then
ncount=rs.recordcount
end if
  int_RPP=ncount
	int_showNumberLink_=int_showNumberLink
	showMorePageGo_Type_ = 1
	str_nonLinkColor_="#999999"
	toF_=toF
	toP10_=toP10
	toP1_=toP1
	toN1_=toN1
	toN10_=toN10
	toL_=toL
	rs.PageSize=int_RPP
	cPageNo=request("Page")
	If cPageNo="" or not isnumeric(cPageNo) Then cPageNo = 1
	cPageNo = Clng(cPageNo)
	If cPageNo<1 Then cPageNo=1
	If cPageNo>rs.PageCount Then cPageNo=rs.PageCount
	rs.AbsolutePage=cPageNo
count=0
do while not (rs.eof or rs.bof) and count<rs.PageSize
            s_imgs=rs("p_img")
			if rs("p_img"&DB_FIELD&"")<>"" then
			s_imgs=rs("p_img"&DB_FIELD&"")
			end if
			if s_imgs<>"" then
			img_arr=split(s_imgs,", ")
			for i=0 to ubound(img_arr)
			p_img=img_arr(0)
			next
			else
			p_img="default/default.png"
			end if


 rs.movenext
 count=count+1
  k=k+1
  loop
  end if
  	if rs.recordcount > ncount then
    response.Write( fPageCount(rs,int_showNumberLink_,str_nonLinkColor_,toF_,toP10_,toP1_,toN1_,toN10_,toL_,showMorePageGo_Type_,cPageNo)  & vbcrlf )
	end if

end sub



'资料推荐
'idsr顶级ID
'topn显示前多少条
sub ListIsHot(id,idsr,typ,topn,ncount)
if id<>"" then
Paramet=id
else
Paramet=ids
end if
set rsa=conn.db("select * from {pre}Navigation where id="&Paramet&" ","records1")
set rs=conn.db("select "&topn&" * from {pre}Product where SortID in("&rsa("ChildPath")&") and p_name"&DB_FIELD&"<>'' and IsHot=true and isShow"&DB_FIELD&"=true   order by Ord asc,Createdate desc,id desc","records1")
  if rs.eof or rs.bof then
  response.Write("")
  else
  k=1

	n=GetPrintIDtop(rs("id"))
	grade=GetGrade(rs("SortID"))
	previd=GetPrevID(rs("SortID"))
	previd2=GetPrevID(previd)
	previd3=GetPrevID(previd2)
	previd4=GetPrevID(previd3)
	previd5=GetPrevID(previd4)

if ncount=0 then
ncount=rs.recordcount
end if
  int_RPP=ncount
	int_showNumberLink_=int_showNumberLink
	showMorePageGo_Type_ = 1
	str_nonLinkColor_="#999999"
	toF_=toF
	toP10_=toP10
	toP1_=toP1
	toN1_=toN1
	toN10_=toN10
	toL_=toL
	rs.PageSize=int_RPP
	cPageNo=request("Page")
	If cPageNo="" or not isnumeric(cPageNo) Then cPageNo = 1
	cPageNo = Clng(cPageNo)
	If cPageNo<1 Then cPageNo=1
	If cPageNo>rs.PageCount Then cPageNo=rs.PageCount
	rs.AbsolutePage=cPageNo
count=0
do while not (rs.eof or rs.bof) and count<rs.PageSize
            s_imgs=rs("p_img")
			if rs("p_img"&DB_FIELD&"")<>"" then
			s_imgs=rs("p_img"&DB_FIELD&"")
			end if
			if s_imgs<>"" then
			img_arr=split(s_imgs,", ")
			for i=0 to ubound(img_arr)
			p_img=img_arr(0)
			next
			else
			p_img="default/default.png"
			end if


'获取路径文件对应的路径
aspUrl = left(p_img, InStrRev(p_img, "/"))
'获取路径对应的文件的文件名
strFilename=mid(p_img,instrrev(p_img,"/")+1)

small_img=p_img
if isUrl(aspUrl)=false then
small_img= aspUrl&"small/"&strFilename
if FileTrueOrFalse(small_img)=false then
small_img=p_img
end if
end if

select case grade
case 2
parm="&f_1="&previd&""
case 3
parm="&f_1="&previd&"&f_2="&previd2&""
case 4
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&""
case 5
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&"&f_4="&previd4&""
case 6
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&"&f_4="&previd4&"&f_5="&previd5&""
end select
getvalue="?idd="&rs("id")&"&ids="&idsr&"&SortID="&rs("SortID")&"&id="&rs("SortID")&"&ord="&rs("ord")&""&parm&""
getvalue=RewriteRule(getvalue)

select case typ

case "news"
echo"<div class='news_zx'>"
echo"<div class='news_zx_left'><a href='"&DelAspExt("newshow.asp")&""&getvalue&"' title='"&rs("p_name"&DB_FIELD&"")&"'><img src='"&small_img&"'' border='0'; /></a></div>"
echo"<div class='news_zx_right'>"
echo"<h2><a href='"&DelAspExt("newshow.asp")&""&getvalue&"' title='"&rs("p_name"&DB_FIELD&"")&"'>"&rs("p_name"&DB_FIELD&"")&"</a></h2>"
echo"<p>"&rs("p_spec"&DB_FIELD&"")&"</p>"
echo"<span style='float:right; font-size:12px; color:#666666;  padding-right:18px;'>"& year(rs("Createdate"))&"-"&fillzero(month(rs("Createdate")))&"-"&fillzero(day(rs("Createdate")))&"</span>"
echo"<p><a href='"&DelAspExt("newshow.asp")&""&getvalue&"' title='"&rs("p_name"&DB_FIELD&"")&"'>+ 更多</a></p>"
echo"</div>"
echo"</div>"


case "products"
echo"<dl>"
echo"<dt><a href='"&DelAspExt("product.asp")&""&getvalue&"'><img src='"&small_img&"' border='0' /></a></dt>"
echo"<dd>"&rs("p_name"&DB_FIELD&"")&"</dd>"
echo"</dl>"


case "partners"
echo"<li><a href='"&rs("p_links"&DB_FIELD&"")&"' target='_blank'><img src='"&small_img&"' width='94' height='35' border='0'  onload='AutoResizeImage(94,35,this)'/></a></li>"

case else
end select

 rs.movenext
 count=count+1
  k=k+1
  loop
  end if
end sub

'资料推荐
'idsr顶级ID
'topn显示前多少条
'ncount每页显示几条
sub ListIsHotPage(id,idsr,typ,topn,ncount)
if id<>"" then
Paramet=id
else
Paramet=ids
end if
set rsa=conn.db("select * from {pre}Navigation where id="&Paramet&" ","records1")
set rs=conn.db("select "&topn&" * from {pre}Product where SortID in("&rsa("ChildPath")&") and p_name"&DB_FIELD&"<>'' and IsHot=true and isShow"&DB_FIELD&"=true   order by Ord asc,Createdate desc,id desc","records1")
  if rs.eof or rs.bof then
  response.Write("")
  else
  k=1

	n=GetPrintIDtop(rs("id"))
	grade=GetGrade(rs("SortID"))
	previd=GetPrevID(rs("SortID"))
	previd2=GetPrevID(previd)
	previd3=GetPrevID(previd2)
	previd4=GetPrevID(previd3)
	previd5=GetPrevID(previd4)

if ncount=0 then
ncount=rs.recordcount
end if
  int_RPP=ncount
	int_showNumberLink_=int_showNumberLink
	showMorePageGo_Type_ = 1
	str_nonLinkColor_="#999999"
	toF_=toF
	toP10_=toP10
	toP1_=toP1
	toN1_=toN1
	toN10_=toN10
	toL_=toL
	rs.PageSize=int_RPP
	cPageNo=request("Page")
	If cPageNo="" or not isnumeric(cPageNo) Then cPageNo = 1
	cPageNo = Clng(cPageNo)
	If cPageNo<1 Then cPageNo=1
	If cPageNo>rs.PageCount Then cPageNo=rs.PageCount
	rs.AbsolutePage=cPageNo
count=0
do while not (rs.eof or rs.bof) and count<rs.PageSize
            s_imgs=rs("p_img")
			if rs("p_img"&DB_FIELD&"")<>"" then
			s_imgs=rs("p_img"&DB_FIELD&"")
			end if
			if s_imgs<>"" then
			img_arr=split(s_imgs,", ")
			for i=0 to ubound(img_arr)
			p_img=img_arr(0)
			next
			else
			p_img="default/default.png"
			end if

 rs.movenext
 count=count+1
  k=k+1
  loop
  end if
  	if rs.recordcount > ncount then
    response.Write( fPageCount(rs,int_showNumberLink_,str_nonLinkColor_,toF_,toP10_,toP1_,toN1_,toN10_,toL_,showMorePageGo_Type_,cPageNo)  & vbcrlf )
	end if

end sub


'详细图片组
sub BrowseContentimg(id,fieldname,typ)
  set rsimg=conn.db("select * from {pre}product where id="&id&"","records1")
  if rsimg.recordcount=0 then
  response.Write""
  else

  			s_imgs=rsimg(fieldname)
			if rsimg(fieldname+DB_FIELD)<>"" then
			s_imgs=rsimg(fieldname+DB_FIELD)
			end if
			if s_imgs<>"" then
			img_arr=split(s_imgs,", ")
			for i=0 to ubound(img_arr)
			if i=0 then
			sty=" active"
			else
			sty=""
			end if
select case typ
case 1
echo"<img src='"&img_arr(i)&"' />"
case 2
sty=""
if i=1 then
sty="tb-selected"
end if
echo"<li><a class='"&sty&"' href='javascript:;'><img src='"&img_arr(i)&"'' mid='"&img_arr(i)&"'' big='"&img_arr(i)&"''></a></li>"

case 3
if i<>0 then
select case i
case 1
sty=""
case 2
sty="class='middle'"
case 3
sty="class='last'"
end select
echo"<li "&sty&"><img src='"&img_arr(i)&"'></li>"
end if
case else

end select
			next
			else
			p_img="default/default.png"
			end if
  end if
  rsimg.close : set rsimg=nothing
end sub

'详细图片组默认图片
sub ProDefaultimg(id,fieldname)
  set rs=conn.db("select * from {pre}product where id="&id&"","records1")
  if rs.recordcount=0 then
  response.Write""
  else
  			s_imgs=rs(fieldname)
			if rs(fieldname+DB_FIELD)<>"" then
			s_imgs=rs(fieldname+DB_FIELD)
			end if
			if s_imgs<>"" then
			img_arr=split(s_imgs,", ")
			for i=0 to ubound(img_arr)
			default=img_arr(0)
			next
			echo (""&default)
			else
			p_img="default/default.png"
			end if
  end if
  rs.close : set rs=nothing
end sub

'输出当前ID对应字段的数据
'datafield字段名
function BrowseNews(id,datafield)
  set rs=conn.db("select * from {pre}news where id="&id&"","records1")
  if rs.eof or rs.bof then
  BrowseNews=""
  else
  BrowseNews=rs(datafield+""&DB_FIELD&"")
  end if
  rs.close : set rs=nothing
end function


'输出当前ID对应字段的数据
'datafield字段名
function BrowseContent(id,datafield)
  set rs=conn.db("select * from {pre}product where id="&id&"","records1")
  if rs.eof or rs.bof then
  BrowseContent=""
  else
  BrowseContent=rs(datafield+""&DB_FIELD&"")
  end if
  rs.close : set rs=nothing
end function


'输出当前ID对应浏览次数
function BrowseTimes(id)
  set rs=conn.db("update {pre}product set Hits=Hits+1 where id="&id&"","records3")
  set rs=conn.db("select * from {pre}product where id="&id&"","records1")
  if rs.eof or rs.bof then
  BrowseTimes=0
  else
  BrowseTimes=rs("Hits")
  end if
  rs.close : set rs=nothing
end function

'输出当前ID对应时间
function BrowseDatetime(id)
  set rs=conn.db("select * from {pre}product where id="&id&"","records1")
  if rs.recordcount=0 then
  BrowseDatetime=now()
  else
  BrowseDatetime=rs("CreateDate")
  end if
  rs.close : set rs=nothing
end function


sub NewsTable(Paramet,typ,url,ids)
set rsa=conn.db("select * from {pre}Navigation where id="&Paramet&" ","records1")
set rs=conn.db("select * from {pre}News where SortID in("&rsa("ChildPath")&") and isShow"&DB_FIELD&"=true   order by Ord asc,Createdate desc,id desc","records1")
if rs.eof or rs.bof then
else
do while not rs.eof
select case typ
case 1
parm="Material="&rs("id")&""
filed="p_material"&DB_FIELD&""
case 2
parm="psize="&rs("id")&""
filed="p_sizeen"
case 3
parm="Collection="&rs("id")&""
filed="p_Collectionen"
case 4
parm="PriceRange="&rs("id")&""
filed="p_PriceRangeen"
end select
counts=GetProductTableCount(rs("id"),""&filed&"",ids)
echo"<li class='facetValue facet-value multiSelect multi-select' data-facets='{facetIds:'"&rs("id")&"'}'>"
echo"<label>"
echo"<input type='checkbox' class='checkbox' /><a href='"&url&""&parm&"' rel=''> <span class='value'>"&rs("NewsName"&DB_FIELD&"")&"</span><span class='count'>&nbsp;("&counts&")</span></a> </label>"
echo"</li>"
rs.movenext
loop

end if
rs.close : set rs=nothing
rsa.close : set rsa=nothing
end sub

'获取News表中当前ID对应的名称
function GetNewsTableName(Paramet)
set rs=conn.db("select * from {pre}News where id in("&Paramet&") and isShow"&DB_FIELD&"=true   order by Ord asc,Createdate desc,id desc","records1")
if rs.eof or rs.bof then
GetNewsTableName=""
else
do while not rs.eof
GetNewsTableName=GetNewsTableName+"&nbsp;"+rs("NewsName"&DB_FIELD&"")+"&nbsp;"
rs.movenext
loop
end if
rs.close : set rs=nothing
end function

'获取Product表中与News表中当前ID对应的记录数
function GetProductTableCount(Paramet,filed,Pid)
set rsbc=conn.db("select * from {pre}Navigation where id="&pid&" ","records1")
set rsba=conn.db("select * from {pre}News  where id="&Paramet&" ","records1")
set rsb=conn.db("select * from {pre}Product where "&filed&"="&rsba("id")&" and SortID in("&rsbc("ChildPath")&") and isShow"&DB_FIELD&"=true   order by Ord asc,Createdate desc,id desc","records1")
if rsb.eof or rsb.bof then
GetProductTableCount=0
else
GetProductTableCount=rsb.recordcount
end if
rsb.close : set rsb=nothing
rsba.close : set rsba=nothing
rsbc.close : set rsbc=nothing
end function

'banner图片地址
sub Bannerimg2(id,typ)
set rs=conn.db("select *  from {pre}slide where ParentID="&id&" and sSlidePic<>'' and isshow<>true and sortid=1 and SlideType='"&DB_LANGUAGE&"' order by ord,id desc","records1")
if rs.eof or rs.bof then
echo""
else
i=1
do while not rs.eof
if rs("bcolor")<>"" then
cor="#"&rs("bcolor")&""
else
cor=""
end if

select case typ
case 1
echo"<div class='topadcs' style='background:url("&rs("sSlidePic")&") center top no-repeat;'></div>"
case 2
echo"<li><a href='"&rs("SlideUrl")&"'><img src='"&rs("sSlidePic")&"' alt='"&rs("SlideName")&"'/></a></li>"
end select
rs.movenext
i=i+1
loop
end if
rs.close : set rs=nothing
end sub
sub Bannerimg2m(id,typ)
set rs=conn.db("select *  from {pre}slide where ParentID="&id&" and sSlidePic<>'' and isshow<>true and sortid=1 and SlideType='m' order by ord,id desc","records1")
if rs.eof or rs.bof then
echo""
else
i=1
do while not rs.eof
if rs("bcolor")<>"" then
cor="#"&rs("bcolor")&""
else
cor=""
end if

select case typ
case 1
echo"<div class='pic_yi'><img src='"&rs("sSlidePic")&"'/></div>"
echo"<div class='pic_er'><img src='"&rs("sSlidePic")&"'/></div>"
case 2
echo"<li><a href='"&rs("SlideUrl")&"'><img src='"&rs("sSlidePic")&"' alt='"&rs("SlideName")&"'/></a></li>"
end select
rs.movenext
i=i+1
loop
end if
rs.close : set rs=nothing
end sub


function BannerIsNull(id)
set rs=conn.db("select *  from {pre}slide where ParentID="&id&" and sSlidePic<>'' and isshow<>true and sortid=1 and SlideType='"&DB_LANGUAGE&"' order by ord,id desc","records1")
if rs.eof or rs.bof then
BannerIsNull=false
else
BannerIsNull=true
end if
rs.close : set rs=nothing
end function

sub Bannerimg(id)
set rs=conn.db("select *  from {pre}slide where ParentID="&id&" and sSlidePic<>'' and isshow<>true and sortid=1 and SlideType='"&DB_LANGUAGE&"' order by ord,id desc","records1")
if rs.eof or rs.bof then
echo""
else
i=1
do while not rs.eof
if rs("bcolor")<>"" then
cor="#"&rs("bcolor")&""
else
cor="#ffffff"
end if
echo"<li style='background:url("&rs("sSlidePic")&") 50% 0 no-repeat;'><a href='"&rs("SlideUrl")&"'></a></li>"
rs.movenext
i=i+1
loop
end if
rs.close : set rs=nothing
end sub

sub Bannerimgm(id)
set rs=conn.db("select *  from {pre}slide where ParentID="&id&" and sSlidePic<>'' and isshow<>true and sortid=1 and SlideType='m' order by ord,id desc","records1")
if rs.eof or rs.bof then
echo""
else
i=1
do while not rs.eof
if rs("bcolor")<>"" then
cor="#"&rs("bcolor")&""
else
cor="#ffffff"
end if
if i=1 then
sty="active"
else
sty=""
end if
echo"<li style='background:url("&rs("sSlidePic")&") 50% 0 no-repeat;'><a href='"&rs("SlideUrl")&"'></a></li>"
rs.movenext
i=i+1
loop
end if
rs.close : set rs=nothing
end sub

sub BannerUrl(id)
set rs=conn.db("select *  from {pre}slide where ParentID="&id&" and sSlidePic<>'' and isshow<>true and sortid=1 and SlideType='"&DB_LANGUAGE&"' order by ord,id desc","records1")
if rs.eof or rs.bof then
echo""
else
i=1
do while not rs.eof
echo""&rs("SlideUrl")&""
rs.movenext
i=i+1
loop
end if
rs.close : set rs=nothing
end sub

sub BannerNumber(id)
set rs=conn.db("select *  from {pre}slide where ParentID="&id&" and sSlidePic<>'' and isshow<>true and sortid=1 and SlideType='"&DB_LANGUAGE&"' order by ord,id desc","records1")
if rs.eof or rs.bof then
echo""
else
ncount=rs.recordcount
i=1
do while not rs.eof
if i=1 then
cla=" act"
else
cla=""
end if
echo"<span></span>"

rs.movenext
i=i+1
loop
end if
rs.close : set rs=nothing
end sub


sub BannerCount(id)
dim countt
set rs=conn.db("select *  from {pre}slide where ParentID="&id&" and sSlidePic<>'' and isshow<>true and sortid=1 and SlideType='"&DB_LANGUAGE&"' order by ord,id desc","records1")
if rs.eof or rs.bof then
echo""
else
countt=rs.recordcount
echo countt
end if
rs.close : set rs=nothing
end sub



'QQ名称
sub QQ()
set rs=conn.db("select  * from {pre}QQ where SlideName"&DB_FIELD&"<>'' and isshow<>true and sortid=1 and QQtype='QQ' order by ord,id desc","records1")
if rs.eof or rs.bof then
echo""
else
i=1
do while not rs.eof
echo"<li class='qq'><a href='tencent://message/?uin="&rs("SlideUrl")&"' rel='nofollow'>"&rs("SlideName"&DB_FIELD&"")&"</a></li>"
rs.movenext
i=i+1
loop
end if
rs.close : set rs=nothing
end sub

'Skype
sub Skype()
set rs=conn.db("select  * from {pre}QQ where SlideName"&DB_FIELD&"<>'' and isshow<>true and sortid=1 and QQtype='SKYPE' order by ord,id desc","records1")
if rs.eof or rs.bof then
echo""
else
i=1
do while not rs.eof
echo"<li style='padding-left:0px;'><a target='_blank' href='skype:"&rs("SlideUrl")&"?call' rel='nofollow'><img src='images/skype.png' align='absmiddle'>&nbsp;&nbsp;"&rs("SlideName"&DB_FIELD&"")&"</a></li>"
rs.movenext
i=i+1
loop
end if
rs.close : set rs=nothing
end sub

'MSN
sub MSN()
set rs=conn.db("select  * from {pre}QQ where SlideName"&DB_FIELD&"<>'' and isshow<>true and sortid=1 and QQtype='MSN' order by ord,id desc","records1")
if rs.eof or rs.bof then
echo""
else
i=1
do while not rs.eof
echo"<li><a target='_blank' href='msnim:chat?contact="&rs("SlideUrl")&"' title='请确保XP版本以上的Windows并安装好MSN，或者手动添加地址。'><IMG  src='qq/img/msn.gif'> </a><a target='_blank' href='msnim:chat?contact="&rs("SlideUrl")&"' title='点击马上咨询'>"&rs("SlideName"&DB_FIELD&"")&"</a></li>"
rs.movenext
i=i+1
loop
end if
rs.close : set rs=nothing
end sub

'Email
sub Email()
set rs=conn.db("select  * from {pre}QQ where SlideName"&DB_FIELD&"<>'' and isshow<>true and sortid=1 and QQtype='Email' order by ord,id desc","records1")
if rs.eof or rs.bof then
echo""
else
i=1
do while not rs.eof
echo"<li class='qq_czaa' id='130'><a href='mailto:"&rs("SlideUrl")&"'><b class='f'></b>"&rs("SlideName"&DB_FIELD&"")&"</a></li>"
rs.movenext
i=i+1
loop
end if
rs.close : set rs=nothing
end sub

'Phone
sub Phone()
set rs=conn.db("select  * from {pre}QQ where SlideName"&DB_FIELD&"<>'' and isshow<>true and sortid=1 and QQtype='Phone' order by ord,id desc","records1")
if rs.eof or rs.bof then
echo""
else
i=1
do while not rs.eof
echo"<div class='floatDtxt'>"&rs("SlideName"&DB_FIELD&"")&"</div>"
echo"<div class='floatDtel'>"&rs("SlideUrl")&"</div>"
rs.movenext
i=i+1
loop
end if
rs.close : set rs=nothing
end sub


'旺旺
sub WangWang()
set rs=conn.db("select * from {pre}QQ where SlideName"&DB_FIELD&"<>'' and isshow<>true and sortid=1 and QQtype='WangWang' order by ord,id desc","records1")
if rs.eof or rs.bof then
echo""
else
do while not rs.eof
echo"<li><a href='http://webatm.alibaba.com/atm_chat.htm?enemberId=enaliint"&rs("SlideUrl")&"' target='_blank'><img src='http://amos.us.alitalk.alibaba.com/online.aw?v=2&amp;uid="&rs("SlideUrl")&"&amp;site=enaliint&amp;s=2'>"&rs("SlideName"&DB_FIELD&"")&"</a></li>"
rs.movenext
loop
end if
rs.close : set rs=nothing
end sub

'日期格式化
function fillzero(l1)
if len(l1)=1 then
fillzero="0"&l1
else
fillzero=l1
end if
end function
'response.Write( year(now)&"-"&fillzero(month(now))&"-"&fillzero(day(now)))

'获取文件大小,类型,创建时间
Function showsize(filename,typ)
FPath=server.mappath(filename)
set fso=server.CreateObject("scripting.filesystemobject")
If fso.fileExists(FPath) Then
Set f = fso.GetFile(FPath)
filetype=f.type
filesize=f.size
adddate=f.DateCreated
Select Case true
Case filesize<1024
fsize=filesize&" B"
Case filesize<1048576
fsize=Round((filesize/1024),2)&" KB"
Case filesize<1073741824
fsize=Round((filesize/1024/1024),2)&" MB"
Case else
fsize=Round((filesize/1024/1024/1024),2)&" GB"
End Select
select case typ
case "size"
showsize=""&fsize&""
case "type"
showsize=""&getFileExt(filetype)&""
case "time"
showsize=""&adddate&""
end select
'echo""&fsize&""
'Response.Write "文件大小:"&fsize&"，文件类型:"&filetype&"，创建时间:"&adddate
else
showsize="none!"
end if
End Function

Function getFileExt(sFileName)
getFileExt = Mid(sFileName, InstrRev(sFileName, ".") + 1)
End Function

'获取产品顶级ID
function GetPrintID(printid)
set rsq= conn.db("select * from {pre}Product where id="&printid&" ","records1")
GetPrintID=GetPrintIDtop(rsq("Sortid"))
rsq.close
set rsq=nothing
end Function

function GetPrintIDtop(m)
set rss= conn.db("select * from {pre}Navigation where id="&m&" order by sequence,id desc","records1")
if rss.eof or rss.bof then
else
if rss("ParentID")=0 then
GetPrintIDtop=rss("ID")
else
GetPrintIDtop=GetPrintIDtop(rss("ParentID"))
end if
end if
rss.close
set rss=nothing
end Function

function GetGrade(m)
set rss= conn.db("select * from {pre}Navigation where id="&m&" order by sequence,id desc","records1")
if rss.eof or rss.bof then
GetGrade=1
else
GetGrade=rss("DeepPath")
end if
rss.close
end function

function GetPrevID(m)
set rss= conn.db("select * from {pre}Navigation where id="&m&" order by sequence,id desc","records1")
if rss.eof or rss.bof then
else
if rss("ParentID")=0 then
GetPrevID=rss("ID")
else
GetPrevID=rss("ParentID")
end if
end if
rss.close
set rss=nothing
end Function


'获取当前Url参数的函数
 Private Function GetUrl()
  Dim ScriptAddress, M_ItemUrl, M_item
  ScriptAddress = CStr(Request.ServerVariables("SCRIPT_NAME")) '取得当前地址
  M_ItemUrl = ""
  If (Request.QueryString <> "") Then
  ScriptAddress =  ScriptAddress & "?"
  For Each M_item In Request.QueryString
   If InStr(page,M_Item)=0 Then
    M_ItemUrl = M_ItemUrl & M_Item &"="& Server.URLEncode(Request.QueryString(""&M_Item&""))  & "&"
   End If
  Next
  end if
  GetUrl = ScriptAddress & M_ItemUrl
 End Function

'上一个
function GetPrevious(SortID,fname,none,typ)
dim i,h
i=0
h=0
set rs=conn.db("select * from {pre}Product where SortID="&SortID&"  order by ord asc,id desc","records1")

do while  not rs.eof
i=i+1
if(pid+0=rs("id")+0) then
h=i
end if
rs.movenext
loop
dim pre,nex,coun
pre=h-1
nex=h+1
coun=Rs.recordcount'记录总数
'上一条

if pre>0 then
rs.absoluteposition=pre

	n=GetPrintIDtop(rs("id"))
	grade=GetGrade(rs("SortID"))
	previd=GetPrevID(rs("SortID"))
	previd2=GetPrevID(previd)
	previd3=GetPrevID(previd2)
	previd4=GetPrevID(previd3)
	previd5=GetPrevID(previd4)
select case grade
case 2
parm="&f_1="&previd&""
case 3
parm="&f_1="&previd&"&f_2="&previd2&""
case 4
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&""
case 5
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&"&f_4="&previd4&""
case 6
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&"&f_4="&previd4&"&f_5="&previd5&""
end select
getvalue="?idd="&rs("id")&"&ids="&ids&"&SortID="&rs("SortID")&"&id="&rs("SortID")&"&ord="&rs("ord")&""&parm&""

getvalue=RewriteRule(getvalue)

select case typ
case 1
GetPrevious=""&DelAspExt(fname)&""&getvalue&""
case 2
GetPrevious=rs("p_name"&DB_FIELD&"")
end select

else
select case typ
case 1
GetPrevious="javascript:;"
case 2
GetPrevious=none
end select

end if
rs.close : set rs=nothing
end function

'下一个
function GetNext(SortID,fname,none,typ)
dim i,h
i=0
h=0
set rs=conn.db("select * from {pre}Product where SortID="&SortID&"  order by ord asc,id desc","records1")

do while  not rs.eof
i=i+1
if(pid+0=rs("id")+0) then
h=i
end if
rs.movenext
loop
dim pre,nex,coun
pre=h-1
nex=h+1
coun=Rs.recordcount'记录总数

'下一条
if nex<=i then
rs.absoluteposition=Nex

	n=GetPrintIDtop(rs("id"))
	grade=GetGrade(rs("SortID"))
	previd=GetPrevID(rs("SortID"))
	previd2=GetPrevID(previd)
	previd3=GetPrevID(previd2)
	previd4=GetPrevID(previd3)
	previd5=GetPrevID(previd4)
select case grade
case 2
parm="&f_1="&previd&""
case 3
parm="&f_1="&previd&"&f_2="&previd2&""
case 4
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&""
case 5
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&"&f_4="&previd4&""
case 6
parm="&f_1="&previd&"&f_2="&previd2&"&f_3="&previd3&"&f_4="&previd4&"&f_5="&previd5&""
end select
getvalue="?idd="&rs("id")&"&ids="&ids&"&SortID="&rs("SortID")&"&id="&rs("SortID")&"&ord="&rs("ord")&""&parm&""

getvalue=RewriteRule(getvalue)

select case typ
case 1
GetNext=""&DelAspExt(fname)&""&getvalue&""
case 2
GetNext=rs("p_name"&DB_FIELD&"")
end select
else

select case typ
case 1
GetNext="javascript:;"
case 2
GetNext=none
end select

end if
rs.close
set rs=nothing
end function



function RewriteRule(url)
onoff=true
if onoff=true then
RewriteRule=url
RewriteRule=replace(RewriteRule,".asp","")
RewriteRule=replace(RewriteRule,"?ids=","-")
RewriteRule=replace(RewriteRule,"?id=","-")
RewriteRule=replace(RewriteRule,"&WebType=","-")
RewriteRule=replace(RewriteRule,"&ids=","-")
RewriteRule=replace(RewriteRule,"&f_1=","-")
RewriteRule=replace(RewriteRule,"&f_2=","-")
RewriteRule=replace(RewriteRule,"&f_3=","-")
RewriteRule=replace(RewriteRule,"&f_4=","-")
RewriteRule=replace(RewriteRule,"&f_5=","-")
RewriteRule=replace(RewriteRule,"?idd=","-")
RewriteRule=replace(RewriteRule,"&id=","-")
RewriteRule=replace(RewriteRule,"&SortID=","-")
RewriteRule=replace(RewriteRule,"&idid=","-")
RewriteRule=replace(RewriteRule,"&ord=","-")
RewriteRule=replace(RewriteRule,"&Page=","_")
RewriteRule=RewriteRule&".html"
else
RewriteRule=url
end if
end function

function DelAspExt(url)
onoff=true
if onoff=true then
DelAspExt=replace(url,".asp","")
else
DelAspExt=url
end if
end function


%>
