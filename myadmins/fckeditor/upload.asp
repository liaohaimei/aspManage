<!--#include file="../admin_inc.asp"-->
<%checkPower%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<body leftmargin="0" topmargin="0" bgcolor=#E9F5F5>
<style type="text/css">*{font-size:12px;}</style>
<%
Server.ScriptTimeOut=999999
dim up_formName,up_formPath,filename,up_file_name,up_fileExt,up_Filesize,up_F_Type,inputname
checkPower

select case request.QueryString("act")
	case "up" : call upload()
end select

'===========================无组件上传============================
sub upload()
	inputname = Request.QueryString("inputname")
	isthumbnail = Request.QueryString("isthumbnail")
	maxwidth = Cint(Request.QueryString("maxwidth"))
	maxheight = Cint(Request.QueryString("maxheight"))
	
	dim upload,file,ranNum,rename,filename1
	set upload=new UpFile_Class ''建立上传对象
	upload.GetDate (1000*102400)   '取得上传数据,不限大小
	if upload.err > 0 then
		select case upload.err
			case 1
				Response.Write "<table><tr><td bgcolor=#E9F5F5>请先选择你要上传的文件　[ <a href=# onclick=history.go(-1)>重新上传</a> ]</td></tr></table>"
			case 2
				Response.Write "<table><tr><td bgcolor=#E9F5F5>文件大小超过了限制　[ <a href=# onclick=history.go(-1)>重新上传</a> ]</td></tr></table>"
		end select
		exit sub
	else
		up_formPath="../../Upload/image/"'upload.form("filepath")
		for each up_formName in upload.file ''列出所有上传了的文件
			set file=upload.file(up_formName)  ''生成一个文件对象
			up_fileExt=lcase(file.up_fileExt)
			'判断文件类型
			if lcase(up_fileExt)="asp" and lcase(up_fileExt)="asa" and lcase(up_fileExt)="aspx" then
				CheckFileExt(up_fileExt)=false
			end if
			if CheckFileExt(up_fileExt)=false then
				response.write "<table><tr><td bgcolor=#E9F5F5>文件格式不正确　[ <a href=# onclick=history.go(-1)>重新上传</a> ]</td></tr></table>"
				response.end
			end if
			randomize
			ranNum=int(90000*rnd)+10000
			up_file_name=year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&ranNum
			filename=up_file_name&"."&up_fileExt
			rename=filename&"|"
			filename1=up_formPath&filename
			up_Filesize=file.up_Filesize
			'die filename1
			'记录文件
			if up_Filesize>0 then         '如果 up_Filesize > 0 说明有文件数据
				'die FileName1
				file.SaveToFile Server.mappath(FileName1)   ''执行上传文件
			
			if isthumbnail = "true" then
			
			Dim sOriginalPath
			sOriginalPath = "../../../upload/image/"&filename
			'原图片路径一般上传完毕后获取，或者从数据库获取
			Dim sReturnInfo, sSmallPath '函数返回信息, 缩略图路径
			sReturnInfo = BuildSmallPic(sOriginalPath, "../../../upload/image/small/", maxwidth , maxheight)
			If InStr(sReturnInfo, "Error_") <= 0 Then
				sSmallPath = sReturnInfo '返回信息就是 
				'将sSmallPath写入数据库
			Else
				Response.Write "详细错误:" 
				Select Case sReturnInfo
				Case "Error_01"
					Response.Write "<font color='red'>创建AspJpeg组件失败,没有正确安装注册该组件</font>" & "<br/>"
				Case "Error_02"
					Response.Write "<font color='red'>原图片不存在,检查s_OriginalPath参数传入值</font>" & "<br/>"
				Case "Error_03"    
					Response.Write "<font color='red'>缩略图存盘失败.可能原因:缩略图保存基地址不存在,检查s_OriginalPath参数传入值;对目录没有写权限;磁盘空间不足</font>" & "<br/>"
				Case "Error_Other"
					Response.Write "<font color='red'>未知错误</font>" & "<br/>"
				End Select
				Response.End
			End If
			
			end if
			
			call checksave(inputname)
			response.write "<table><tr><td bgcolor=#E9F5F5><font color=red >"&filename&"上传成功![ <a href=# onclick=history.go(-1)>重新上传</a> ]</font></td></tr></table>"
				'call checksave(inputname)	
				'on error resume next
				'if waterMark=1 and isInstallObj(JPEG_OBJ_NAME) then  writeFontWaterPrint filename1,waterMarkLocation
				'if err  then 
					'response.Write  "<table><tr><td bgcolor=#E9F5F5>"&"<font color=red >图片上传成功,加水印失败,是否支持?</font></td></tr></table>" : err.clear           
				'else
					 'response.write "<table><tr><td bgcolor=#E9F5F5><font color=red >"&filename&"上传成功![ <a href=# onclick=history.go(-1)>重新上传</a> ]</font></td></tr></table>"
				'end if
			end if
			set file=nothing
		next
	end if
	set upload=nothing
end sub

'判断文件类型是否合格
Private Function CheckFileExt (up_fileExt)
	dim Forumupload,i
	Forumupload=split("jpg|gif|png|bmp","|")
	for i=0 to ubound(Forumupload)
		if lcase(up_fileExt)=lcase(trim(Forumupload(i))) then
			CheckFileExt=true
			exit Function
		else
			CheckFileExt=false
		end if
	next
End Function

Private sub checksave(inputname)
	'插入上传表并获得ID
	'response.write <script>parent.editform.m_pic.value=images/uploadimg/&filename&<script>"
	response.write "<script>parent.document.getElementById("""& inputname &""").value='upload/image/"&filename&"'</script>"
end Sub


Dim oUpFileStream

Class UpFile_Class

Dim Form,File,Version,Err 

Private Sub Class_Initialize
 Version = "上传类 Version V1.0"
 Err = -1
End Sub

Private Sub Class_Terminate  
  '清除变量及对像
  If Err < 0 Then
    Form.RemoveAll
    Set Form = Nothing
    File.RemoveAll
    Set File = Nothing
    oUpFileStream.Close
    Set oUpFileStream = Nothing
  End If
End Sub
   
Public Sub GetDate (RetSize)
   '定义变量
  Dim RequestBinDate,sSpace,bCrLf,sInfo,iInfoStart,iInfoEnd,tStream,iStart,oFileInfo
  Dim iFileSize,sFilePath,sFileType,sFormValue,sFileName
  Dim iFindStart,iFindEnd
  Dim iFormStart,iFormEnd,sFormName
  Dim s
   '代码开始
  If Request.TotalBytes < 1 Then
    Err = 1
    Exit Sub
  End If
  If RetSize > 0 Then 
    If Request.TotalBytes > RetSize Then
    Err = 2
    Exit Sub
    End If
  End If
  Set Form = Server.CreateObject ("Scripting.Dictionary")
  Form.CompareMode = 1
  Set File = Server.CreateObject ("Scripting.Dictionary")
  File.CompareMode = 1
  s="stream"
  Set tStream = Server.CreateObject ("ADODB."&s)
  Set oUpFileStream = Server.CreateObject ("ADODB."&s)
  oUpFileStream.Type = 1
  oUpFileStream.Mode = 3
  oUpFileStream.Open 
  oUpFileStream.Write Request.BinaryRead(Request.TotalBytes)
  oUpFileStream.Position = 0
  RequestBinDate = oUpFileStream.Read 
  iFormEnd = oUpFileStream.Size
  bCrLf = ChrB (13) & ChrB (10)
  '取得每个项目之间的分隔符
  sSpace = MidB (RequestBinDate,1, InStrB (1,RequestBinDate,bCrLf)-1)
  iStart = LenB  (sSpace)
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
    tStream.CharSet = "utf-8"
    sInfo = tStream.ReadText      
    '取得表单项目名称
    iFormStart = InStrB (iInfoEnd,RequestBinDate,sSpace)-1
    iFindStart = InStr (22,sInfo,"name=""",1)+6
    iFindEnd = InStr (iFindStart,sInfo,"""",1)
    sFormName = Mid  (sinfo,iFindStart,iFindEnd-iFindStart)
    '如果是文件
    If InStr  (45,sInfo,"filename=""",1) > 0 Then
      Set oFileInfo = new FileInfo_Class
      '取得文件属性
      iFindStart = InStr (iFindEnd,sInfo,"filename=""",1)+10
      iFindEnd = InStr (iFindStart,sInfo,"""",1)
      sFileName = Mid  (sinfo,iFindStart,iFindEnd-iFindStart)
      oFileInfo.filename = Mid (sFileName,InStrRev (sFileName, "\")+1)
      oFileInfo.FilePath = Left (sFileName,InStrRev (sFileName, "\")+1)
      oFileInfo.up_fileExt = Mid (sFileName,InStrRev (sFileName, ".")+1)
      iFindStart = InStr (iFindEnd,sInfo,"Content-Type: ",1)+14
      iFindEnd = InStr (iFindStart,sInfo,vbCr)
      oFileInfo.FileType = Mid  (sinfo,iFindStart,iFindEnd-iFindStart)
      oFileInfo.FileStart = iInfoEnd
      oFileInfo.up_Filesize = iFormStart -iInfoEnd -2
      oFileInfo.up_formName = sFormName
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
      tStream.CharSet = "utf-8"
      sFormValue = tStream.ReadText
      If Form.Exists (sFormName) Then
        Form (sFormName) = Form (sFormName) & ", " & sFormValue
        else
        form.Add sFormName,sFormValue
      End If
    End If
    tStream.Close
    iFormStart = iFormStart+iStart+2
    '如果到文件尾了就退出
  Loop Until  (iFormStart+2) = iFormEnd 
  RequestBinDate = ""
  Set tStream = Nothing
End Sub
End Class

'文件属性类
Class FileInfo_Class
Dim up_formName,filename,FilePath,up_Filesize,FileType,FileStart,up_fileExt
'保存文件方法
Public Function SaveToFile (Path)
  'On Error Resume Next
  Dim oFileStream,s
  s="stream"
  Set oFileStream = CreateObject ("ADODB."&s)
  oFileStream.Type = 1
  oFileStream.Mode = 3
  oFileStream.Open
  oUpFileStream.Position = FileStart
  oUpFileStream.CopyTo oFileStream,up_Filesize
  oFileStream.SaveToFile Path,2
  oFileStream.Close
  Set oFileStream = Nothing 
End Function
 
'取得文件数据
Public Function FileDate
  oUpFileStream.Position = FileStart
  FileDate = oUpFileStream.Read (up_Filesize)
  End Function
End Class

'================================================================
'Author：laifangsong QQ:25313644
'功能：按照指定图片生成缩略图
'注意：以下提到的“路径”都是值相对于调用本函数的文件的相对路径
'参数：
'    s_OriginalPath:        原图片路径 例:images/image1.gif
'    s_BuildBasePath:    生成图片的基路径,不论是否以“/”结尾均可 例:images或images/
'    n_MaxWidth:            生成图片最大宽度
'                        如果在前台显示的缩略图是 100*100,这里 n_MaxWidth=100,n_MaxHeight=100.
'    n_MaxHeight:        生成图片最大高度
'返回值：
'    返回生成后的缩略图的路径
'错误处理：
'    如果函数执行过程中出现错误,将返回错误代码,错误代码以 “Error”开头
'        Error_01:创建AspJpeg组件失败,没有正确安装注册该组件
'        Error_02:原图片不存在,检查s_OriginalPath参数传入值
'        Error_03:缩略图存盘失败.可能原因:缩略图保存基地址不存在,检查s_OriginalPath参数传入值;对目录没有写权限;磁盘空间不足
'        Error_Other:未知错误
'调用例子:
'    Dim sSmallPath '缩略图路径
'    sSmallPath = BuildSmallPic("images/image1.gif", "images", 100, 100)    
'================================================================
Function BuildSmallPic(s_OriginalPath, s_BuildBasePath, n_MaxWidth, n_MaxHeight)
    Err.Clear
    On Error Resume Next
    
    '检查组件是否已经注册
    Dim AspJpeg
    Set AspJpeg = Server.Createobject("Persits.Jpeg")
    If Err.Number <> 0 Then
        Err.Clear
        BuildSmallPic = "Error_01"
        Exit Function
    End If
    '检查原图片是否存在
    Dim s_MapOriginalPath
    s_MapOriginalPath = Server.MapPath(s_OriginalPath)
	'die Server.MapPath(s_OriginalPath)
    AspJpeg.Open s_MapOriginalPath '打开原图片
    If Err.Number <> 0 Then
        Err.Clear
        BuildSmallPic = "Error_02"
        Exit Function
    End If
    '按比例取得缩略图宽度和高度
    Dim n_OriginalWidth, n_OriginalHeight '原图片宽度、高度
    Dim n_BuildWidth, n_BuildHeight '缩略图宽度、高度
    Dim div1, div2
    Dim n1, n2
    n_OriginalWidth = AspJpeg.Width
    n_OriginalHeight = AspJpeg.Height
    div1 = n_OriginalWidth / n_OriginalHeight
    div2 = n_OriginalHeight / n_OriginalWidth
    n1 = 0
    n2 = 0
    If n_OriginalWidth > n_MaxWidth Then
        n1 = n_OriginalWidth / n_MaxWidth
    Else
        n_BuildWidth = n_OriginalWidth
    End If
    If n_OriginalHeight > n_MaxHeight Then
        n2 = n_OriginalHeight / n_MaxHeight
    Else
        n_BuildHeight = n_OriginalHeight
    End If
    If n1 <> 0 Or n2 <> 0 Then
        If n1 > n2 Then
            n_BuildWidth = n_MaxWidth
            n_BuildHeight = n_MaxWidth * div2
        Else
            n_BuildWidth = n_MaxHeight * div1
            n_BuildHeight = n_MaxHeight
        End If
    End If
    '指定宽度和高度生成
    AspJpeg.Width = n_BuildWidth
    AspJpeg.Height = n_BuildHeight
    
    '--将缩略图存盘开始--
    Dim pos, s_OriginalFileName, s_OriginalFileExt '位置、原文件名、原文件扩展名
    pos = InStrRev(s_OriginalPath, "/") + 1
    s_OriginalFileName = Mid(s_OriginalPath, pos)
    pos = InStrRev(s_OriginalFileName, ".")
    s_OriginalFileExt = Mid(s_OriginalFileName, pos)
    Dim s_MapBuildBasePath, s_MapBuildPath, s_BuildFileName '缩略图绝对路径、缩略图文件名
    Dim s_EndFlag '小图片文件名结尾标识 例: 如果大图片文件名是“image1.gif”,结尾标识是“_small”,那么小图片文件名就是“image1_small.gif”
    If Right(s_BuildBasePath, 1) <> "/" Then s_BuildBasePath = s_BuildBasePath & "/"
    s_MapBuildBasePath = Server.MapPath(s_BuildBasePath)
    s_EndFlag = "" '可以自定义,只要能区别大小图片即可
    s_BuildFileName = Replace(s_OriginalFileName, s_OriginalFileExt, "") & s_EndFlag & s_OriginalFileExt
    s_MapBuildPath = s_MapBuildBasePath & "\" & s_BuildFileName
    
    AspJpeg.Save s_MapBuildPath '保存
    If Err.Number <> 0 Then
        Err.Clear
        BuildSmallPic = "Error_03"
        Exit Function
    End If
    '--将缩略图存盘结束--
    '注销实例
    Set AspJpeg = Nothing
    If Err.Number <> 0 Then
        BuildSmallPic = "Error_Other"
        Err.Clear
    End If
    BuildSmallPic = s_BuildBasePath & s_BuildFileName
End Function
%>
