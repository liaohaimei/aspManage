﻿<!--#include file="../admin_inc.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<body leftmargin="0" topmargin="0" bgcolor=#E9F5F5>
<style type="text/css">*{font-size:12px;}</style>
<%
Server.ScriptTimeOut=999999
dim up_formName,up_formPath,filename,up_file_name,up_fileExt,up_Filesize,up_F_Type,inputname

select case request.QueryString("act")
	case "up" : call upload()
end select

'===========================无组件上传============================
sub upload()
	inputname = Request.QueryString("inputname")
	
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
		up_formPath="../../Upload/file/"'upload.form("filepath")
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
				call checksave(inputname)	
				'on error resume next
				'if waterMark=1 and isInstallObj(JPEG_OBJ_NAME) then  writeFontWaterPrint filename1,waterMarkLocation
				'if err  then 
					'response.Write  "<table><tr><td bgcolor=#E9F5F5>"&"<font color=red >图片上传成功,加水印失败,是否支持?</font></td></tr></table>" : err.clear           
				'else
					 response.write "<table><tr><td bgcolor=#E9F5F5><font color=red >"&filename&"上传成功![ <a href=# onclick=history.go(-1)>重新上传</a> ]</font></td></tr></table>"
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
	Forumupload=split("jpg|gif|png|bmp|rar|doc|xls|pdf","|")
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
	response.write "<script>parent.document.getElementById("""& inputname &""").value='Upload/file/"&filename&"'</script>"
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

%>
