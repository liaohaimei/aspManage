﻿<%
dim conn,db
dim connstr
db="Data/#WebAdminDB.mdb" '数据库文件位置
on error resume next
'connstr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & Server.MapPath(Artmdb)
connstr="DBQ="+server.mappath(""&db&"")+";DefaultDir=;DRIVER={Microsoft Access Driver (*.mdb)};"
set conn=server.createobject("ADODB.CONNECTION")

if err then
    err.clear
else
    conn.open connstr
end if

sub CloseConn()
	conn.close
	set conn=nothing
end sub

%>
