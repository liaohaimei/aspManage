<!--#include file="../../../admin_inc.asp"-->
<!--#include file="../../../../inc/json.asp"-->
<%
'response.ContentType="text/json"
dim j

'多重嵌套的JSON,要使用Dictionary才能实现
set j=new json
j.toResponse=false
set r=server.createobject("scripting.dictionary")
set b=server.createobject("scripting.dictionary")
set c=server.createobject("scripting.dictionary")
                            c.add "x",5
                            c.add "y",6
                            c.add "z",11
                b.add "event","Mouse Click"
                b.add "data",c
r.add "success",true
r.add "result",b
a=j.toJSON(empty,r,false)
'response.write a
%>

<%
    Dim sql_class,sql_top,sql_colums,sql_whereBy,sql_orderBy
    sql_class = request.Item("sql_class")
    sql_top = request.Item("sql_top")
    sql_colums = request.Item("sql_colums")
    sql_whereBy = request.Item("sql_whereBy")
    sql_orderBy = request.Item("sql_orderBy")

    Sql="select "&sql_top&" "&sql_colums&" from "&sql_class&" where 1=1 "&sql_whereBy&" "&sql_orderBy
%>

<%
 	set Rs = dbconn.db(sql,"records1")
    jsonStr = ""
    rows = ""

    Dim i,json_rows,json_ret,arr_rows
    Dim myArray()
    Redim myArray(rs.recordcount-1) '将数组大小重新定义为20
    Set jsonObj=New json
    jsonObj.toResponse=False
    Set json_ret = server.createobject("scripting.dictionary")        
    For i=0 To rs.recordcount-1
        Set myArray(i) = server.createobject("scripting.dictionary")
        For Each e In rs.Fields                
                'rows = rows &""""& e.Name & """:""" & replace(e.value,chr(34),"@_'_@") & """," 
                myArray(i).Add e.Name,e.value  '将key/value加到行数组对象中
        Next   
        Rs.movenext
    Next       
    json_ret.Add "total",rs.recordcount
    json_ret.Add "rows",myArray 
    jsonStr = jsonObj.toJSON(Empty,json_ret,False)

    echo jsonStr

%>