﻿<!--#include file="config.asp"-->
<!--#include file="inc/upload_class.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/session.asp"-->
<%
if Mosession.get("username")="" then
	response.Write "{err:true,msg:'请登录后再上传文件'}" 
	response.End()
end if
Dim Upload,path,tempCls,e
set Upload=new AnUpLoad	
Upload.SingleSize=AllowFileSizeLimit
Upload.MaxSize=AllowFileSizeLimit
Upload.Exe=AllowExt 
Upload.Charset="utf-8"
Upload.GetData() 
if Upload.ErrorID>0 then
	response.Write("{err:true,msg:'" & Upload.description & "'}")
else
	path=rootpath
	subpath = request.QueryString("path")
	if RegTest(replace(subpath,"/",""),NameReg) then
		response.Write "{err:true,msg:'file_upload_error_name_format'}"
	else
		subpath = replace(subpath,"/","\")
		path = path & "\" & subpath
		path = replaceex(path,"([\\]{2,})","\")
		set tempCls=Upload.files("filedata") 
		if tempCls.isfile then
			if tempCls.SaveToFile(path,1,false) then
				response.Write("{err:false,msg:'upload',name:'" & tempCls.filename & "',src:'" & tempCls.LocalName & "'}")
			else
				response.Write("{err:true,msg:'" & tempCls.Exception & "'}")
			end if
		else
			response.Write("{err:true,msg:'文件表单丢失'}")
		end if
		set tempCls=nothing
	end if
end if
set Upload=nothing
%>
