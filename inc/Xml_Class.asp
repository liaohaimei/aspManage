<%
'****************************************************
'Code for cms668com
'Vision : v2.0
'****************************************************

Class MainClass_Xml
	Public xmlDocument,xmlPath,xmlDomObj,xmlstr
	Private xmlDomVer,xmlFileSavePath
	
	Public Sub Class_Initialize()
		xmlDomVer = getXmlDomVer()
		createXmlDomObj
	End Sub
	
	Public Sub Class_Terminate()
		If IsObject(xmlDomObj) Then Set xmlDomObj = Nothing
	End Sub
	
	Private Function getXmlDomVer()
		dim i,xmldomVersions,xmlDomVersion
		getXmlDomVer = false
		xmldomVersions = Array("Microsoft.2MLDOM","MSXML2.DOMDocument","MSXML2.DOMDocument.3.0","MSXML2.DOMDocument.4.0","MSXML2.DOMDocument.5.0")
		for i = 0 to ubound(xmldomVersions)
			xmlDomVersion = xmldomVersions(i)
			if isInstallObj(xmlDomVersion) then getXmlDomVer = xmlDomVersion : Exit Function
		next
    End Function
	
	Private Sub createXmlDomObj
		set xmlDomObj = server.CreateObject(xmlDomVer)
		xmlDomObj.validateonparse = true 
		xmlDomObj.async=false 
	End Sub
	
	Public Function load(Byval xml,Byval xmlType)
		dim xmlUrl,xmlfilePath
		select case xmlType 
			case "xmlfile"
				xmlfilePath=server.mappath(xml)   
		 		xmlDomObj.load(xmlfilePath)   
			case "xmldocument"
				xmlUrl = xml
				xmlstr = getRemoteContent(xmlUrl,"text")
				If left(xmlstr, 5) <> "<?xml" then die err_xml else xmlDomObj.loadXML(xmlstr)
			case "transfer"
				xmlUrl = xml
				xmlstr = bytesToStr(getRemoteContent(xmlUrl,"body"),"gbk")
				If left(xmlstr, 5) <> "<?xml" then die err_xml else xmlDomObj.loadXML(xmlstr)
		end select
	End Function
	
	Public Function isExistNode(nodename)
        dim node
        isExistNode = True
        set node = xmlDomObj.getElementsByTagName(nodename)
        If node.Length = 0 Then isExistNode = False : set node = nothing
    End Function
	
	Public Function getNodeValue(nodename, itemId)
		if isNul(itemId) then  itemId = 0
    	getNodeValue = xmlDomObj.getElementsByTagName(nodename).Item(itemId).Text
    End Function
	
	Public Function getNodeLen(nodename)
        getNodeLen = xmlDomObj.getElementsByTagName(nodename).Length
    End Function
	
	Public Function getNodes(nodename)
        Set getNodes = xmlDomObj.getElementsByTagName(nodename)
    End Function
	
	Public Function getNode(nodename, itemId)
        Set getNode = xmlDomObj.getElementsByTagName(nodename).Item(itemId)
    End Function
	
	Public Function getAttributes(nodeName, attrName, itemId)
        dim xmlAttributes, i
		if isNul(itemId) then  itemId = 0
        Set xmlAttributes = xmlDomObj.getElementsByTagName(nodeName).Item(itemId).Attributes
        For i = 0 To xmlAttributes.Length -1
            If xmlAttributes(i).Name = attrName Then
                getAttributes = XmlAttributes(i).Value
				Set xmlAttributes = nothing
                Exit Function
            End If
        Next
        getAttributes = false
    End Function
	
	Public Function setXmlNodeValue(Byval nodename, Byval itemId, Byval str,Byval savePath)
        dim node
		xmlFileSavePath = savePath
        Set node = xmlDomObj.getElementsByTagName(nodename).Item(itemId)
        node.childNodes(0).text = str
        xmlDomObj.save Server.MapPath(xmlFileSavePath)
		set node = nothing
    End Function

End Class
%>