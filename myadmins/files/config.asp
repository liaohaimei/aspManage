<%
Const Root = "/upload"
Const AllowExt = "*.bmp;*.rar;*.jpg;*.gif;*.png;*.doc;*.zip;"
Const AllowFileSizeLimit = "20480000kb" '204800
Const NameReg = "[\\\/\:\*\?\""\>\<\|]+"
Dim rootpath
rootpath = Root
if instr(rootpath,":")<=0 then
	rootpath = server.MapPath(rootpath)
end if
rootpath = replace(rootpath,"/","\")
if right(rootpath,1)="\" then rootpath = left(rootpath,len(rootpath)-1)
%>