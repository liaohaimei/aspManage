<%
'****************************************************
'函数名：getThumbnail
'作者：www.goimage.cn
'作  用：真正按比例生成缩略图
'****************************************************
Function getThumbnail(LocalFile, TargetFile, strWidth, strHeight)
    Dim Jpeg,w,h,a,b,c
    Set Jpeg = Server.Createobject("Persits.Jpeg")
        Jpeg.open server.MapPath(LocalFile) 
    
        If (jpeg.OriginalHeight / jpeg.OriginalWidth)*10 < (strHeight / strWidth)*10 Then
        	w = strHeight*jpeg.OriginalWidth/strWidth
			'jpeg.crop (jpeg.OriginalWidth-w)/2,0,(jpeg.OriginalWidth-w)/2+w,jpeg.OriginalHeight
    	Else
        	h = strHeight*jpeg.OriginalWidth/strWidth
			'jpeg.crop  0,(jpeg.OriginalHeight-h)/2,jpeg.OriginalWidth,(jpeg.OriginalHeight-h)/2+h
    	End If
			
			jpeg.height = strHeight
			jpeg.width = strWidth
			'jpeg.Sharpen 1, 110                                 '设定锐化效果
	
    Jpeg.Save Server.MapPath(TargetFile) '//生成缩略图位置及名称

    '注销实例
    Set Jpeg = Nothing
End Function
%>