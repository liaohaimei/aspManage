<%
'****************************************************
'Code for cms668com
'Vision : v2.0
'****************************************************

Class MainClass_DataList
	Public primaryField,tableStr
	Public orderStr,whereStr,dataSortType,fieldsStr,dataPageSize,dataCurrentPage
	Public recordsCount,pagesCount
	private tempTableCount,sqlstr,topCount,whereStr2,whereStr3
	private m,n
	
	Public Sub Class_Initialize
		 dataSortType = "desc"
	End Sub
	
	Public Sub Class_Terminate
		 
	End Sub
	
	Public Function getDataList()
		dim order
		if isNul(dataPageSize) then dataPageSize = 100 else dataPageSize = cint(dataPageSize)
		if not isNul(whereStr) then whereStr= " where "&whereStr else whereStr=""
		if isNul(tableStr) then die err_table
		if isNul(fieldsStr) then fieldsStr = " * "  else  fieldsStr = " " & fieldsStr & " "
		if not isNul(orderStr) then order = " order by " & orderStr else order=" "
		sqlstr = "select top " & dataPageSize & fieldsStr & " from " & tableStr & " " & whereStr & order
		getDataList = dbconn.db(sqlstr,"array")
	End Function
	
	Public Function getPageList()
		dim order
		if isNul(dataPageSize) then dataPageSize = 30 else dataPageSize = cint(dataPageSize)
		if not isNul(whereStr) then whereStr2 = " where "&whereStr : whereStr3 = " and "&whereStr else whereStr2="":whereStr3=""
		recordsCount = conn.db("select count(*) from "&tableStr&whereStr2,"array")(0,0)
		m = recordsCount mod dataPageSize
		n = int(recordsCount / dataPageSize)
		if m = 0 then pagesCount = n else pagesCount = n + 1  
		if isNul(primaryField) then die err_primarykey
		if isNul(tableStr) then die err_table
		if isNul(orderStr) then orderStr = primaryField
		if isNul(fieldsStr) then fieldsStr = " * "  else  fieldsStr = " " & fieldsStr & " "
		if dataCurrentPage > pagesCount   then dataCurrentPage = pagesCount
		if isNul(dataCurrentPage)  then 
			dataCurrentPage = 1 
		else 
			if dataCurrentPage <= 0 then dataCurrentPage = 1 else dataCurrentPage = cint(dataCurrentPage)
		end if
		order = " " & orderStr & " " & dataSortType 
		if dataSortType = "desc" then
			if dataCurrentPage = 1 then 
				sqlstr = "select top " & dataPageSize & fieldsStr & " from " & tableStr & " " & whereStr2 & " order by " & order
			else
				sqlstr = "select top " & dataPageSize & fieldsStr & " from " & tableStr & " where " & primaryField & "<(select min(" & primaryField & ") from (select top " & (dataCurrentPage - 1) * dataPageSize & " " & primaryField & " from " & tableStr &" "&whereStr2& " order by  " & order & ") as temptable)  "& whereStr3& " order by " & order
			end if
		else dataSortType = "asc" 
			if dataCurrentPage = 1 then 
				sqlstr = "select top " & dataPageSize & fieldsStr & " from " & tableStr & " " & whereStr2 & " order by " & order
			else
				sqlstr = "select top " & dataPageSize & fieldsStr & " from " & tableStr & " where " & primaryField & ">(select max(" & primaryField & ") from (select top " & (dataCurrentPage - 1) * dataPageSize  & " " & primaryField & " from " & tableStr &" "& whereStr& " order by  " & order & ") as temptable)  "& whereStr3& " order by " & order
			end if
		end if
		getPageList = conn.db(sqlstr,"array")
	End Function
End Class

%>