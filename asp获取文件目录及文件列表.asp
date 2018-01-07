        <%
SET Fso = CreateObject("Scripting.FileSystemObject")
Set X = Fso.GetFolder(Server.MapPath("/admin_4/page"))

For Each F in X.Subfolders '遍历目录
    Response.Write F.Name & "/" & chr(9) '文件名
    ' Response.Write F.DateCreated & chr(9) '创建时间
    ' Response.Write F.DateLastAccessed & chr(9) '访问时间
    ' Response.Write F.DateLastModified & chr(9) '修改时间
    ' Response.Write "0" & chr(9) '文件大小
    ' Response.Write F.Type & chr(9) '文件类型
    ' Response.Write F.Attributes & "<br>" & Vbcrlf '文件属性
Next
For Each F in X.Files '遍历文件
    Response.Write F.Name & chr(9) '文件名
    ' Response.Write F.DateCreated & chr(9) '创建时间
    ' Response.Write F.DateLastAccessed & chr(9) '访问时间
    ' Response.Write F.DateLastModified & chr(9) '修改时间
    ' Response.Write F.Size & chr(9) '文件大小
    ' Response.Write F.Type & chr(9) '文件类型
    ' Response.Write F.Attributes & "<br>" & Vbcrlf '文件属性
Next
%>