﻿<!--#include file="config.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/session.asp"-->
<%
response.Charset="utf-8"
if Mosession.get("username")="" then
	response.Write "{err:true,desc:'session_get_error_value_blank'}" 
	response.End()
end if
dim action
action = request.QueryString("action")
if instr("folder_load|folder_create|folder_delete|folder_rename|file_delete|file_rename",action)<=0 then
	response.Write "{err:true,desc:'action_error'}"
	response.End()
end if
dim fso,actpath
set fso = server.CreateObject("scripting.filesystemobject")
actpath = request.QueryString("path")
actpath = replace(actpath,"/","\")
if actpath="" then actpath="\"
actpath = clearFolderDot(actpath)
if left(actpath,1)<>"\" then actpath = "\" & actpath
actpath = rootpath & actpath
if right(actpath,1)="\" then actpath = left(actpath,len(actpath)-1)
if instr(actpath,"\..\")>0 or instr(actpath,"\.\")>0 then
	response.Write "{err:true,desc:'folder_create_error_name_format'}"
	response.End()
end if
Execute "Call " & action & "()"
set fso = nothing
sub folder_load
	if not fso.folderexists(actpath) then
		response.Write "{err:true,desc:'folder_load_error_exists_false',path:'" & replace(actpath,"\","\\") & "'}"
		exit sub	
	end if
	dim folder,ret,f,count
	count=0
	set folder = fso.getfolder(actpath)
	ret = "{err:false,filescount:" & folder.files.count & ",folderscount:" & folder.subfolders.count & ",list:["
	for each f in folder.subfolders
		ret = ret & "{isfolder:true,name:""" & f.name & """,create:""" & formatDateEx(f.DateCreated,"yyyy-mm-dd hh:nn:ss") & """,mod:""" & formatDateEx(f.DateLastModified,"yyyy-mm-dd hh:nn:ss") & """,size:" & f.size & ",filescount:" & f.files.count & ",folderscount:" & f.subfolders.count & "},"
		count = count + 1
	next
	for each f in folder.files
		ret = ret & "{isfolder:false,name:""" & f.name & """,create:""" & formatDateEx(f.DateCreated,"yyyy-mm-dd hh:nn:ss") & """,mod:""" & formatDateEx(f.DateLastModified,"yyyy-mm-dd hh:nn:ss") & """,size:" & f.size & "},"
		count = count + 1
	next
	if count>0 then ret = left(ret,len(ret)-1)
	ret = ret & "]}"
	response.Write ret
end sub

sub file_rename
	on error resume next
	err.clear
	dim newname,newpath,name,path
	newname = trim(request.QueryString("newname"))
	name = trim(request.QueryString("name"))
	if newname="" then
		response.Write "{err:true,desc:'file_rename_error_name_empty'}"
		exit sub	
	end if
	if RegTest(newname,NameReg) then
		response.Write "{err:true,desc:'file_rename_error_name_format'}"
		exit sub
	end if
	if name="" then
		response.Write "{err:true,desc:'file_rename_error_name_empty'}"
		exit sub	
	end if
	if RegTest(name,NameReg) then
		response.Write "{err:true,desc:'file_rename_error_name_format'}"
		exit sub
	end if
	newpath =actpath & "\" & newname
	path =actpath & "\" & name
	if not fso.fileexists(path) then
		response.Write "{err:true,desc:'file_rename_error_name_exists_false'}"
		exit sub
	end if
	if fso.fileexists(newpath) then
		response.Write "{err:true,desc:'file_rename_error_name_exists_true'}"
		exit sub
	end if
	fso.MoveFile path,newpath
	if not err then
		response.Write "{err:false}"
	else
		response.Write "{err:true,desc:'file_rename_error_system'}"
	end if
end sub

sub file_delete
	on error resume next
	err.clear
	if not fso.fileexists(actpath) then
		response.Write "{err:true,desc:'file_delete_error_exists_false'}"
		exit sub	
	end if
	fso.DeleteFile actpath
	if not err then
		response.Write "{err:false}"
	else
		response.Write "{err:true,desc:'folder_delete_error_system'}"
	end if
end sub

sub folder_create
	if actpath=rootpath then
		response.Write "{err:true,desc:'folder_create_error_root'}"
		exit sub
	end if
	if fso.folderexists(actpath) then
		response.Write "{err:true,desc:'folder_create_error_exists_true'}"
		exit sub	
	end if
	if instr(actpath,"..\")>0 or instr(actpath,".\")>0 then
		response.Write "{err:true,desc:'folder_create_error_name_format'}"
		exit sub	
	end if
	on error resume next
	err.clear
	fso.CreateFolder actpath
	if not err then
		if fso.folderexists(actpath)then
			response.Write "{err:false}"
		else
			response.Write "{err:true,desc:'folder_create_error_system'}"
		end if
	else
		response.Write "{err:true,desc:'folder_create_error_system'}"
	end if
end sub
sub folder_delete
	if actpath=rootpath then
		response.Write "{err:true,desc:'folder_delete_error_root'}"
		exit sub
	end if
	if not fso.folderexists(actpath) then
		response.Write "{err:true,desc:'folder_delete_error_exists_false'}"
		exit sub	
	end if
	on error resume next
	err.clear
	fso.DeleteFolder actpath
	if not err then
		response.Write "{err:false}"
	else
		response.Write "{err:true,desc:'folder_delete_error_system'}"
	end if
end sub
sub folder_rename
	if actpath=rootpath then
		response.Write "{err:true,desc:'folder_rename_error_root'}"
		exit sub
	end if
	if not fso.folderexists(actpath) then
		response.Write "{err:true,desc:'folder_rename_error_exists_false'}"
		exit sub	
	end if
	on error resume next
	err.clear
	dim newname,newpath
	newname = trim(request.QueryString("newname"))
	if newname="" then
		response.Write "{err:true,desc:'folder_rename_error_name_empty'}"
		exit sub	
	end if
	if RegTest(newname,NameReg) then
		response.Write "{err:true,desc:'folder_rename_error_name_format'}"
		exit sub
	end if
	newpath = replaceex(actpath,"^(.+)\\([^\\]+?)$","$1\" & newname)
	if newpath=actpath then
		response.Write "{err:true,desc:'folder_rename_error_name_same'}"
		exit sub
	end if
	if fso.folderexists(newpath) then
		response.Write "{err:true,desc:'folder_rename_error_exists_true'}"
		exit sub	
	end if
	fso.MoveFolder actpath,newpath
	if not err then
		response.Write "{err:false}"
	else
		response.Write "{err:true,desc:'folder_rename_error_system'}"
	end if
end sub
%>
