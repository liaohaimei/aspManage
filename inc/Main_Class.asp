<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
'****************************************************
'Code for cms668com
'Vision : v2.0
'****************************************************
'Option Explicit
dim starttime,endtime

const CONN_OBJ_NAME = "ADODB.CONNECTION"
const RECORDSET_OBJ_NAME = "ADODB.RECORDSET"
	
dim FSO_OBJ_NAME
	FSO_OBJ_NAME = "SCRI"&"PTING.FILES"&"YSTEMOBJECT"

dim STREAM_OBJ_NAME
	STREAM_OBJ_NAME = "ADOD"&"B.ST"&"REAM"

dim DICTIONARY_OBJ_NAME
	DICTIONARY_OBJ_NAME = "SCRIPTING.DICTIONARY"

dim JPEG_OBJ_NAME
	JPEG_OBJ_NAME="Persits.jpeg"

dim UPLOAD_OBJ_NAME
	UPLOAD_OBJ_NAME="Persits.Upload.1"

dim TABLE_PRE
	TABLE_PRE = "wspcms_"

Class MainClass
	private className

	Private Sub Class_Initialize
		className=""
	End Sub

	Public Function createObject(byval classStr)
		className=classStr
		classname=replace(classname,".","_")
		Execute("set createObject=new "&classname)
	End Function
	
	Private Sub Class_Terminate()
		
	End Sub
End Class
%>
<!--#include file="config.asp"-->
<!--#include file="CommonFun.asp"-->
<!--#include file="Xml_Class.asp"-->
<!--#include file="Template_Class.asp"-->
<!--#include file="DB_Class.asp"-->
<!--#include file="Datelist_Class.asp"-->
<!--#include file="lang.asp"-->
<!--#include file="Cls_vbsPage.asp"-->
<%
dim mainClassObj
set mainClassObj = New MainClass

'dim dbConn
set dbConn = mainClassobj.createObject("MainClass.DB") 
if  databaseType  = 0 then dbConn.dbType = "acc" : else dbConn.dbType = "sql"
dim objFso,objStream
initializeAllObjects
'dbConn.openDbConnection
%>