<%
'****************************************************
'Code for cms668com
'Vision : v2.0
'****************************************************

Class MainClass_DB
	public dbConn,dbRs,isConnect,fetchCount
	private connStr,vqueryCount,vdbType
	private errid,errdes,dbfile
	
	Private Sub Class_Initialize
		isConnect=false
		vqueryCount=0
		fetchCount=0
	End Sub
	
	Public Property Get queryCount
		queryCount = vqueryCount
	End Property
	
	Public Property Let dbType(byval pType)
		if pType = "sql" then vdbType=pType  else vdbType = "acc"
	End Property
	
	Private Sub getConnStr()
		if vdbType = "sql" then
			connStr = "Provider=Sqloledb;Data Source=" & databaseServer & ";Initial Catalog=" & databaseName & ";User ID=" & databaseUser & ";Password=" & databasePwd & ";"
		elseif vdbType = "acc" then
		    if sitePath<>"" then dbfile="/"&left(sitePath,len(sitePath)-1)&accessFilePath : else dbfile=accessFilePath
			connStr = "Provider=Microsoft.Jet.OLEdb.4.0;Data Source=" & server.mappath(dbfile)
		end if
	End Sub
	
	Public Sub connect()
		getConnStr
		if isObject(dbConn) = false or isConnect = false then
			On Error Resume Next
			set dbConn=server.CreateObject(CONN_OBJ_NAME)
			dbConn.open connStr
			isConnect = true
			if Err then errid=Err.number:errdes=Err.description:Err.Clear:dbConn.close:set dbConn=nothing:isConnect = false:echoErr err_dbconect,errid,errdes
		end if
	End Sub
	
	Function db(byval sqlStr,byval sqlType)
		if not isConnect = true then connect
		On Error Resume Next
		sqlStr = replace(sqlStr,"{pre}",TABLE_PRE)
		select case sqlType
			case "execute"
				set db = dbConn.execute(sqlStr)
			case "records1"
				set db=server.CreateObject(RECORDSET_OBJ_NAME)
				db.open sqlStr,dbConn,1,1
			case "records3"
				set db=server.CreateObject(RECORDSET_OBJ_NAME)
				db.open sqlStr,dbConn,3,3
			case "array"
				set dbRs=server.CreateObject(RECORDSET_OBJ_NAME)
				dbRs.open sqlStr,dbConn,1,1
				if not dbRs.eof then
					if fetchCount = 0 then  db = dbRs.getRows() else db = dbRs.getRows(fetchCount)
				end if
				dbRs.close:set dbRs=nothing
		end select
		vqueryCount = vqueryCount+1
		if Err then 
			errid=Err.number:errdes=Err.description:Err.Clear:dbConn.close:set dbConn=nothing:isConnect = false
			echoErr err_rsopen,errid,errdes
		end if
	End Function
	
	Public Sub Class_Terminate()
		if isObject(dbRs) then set dbRs = nothing
		if isConnect then dbConn.close:set dbConn = nothing
	End Sub
End Class
%>