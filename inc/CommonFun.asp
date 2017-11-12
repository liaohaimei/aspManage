<%
'三元运算
Function IIF(A,B,C)
 If A Then IIF = B Else IIF = C
End Function

'判断变量是否为空
Function varNull(var)
if var="undefined" then varNull=false else varNull=true end if
end Function

'弹出信息
Sub alertMsg(str,url)
	dim urlstr 
	if url<>"" then urlstr="location.href='"&url&"';"
	if not isNul(str) then str ="alert('"&str&"');"
	echo("<script>"&str&urlstr&"</script>")
End Sub

'返回并刷新页面
sub BackRefresh
response.Write("<script language=javascript>self.location=document.referrer;</script>")
end sub

'弹出选择信息
Sub selectMsg(str,url1,url2)
	echo("<script>if(confirm('"&str&"')){location.href='"&url1&"'}else{location.href='"&url2&"'}</script>") 
End Sub

'输出信息
Sub echo(str)
	response.write(str)
	response.Flush()
End Sub
'输出并结束
Sub die(str)
	if not isNul(str) then
		echo str
	end if	 
	response.End()
End Sub
'读取cookies
Function rCookie(cookieName)
	rCookie = request.cookies(cookieName)
End Function
'写入cookies
Sub wCookie(cookieName,cookieValue)
	response.cookies(cookieName) = cookieValue
End Sub

Sub wCookieInTime(cookieName,cookieValue,dateType,dateNum)
	Response.Cookies(cookieName).Expires=DateAdd(dateType,dateNum,now())  
	response.cookies(cookieName) = cookieValue
End Sub
'是否为空
Function isNul(str)
	if isnull(str) or str = ""  then isNul = true else isNul = false 
End Function
'是否为数字
Function isNum(str)
	if not isNul(str) then   isNum=isnumeric(str) else isNum=false
End Function
'是否为Url地址
Function isUrl(str)
	if not isNul(str) then 
		if left(str,7) = "http://" then isUrl = true else isUrl = false
	else
		isUrl = false
	end if
End Function
'获取文件后缀
Function getFileFormat(str)
	if not isNul(str) then getFileFormat = mid(str,instrRev(str,".")) else getFileFormat = ""
End Function
'输出自定义错误信息
Sub echoErr(byval str,byval id, byval des)
	die "<script>alert('"&des&"');history.go(-1);</script>"
End Sub
'获取返回值
Function getForm(element,ftype)
	Select case ftype
		case "get"
			getForm=trim(request.QueryString(element))
		case "post"
			getForm=trim(request.Form(element))
		case "both"
			getForm=trim(request(element))
	End Select
End Function
'是否安装组件
Function isInstallObj(objname)
	dim isInstall,obj
	On Error Resume Next
	set obj=server.CreateObject(objname)
	if Err then 
		isInstallObj = false : err.clear 
	else 
		isInstallObj=true:set obj = nothing
	end if
End Function
'加载文件
Function loadFile(ByVal filePath)
    dim errid,errdes
    On Error Resume Next
    With objStream
        .Type = 2
        .Mode = 3
        .Open
	    .Charset = "gbk"
        .LoadFromFile Server.MapPath(filePath)
        If Err Then  errid=err.number:errdes=err.description:Err.Clear:echoErr err_loadfile,errid,errdes
        .Position = 0
        loadFile = .ReadText
        .Close
    End With
End Function
'弹出错误信息
Sub echoSaveStr(ptype)
	dim cssstr
	cssstr="<meta http-equiv='Content-Type' content='text/html; charset=utf-8' /><style>body{text-align:center}#msg{background-color:white;border:1px solid #1B76B7;margin:0 auto;width:400px;text-align:left}.msgtitle{padding:3px 3px;color:white;font-weight:700;line-height:21px;height:25px;font-size:12px;border-bottom:1px solid #1B76B7; text-indent:3px; background-color:#1B76B7}#msgbody{font-size:12px;padding:40px 8px 50px;line-height:25px}#msgbottom{text-align:center;height:20px;line-height:20px;font-size:12px;background-color:#1b76b7;color:#FFFFFF}</style>"
	select case ptype
		case "safe"
			die cssstr&"<div id='msg'><div class='msgtitle'>【警告】非法提交：</div><div id='msgbody'>你提交的数据有非法字符，你的IP【<b>"&getIp&"</b>】已被记录,操作时间:"&now()&"</div><div id='msgbottom'>Powered By "&siteName&"</div></div>" 
		case "null"
			die cssstr&"<div id='msg'><div class='msgtitle'>【警告】参数错误：</div><div id='msgbody'><b>错误描述</b>：参数为空或不正确</div><div id='msgbottom'>Powered By "&siteName&"</div></div>"
	end Select
	cssstr=""
End Sub
'设置开始时间
Sub setStartTime()
	starttime=timer()
End Sub
'输出执行时间
Sub echoRunTime()
	endtime=timer()      
	echo "<div align=center><font color=red>页面执行时间: "&FormatNumber((endtime-starttime),4,-1)&"秒 &nbsp;&nbsp;&nbsp;" & dbconn.queryCount & "次数据查询</font></div>"
End Sub
'获取执行时间
Function getRunTime()
	endtime=timer()
	getRunTime="页面执行时间: "&FormatNumber((endtime-starttime),4,-1)&"秒 &nbsp;" & dbconn.queryCount & "次数据查询"
End Function

'替换字符串
Function replaceStr(Byval str,Byval finStr,Byval repStr)
	on error resume next
	if isNull(repStr) then repStr=""
	replaceStr = replace(str,finStr,repStr)
	if err then replaceStr = "" : err.clear
End Function
'去除字符串前后空格
Function trimOuter(Byval str)
	dim vstr : vstr = str
	if left(vstr,1) = chr(32) then vstr = right(vstr,len(vstr)-1) 
	if right(vstr,1) = chr(32) then  vstr = left(vstr,len(vstr)-1)
	trimOuter = vstr
End Function

Function trimOuterStr(Byval str,Byval flag)
	dim vstr,m : vstr = str : m=len(flag)
	if left(vstr,m) = flag then vstr = right(vstr,len(vstr)-m)
	if right(vstr,m) = flag then  vstr = left(vstr,len(vstr)-m)
	trimOuterStr = vstr
End Function
'去除html格式
Function filterStr(Byval str,Byval filtertype)
	if isNul(str) then  filterStr = "" : Exit Function
	dim regObj, outstr,rulestr : set regObj = New Regexp
	regObj.IgnoreCase = true : regObj.Global = true
	Select case filtertype
		case "html"	
			rulestr = "(<[a-zA-Z].*?>)|(<[\/][a-zA-Z].*?>)"
		case "jsiframe"
			rulestr = "(<(script|iframe).*?>)|(<[\/](script|iframe).*?>)"
	end Select
	regObj.Pattern = rulestr
	outstr = regObj.Replace(str, "")
	set regObj = Nothing : filterStr = outstr
End Function
'获取浏览器信息
Function getAgent()
	getAgent = request.ServerVariables("HTTP_USER_AGENT")
End Function
'获取上一页
Function getRefer()
	getRefer = request.ServerVariables("HTTP_REFERER")
End Function
'获取服务器名称
Function getServername()
	getServername = request.ServerVariables("server_name")
End Function
'是否为外部提交
Function isOutSubmit()
	dim server1, server2
	server1 = getRefer
	server2 = getServername
	if Mid(server1, 8, len(server2)) <> server2 then
		isOutSubmit = true
	else
		isOutSubmit = false
	end if
End Function
'获取IP地址
Function getIp()
	dim forwardFor
	forwardFor = request.servervariables("Http_X_Forwarded_For")
	if forwardFor = "" then 
		getIp = request.servervariables("Remote_Addr") 
	else 
		getIp = forwardFor
	end if
	getIp = replace(getIp, chr(39), "")
End Function
'获取每页显示条数（生成静态使用）
Function getPageSize(Byval str,Byval ptype)
	dim regObj,matchChannel,matchesChannel,sizeValue
	set regObj=New RegExp
	regObj.Pattern="\{cms668com:"&ptype&"[\s\S]*size=([\d]+)[\s\S]*\}"	
	set matchesChannel=regObj.Execute(str)
	for each matchChannel in matchesChannel
		sizeValue=matchChannel.SubMatches(0) : if isNul(sizeValue) then sizeValue=10
		set regObj=nothing
		set matchesChannel=nothing
		getPageSize=sizeValue
		Exit Function
	next
End Function
'创建文件
Function createTextFile(Byval content,Byval fileDir)
	dim fileobj : fileDir = replace(fileDir, "\", "/")
	call createfolder(fileDir,"filedir")
	on error resume next
	set fileobj = objFso.CreateTextFile(server.mappath(fileDir),True)
	fileobj.Write content
	set fileobj=nothing
	if Err Then  createTextFile = false : errid=err.number:errdes=err.description:Err.Clear : echoErr err_writefile,errid,errdes else createTextFile = true
End Function

Function createMapFile(Byval content,Byval fileDir,Byval code)
	dim fileobj,fileCode : fileDir=replace(fileDir, "\", "/")
	if isNul(code) then fileCode="gbk" else fileCode=code
	call createfolder(fileDir,"filedir")
	on error resume next:err.clear
	set fileobj=objFso.CreateTextFile(server.mappath(fileDir),True)
	fileobj.Write(content)
	set fileobj=nothing
	if Err or not isNul(code) then
		err.clear 
		With objStream
			.Charset=fileCode:.Type=2:.Mode=3:.Open:.Position=0
			.WriteText content:.SaveToFile Server.MapPath(fileDir), 2
			.Close
		End With
	end if	
	if Err Then  createMapFile=false : errid=err.number:errdes=err.description:Err.Clear : echoErr err_writefile,errid,errdes else createMapFile=true
End Function
'创建流文件
Function createStreamFile(Byval stream,Byval fileDir)
	dim errid,errdes
	fileDir = replace(fileDir, "\", "/")
	call createfolder(fileDir,"filedir")
	on error resume next
	If Err Then errid=err.number:errdes=err.description:Err.Clear:echoErr err_stmobj,errid,errdes
	With objStream
		.Type =1
		.Mode=3  
		.Open
		.write stream
		.SaveToFile server.mappath(fileDir),2
		.close
	End With
	if Err Then  createStreamFile = false : errid=err.number:errdes=err.description:Err.Clear : echoErr err_writefile,errid,errdes else createStreamFile = true
End  Function
'创建文件夹
Function createFolder(Byval dir,Byval dirType)
	dim subPathArray,lenSubPathArray, pathDeep, i
	on error resume next
	dir = replace(dir, "\", "/")
	dir = replace(server.mappath(dir), server.mappath("/"), "")
	subPathArray = split(dir, "\")
	pathDeep = pathDeep & server.mappath("/")
	select case dirType
		case "filedir"
			 lenSubPathArray = ubound(subPathArray) - 1
		case "folderdir"
			lenSubPathArray = ubound(subPathArray)
	end select
	for i = 1 to lenSubPathArray
		pathDeep = pathDeep & "\" & subPathArray(i)
		if not objFso.FolderExists(pathDeep) then objFso.CreateFolder pathDeep
	next
	if Err Then  createFolder = false : errid=err.number:errdes=err.description:Err.Clear : echoErr err_createFolder,errid,errdes else createFolder = true
End Function
'判断文件是否存在
Function isExistFile(Byval fileDir)
	on error resume next
	If (objFso.FileExists(server.MapPath(fileDir))) Then  isExistFile = True  Else  isExistFile = False
	if err then err.clear:isExistFile = False
End Function
'判断文件夹是否存在
Function isExistFolder(Byval folderDir)
	on error resume next
	If objFso.FolderExists(server.MapPath(folderDir)) Then  isExistFolder = True Else isExistFolder = False
	if err then err.clear:isExistFolder = False
End Function
'删除文件夹
Function delFolder(Byval folderDir)
	on error resume next
	If isExistFolder(folderDir) = True Then  
		objFso.DeleteFolder(server.mappath(folderDir)) 
		if Err Then  delFolder = false : errid = err.number : errdes = err.description:Err.Clear : echoErr err_delFolder,errid,errdes else delFolder = true
	else
		delFolder = false : die(err_notExistFolder)
	end if
End Function 
'删除文件
Function delFile(Byval fileDir)
	on error resume next
	If isExistFile(fileDir)=True Then  objFso.DeleteFile(server.mappath(fileDir))
	if  Err Then  delFile = false : errid = err.number : errdes = err.description:Err.Clear : echoErr err_delFile,errid,errdes else delFile = true
End Function 
'判断必要组件是否存在
Function initializeAllObjects()
	dim errid,errdes
	on error resume next
	if not isobject(objFso) then set objFso = server.createobject(FSO_OBJ_NAME)
	If Err Then errid=err.number:errdes=err.description:Err.Clear:echoErr err_fsoobj,errid,errdes
	if not isobject(objStream) then Set objStream = Server.CreateObject(STREAM_OBJ_NAME)
	If Err Then errid=err.number:errdes=err.description:Err.Clear:echoErr err_stmobj,errid,errdes
End Function
'释放所有对象
Function terminateAllObjects()
	on error resume next
	if dbconn.isConnect then dbconn.close
	if isobject(conn) then : set conn=nothing
	if isobject(objFso) then set objFso = nothing
	if isobject(objStream) then set objStream = nothing
	if isobject(cacheObj) then set cacheObj = nothing
	if isobject(mainClassObj) then set mainClassObj = nothing
End Function
'移动文件夹
Function moveFolder(oldFolder,newFolder)
	dim voldFolder,vnewFolder
	voldFolder = oldFolder
	vnewFolder = newFolder
	on error resume next
	if voldFolder <> vnewFolder then
		voldFolder=server.mappath(oldFolder)
		vnewFolder=server.mappath(newFolder)
		if not objFso.FolderExists(vnewFolder) then createFolder newFolder,"folderdir" 
		if  objFso.FolderExists(voldFolder)  then  objFso.CopyFolder voldFolder,vnewFolder : objFso.DeleteFolder(voldFolder)
		if Err Then  moveFolder = false : errid = err.number : errdes = err.description:Err.Clear : echoErr err_moveFolder,errid,errdes else moveFolder = true
	end if
End Function
'移动文件
Function moveFile(ByVal src,ByVal target,Byval operType)
	dim srcPath,targetPath
	srcPath=Server.MapPath(src) 
	targetPath=Server.MapPath(target)
	if isExistFile(src) then
		objFso.Copyfile srcPath,targetPath
		if operType="del" then  delFile src 
		moveFile=true
	else
		moveFile=false
	end if
End Function
'获取文件夹列表
Function getFolderList(Byval cDir)
	dim filePath,objFolder,objSubFolder,objSubFolders,i
	i = 0
	redim  folderList(0)
	filePath = server.mapPath(cDir)
	set objFolder=objFso.GetFolder(filePath)
	set objSubFolders=objFolder.Subfolders
	for each objSubFolder in objSubFolders
		ReDim Preserve folderList(i)
		With objSubFolder
			folderList(i) = .name & ",文件夹," & .size/1000 & "k," & .DateLastModified & "," & cDir & "/" & .name
		End With
		i = i + 1 
	next 
	set objFolder=nothing
	set objSubFolders=nothing
	getFolderList = folderList
End Function
'获取文件列表
Function getFileList(Byval cDir)
	dim filePath,objFolder,objFile,objFiles,i
	i = 0
	redim  fileList(0)
	filePath = server.mapPath(cDir)
	set objFolder=objFso.GetFolder(filePath)
	set objFiles=objFolder.Files
	for each objFile in objFiles
		ReDim Preserve fileList(i)
		With objFile
			fileList(i) = .name & "," & Mid(.name, InStrRev(.name, ".") + 1) & "," & .size/1000 & "k," & .DateLastModified & "," & cDir & "/" & .name
		End With
		i = i + 1 
	next 
	set objFiles=nothing
	set objFolder=nothing
	getFileList = fileList
End Function

Function getXmlHttpVer()
	dim i,xmlHttpVersions,xmlHttpVersion
	getXmlHttpVer = false
	xmlHttpVersions = Array("Microsoft.XMLHTTP", "MSXML2.XMLHTTP", "MSXML2.XMLHTTP.3.0","MSXML2.XMLHTTP.4.0","MSXML2.XMLHTTP.5.0")
	for i = 0 to ubound(xmlHttpVersions)
		xmlHttpVersion = xmlHttpVersions(i)
		if isInstallObj(xmlHttpVersion) then getXmlHttpVer = xmlHttpVersion : Exit Function
	next	
End Function
'返回首页地址
Function getIndexLink()
	getIndexLink="/"&sitePath
End Function
'链接地址
Function getContentLink(Byval typeId,Byval videoId)
	dim linkStr,typePath
	if runMode="dynamic" then  
		linkStr="/"&sitePath&contentDirName1&"/?"&videoId&fileSuffix
	elseif runMode="static" and makeMode="dir1"   then
		typePath = getTypePathOnCache(typeId)
		linkStr="/"&sitePath&typePath&videoId&"/"&contentPageName2&fileSuffix
	elseif runMode="static" and makeMode="dir2" then
		linkStr="/"&sitePath&contentDirName3&"/"&contentPageName3&videoId&fileSuffix
	end if
	getContentLink=linkStr
End Function
'导航链接
Function getNavLink(Byval NavId,Byval NavType)
	dim linkStr
	if NavType="GuestBook" then
	  if runMode="dynamic" then
		  linkStr="/"&sitePath&NavType&"/GuestBook.asp"
	  elseif runMode="static" then
		  linkStr="http://"&siteUrl&"/"&sitePath&NavType&"/GuestBook.asp"
	  end if
	else
	  if runMode="dynamic" then
		  linkStr="/"&sitePath&NavType&"/indexlist.asp?SortID="&NavId
	  elseif runMode="static" then
		  linkStr="http://"&siteUrl&"/"&sitePath&NavType&"/list/index"&NavId&".html"
	  end if
	end if
	getNavLink=linkStr
End Function
'内容页链接链接
Function getShowLink(Byval SortID,Byval Id,Byval ShowType)
	dim linkStr,rsObj
	if runMode="dynamic" then
		linkStr="/"&sitePath&ShowType&"/indexshow.asp?SortID="&SortID&"&ID="&Id
	elseif runMode="static" then
		linkStr="/"&sitePath&ShowType&"/view/index"&ID&".html"
	end if
	getShowLink=linkStr
End Function
'str中是否存在findstr
Function isExistStr(str,findstr)
	if isNul(str) or isNul(findstr) then isExistStr=false:Exit Function
	if instr(str,findstr)>0 then isExistStr=true else isExistStr=false
End Function
'获取指定长度字符串
Function getStrByLen(Byval str, Byval strlen)
	dim vStrlen,charCount,i
	str=trim(str)
	if isNul(str) then Exit Function   
	charCount = len(str)  
	vStrlen = 0   
	for i = 1 to charCount   
		if asc(mid(str,i,1)) < 0 or asc(mid(str,i,1)) >255 then   
			vStrlen = vStrlen + 1   
		else   
			vStrlen = vStrlen + 2   
		end if
		if vStrlen >= strlen then  getStrByLen = left(str,i) : Exit Function
	next
	getStrByLen = left(str,charCount)
End Function

Function encodeHtml(Byval str)
	IF len(str)=0 OR Trim(str)="" then exit function
		str=replace(str,"<","&lt;")
		str=replace(str,">","&gt;")
		str=replace(str,CHR(34),"&quot;")
		str=replace(str,CHR(39),"&apos;")
		encodeHtml=str
End Function

Function decodeHtml(Byval str)
	IF len(str)=0 OR Trim(str)="" or isNull(str) then exit function
		str=replace(str,"&lt;","<")
		str=replace(str,"&gt;",">")
		str=replace(str,"&quot;",CHR(34))
		str=replace(str,"&apos;",CHR(39))
		decodeHtml=str
End Function

Function  codeTextarea(Byval str,Byval enType)
	select case enType
		case "en"
			codeTextarea = replace(replace(str,chr(13)&chr(10),"<br>"),chr(32),"&nbsp;")
		case "de"
			codeTextarea = replace(replace(str,"<br>",chr(13)&chr(10)),"&nbsp;",chr(32))
	end select
End Function

Function timeToStr(Byval t)
	t=Replace(Replace(Replace(Replace(t,"-",""),":","")," ",""),"/","") : timeToStr = t
End Function

'把数组转换为Dictionay
Function typeArrayToDictionay(Byval arrayObj)
	dim dictionaryObj : set dictionaryObj = server.CreateObject(DICTIONARY_OBJ_NAME)
	dim dicKey,dicValue,i
	if isArray(arrayObj) then 
		for i=0 to ubound(arrayObj,2)
			dicKey =  arrayObj(0,i) : dicValue =  arrayObj(1,i)&","&arrayObj(2,i)
			if not dictionaryObj.Exists(dicKey) then dictionaryObj.add dicKey,dicValue  else  dictionaryObj(dicKey) = dicValue
		next
	end if
	set typeArrayToDictionay = dictionaryObj
End Function
'分页
Function makePageNumber(Byval currentPage,Byval pageListLen,Byval totalPages,Byval linkType,Byval typeId)
	dim beforePages,pagenumber,page
	dim beginPage,endPage,strPageNumber
	if pageListLen mod 2 = 0 then beforePages = pagelistLen / 2 else beforePages = clng(pagelistLen / 2) - 1
	if  currentPage < 1  then currentPage = 1 else if currentPage > totalPages then currentPage = totalPages
	if pageListLen > totalPages then pageListLen=totalPages
	if currentPage - beforePages < 1 then
		beginPage = 1 : endPage = pageListLen
	elseif currentPage - beforePages + pageListLen > totalPages  then
		beginPage = totalPages - pageListLen + 1 : endPage = totalPages
	else 
		beginPage = currentPage - beforePages : endPage = currentPage - beforePages + pageListLen - 1
	end if	
	for pagenumber = beginPage  to  endPage
		if pagenumber=1 then page = "" else page = pagenumber
		if pagenumber=currentPage then
			strPageNumber=strPageNumber&"&nbsp;<span><font color=red>"&pagenumber&"</font></span>"&"&nbsp;"
		else
			select case linkType
				case "newslist","downlist","caselist","productlist","photolist"
				    on error resume next
					strPageNumber=strPageNumber&"<a href='?page="&pagenumber&"&id="&id&"&keyword="&keyword&"'>"&pagenumber&"</a>&nbsp;"
					if err.number<>0 then if pagenumber>1 then strPageNumber=strPageNumber&"<a href='index"&typeId&"_"&pagenumber&".html'>"&pagenumber&"</a>&nbsp;" : else strPageNumber=strPageNumber&"<a href='index"&typeId&".html'>"&pagenumber&"</a>&nbsp;"
				case "guestlist"
				    strPageNumber=strPageNumber&"<a href='?page="&pagenumber&"'>"&pagenumber&"</a>&nbsp;"
				case "Infolist","Newslist","Photolist","Caselist","Downlist","Productlist","Joblist"
				    strPageNumber=strPageNumber&"<a href='?page="&pagenumber&"&order="&order&"&parentid="&parentid&"&pid="&pid&"&bid="&bid&"&tid="&tid&"&sid="&sid&"&uid="&uid&"&cid="&cid&"&keyword="&keyword&"'>"&pagenumber&"</a>&nbsp;"
				case "Guestlist","Adslist"
				    strPageNumber=strPageNumber&"<a href='?page="&pagenumber&"'>"&pagenumber&"</a>&nbsp;"
			end select
		end if	
	next
	makePageNumber=strPageNumber
End Function
'分页2
Function makePageNumberbidtid(Byval currentPage,Byval pageListLen,Byval totalPages,Byval linkType,Byval typeId)
	dim beforePages,pagenumber,page
	dim beginPage,endPage,strPageNumber
	if pageListLen mod 2 = 0 then beforePages = pagelistLen / 2 else beforePages = clng(pagelistLen / 2) - 1
	if  currentPage < 1  then currentPage = 1 else if currentPage > totalPages then currentPage = totalPages
	if pageListLen > totalPages then pageListLen=totalPages
	if currentPage - beforePages < 1 then
		beginPage = 1 : endPage = pageListLen
	elseif currentPage - beforePages + pageListLen > totalPages  then
		beginPage = totalPages - pageListLen + 1 : endPage = totalPages
	else 
		beginPage = currentPage - beforePages : endPage = currentPage - beforePages + pageListLen - 1
	end if	
	for pagenumber = beginPage  to  endPage
		if pagenumber=1 then page = "" else page = pagenumber
		if pagenumber=currentPage then
			strPageNumber=strPageNumber&"&nbsp;<span><font color=red>"&pagenumber&"</font></span>"&"&nbsp;"
		else
			select case linkType
				case "newslist","downlist","caselist","productlist","photolist"
				    on error resume next
					strPageNumber=strPageNumber&"<a href='?page="&pagenumber&"&SortID="&sortid&"&keys="&keys&"'>"&pagenumber&"</a>&nbsp;"
					if err.number<>0 then if pagenumber>1 then strPageNumber=strPageNumber&"<a href='index"&typeId&"_"&pagenumber&".html'>"&pagenumber&"</a>&nbsp;" : else strPageNumber=strPageNumber&"<a href='index"&typeId&".html'>"&pagenumber&"</a>&nbsp;"
				case "guestlist"
				    strPageNumber=strPageNumber&"<a href='?page="&pagenumber&"'>"&pagenumber&"</a>&nbsp;"
				case "Infolist","Newslist","Photolist","Caselist","Downlist","Productlist","Joblist"
				    strPageNumber=strPageNumber&"<a href='?page="&pagenumber&"&order="&order&"&bid="&bid&"&tid="&tid&"&sid="&sid&"&keyword="&keyword&"'>"&pagenumber&"</a>&nbsp;"
				case "Guestlist","Adslist"
				    strPageNumber=strPageNumber&"<a href='?page="&pagenumber&"'>"&pagenumber&"</a>&nbsp;"
			end select
		end if	
	next
	makePageNumberbidtid=strPageNumber
End Function

Function pageNumberLinkInfo(Byval currentPage,Byval pageListLen,Byval totalPages,Byval linkType,Byval typeId)
	dim pageNumber,pagesStr,i,pageNumberInfo,firstPageLink,lastPagelink,nextPagelink,finalPageLink
	pageNumber=makePageNumber(currentPage,pageListLen,totalPages,linkType,typeId)
	if currentPage=1 then  
		firstPageLink="<span class='nolink'>首页</span>" : lastPagelink="<span class='nolink'>上一页</span>"
	else
	    if linkType="guestlist" then
		    firstPageLink="<a href='?page=1'>首页</a>" : lastPagelink="<a href='?page="&currentPage-1&"'>上一页</a>"
		else
			on error resume next
			firstPageLink="<a href='?page=1&SortID="&sortid&"&keys="&keys&"'>首页</a>" : lastPagelink="<a  href='?page="&currentPage-1&"&SortID="&sortid&"&keys="&keys&"'>上一页</a>"
			if err.number<>0 then firstPageLink="<a href='index"&typeId&".html'>首页</a>" : if currentPage>2 then lastPagelink="<a href='index"&typeId&"_"&currentPage-1&".html'>上一页</a>" : else lastPagelink="<a href='index"&typeId&".html'>上一页</a>"
		end if
	end if 
	if currentPage=totalPages then 
		nextPagelink="<span class='nolink'>下一页</span>" : finalPageLink="<span class='nolink'>尾页</span>"
	else
	    if linkType="guestlist" then
		    nextPagelink="<a href='?page="&currentPage+1&"'>下一页</a>" : finalPageLink="<a href='?page="&totalPages&"'>尾页</a>"
		else
			if err.number<>0 then
				nextPagelink="<a href='index"&typeId&"_"&currentPage+1&".html'>下一页</a>" : finalPageLink="<a href='index"&typeId&"_"&totalPages&".html'>尾页</a>"
			else
			   nextPagelink="<a href='?page="&currentPage+1&"&SortID="&sortid&"&keys="&keys&"'>下一页</a>" : finalPageLink="<a href='?page="&totalPages&"&SortID="&sortid&"&keys="&keys&"'>尾页</a>"
			end if
		end if	
	end if 
	pageNumberInfo="<span>共"&totalPages&"页 页次:"&currentPage&"/"&totalPages&"页</span>&nbsp;"&firstPageLink&lastPagelink&pageNumber&""&nextPagelink&""&finalPagelink
	pageNumberLinkInfo=pageNumberInfo
End Function
'生成各大类类别(生成文章类别)
Sub makeType(typeId)
	dim sqlStr,rsObj
	sqlStr= "select ID,NavName from {pre}Navigation where WebType="&typeId&" order by ParentID,ID"
	set rsObj = dbconn.db(sqlStr,"records1")
	do while not rsObj.eof 
		echo "<option value='"&rsObj("ID")&"'>&nbsp;|—"&rsObj("NavName")&"</option>"
		rsObj.movenext
	loop
	rsObj.close
	set rsObj = nothing
End Sub
'判断该大类是否存在
Function IsType(typeId)
	dim sqlStr,rsObj
	sqlStr= "select ID,NavName from {pre}Navigation where WebType="&typeId&" and IsShow=1 order by ParentID,ID"
	set rsObj = dbconn.db(sqlStr,"records1")
	if rsObj.eof then
	    IsType=0
	else
	    IsType=1
	end if
	rsObj.close
	set rsObj = nothing
End Function
'经销商城市
Function SortCName(sortId)
    dim sqlStr,rsObj
	sqlStr= "select Name from {pre}City where ID=(select Pid from {pre}City where ID="&sortId&")"
	set rsObj = dbconn.db(sqlStr,"records1")
	if not rsObj.eof then SortCName=rsObj(0) else SortCName="未知分类"
	rsObj.close
	set rsObj = nothing
End Function
'经销商省份
Function SortCPName(sortId)
    dim sqlStr,rsObj
	sqlStr= "select Name from {pre}City where ID="&sortId&""
	set rsObj = dbconn.db(sqlStr,"records1")
	if not rsObj.eof then SortCPName=rsObj(0) else SortCPName="未知分类"
	rsObj.close
	set rsObj = nothing
End Function
'类别名称
Function SortName(sortId)
    dim sqlStr,rsObj
	sqlStr= "select NavName from {pre}Navigation where ID="&sortId&""
	set rsObj = dbconn.db(sqlStr,"records1")
	if not rsObj.eof then SortName=rsObj(0) else SortName="未知分类"
	rsObj.close
	set rsObj = nothing
End Function
'类别父名称(文章显示)
Function SortPName(sortId)
    dim sqlStr,rsObj
	sqlStr= "select NavName from {pre}Navigation where ID=(select ParentID from {pre}Navigation where ID="&sortId&")"
	set rsObj = dbconn.db(sqlStr,"records1")
	if not rsObj.eof then SortPName=rsObj(0) else SortPName="未知分类"
	rsObj.close
	set rsObj = nothing
End Function
'选择类别(添加文章类别选择)
Sub selectTypeAdd(typeId)
	dim sqlStr,rsObj
	sqlStr= "select ParentID from {pre}Navigation where WebType="&typeId&" and deeppath=2 and IsShow=1 group by ParentID"
	set rsObj = dbconn.db(sqlStr,"records1")
	do while not rsObj.eof
	    makeTypeOption rsObj(0),"&nbsp;&nbsp;&nbsp;&nbsp;",0
	rsObj.movenext
	loop
	rsObj.close
	set rsObj = nothing
End Sub
'选择类别(修改文章类别选择)
Sub selectTypeEdit(typeId,compareValue,parentid)
	dim sqlStr,rsObj
	sqlStr= "select ParentID from {pre}Navigation where ParentID="& parentid &" and deeppath=2  group by ParentID"
	set rsObj = dbconn.db(sqlStr,"records1")
	if rsObj.recordCount>0 Then
	do while not rsObj.eof
		makeTypeOption rsObj(0),"&nbsp;&nbsp;&nbsp;&nbsp;",compareValue
	rsObj.movenext
	loop
	else
		dim names:names=dbconn.db("select NavName from {pre}Navigation where id="&parentid ,"execute")(0)
		echo "<option value='"&parentid&"' selected>&nbsp;|—"&names&"</option>"
	end if
	rsObj.close : set rsObj = nothing
End Sub
'所有类别
dim span : span=""
Sub makeTypeOption(topId,separateStr,compareValue)
	dim sqlStr,rsObj,selectedStr
	sqlStr= "select ID,NavName from {pre}Navigation where ParentID="&topId&" order by ID asc"
	set rsObj = dbconn.db(sqlStr,"records1")
	do while not rsObj.eof
	    if rsObj("ID")=compareValue then selectedStr=" selected" else selectedStr=""
		echo "<option value='"&rsObj("ID")&"' "&selectedStr&">"&span&"&nbsp;|—"&rsObj("NavName")&"</option>"
		span=span&separateStr
		makeTypeOption rsObj("ID"),separateStr,compareValue
		rsObj.movenext
	loop
	if not isNul(span) then span = left(span,len(span)-len(separateStr))
	rsObj.close
	set rsObj = nothing
End Sub

'二级类别
Sub makeTypeTOption(topId,separateStr,compareValue)
	dim sqlStr,rsObj,selectedStr
	sqlStr= "select ID,NavName,DeepPath from {pre}Navigation where ParentID="&topId&" and  DeepPath <= 3 order by ID asc"
	set rsObj = dbconn.db(sqlStr,"records1")
	do while not rsObj.eof
	    if rsObj("ID")=compareValue then selectedStr=" selected" else selectedStr=""
		echo "<option value='"&rsObj("ID")&"' "&selectedStr&">"&span&"&nbsp;|—"&rsObj("NavName")&"</option>"
		span=span&separateStr
		makeTypeTOption rsObj("ID"),separateStr,compareValue
		rsObj.movenext
	loop
	if not isNul(span) then span = left(span,len(span)-len(separateStr))
	rsObj.close
	set rsObj = nothing
End Sub
'所有大类别
Sub makeTypePOption(topId,separateStr,compareValue)
	dim sqlStr,rsObj,selectedStr
	sqlStr= "select ID,NavName from {pre}Navigation where ParentID="&topId&" order by ID asc"
	set rsObj = dbconn.db(sqlStr,"records1")
	do while not rsObj.eof
	    if rsObj("ID")=compareValue then selectedStr=" selected" else selectedStr=""
		echo "<option value='"&rsObj("ID")&"' "&selectedStr&">"&span&"&nbsp;|—"&rsObj("NavName")&"</option>"
		span=span&separateStr
		makeTypeOption rsObj("ID"),separateStr,compareValue
		rsObj.movenext
	loop
	if not isNul(span) then span = left(span,len(span)-len(separateStr))
	rsObj.close
	set rsObj = nothing
End Sub

Sub CityOption(topId,separateStr,compareValue)
	dim sqlStr,rsObj,selectedStr
	sqlStr= "select ID,Name from {pre}City where Pid="&topId&" order by ord,ID asc"
	set rsObj = dbconn.db(sqlStr,"records1")
	do while not rsObj.eof
	    if rsObj("ID")=compareValue then selectedStr=" selected" else selectedStr=""
		echo "<option value='"&rsObj("ID")&"' "&selectedStr&">"&span&"&nbsp;|—"&rsObj("Name")&"</option>"
		'span=span&separateStr
		'makeTypeOption rsObj("ID"),separateStr,compareValue
		rsObj.movenext
	loop
	if not isNul(span) then span = left(span,len(span)-len(separateStr))
	rsObj.close
	set rsObj = nothing
End Sub

'所有类别
dim qtspan : qtspan=""
dim qtstr : qtstr=""
Function makeqtType(topId,separateStr,classname,dir)
	dim sqlStr,rsObj,selectedStr
	sqlStr= "select ID,NavName from {pre}Navigation where ParentID="&topId&" order by ID asc"
	set rsObj = dbconn.db(sqlStr,"records1")
	do while not rsObj.eof
		if runMode="dynamic" then
			qtstr = qtstr + "<div class='"&classname&"'>"&qtspan&"·<a href='/"&sitePath&dir&"/indexlist.asp?SortID="&rsObj("ID")&"'>"&rsObj("NavName")&"</a></div>"
		elseif runMode="static" then
			qtstr = qtstr + "<div class='"&classname&"'>"&qtspan&"·<a href='/"&sitePath&dir&"/list/index"&rsObj("ID")&".html'>"&rsObj("NavName")&"</a></div>"
		end if
		qtspan=qtspan&separateStr
		makeqtType rsObj("ID"),separateStr,classname,dir
		rsObj.movenext
	loop
	if not isNul(qtspan) then qtspan = left(qtspan,len(qtspan)-len(separateStr))
	rsObj.close
	set rsObj = nothing
	makeqtType=qtstr
End Function
'正则
function OnlyWord(strng)
  Set re=new RegExp
  re.IgnoreCase =True
  re.Global=True
  re.Pattern = "(<img )(.[^>]*)(>)" '设置模式。
  OnlyWord=re.Replace(strng,"")
  Set re= nothing
end function

'获取SortID分类的顶级分类ID
Function GetTopId(byval SortID)
    dim sqlStr,rsObj,ChildArray,i
	sqlStr= "select ID,ChildPath from {pre}Navigation where ParentID=0"
	set rsObj = dbconn.db(sqlStr,"records1")
	do while not rsObj.eof
	    ChildArray=split(rsObj(1),",")
		for i=0 to ubound (ChildArray)
		    if cint(ChildArray(i))=cint(SortID) then GetTopId=rsObj(0) : exit for : exit do
		next
	rsObj.movenext
	loop
	rsObj.close
	set rsObj = nothing
End Function

Sub checkRunMode
	if runMode="dynamic" then  die "<div style='width:50%;margin-top:50px;background:#66CCCC;font-size:13px;'><br><font color='red'>网站运行模式为动态，不允许生成</font><br><br></div>"
End Sub
'是否为当前日期
Sub isCurrentDay(timeStr)
	if isNul(timeStr) then echo "":Exit Sub
	dim timeStr2 : timeStr2=date
	if instr(timeStr,timeStr2)>0 then  echo "<span style='color:red;font-size:9px'>"&timeStr&"</span>" else echo "<span style='font-size:9px'>"&timeStr&"</span>"
End Sub

'替换特殊符号
Function ReplaceSymbols(byVal ChkStr)
    Dim Str
    Str = ChkStr
    If IsNull(Str) Then
        CheckStr = ""
        Exit Function
    End If
    Str = Replace(Str, "'", "''")
    ReplaceSymbols = Str
End Function

'过滤xss注入
Function Checkxss(byVal ChkStr)
    Dim Str
    Str = ChkStr
    If IsNull(Str) Then
        CheckStr = ""
        Exit Function
    End If
    Str = Replace(Str, "&", "&amp;")
    Str = Replace(Str, "'", "&acute;")
    Str = Replace(Str, """", "&quot;")
        Str = Replace(Str, "<", "&lt;")
        Str = Replace(Str, ">", "&gt;")
        Str = Replace(Str, "/", "&#47;")
        Str = Replace(Str, "*", "&#42;")
    Dim re
    Set re = New RegExp
    re.IgnoreCase = True
    re.Global = True
    re.Pattern = "(w)(here)"
    Str = re.Replace(Str, "$1h&#101;re")
    re.Pattern = "(s)(elect)"
    Str = re.Replace(Str, "$1el&#101;ct")
    re.Pattern = "(i)(nsert)"
    Str = re.Replace(Str, "$1ns&#101;rt")
    re.Pattern = "(c)(reate)"
    Str = re.Replace(Str, "$1r&#101;ate")
    re.Pattern = "(d)(rop)"
    Str = re.Replace(Str, "$1ro&#112;")
    re.Pattern = "(a)(lter)"
    Str = re.Replace(Str, "$1lt&#101;r")
    re.Pattern = "(d)(elete)"
    Str = re.Replace(Str, "$1el&#101;te")
    re.Pattern = "(u)(pdate)"
    Str = re.Replace(Str, "$1p&#100;ate")
    re.Pattern = "(\s)(or)"
    Str = re.Replace(Str, "$1o&#114;")
        re.Pattern = "(\n)"
    Str = re.Replace(Str, "$1o&#114;")
        '----------------------------------
        re.Pattern = "(java)(script)"
    Str = re.Replace(Str, "$1scri&#112;t")
        re.Pattern = "(j)(script)"
    Str = re.Replace(Str, "$1scri&#112;t")
        re.Pattern = "(vb)(script)"
    Str = re.Replace(Str, "$1scri&#112;t")
        '----------------------------------
        If Instr(Str, "expression") > 0 Then
                Str = Replace(Str, "expression", "e&#173;xpression", 1, -1, 0)
        End If
    Set re = Nothing
    Checkxss = Str
End Function



Function RemoveHTML( strText )
Dim TAGLIST
TAGLIST = ";!--;!DOCTYPE;A;ACRONYM;ADDRESS;APPLET;AREA;B;BASE;BASEFONT;" &_
"BGSOUND;BIG;BLOCKQUOTE;BODY;BR;BUTTON;CAPTION;CENTER;CITE;CODE;" &_
"COL;COLGROUP;COMMENT;DD;DEL;DFN;DIR;DIV;DL;DT;EM;EMBED;FIELDSET;" &_
"FONT;FORM;FRAME;FRAMESET;HEAD;H1;H2;H3;H4;H5;H6;HR;HTML;I;IFRAME;IMG;" &_
"INPUT;INS;ISINDEX;KBD;LABEL;LAYER;LAGEND;LI;LINK;LISTING;MAP;MARQUEE;" &_
"MENU;META;NOBR;NOFRAMES;NOSCRIPT;OBJECT;OL;OPTION;p;PARAM;PLAINTEXT;" &_
"PRE;Q;S;SAMP;SCRIPT;SELECT;SMALL;SPAN;STRIKE;STRONG;STYLE;SUB;SUP;" &_
"TABLE;TBODY;TD;TEXTAREA;TFOOT;TH;THEAD;TITLE;TR;TT;U;UL;VAR;WBR;XMP;"

Const BLOCKTAGLIST = ";APPLET;EMBED;FRAMESET;HEAD;NOFRAMES;NOSCRIPT;OBJECT;SCRIPT;STYLE;"

Dim nPos1
Dim nPos2
Dim nPos3
Dim strResult
Dim strTagName
Dim bRemove
Dim bSearchForBlock

nPos1 = InStr(strText, "<")
Do While nPos1 > 0
nPos2 = InStr(nPos1 + 1, strText, ">")
If nPos2 > 0 Then
strTagName = Mid(strText, nPos1 + 1, nPos2 - nPos1 - 1)
strTagName = Replace(Replace(strTagName, vbCr, " "), vbLf, " ")

nPos3 = InStr(strTagName, " ")
If nPos3 > 0 Then
strTagName = Left(strTagName, nPos3 - 1)
End If

If Left(strTagName, 1) = "/" Then
strTagName = Mid(strTagName, 2)
bSearchForBlock = False
Else
bSearchForBlock = True
End If

If InStr(1, TAGLIST, ";" & strTagName & ";", vbTextCompare) > 0 Then
bRemove = True
If bSearchForBlock Then
If InStr(1, BLOCKTAGLIST, ";" & strTagName & ";", vbTextCompare) > 0 Then
nPos2 = Len(strText)
nPos3 = InStr(nPos1 + 1, strText, "</" & strTagName, vbTextCompare)
If nPos3 > 0 Then
nPos3 = InStr(nPos3 + 1, strText, ">")
End If

If nPos3 > 0 Then
nPos2 = nPos3
End If
End If
End If
Else
bRemove = False
End If

If bRemove Then
strResult = strResult & Left(strText, nPos1 - 1)
strText = Mid(strText, nPos2 + 1)
Else
strResult = strResult & Left(strText, nPos1)
strText = Mid(strText, nPos1 + 1)
End If
Else
strResult = strResult & strText
strText = ""
End If

nPos1 = InStr(strText, "<")
Loop
strResult = strResult & strText

RemoveHTML = strResult
End Function

Public Function CutStr(str,strlen)
Dim l,t,i,c
  If str="" Then
     cutstr=""
    Exit Function
  End If
     l=Len(str)
     t=0
     For i=1 To l
     c=Abs(Asc(Mid(str,i,1)))
     If c>255 Then
    t=t+2
     Else
    t=t+1
     End If
     If t>=strlen Then
    cutstr=Left(str,i) & "..."
    Exit For
     Else
    cutstr=str
     End If
     Next
End Function


'生成缩略图
'lj1 原图路径
'tu 图片名称
'lj2 缩略图存放路径
function CreatePic(lj1,tu,lj2,img_width)
dim Jpeg,Path
Set Jpeg = Server.CreateObject("Persits.Jpeg")
Path = server.mappath(lj1& "" &tu) ' 图片所在位置
Jpeg.Open Path ' 打开
if Jpeg.OriginalWidth>Jpeg.OriginalHeight then ' 设置缩略图大小（这里比例设定为50%）
Jpeg.Width =img_width
Jpeg.Height = Jpeg.OriginalHeight / (Jpeg.OriginalWidth / Jpeg.Width )
else
Jpeg.Height =img_width
Jpeg.Width = Jpeg.OriginalWidth / ( Jpeg.OriginalHeight/ Jpeg.Height)
end if 

If CheckFolder(lj2) Then
'response.Write("<script>alert('文件夹已经创建')<'/script>")
Else 
CreateFolder(lj2)
End If
Jpeg.Save server.mappath(lj2 & "/"&tu) ' 保存缩略图到指定文件夹下
Set Jpeg = Nothing ' 注销实例
end function 

'判断文件夹是否存在
function CheckFolder(path)
  Set fs = Server.CreateObject("Scripting.FileSystemObject")
  If fs.FolderExists(Server.MapPath(path)) = true Then
      CheckFolder=true
  Else
      CheckFolder=false
  End If
end function

'新建文件夹
function CreateFolder(strFolder)
strTestFolder = Server.Mappath(strFolder)
set objFSO = server.CreateObject("scripting.filesystemobject") 
if objFSO.FolderExists(strTestFolder) Then
CreateFolder=false
else
objFSO.createfolder(strTestFolder)
CreateFolder=true
end if
set objFSO=nothing
end function

'判断文件是否存在
function FileTrueOrFalse(path)
set objFSO = Server.CreateObject("Scripting.FileSystemObject")
if objFSO.fileexists(server.mappath(path))  then   
    FileTrueOrFalse=true
else
    FileTrueOrFalse=false
end if
set objFSO=nothing

end function

'将路径字段的路径对应的图片遍历生成缩略图
'm_p_img文件路径字段名
'文本框的值
sub PathFieldCreate(m_p_img,text_value)
if m_p_img<>"" then
max_widthheight=text_value
if not isnumeric(max_widthheight) then 
response.Write("<script>alert('对不起，您输入的值“"&max_widthheight&"”不是整数型的，请输入整数型数值'); history.back();</script>")
exit sub
end if
max_widthheight=cint(text_value)
if max_widthheight <= 0 or max_widthheight="" or max_widthheight=null then
response.Write("<script>alert('对不起，您输入的值“"&max_widthheight&"”，请输入大于0的数字'); history.back();</script>")
exit sub
end if
path = split(m_p_img,", ")
filepath=split(m_p_img,", ")
for n=0 to ubound(filepath)
originalpath = left(path(n), InStrRev(path(n), "/"))
strFilename=mid(filepath(n),instrrev(filepath(n),"/")+1)
call CreatePic(originalpath,strFilename,""&originalpath&"small",max_widthheight)
next
end if
end sub

'将路径字段的路径对应的图片遍历生成缩略图删除
'm_p_img文件路径字段名
sub PathFieldDelete(m_p_img)
if m_p_img<>"" then
path = split(m_p_img,", ")
filepath=split(m_p_img,", ")
for n=0 to ubound(filepath)
originalpath = left(path(n), InStrRev(path(n), "/"))
strFilename=mid(filepath(n),instrrev(filepath(n),"/")+1)
small_img= originalpath&"small/"&strFilename
delFile(small_img)
next
end if
end sub

%>