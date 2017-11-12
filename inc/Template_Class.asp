<%
'****************************************************
'Code for cms668com
'Vision : v2.0
'****************************************************

Class MainClass_Template
	Public content,allPages,currentPage,currentType
	Private labelRule,regExpObj,strDictionary,typeDic
	
	Public Sub Class_Initialize()
		set regExpObj= new RegExp
		regExpObj.ignoreCase = true
		regExpObj.Global = true
		set strDictionary = server.CreateObject(DICTIONARY_OBJ_NAME)
	End Sub
	
	Public Sub Class_Terminate()
		set regExpObj = nothing
		set strDictionary = nothing
	End Sub
	'加载模板文件
	Public Function load(Byval filePath)
			content = loadFile(filePath)
	End Function		
	'自定义标签替换
	Public Function parseSelf()
		dim matches,match,labelName,selfLabelArray,selfLabelLen,sql,singleAttrKey,singleAttrValue
		sql = "select LName,LContent from {pre}selflabel"
		labelRule="{self:([\s\S]+?)}"
		selfLabelArray = conn.db(sql,"array")
		if isArray(selfLabelArray) then 
			for selfLabelLen = 0 to ubound(selfLabelArray,2)
				singleAttrKey=selfLabelArray(0,selfLabelLen)
				singleAttrValue=decodeHtml(selfLabelArray(1,selfLabelLen))
				if not strDictionary.Exists(singleAttrKey) then strDictionary.add singleAttrKey,singleAttrValue  else  strDictionary(singleAttrKey) = singleAttrValue
			next
		end if
		regExpObj.Pattern = labelRule
		set matches = regExpObj.Execute(content)
		for each match in matches
			labelName = trim(match.SubMatches(0))
			if strDictionary.Exists(labelName) then content=replace(content,match.value,strDictionary(labelName))
		next
		strDictionary.RemoveAll
		set matches = nothing
	End Function
	'头部和底部文件替换
	Public Function parseTopAndFoot() 
		content = replaceStr(content,"{cms668com:top}",loadFile("/"&sitePath&"template/"&defaultTemplate&"/"&templateFileFolder&"/head.html")) 
		content = replaceStr(content,"{cms668com:foot}",loadFile("/"&sitePath&"template/"&defaultTemplate&"/"&templateFileFolder&"/foot.html"))
		content = replaceStr(content,"{cms668com:slide}",loadFile("/"&sitePath&"js/ad/slide.asp"))
		content = replaceStr(content,"images/","/"&sitePath&"template/"&defaultTemplate&"/images/")
	End Function
	'全局标签替换
	Public Function parseGlobal() 
		content = replaceStr(content,"{cms668com:indexlink}",getIndexLink)
		content = replaceStr(content,"{cms668com:sitename}",siteName) 
		content = replaceStr(content,"{cms668com:copyright}",decodeHtml(copyRight))
		content = replaceStr(content,"{cms668com:des}",decodeHtml(siteDes))
		content = replaceStr(content,"{cms668com:keywords}",siteKeyWords)
		content = replaceStr(content,"{cms668com:sitenotice}",siteNotice) 
	End Function
	'获取可用标签参数
	Public Function parseAttr(Byval attr)
		dim attrStr,attrArray,attrDictionary,i,singleAttr,singleAttrKey,singleAttrValue
		attrStr = regExpReplace(attr,"[\s]+",chr(32))
		attrStr = trimOuter(attrStr)
		attrArray = split(attrStr,chr(32))
		for i=0 to ubound(attrArray)
			singleAttr = split(attrArray(i),chr(61))
			singleAttrKey =  singleAttr(0) : singleAttrValue =  singleAttr(1)
			if not strDictionary.Exists(singleAttrKey) then strDictionary.add singleAttrKey,singleAttrValue else strDictionary(singleAttrKey) = singleAttrValue
		next
		set parseAttr = strDictionary
	End Function
	'正则替换
	Public Function regExpReplace(contentstr,patternstr,replacestr)
		regExpObj.Pattern = patternstr
		regExpReplace = regExpObj.replace(contentstr,replacestr)
	End Function
	'替换循环标签
	Public Function parseContent(Byval str)
	    dim match,matches,matchfield,matchesfield
		dim labelAttr,loopstr,nloopstr,loopstrTotal,attrDictionary
		dim vnum,vtype,vsort,vorder,vtime
		dim fieldName,fieldAttr,fieldNameAndAttr
		dim i,labelRuleField
		dim timestyle,namelen,infolen
		dim m,sql,whereType,whereSort,whereTime,orderStr,DateArray
		dim vsortStr,vsortI,vsortArray,vsortArrayLen
		labelRule = "{cms668com:"&str&"([\s\S]*?)}([\s\S]*?){/cms668com:"&str&"}"
		labelRuleField = "\["&str&":([\s\S]+?)\]"
		regExpObj.Pattern = labelRule
		set matches = regExpObj.Execute(content)
		for each match in matches
		    labelAttr = match.SubMatches(0)
			loopstr = match.SubMatches(1)
			set attrDictionary = parseAttr(labelAttr)
			vnum = attrDictionary("num") : vtype = attrDictionary("type") : vsort = attrDictionary("sort") : vorder = attrDictionary("order") : vtime = attrDictionary("time")
			if isNul(vtype) then vtype="all"
			if  vtype <> "all" then 
				if cint(vtype)=1 then
					whereType=" and len(sNewsPic)=0"
				elseif 	cint(vtype)=2 then
					whereType=" and len(sNewsPic)>0"
				end if
			else 
				whereType=""
			end if
			if isNul(vnum) then vnum = 10  else vnum = cint(vnum)
			vsortStr=""
			if isNul(vsort) then vsort="all"
			if  vsort <> "all" then 
				if instr(vsort,",")>0 then 
					vsortArray=split(vsort,","):vsortArrayLen=ubound(vsortArray)
					for vsortI=0 to vsortArrayLen
						vsortStr=vsortStr&vsortArray(vsortI)&","
					next
					vsortStr=trimOuterStr(vsortStr,",")
				else
					vsortStr=vsort
				end if
				whereSort=" and SortID in ("&vsortStr&")"
			else 
				whereSort=""
			end if
			if isNul(vorder) then vorder = "time"
			select case vorder           
				case "id" : orderStr =" order by ID desc"
				case "hit" : orderStr =" order by hits desc"
				case "time" : orderStr =" order by AddDate desc"
			end select
			select case vtime
				case "day" : whereTime = " and  DateDiff('d',AddDate,'"&now()&"')=0"
				case "week" : whereTime = " and  DateDiff('w',AddDate,'"&now()&"')=0"
				case "month" : whereTime = " and  DateDiff('m',AddDate,'"&now()&"')=0"
				case else : whereTime=""
			end select
			set attrDictionary = nothing
			select case str
			case "news"
			    sql="select top "&vnum&" ID,NewsName,IsTurn,Hits,sNewsPic,AddDate,TurnUrl,Content,SortID from {pre}News where 1=1"&whereType&whereSort&whereTime&orderStr
			case "downs"
			    sql="select top "&vnum&" ID,DownName,TitleColor,sSoftPic,Hits,AddDate,SortID from {pre}Down where 1=1"&whereSort&whereTime&orderStr
			case "products"
			    sql="select top "&vnum&" ID,ProductName,TitleColor,sProductPic,YPrice,DZPrice,SortID from {pre}Product where 1=1"&whereSort&whereTime&orderStr
			case "photos"
			    sql="select top "&vnum&" ID,PhotoName,TitleColor,sPhotoPic,[Describe],PhotoPic,SortID from {pre}Photo where 1=1"&whereSort&whereTime&orderStr
			case "cases"
			    sql="select top "&vnum&" ID,CaseName,TitleColor,sCasePic,Introduce,SortID from {pre}Case where 1=1"&whereSort&whereTime&orderStr
			case "about"
			    if isNul(vsort) then
			        sql="select top 1 Content,ID,SortID from {pre}About"
				else
				    sql="select Content,ID,SortID from {pre}About where SortID="&vsort&""
				end if
			end select
			conn.fetchCount=vnum
			DateArray = conn.db(sql,"array")
			conn.fetchCount=0
			regExpObj.Pattern = labelRuleField
			set matchesfield = regExpObj.Execute(loopstr)
			loopstrTotal = ""
			if isArray(DateArray) then vnum = ubound(DateArray,2) else vnum=-1
			for i = 0 to vnum
			    nloopstr=loopstr
			    for each matchfield in matchesfield
					fieldNameAndAttr = regExpReplace(matchfield.SubMatches(0),"[\s]+",chr(32))
					fieldNameAndAttr = trimOuter(fieldNameAndAttr)
					m = instr(fieldNameAndAttr,chr(32))
					if  m > 0 then 
						fieldName = left(fieldNameAndAttr,m - 1)
						fieldAttr =	right(fieldNameAndAttr,len(fieldNameAndAttr) - m)
					else
						fieldName = fieldNameAndAttr
						fieldAttr =	""
					end if
					select case str
					case "news"
						select case fieldName
							case "i"
								nloopstr = replaceStr(nloopstr,matchfield.value,i+1)
							case "link"
							    if DateArray(2,i)=1 then nloopstr = replaceStr(nloopstr,matchfield.value,DateArray(6,i)) : else nloopstr = replaceStr(nloopstr,matchfield.value,getShowLink(DateArray(8,i),DateArray(0,i),"News"))
							case "name"
								namelen = parseAttr(fieldAttr)("len") : if isNul(namelen) then namelen = 8 else namelen=cint(namelen)
								nloopstr = replaceStr(nloopstr,matchfield.value,left(DateArray(1,i),namelen))
							case "info"
								infolen = parseAttr(fieldAttr)("len") : if isNul(infolen) then infolen = 8 else infolen=cint(infolen)
								nloopstr = replaceStr(nloopstr,matchfield.value,left(filterStr(DateArray(7,i),"html"),infolen))
							case "hits"
								nloopstr = replaceStr(nloopstr,matchfield.value,DateArray(3,i))
							case "spic"
								if not isNul(DateArray(4,i)) then 
									if instr(DateArray(4,i),"http://")>0 then 
										nloopstr = replaceStr(nloopstr,matchfield.value,DateArray(4,i))
									else
										nloopstr = replaceStr(nloopstr,matchfield.value,"/"&sitePath&DateArray(4,i))
									end if
								else
									nloopstr = replaceStr(nloopstr,matchfield.value,"/"&sitePath&"images/nopic_small.gif")
								end if
							case "date"
								timestyle = parseAttr(fieldAttr)("style") : if isNul(timestyle) then timestyle = "m-d"
								select case timestyle
									case "yy-m-d"
										nloopstr = replaceStr(nloopstr,matchfield.value,year(DateArray(5,i))&"-"&month(DateArray(5,i))&"-"&day(DateArray(5,i)))
									case "y-m-d"
										nloopstr = replaceStr(nloopstr,matchfield.value,right(year(DateArray(5,i)),2)&"-"&month(DateArray(5,i))&"-"&day(DateArray(5,i)))
									case "m-d"
										nloopstr = replaceStr(nloopstr,matchfield.value,month(DateArray(5,i))&"-"&day(DateArray(5,i)))
								end select	
						end select
					case "downs"
						select case fieldName
							case "i"
								nloopstr = replaceStr(nloopstr,matchfield.value,i+1)
							case "link"
								nloopstr = replaceStr(nloopstr,matchfield.value,getShowLink(DateArray(6,i),DateArray(0,i),"Downs"))
							case "name"
								namelen = parseAttr(fieldAttr)("len") : if isNul(namelen) then namelen = 8 else namelen=cint(namelen)
								nloopstr = replaceStr(nloopstr,matchfield.value,left(DateArray(1,i),namelen))
							case "info"
								infolen = parseAttr(fieldAttr)("len") : if isNul(infolen) then infolen = 8 else infolen=cint(infolen)
								nloopstr = replaceStr(nloopstr,matchfield.value,left(filterStr(DateArray(4,i),"html"),infolen))
							case "spic"
								if not isNul(DateArray(3,i)) then 
									if instr(DateArray(3,i),"http://")>0 then 
										nloopstr = replaceStr(nloopstr,matchfield.value,DateArray(3,i))
									else
										nloopstr = replaceStr(nloopstr,matchfield.value,"/"&sitePath&DateArray(3,i))
									end if
								else
									nloopstr = replaceStr(nloopstr,matchfield.value,"/"&sitePath&"images/nopic_small.gif")
								end if	
							case "hits"
								nloopstr = replaceStr(nloopstr,matchfield.value,DateArray(5,i))
							case "date"
								timestyle = parseAttr(fieldAttr)("style") : if isNul(timestyle) then timestyle = "m-d"
								select case timestyle
									case "yy-m-d"
										nloopstr = replaceStr(nloopstr,matchfield.value,year(DateArray(6,i))&"-"&month(DateArray(6,i))&"-"&day(DateArray(6,i)))
									case "y-m-d"
										nloopstr = replaceStr(nloopstr,matchfield.value,right(year(DateArray(6,i)),2)&"-"&month(DateArray(6,i))&"-"&day(DateArray(6,i)))
									case "m-d"
										nloopstr = replaceStr(nloopstr,matchfield.value,month(DateArray(6,i))&"-"&day(DateArray(6,i)))
								end select	
						end select
					case "products"
						select case fieldName
							case "i"
								nloopstr = replaceStr(nloopstr,matchfield.value,i+1)
							case "link"
								nloopstr = replaceStr(nloopstr,matchfield.value,getShowLink(DateArray(6,i),DateArray(0,i),"Products"))
							case "name"
								namelen = parseAttr(fieldAttr)("len") : if isNul(namelen) then namelen = 8 else namelen=cint(namelen)
								nloopstr = replaceStr(nloopstr,matchfield.value,left(DateArray(1,i),namelen))
							case "spic"
								if not isNul(DateArray(3,i)) then 
									if instr(DateArray(3,i),"http://")>0 then 
										nloopstr = replaceStr(nloopstr,matchfield.value,DateArray(3,i))
									else
										nloopstr = replaceStr(nloopstr,matchfield.value,"/"&sitePath&DateArray(3,i))
									end if
								else
									nloopstr = replaceStr(nloopstr,matchfield.value,"/"&sitePath&"images/nopic_small.gif")
								end if	
							case "yprice"
								nloopstr = replaceStr(nloopstr,matchfield.value,DateArray(4,i))
							case "dzprice"
								nloopstr = replaceStr(nloopstr,matchfield.value,DateArray(5,i))
						end select
					case "photos"
						select case fieldName
							case "i"
								nloopstr = replaceStr(nloopstr,matchfield.value,i+1)
							case "link"
								nloopstr = replaceStr(nloopstr,matchfield.value,getShowLink(DateArray(6,i),DateArray(0,i),"Photos"))
							case "name"
								namelen = parseAttr(fieldAttr)("len") : if isNul(namelen) then namelen = 8 else namelen=cint(namelen)
								nloopstr = replaceStr(nloopstr,matchfield.value,left(DateArray(1,i),namelen))
							case "spic"
								if not isNul(DateArray(3,i)) then 
									if instr(DateArray(3,i),"http://")>0 then 
										nloopstr = replaceStr(nloopstr,matchfield.value,DateArray(3,i))
									else
										nloopstr = replaceStr(nloopstr,matchfield.value,"/"&sitePath&DateArray(3,i))
									end if
								else
									nloopstr = replaceStr(nloopstr,matchfield.value,"/"&sitePath&"images/nopic_small.gif")
								end if
							case "pic"
									if not isNul(DateArray(5,i)) then 
										if instr(DateArray(5,i),"http://")>0 then 
											nloopstr = replaceStr(nloopstr,matchfield.value,DateArray(5,i))
										else
											nloopstr = replaceStr(nloopstr,matchfield.value,"/"&sitePath&DateArray(5,i))
										end if
									else
										nloopstr = replaceStr(nloopstr,matchfield.value,"/"&sitePath&"images/nopic_small.gif")
									end if
							case "info"
								infolen = parseAttr(fieldAttr)("len") : if isNul(infolen) then infolen = 8 else infolen=cint(infolen)
								nloopstr = replaceStr(nloopstr,matchfield.value,left(filterStr(DateArray(4,i),"html"),infolen))
						end select
					case "cases"
						select case fieldName
							case "i"
								nloopstr = replaceStr(nloopstr,matchfield.value,i+1)
							case "link"
								nloopstr = replaceStr(nloopstr,matchfield.value,getShowLink(DateArray(5,i),DateArray(0,i),"Cases"))
							case "name"
								namelen = parseAttr(fieldAttr)("len") : if isNul(namelen) then namelen = 8 else namelen=cint(namelen)
								nloopstr = replaceStr(nloopstr,matchfield.value,left(DateArray(1,i),namelen))
							case "spic"
								if not isNul(DateArray(3,i)) then 
									if instr(DateArray(3,i),"http://")>0 then 
										nloopstr = replaceStr(nloopstr,matchfield.value,DateArray(3,i))
									else
										nloopstr = replaceStr(nloopstr,matchfield.value,"/"&sitePath&DateArray(3,i))
									end if
								else
									nloopstr = replaceStr(nloopstr,matchfield.value,"/"&sitePath&"images/nopic_small.gif")
								end if	
							case "info"
								infolen = parseAttr(fieldAttr)("len") : if isNul(infolen) then infolen = 8 else infolen=cint(infolen)
								nloopstr = replaceStr(nloopstr,matchfield.value,left(filterStr(DateArray(4,i),"html"),infolen))
						end select
					case "about"
						select case fieldName
							case "info"
								infolen = parseAttr(fieldAttr)("len") : if isNul(infolen) then infolen = 8 else infolen=cint(infolen)
								nloopstr = replaceStr(nloopstr,matchfield.value,left(filterStr(DateArray(0,i),"html"),infolen))
						end select
					end select	
				next
				loopstrTotal = loopstrTotal & nloopstr
			next
			set matchesfield = nothing
			content = replaceStr(content,match.value,loopstrTotal)
			strDictionary.removeAll
		next
		set matches = nothing
	End Function
	'替换List循环标签
	Public Function parsePageList(typeIds,currentPage,pageListType,keys)
		dim matchChannel,matchesChannel,loopstrChannel,loopstrTotal,attrChannel,attrDictionary,loopstrChannelNew
		dim labelRuleField
		dim vsize,vorder
		dim i,m,sql,rsObj,orderStr,whereStr
		dim matchfield,matchesfield,fieldNameAndAttr,fieldName,fieldAttr
		dim namelen,infolen,actorlen,deslen,timestyle,videoTime,colornamelen,m_colorname,m_color,m_note,notelen
		dim matchPagelist,matchesPagelist,labelRulePagelist,lenPagelist,strPagelist
		dim TypeId
		labelRule = "{cms668com:"&pageListType&"([\s\S]*?)}([\s\S]*?){/cms668com:"&pageListType&"}"
		labelRuleField = "\["&pageListType&":([\s\S]+?)\]"
		labelRulePagelist = "\["&pageListType&":pagenumber([\s\S]*?)\]"
		regExpObj.Pattern = labelRule
		set matchesChannel = regExpObj.Execute(content)
		for each matchChannel in matchesChannel
			attrChannel = matchChannel.SubMatches(0)
			loopstrChannel = matchChannel.SubMatches(1)
			set attrDictionary = parseAttr(attrChannel)
			vsize = cint(attrDictionary("size")) : vorder = attrDictionary("order")
			if isNul(vsize) then vsize = 12 
			if isNul(vorder) then vorder = "time"
			select case vorder           
				case "id" : orderStr =" order by ID desc"
				case "hit" : orderStr =" order by hits desc"
				case "time" : orderStr =" order by AddDate desc"
			end select
			set attrDictionary = nothing
			select case pageListType
				case "newslist"
				    if isNul(keys) then
					    sql="select ID,NewsName,TitleColor,sNewsPic,Content,IsTurn,Hits,AddDate,SortID,TurnUrl from {pre}News where SortID in ("&typeIds&")"&orderStr
					else
					    sql="select ID,NewsName,TitleColor,sNewsPic,Content,IsTurn,Hits,AddDate,SortID,TurnUrl from {pre}News where NewsName like '%"&keys&"%' and SortID in ("&typeIds&")"&orderStr
					end if
				case "photolist"
				    if isNul(keys) then
					    sql="select ID,PhotoName,TitleColor,lPhotoPic,PhotoPic,[Describe],SortID from {pre}Photo where SortID in ("&typeIds&") "&orderStr
					else
					    sql="select ID,PhotoName,TitleColor,lPhotoPic,PhotoPic,[Describe],SortID from {pre}Photo where PhotoName like '%"&keys&"%' and SortID in ("&typeIds&") "&orderStr
					end if
				case "downlist"
				    if isNul(keys) then
					    sql="select ID,DownName,TitleColor,lSoftPic,Content,[Language],Accmode,FileSize,Hits,AddDate,SortID from {pre}Down where SortID in ("&typeIds&") "&orderStr
					else
					    sql="select ID,DownName,TitleColor,lSoftPic,Content,[Language],Accmode,FileSize,Hits,AddDate,SortID from {pre}Down where DownName like '%"&keys&"%' and SortID in ("&typeIds&") "&orderStr
					end if
				case "productlist"
				    if isNul(keys) then
					    sql="select ID,ProductName,TitleColor,lProductPic,YPrice,DZPrice,SortID from {pre}Product where SortID in ("&typeIds&") "&orderStr
					else
					    sql="select ID,ProductName,TitleColor,lProductPic,YPrice,DZPrice,SortID from {pre}Product where ProductName like '%"&keys&"%' and SortID in ("&typeIds&") "&orderStr
					end if
				case "caselist"
				    if isNul(keys) then
					    sql="select ID,CaseName,TitleColor,lCasePic,CaseDate,Introduce,CaseAddr,Hits,AddDate,SortID from {pre}Case where SortID in ("&typeIds&") "&orderStr
					else
					    sql="select ID,CaseName,TitleColor,lCasePic,CaseDate,Introduce,CaseAddr,Hits,AddDate,SortID from {pre}Case where CaseName like '%"&keys&"%' and SortID in ("&typeIds&") "&orderStr
					end if
				case "guestlist"
				    if guestmode="0" then
				        sql="select MesTitle,LinkName,Content,AddTime,ReplyContent,ReplyTime from {pre}GuestBook where 1=1 order by id desc"
					else
					    sql="select MesTitle,LinkName,Content,AddTime,ReplyContent,ReplyTime from {pre}GuestBook where IsShow=1 order by id desc"
					end if
			end select
			regExpObj.Pattern = labelRuleField
			set matchesfield = regExpObj.Execute(loopstrChannel)
			set rsObj=conn.db(sql,"records1")
			if rsObj.eof then 
			    if isNul(keys) then
				    loopstrTotal="对不起，该分类无任何记录"
				else
				    loopstrTotal="对不起，关键字 <font color='red'>"&keys&"</font> 无任何记录"
				end if
			else
				rsObj.pagesize = vsize
				if currentPage>rsObj.pagecount then currentPage=rsObj.pagecount
				rsObj.absolutepage=currentPage
				loopstrTotal = ""
				for i = 1 to vsize
					loopstrChannelNew = loopstrChannel
					for each matchfield in matchesfield
						fieldNameAndAttr = regExpReplace(matchfield.SubMatches(0),"[\s]+",chr(32))
						fieldNameAndAttr = trimOuter(fieldNameAndAttr)
						m = instr(fieldNameAndAttr,chr(32))
						if  m > 0 then 
							fieldName = left(fieldNameAndAttr,m - 1)
							fieldAttr =	right(fieldNameAndAttr,len(fieldNameAndAttr) - m)
						else
							fieldName = fieldNameAndAttr
							fieldAttr =	""
						end if
						select case pageListType
						case "newslist"
							select case fieldName
								case "link"
								    if rsObj(5)=1 then loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,rsObj(9)) : else loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,getShowLink(rsObj(8),rsObj(0),"News"))
								case "name"
									namelen = parseAttr(fieldAttr)("len") : if isNul(namelen) then namelen = 8 else namelen=cint(namelen)
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,left(rsObj(1),namelen))
								case "info"
									infolen = parseAttr(fieldAttr)("len") : if isNul(infolen) then infolen = 8 else infolen=cint(infolen)
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,left(filterStr(rsObj(4),"html"),infolen))
								case "spic"
									if not isNul(rsObj(3)) then 
										if instr(rsObj(3),"http://")>0 then 
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,rsObj(3))
										else
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,"/"&sitePath&rsObj(3))
										end if
									else
										loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,"/"&sitePath&"images/nopic_small.gif")
									end if
								case "hits"
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,rsObj(6))
								case "date"
									timestyle = parseAttr(fieldAttr)("style") : if isNul(timestyle) then timestyle = "m-d"
									 select case timestyle
										case "yy-m-d"
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,year(rsObj(7))&"-"&month(rsObj(7))&"-"&day(rsObj(7)))
										case "y-m-d"
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,right(year(rsObj(7)),2)&"-"&month(rsObj(7))&"-"&day(rsObj(7)))
										case "m-d"
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,month(rsObj(7))&"-"&day(rsObj(7)))
									end select	
							end select
						case "downlist"
							select case fieldName
								case "link"
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,getShowLink(rsObj(10),rsObj(0),"Downs"))
								case "name"
									namelen = parseAttr(fieldAttr)("len") : if isNul(namelen) then namelen = 8 else namelen=cint(namelen)
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,left(rsObj(1),namelen))
								case "info"
									infolen = parseAttr(fieldAttr)("len") : if isNul(infolen) then infolen = 8 else infolen=cint(infolen)
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,left(filterStr(rsObj(4),"html"),infolen))
								case "language"
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,rsObj(5))
								case "accmode"
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,rsObj(6))
								case "hits"
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,rsObj(8))
								case "date"
									timestyle = parseAttr(fieldAttr)("style") : if isNul(timestyle) then timestyle = "m-d"
									 select case timestyle
										case "yy-m-d"
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,year(rsObj(9))&"-"&month(rsObj(9))&"-"&day(rsObj(9)))
										case "y-m-d"
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,right(year(rsObj(9)),2)&"-"&month(rsObj(9))&"-"&day(rsObj(9)))
										case "m-d"
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,month(rsObj(9))&"-"&day(rsObj(9)))
									end select	
							end select
						case "caselist"
							select case fieldName
							    case "link"
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,getShowLink(rsObj(9),rsObj(0),"Cases"))
								case "name"
									namelen = parseAttr(fieldAttr)("len") : if isNul(namelen) then namelen = 8 else namelen=cint(namelen)
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,left(rsObj(1),namelen))
								case "lpic"
									if not isNul(rsObj(3)) then 
										if instr(rsObj(3),"http://")>0 then 
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,rsObj(3))
										else
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,"/"&sitePath&rsObj(3))
										end if
									else
										loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,"/"&sitePath&"images/nopic_small.gif")
									end if
								case "info"
									infolen = parseAttr(fieldAttr)("len") : if isNul(infolen) then infolen = 8 else infolen=cint(infolen)
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,left(filterStr(rsObj(5),"html"),infolen))
								case "period"
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,rsObj(4))
								case "address"
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,rsObj(6))
								case "hits"
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,rsObj(7))
								case "date"
									timestyle = parseAttr(fieldAttr)("style") : if isNul(timestyle) then timestyle = "m-d"
									 select case timestyle
										case "yy-m-d"
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,year(rsObj(8))&"-"&month(rsObj(8))&"-"&day(rsObj(8)))
										case "y-m-d"
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,right(year(rsObj(8)),2)&"-"&month(rsObj(8))&"-"&day(rsObj(8)))
										case "m-d"
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,month(rsObj(8))&"-"&day(rsObj(8)))
									end select	
							end select
						case "photolist"
							select case fieldName
								case "link"
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,getShowLink(rsObj(6),rsObj(0),"Photos"))
								case "name"
									namelen = parseAttr(fieldAttr)("len") : if isNul(namelen) then namelen = 8 else namelen=cint(namelen)
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,left(rsObj(1),namelen))
								case "info"
									infolen = parseAttr(fieldAttr)("len") : if isNul(infolen) then infolen = 8 else infolen=cint(infolen)
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,left(filterStr(rsObj(5),"html"),infolen))
								case "lpic"
									if not isNul(rsObj(3)) then 
										if instr(rsObj(3),"http://")>0 then 
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,rsObj(3))
										else
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,"/"&sitePath&rsObj(3))
										end if
									else
										loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,"/"&sitePath&"images/nopic_small.gif")
									end if
								case "pic"
									if not isNul(rsObj(4)) then 
										if instr(rsObj(4),"http://")>0 then 
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,rsObj(4))
										else
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,"/"&sitePath&rsObj(4))
										end if
									else
										loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,"/"&sitePath&"images/nopic_small.gif")
									end if	
							end select
						case "productlist"
							select case fieldName
								case "link"
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,getShowLink(rsObj(6),rsObj(0),"Products"))
								case "name"
									namelen = parseAttr(fieldAttr)("len") : if isNul(namelen) then namelen = 8 else namelen=cint(namelen)
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,left(rsObj(1),namelen))
								case "lpic"
									if not isNul(rsObj(3)) then 
										if instr(rsObj(3),"http://")>0 then 
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,rsObj(3))
										else
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,"/"&sitePath&rsObj(3))
										end if
									else
										loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,"/"&sitePath&"images/nopic_small.gif")
									end if
								case "yprice"
								    loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,rsObj(4))
								case "dzrice"
								    loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,rsObj(5))
							end select
						case "guestlist"
							select case fieldName
							    case "i"
								    loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,i)
								case "title"
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,rsObj(0))
								case "name"
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,rsObj(1))
								case "winfo"
									loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,rsObj(2))
								case "wdate"
									timestyle = parseAttr(fieldAttr)("style") : if isNul(timestyle) then timestyle = "m-d"
									 select case timestyle
										case "yy-m-d"
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,year(rsObj(3))&"-"&month(rsObj(3))&"-"&day(rsObj(3)))
										case "y-m-d"
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,right(year(rsObj(3)),2)&"-"&month(rsObj(3))&"-"&day(rsObj(3)))
										case "m-d"
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,month(rsObj(3))&"-"&day(rsObj(3)))
									end select
								case "rinfo"
								    loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,rsObj(4))
								case "isreplay"
								    if rsObj(4)<>"" then loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,1) : else loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,0)
								case "rdate"
								    timestyle = parseAttr(fieldAttr)("style") : if isNul(timestyle) then timestyle = "m-d"
									 select case timestyle
										case "yy-m-d"
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,year(rsObj(5))&"-"&month(rsObj(5))&"-"&day(rsObj(5)))
										case "y-m-d"
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,right(year(rsObj(5)),2)&"-"&month(rsObj(5))&"-"&day(rsObj(5)))
										case "m-d"
											loopstrChannelNew = replaceStr(loopstrChannelNew,matchfield.value,month(rsObj(5))&"-"&day(rsObj(5)))
									end select
							end select
							
						end select
					next
					loopstrTotal = loopstrTotal & loopstrChannelNew
					rsObj.movenext
					if rsObj.eof then exit for
				next
			end if
			content = replace(content,matchChannel.value,loopstrTotal)
			regExpObj.Pattern = labelRulePagelist
			set matchesPagelist = regExpObj.Execute(content)
			for each matchPagelist in matchesPagelist
				if rsObj.pagecount=0 then
					content = replace(content,matchPagelist.value,"")
				else
					lenPagelist = parseAttr(matchPagelist.SubMatches(0))("len")
					if isNul(lenPagelist) then lenPagelist = 10 else lenPagelist = cint(lenPagelist)
					if isExistStr(TypeIds,",") then TypeId=split(TypeIds,",")(0) : else TypeId=TypeIds
					strPagelist = pageNumberLinkInfo(currentPage,lenPagelist,rsObj.pagecount,pageListType,TypeId)
					content = replace(content,matchPagelist.value,strPagelist)
				end if
			next 
			set matchesPagelist = nothing
			set matchesfield = nothing
			strDictionary.removeAll
		next
		set matchesChannel = nothing
	End Function
	'替换菜单
	Public Function parseMenuList(str)
		dim match,matches,matchfield,matchesfield
		dim labelAttrMenulist,loopstrMenulist,loopstrMlistNew,loopstrTotal
		dim vtype,vnum,svtype
		dim fieldName,fieldAttr,fieldNameAndAttr,fieldAttrLen
		dim i,j,labelRuleField,tid,nid
		dim m,rsArray,rslinkArray
		labelRule="{cms668com:"&str&"menulist([\s\S]*?)}([\s\S]*?){/cms668com:"&str&"menulist}"
		labelRuleField="\["&str&"menulist:([\s\S]+?)\]"
		regExpObj.Pattern=labelRule
		set matches=regExpObj.Execute(content)
		for each match in matches
			loopstrTotal=""
			labelAttrMenulist=match.SubMatches(0)
			loopstrMenulist=match.SubMatches(1)
			vtype=parseAttr(labelAttrMenulist)("type")
			if isNul(vtype) then vtype="top"
			select case vtype
				case "top"
					rsArray=conn.db("select NavName,ChildPath,ID from {pre}Navigation where IsShow=1 and ParentID=0 order by Sequence","array")
					if isArray(rsArray) then vnum=ubound(rsArray,2)  else  vnum=-1
				case else
					for i=0 to ubound(split(vtype,","))
						if not isnum(split(vtype,",")(i)) then die "参数错误！"
						j=i+1
						if j<=ubound(split(vtype,",")) then svtype=svtype & split(vtype,",")(i+1) & ","
					next
					if isNul(str) then 
						rsArray=conn.db("select NavName,ChildPath,ID from {pre}Navigation where IsShow=1 and ID in ("&vtype&") order by Sequence","array")			
					else
						rsArray=conn.db("select NavName,ChildPath,ID from {pre}Navigation where IsShow=1 and ID in ("&svtype&") order by Sequence","array")	
					end if
					if isArray(rsArray) then vnum=ubound(rsArray,2)  else  vnum=-1
			end select
			regExpObj.Pattern=labelRuleField
			set matchesfield=regExpObj.Execute(loopstrMenulist)
			for i=0 to vnum
				loopstrMlistNew=loopstrMenulist
				for each matchfield in matchesfield
					fieldNameAndAttr=regExpReplace(matchfield.SubMatches(0),"[\s]+",chr(32))
					fieldNameAndAttr=trimOuter(fieldNameAndAttr)
					m=instr(fieldNameAndAttr,chr(32))
					if  m > 0 then 
						fieldName=left(fieldNameAndAttr,m - 1)
						fieldAttr =	right(fieldNameAndAttr,len(fieldNameAndAttr) - m)
					else
						fieldName=fieldNameAndAttr
						fieldAttr =	""
					end if
					select case fieldName
						case "i"
							loopstrMlistNew=replaceStr(loopstrMlistNew,matchfield.value,i+1)
						case "typeid"
							loopstrMlistNew=replaceStr(loopstrMlistNew,matchfield.value,rsArray(1,i))
						case "typename"
							loopstrMlistNew=replaceStr(loopstrMlistNew,matchfield.value,rsArray(0,i))
						case "link"
						    if isExistStr(rsArray(1,i),",") then tid=split(rsArray(1,i),",")(1) : else tid=rsArray(1,i)
							nid=rsArray(2,i)
							rslinkArray=conn.db("select WebType from {pre}Navigation where IsShow=1 and ID="&tid&" order by Sequence","records1")
							select case rslinkArray(0)
							   case 1
							       loopstrMlistNew=replaceStr(loopstrMlistNew,matchfield.value,getNavLink(tid,"About"))
							   case 2
							       loopstrMlistNew=replaceStr(loopstrMlistNew,matchfield.value,getNavLink(nid,"News"))
							   case 3
							       loopstrMlistNew=replaceStr(loopstrMlistNew,matchfield.value,getNavLink(nid,"Photos"))
							   case 4
							       loopstrMlistNew=replaceStr(loopstrMlistNew,matchfield.value,getNavLink(nid,"Cases"))
							   case 5
							       loopstrMlistNew=replaceStr(loopstrMlistNew,matchfield.value,getNavLink(nid,"Downs"))
							   case 6
							       loopstrMlistNew=replaceStr(loopstrMlistNew,matchfield.value,getNavLink(nid,"Products"))
							   case 7
							       loopstrMlistNew=replaceStr(loopstrMlistNew,matchfield.value,getNavLink(tid,"GuestBook"))
							end select
					end select
				next
				loopstrTotal=loopstrTotal&loopstrMlistNew
			next
			set matchesfield=nothing
			content=replaceStr(content,match.value,loopstrTotal)
			strDictionary.removeAll
		next
		set matches=nothing
		if  isExistStr(content,"{cms668com:smallmenulist") then parseMenuList "small" else Exit Function
	End Function
	'替换友情链接
	Public Function parseLinkList()
		dim match,matches,matchfield,matchesfield
		dim labelAttrLinklist,loopstrLinklist,loopstrLinklistNew,loopstrTotal
		dim vtype,vnum,whereStr,linkArray
		dim fieldName,fieldAttr,fieldNameAndAttr,fieldAttrLen
		dim i,labelRuleField
		dim m,namelen,deslen
		labelRule = "{cms668com:linklist([\s\S]*?)}([\s\S]*?){/cms668com:linklist}"
		labelRuleField = "\[linklist:([\s\S]+?)\]"
		regExpObj.Pattern = labelRule
		set matches = regExpObj.Execute(content)
		for each match in matches
			labelAttrLinklist = match.SubMatches(0)
			loopstrLinklist = match.SubMatches(1)
			vtype = parseAttr(labelAttrLinklist)("type")
			if isNul(vtype) then vtype = "font"
			select case vtype
				case "font" : whereStr = chr(32) & "LinkType=0" & chr(32)
				case "pic" : whereStr = chr(32) & "LinkType=1" & chr(32)
				case else : whereStr = chr(32) & "LinkType=0" & chr(32)
			end select
			linkArray = conn.db("select SiteName,SiteLogo,SiteUrl,LinkInfo from {pre}Link where " & whereStr & " order by Sequence asc","array")
			if not isarray(linkArray) then  vnum=-1  else vnum = ubound(linkArray,2)
			regExpObj.Pattern = labelRuleField
			set matchesfield = regExpObj.Execute(loopstrLinklist)
			loopstrTotal = ""
			for i = 0 to vnum
				loopstrLinklistNew = loopstrLinklist
				for each matchfield in matchesfield
					fieldNameAndAttr = regExpReplace(matchfield.SubMatches(0),"[\s]+",chr(32))
					fieldNameAndAttr = trimOuter(fieldNameAndAttr)
					m = instr(fieldNameAndAttr,chr(32))
					if  m > 0 then 
						fieldName = left(fieldNameAndAttr,m - 1)
						fieldAttr =	right(fieldNameAndAttr,len(fieldNameAndAttr) - m)
					else
						fieldName = fieldNameAndAttr
						fieldAttr =	""
					end if
					select case fieldName
						case "name"
							namelen = parseAttr(fieldAttr)("len") : if isNul(namelen) then namelen = 8 else namelen=cint(namelen)
							loopstrLinklistNew = replaceStr(loopstrLinklistNew,matchfield.value,left(linkArray(0,i),namelen))
						case "link"
							loopstrLinklistNew = replaceStr(loopstrLinklistNew,matchfield.value,linkArray(2,i))
						case "pic"
							loopstrLinklistNew = replaceStr(loopstrLinklistNew,matchfield.value,linkArray(1,i))
						case "des"
							deslen = cint(parseAttr(fieldAttr)("len")) : if isNul(deslen) then namelen = 20
							loopstrLinklistNew = replaceStr(loopstrLinklistNew,matchfield.value,linkArray(3,i))
						case "i"
							loopstrLinklistNew = replaceStr(loopstrLinklistNew,matchfield.value,i+1)
					end select
				next
				loopstrTotal = loopstrTotal & loopstrLinklistNew
			next
			set matchesfield = nothing
			content = replaceStr(content,match.value,loopstrTotal)
			strDictionary.removeAll
		next
		set matches = nothing
	End Function
	
	'替换前台分类
	Public Function parseColumn()
		dim match,matches,matchfield,matchesfield
		dim labelAttrColumn,loopstrColumn,loopstrColumnNew,loopstrTotal
		dim vstyle,vsort,vseparateStr,vdir
		dim fieldName,fieldAttr,fieldNameAndAttr
		dim i,labelRuleField
		dim m
		labelRule = "{cms668com:column([\s\S]*?)}([\s\S]*?){/cms668com:column}"
		labelRuleField = "\[column:([\s\S]+?)\]"
		regExpObj.Pattern = labelRule
		set matches = regExpObj.Execute(content)
		for each match in matches
			labelAttrColumn = match.SubMatches(0)
			loopstrColumn = match.SubMatches(1)
			vsort = parseAttr(labelAttrColumn)("sort")
			vseparateStr = parseAttr(labelAttrColumn)("separateStr")
			vstyle = parseAttr(labelAttrColumn)("style")
			vdir = parseAttr(labelAttrColumn)("dir")
			regExpObj.Pattern = labelRuleField
			set matchesfield = regExpObj.Execute(loopstrColumn)
			loopstrTotal = ""
			loopstrColumnNew = loopstrColumn
			for each matchfield in matchesfield
				fieldNameAndAttr = regExpReplace(matchfield.SubMatches(0),"[\s]+",chr(32))
				fieldNameAndAttr = trimOuter(fieldNameAndAttr)
				m = instr(fieldNameAndAttr,chr(32))
				if  m > 0 then 
					fieldName = left(fieldNameAndAttr,m - 1)
					fieldAttr =	right(fieldNameAndAttr,len(fieldNameAndAttr) - m)
				else
					fieldName = fieldNameAndAttr
					fieldAttr =	""
				end if
				select case fieldName
					case "info"
						loopstrColumnNew = replaceStr(loopstrColumnNew,matchfield.value,makeqtType(vsort,vseparateStr,vstyle,vdir))
				end select
			next
			loopstrTotal = loopstrTotal & loopstrColumnNew
			set matchesfield = nothing
			content = replaceStr(content,match.value,loopstrTotal)
			strDictionary.removeAll
		next
		set matches = nothing
	End Function
	
	Public Function parseIf()
		if not isExistStr(content,"{if:") then Exit Function
		dim matchIf,matchesIf,strIf,strThen,strThen1,strElse1,labelRule2,labelRule3
		dim ifFlag,elseIfArray,elseIfSubArray,elseIfArrayLen,resultStr,elseIfLen,strElseIf,strElseIfThen,elseIfFlag
		labelRule="{if:([\s\S]+?)}([\s\S]*?){end\s+if}":labelRule2="{elseif":labelRule3="{else}":elseIfFlag=false
		regExpObj.Pattern=labelRule
		set matchesIf=regExpObj.Execute(content)
		for each matchIf in matchesIf 
			strIf=matchIf.SubMatches(0):strThen=matchIf.SubMatches(1)
			if instr(strThen,labelRule2)>0 then
				elseIfArray=split(strThen,labelRule2):elseIfArrayLen=ubound(elseIfArray):elseIfSubArray=split(elseIfArray(elseIfArrayLen),labelRule3)
				resultStr=elseIfSubArray(1)
				Execute("if  "&strIf&" then resultStr=elseIfArray(0)")
				for elseIfLen=1 to elseIfArrayLen-1
					strElseIf=getSubStrByFromAndEnd(elseIfArray(elseIfLen),":","}","")
					strElseIfThen=getSubStrByFromAndEnd(elseIfArray(elseIfLen),"}","","start")
					Execute("if  "&strElseIf&" then resultStr=strElseIfThen")
					Execute("if  "&strElseIf&" then elseIfFlag=true else  elseIfFlag=false")
					if elseIfFlag then exit for
				next
				Execute("if  "&getSubStrByFromAndEnd(elseIfSubArray(0),":","}","")&" then resultStr=getSubStrByFromAndEnd(elseIfSubArray(0),""}"","""",""start""):elseIfFlag=true")
				content=replace(content,matchIf.value,resultStr)
			else 
				if instr(strThen,"{else}")>0 then 
					strThen1=split(strThen,labelRule3)(0)
					strElse1=split(strThen,labelRule3)(1)
					Execute("if  "&strIf&" then ifFlag=true else ifFlag=false")
					if ifFlag then content=replace(content,matchIf.value,strThen1) else content=replace(content,matchIf.value,strElse1)
				else
					Execute("if  "&strIf&" then ifFlag=true else ifFlag=false")
					if ifFlag then content=replace(content,matchIf.value,strThen) else content=replace(content,matchIf.value,"")
				end if
			end if
			elseIfFlag=false
		next
		set matchesIf=nothing
	End Function

End Class
%>