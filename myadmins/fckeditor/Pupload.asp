<!--#include file="../admin_inc.asp"-->
<!--#include file="jpeg.asp"-->
<%checkPower%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>文件上传</title>
<style type="text/css">
td,div,input,select,textarea,body {font-family:Verdana, 宋体, fantasy;font-size:12px;}
body {margin:0 3px;padding:0;background-color:transparent;}
form {margin:0;padding:0;}
</style>
 
</head>
<body><%

dim action,sortType,saveFilePath,stype
action = Request("action")
stype = Request("stype")

Dim Tobj : Tobj =Request("Tobj")

if action="save" then 
	response.write uploadfile()
else
%>
<form name="form" enctype="multipart/form-data" action="?action=save&stype=<%=stype%>&Tobj=<%=Tobj%>"  method="post">
<input type="file" style=" width:260px;" class="input" name="filedata"/>
<input type="submit"class="button"  name="submit" value="上传" >
</form>
<%
end if
%>

</body>
</html>
<%
function uploadfile()
	dim immediate,attachdir,dirtype,maxattachsize,upext,saveFilePath,fType,filejpeg

	immediate=Request.QueryString("immediate")
	'die attachdir
	'createFolder attachdir,"folderdir"
	'==========================================================
	'此次需要修改
	'==========================================================
	saveFilePath = "/"&sitePath&"upLoad" & saveFilePath
	filejpeg = "/"&sitePath&"upLoad/image/small/"  '缩略图路径
	attachdir="/"&sitePath&"upload/image"'上传文件保存路径，结尾不要带/
	dirtype=2'1:按天存入目录 2:按月存入目录 3:按扩展名存目录  建议使用按天存
	maxattachsize=20971520'最大上传大小，默认是2M
	upext="txt,rar,zip,jpg,jpeg,gif,png,swf,wmv,avi,wma,mp3,pdf"'上传扩展名txt,rar,zip,jpg,jpeg,gif,png,swf,wmv,avi,wma,mp3,mid

	server.ScriptTimeout=600
	
	dim err,msg,upfile
	err = ""
	msg = ""
	
	set upfile=new upfile_class
	upfile.AllowExt=replace(upext,",",";")+";"
	upfile.GetData(maxattachsize)
	
	if upfile.isErr then
		select case upfile.isErr
		case 1
			err="无数据提交"
		case 2		
			err="文件大小超过 "+cstr(maxattachsize)+"字节"
		case else
			err=upfile.ErrMessage
		end select
		alertMsgAndGo err,"-1"
	else
		dim attach_dir,attach_subdir,filename,extension,target,tmpfile,formName,oFile,fsize,targets
		for each formName in upfile.file '列出所有上传了的文件
			set oFile=upfile.file(formname)
			extension=oFile.FileExt
			fType=extension
			select case dirtype
				case 1
					attach_subdir="day_"+DateFormat(now,"yymmdd")
				case 2
					attach_subdir="month_"+DateFormat(now,"yymm")
				case 3
					attach_subdir="ext_"+extension
			end select
			attach_dir=attachdir+"/"'+attach_subdir+"/"
			
			'建文件夹
			'attach_dir,"folderdir"
			tmpfile=upfile.AutoSave(formName,Server.mappath(attach_dir)+"\")
			
			if upfile.isErr then
				if upfile.isErr=3 then
					err="上传文件扩展名必需为："+upext
				else
					err=upfile.ErrMessage
				end if
				
				alertMsgAndGo err,"-1"
			else
				'生成随机文件名并改名
				Randomize timer
				filename=DateFormat(now,"yyyymmddhhnnss")+cstr(cint(9999*Rnd))+"."+extension
				target=attach_dir+filename 
				moveFile attach_dir+tmpfile,target
				if waterMark=1 then waterMarkImg target,waterMarkLocation
				msg=target
				
				 'aspjpeg组件生成缩略图
		 			call getThumbnail(msg,filejpeg&filename,175,158)
					
				if immediate="1" then msg="!"+msg
			end if
			fsize=oFile.filesize
			set oFile=nothing
%>
<input type="text" name="file1" size="70" style="width:300px;" class="input" value="<%="upload/image/"&filename%>"> <input type="button" onClick="javascript:history.go(-1)" value="继续上传" class="button"><br>
<font color="blue">恭喜你！文件上传成功。<a href="<%=Request.ServerVariables("HTTP_REFERER")%>">点击此处继续上传</a></font>

<%			

if stype="image"  then
	dim inEditorStr
	Select Case fType
		Case "gif","jpg","png","bmp","jpeg","tif","iff"	
			if stype="sort" then inEditorStr="oEditor.InsertHtml(""<img src=""+""'""+ContentStr+""'""+""/>"");" & vbCrLf
			'inEditorStr="oEditor.InsertHtml(""<img src=""+""'""+ContentStr+""'""+""/>"");" & vbCrLf
%>

<script type="text/javascript">

// 文件上传成功接口操作
function doInterfaceUpload(strValue){
	if (strValue=="") return;
	var objLinkUpload = parent.document.getElementsByName("m_pic")[0];
	if (objLinkUpload){
		if (objLinkUpload.value!=""){
			objLinkUpload.value = objLinkUpload.value + "|";
		}
		objLinkUpload.value = objLinkUpload.value + strValue;
//		objLinkUpload.fireEvent("onchange");
	}
}
doInterfaceUpload('<%="upload/image/"&filename%>');
divMsg('<%="upload/image/"&filename%>');
doChange(parent.document.getElementById("m_pic"),parent.document.getElementById("ImageFileList"))

function doChange(objText, objDrop){
if (!objDrop) return;
var str = objText.value;
var arr = str.split("|");
var nIndex = objDrop.selectedIndex;
objDrop.length=1;
for (var i=0; i<arr.length; i++){
objDrop.options[objDrop.length] = new Option(arr[i], arr[i]);
}
objDrop.selectedIndex = nIndex;
}
</script>
<script type="text/javascript">
function divMsg(t){

  //alert(parent.document.getElementById("pw").innerHTML);
  var pstr=parent.document.getElementById("pw").innerHTML; 
   
  var imgvalue=parent.document.getElementById("m_pic").value;
	
  if(t.indexOf("err:")==-1)
  {
  	var ids=t
	ids=ids.substr(ids.lastIndexOf("/")+1,ids.lastIndexOf("."))
	 //ids=ids.replace(".","") 
  	 var itml = pstr + '<div class="imgDiv" id="'+ids+'"><img src="../upload/image/small/'+ ids + '" border="0" /><br> <a href="javascript:dropThisDiv(\''+ids+'\',\''+t+'\')">删除</a></div> ';
	 imgvalue=imgvalue+t+'|';
  }
  else
 {
 	 var itml = pstr + '<div class="imgDiv" id="'+t+'">"'+t+'"<br/>图片上传失败</div> ';
 } 
//parent.document.getElementById("m_pic").value=t;
 parent.document.getElementById("pw").innerHTML=itml;

}
divMsg('<%="upload/image/"&filename%>')
</script>
<%	

	case else 
	Response.Write"<script>alert('图片格式错误，请重新上传');history.go(-1);</script>"

		
	End Select
	 
elseif stype="file" then
Select Case fType
		Case "txt","rar","zip","pdf","doc","docs"
	Response.Write  "<script language=""javascript"">parent.document.getElementById('m_url').value='"&target&"'</script>" 				
	'Response.Write  "<script language=""javascript"">parent.document.getElementById('m_size').value='"&maxattachsize&"'<script>" 								
	'echo "<table><tr><td bgcolor=#FFFFFF style=""font-size:12px;""><font color=red>"&filename&"上传成功![ <span  onclick=history.go(-1)>重新上传</span> ]</font></td></tr></table>"	
	
case else 
	Response.Write"<script>alert('文件格式错误，请重新上传');history.go(-1);</script>"

		
	End Select
end if
		next
	end if
	set upfile=nothing
end function

function jsonString(str)
	str=replace(str,"\","\\")
	str=replace(str,"/","\/")
	str=replace(str,"'","\'")
	jsonString=str
end function

Function Iif(expression,returntrue,returnfalse)
	If expression=true Then
		iif=returntrue
	Else
		iif=returnfalse
	End If
End Function

function DateFormat(strDate,fstr)
	if isdate(strDate) then
		dim i,temp
		temp=replace(fstr,"yyyy",DatePart("yyyy",strDate))
		temp=replace(temp,"yy",mid(DatePart("yyyy",strDate),3))
		temp=replace(temp,"y",DatePart("y",strDate))
		temp=replace(temp,"w",DatePart("w",strDate))
		temp=replace(temp,"ww",DatePart("ww",strDate))
		temp=replace(temp,"q",DatePart("q",strDate))
		temp=replace(temp,"mm",iif(len(DatePart("m",strDate))>1,DatePart("m",strDate),"0"&DatePart("m",strDate)))
		temp=replace(temp,"dd",iif(len(DatePart("d",strDate))>1,DatePart("d",strDate),"0"&DatePart("d",strDate)))
		temp=replace(temp,"hh",iif(len(DatePart("h",strDate))>1,DatePart("h",strDate),"0"&DatePart("h",strDate)))
		temp=replace(temp,"nn",iif(len(DatePart("n",strDate))>1,DatePart("n",strDate),"0"&DatePart("n",strDate)))
		temp=replace(temp,"ss",iif(len(DatePart("s",strDate))>1,DatePart("s",strDate),"0"&DatePart("s",strDate)))
		DateFormat=temp
	else
		DateFormat=false
	end if
end function

 
Function moveFile(oldfile,newfile)
	dim fs
 Set fs=Server.CreateObject("Scri"&"pting.File"&"Sys"&"temObject")
 fs.movefile Server.MapPath(oldfile),Server.MapPath(newfile)
 Set fs=Nothing
End Function
 
'----------------------------------------------------------------------
'文件上传类
Class UpFile_Class

Dim Form,File
Dim AllowExt_
Dim NoAllowExt_
Dim IsDebug_
Private	oUpFileStream
Private isErr_
Private ErrMessage_
Private isGetData_

'------------------------------------------------------------------
'类的属性
Public Property Get Version
	Version="无惧上传类 Version V2.0"
End Property

Public Property Get isErr
	isErr=isErr_
End Property

Public Property Get ErrMessage
	ErrMessage=ErrMessage_
End Property

Public Property Get AllowExt
	AllowExt=AllowExt_
End Property

Public Property Let AllowExt(Value)
	AllowExt_=LCase(Value)
End Property

Public Property Get NoAllowExt
	NoAllowExt=NoAllowExt_
End Property

Public Property Let NoAllowExt(Value)
	NoAllowExt_=LCase(Value)
End Property

Public Property Let IsDebug(Value)
	IsDebug_=Value
End Property


'----------------------------------------------------------------
'类实现代码

'初始化类
Private Sub Class_Initialize
	isErr_ = 0
	NoAllowExt="asp;asa;cer;aspx;php;"
	NoAllowExt=LCase(NoAllowExt)
	AllowExt=""
	AllowExt=LCase(AllowExt)
	isGetData_=false
End Sub

'类结束
Private Sub Class_Terminate	
	on error Resume Next
	'清除变量及对像
	Form.RemoveAll
	Set Form = Nothing
	File.RemoveAll
	Set File = Nothing
	oUpFileStream.Close
	Set oUpFileStream = Nothing
	if Err.number<>0 then OutErr("清除类时发生错误!")
End Sub

'分析上传的数据
Public Sub GetData (MaxSize)
	 '定义变量
	on error Resume Next
	if isGetData_=false then 
		Dim RequestBinDate,sSpace,bCrLf,sInfo,iInfoStart,iInfoEnd,tStream,iStart,oFileInfo
		Dim sFormValue,sFileName
		Dim iFindStart,iFindEnd
		Dim iFormStart,iFormEnd,sFormName
		'代码开始
		If Request.TotalBytes < 1 Then	'如果没有数据上传
			isErr_ = 1
			ErrMessage_="没有数据上传,这是因为直接提交网址所产生的错误!"
			OutErr("没有数据上传,这是因为直接提交网址所产生的错误!!")
			Exit Sub
		End If
		If MaxSize > 0 Then '如果限制大小
			If Request.TotalBytes > MaxSize Then
			isErr_ = 2	'如果上传的数据超出限制大小
			ErrMessage_="上传的数据超出限制大小!"
			OutErr("上传的数据超出限制大小!")
			Exit Sub
			End If
		End If
		Set Form = Server.CreateObject ("Scripting.Dictionary")
		Form.CompareMode = 1
		Set File = Server.CreateObject ("Scripting.Dictionary")
		File.CompareMode = 1
		Set tStream = Server.CreateObject ("ADODB.Stream")
		Set oUpFileStream = Server.CreateObject ("ADODB.Stream")
		if Err.number<>0 then OutErr("创建流对象(ADODB.STREAM)时出错,可能系统不支持或没有开通该组件")
		oUpFileStream.Type = 1
		oUpFileStream.Mode = 3
		oUpFileStream.Open 
		oUpFileStream.Write Request.BinaryRead (Request.TotalBytes)
		oUpFileStream.Position = 0
		RequestBinDate = oUpFileStream.Read 
		iFormEnd = oUpFileStream.Size
		bCrLf = ChrB (13) & ChrB (10)
		'取得每个项目之间的分隔符
		sSpace = MidB (RequestBinDate,1, InStrB (1,RequestBinDate,bCrLf)-1)
		iStart = LenB(sSpace)
		iFormStart = iStart+2
		'分解项目
		Do
			iInfoEnd = InStrB (iFormStart,RequestBinDate,bCrLf & bCrLf)+3
			tStream.Type = 1
			tStream.Mode = 3
			tStream.Open
			oUpFileStream.Position = iFormStart
			oUpFileStream.CopyTo tStream,iInfoEnd-iFormStart
			tStream.Position = 0
			tStream.Type = 2
			tStream.CharSet = "gb2312"
			sInfo = tStream.ReadText			
			'取得表单项目名称
			iFormStart = InStrB (iInfoEnd,RequestBinDate,sSpace)-1
			iFindStart = InStr (22,sInfo,"name=""",1)+6
			iFindEnd = InStr (iFindStart,sInfo,"""",1)
			sFormName = Mid(sinfo,iFindStart,iFindEnd-iFindStart)
			'如果是文件
			If InStr (45,sInfo,"filename=""",1) > 0 Then
				Set oFileInfo = new FileInfo_Class
				'取得文件属性
				iFindStart = InStr (iFindEnd,sInfo,"filename=""",1)+10
				iFindEnd = InStr (iFindStart,sInfo,""""&vbCrLf,1)
				sFileName = Trim(Mid(sinfo,iFindStart,iFindEnd-iFindStart))
				oFileInfo.FileName = GetFileName(sFileName)
				oFileInfo.FilePath = GetFilePath(sFileName)
				oFileInfo.FileExt = GetFileExt(sFileName)
				iFindStart = InStr (iFindEnd,sInfo,"Content-Type: ",1)+14
				iFindEnd = InStr (iFindStart,sInfo,vbCr)
				oFileInfo.FileMIME = Mid(sinfo,iFindStart,iFindEnd-iFindStart)
				oFileInfo.FileStart = iInfoEnd
				oFileInfo.FileSize = iFormStart -iInfoEnd -2
				oFileInfo.FormName = sFormName
				file.add sFormName,oFileInfo
			else
			'如果是表单项目
				tStream.Close
				tStream.Type = 1
				tStream.Mode = 3
				tStream.Open
				oUpFileStream.Position = iInfoEnd 
				oUpFileStream.CopyTo tStream,iFormStart-iInfoEnd-2
				tStream.Position = 0
				tStream.Type = 2
				tStream.CharSet = "gb2312"
				sFormValue = tStream.ReadText
				If Form.Exists (sFormName) Then
					Form (sFormName) = Form (sFormName) & ", " & sFormValue
					else
					Form.Add sFormName,sFormValue
				End If
			End If
			tStream.Close
			iFormStart = iFormStart+iStart+2
			'如果到文件尾了就退出
		Loop Until (iFormStart+2) >= iFormEnd 
		if Err.number<>0 then OutErr("分解上传数据时发生错误,可能客户端的上传数据不正确或不符合上传数据规则")
		RequestBinDate = ""
		Set tStream = Nothing
		isGetData_=true
	end if
End Sub

'保存到文件,自动覆盖已存在的同名文件
Public Function SaveToFile(Item,Path)
	SaveToFile=SaveToFileEx(Item,Path,True)
End Function

'保存到文件,自动设置文件名
Public Function AutoSave(Item,Path)
	AutoSave=SaveToFileEx(Item,Path,false)
End Function

'保存到文件,OVER为真时,自动覆盖已存在的同名文件,否则自动把文件改名保存
Private Function SaveToFileEx(Item,Path,Over)
	On Error Resume Next
	Dim FileExt
	if file.Exists(Item) then
		Dim oFileStream
		Dim tmpPath
		isErr_=0
		Set oFileStream = CreateObject ("ADODB.Stream")
		oFileStream.Type = 1
		oFileStream.Mode = 3
		oFileStream.CharSet = "gb2312"
		oFileStream.Open
		oUpFileStream.Position = File(Item).FileStart
		oUpFileStream.CopyTo oFileStream,File(Item).FileSize
		tmpPath=Split(Path,".")(0)
		FileExt=GetFileExt(Path)
		if Over then
			if isAllowExt(FileExt) then
				oFileStream.SaveToFile tmpPath & "." & FileExt,2
				if Err.number<>0 then OutErr("保存文件时出错,请检查路径,是否存在该上传目录!该文件保存路径为" & tmpPath & "." & FileExt)
			Else
				isErr_=3
				ErrMessage_="该后缀名的文件不允许上传!"
				OutErr("该后缀名的文件不允许上传")
			End if
		Else
			Path=GetFilePath(Path)
			dim fori
			fori=1
			if isAllowExt(File(Item).FileExt) then
				do
					fori=fori+1
					Err.Clear()
					tmpPath=Path&GetNewFileName()&"."&File(Item).FileExt
					oFileStream.SaveToFile tmpPath
				loop Until ((Err.number=0) or (fori>50))
				if Err.number<>0 then OutErr("自动保存文件出错,已经测试50次不同的文件名来保存,请检查目录是否存在!该文件最后一次保存时全路径为"&Path&GetNewFileName()&"."&File(Item).FileExt)
			Else
				isErr_=3
				ErrMessage_="该后缀名的文件不允许上传!"
				OutErr("该后缀名的文件不允许上传")
			End if
		End if
		oFileStream.Close
		Set oFileStream = Nothing
	else
		ErrMessage_="不存在该对象(如该文件没有上传,文件为空)!"
		OutErr("不存在该对象(如该文件没有上传,文件为空)")
	end if
	if isErr_=3 then SaveToFileEx="" else SaveToFileEx=GetFileName(tmpPath)
End Function

'取得文件数据
Public Function FileData(Item)
	isErr_=0
	if file.Exists(Item) then
		if isAllowExt(File(Item).FileExt) then
			oUpFileStream.Position = File(Item).FileStart
			FileData = oUpFileStream.Read (File(Item).FileSize)
			Else
			isErr_=3
			ErrMessage_="该后缀名的文件不允许上传"
			OutErr("该后缀名的文件不允许上传")
			FileData=""
		End if
	else
		ErrMessage_="不存在该对象(如该文件没有上传,文件为空)!"
		OutErr("不存在该对象(如该文件没有上传,文件为空)")
	end if
End Function


'取得文件路径
Public function GetFilePath(FullPath)
  If FullPath <> "" Then
    GetFilePath = Left(FullPath,InStrRev(FullPath, "\"))
    Else
    GetFilePath = ""
  End If
End function

'取得文件名
Public Function GetFileName(FullPath)
  If FullPath <> "" Then
    GetFileName = mid(FullPath,InStrRev(FullPath, "\")+1)
    Else
    GetFileName = ""
  End If
End function

'取得文件的后缀名
Public Function GetFileExt(FullPath)
  If FullPath <> "" Then
    GetFileExt = LCase(Mid(FullPath,InStrRev(FullPath, ".")+1))
    Else
    GetFileExt = ""
  End If
End function

'取得一个不重复的序号
Public Function GetNewFileName()
	dim ranNum
	dim dtNow
	dtNow=Now()
	randomize
	ranNum=int(90000*rnd)+10000
	'以下这段由webboy提供
	GetNewFileName=year(dtNow) & right("0" & month(dtNow),2) & right("0" & day(dtNow),2) & right("0" & hour(dtNow),2) & right("0" & minute(dtNow),2) & right("0" & second(dtNow),2) & ranNum
End Function

Public Function isAllowExt(Ext)
	if NoAllowExt="" then
		isAllowExt=cbool(InStr(1,";"&AllowExt&";",LCase(";"&Ext&";")))
	else
		isAllowExt=not CBool(InStr(1,";"&NoAllowExt&";",LCase(";"&Ext&";")))
	end if
End Function
End Class

Public Sub OutErr(ErrMsg)
if IsDebug_=true then
	Response.Write ErrMsg
	Response.End
	End if
End Sub

'----------------------------------------------------------------------------------------------------
'文件属性类
Class FileInfo_Class
Dim FormName,FileName,FilePath,FileSize,FileMIME,FileStart,FileExt
End Class
%>