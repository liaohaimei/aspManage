<%
'****************************************************
'��������getThumbnail
'���ߣ�www.goimage.cn
'��  �ã�������������������ͼ
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
			'jpeg.Sharpen 1, 110                                 '�趨��Ч��
	
    Jpeg.Save Server.MapPath(TargetFile) '//��������ͼλ�ü�����

    'ע��ʵ��
    Set Jpeg = Nothing
End Function
%>