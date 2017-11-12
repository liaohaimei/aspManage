<!DOCTYPE html>
<html lang="en">
<head><meta name="baidu-site-verification" content="o9BPYkfLYN" />
<meta name="renderer" content="webkit" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="model/publiccn.asp"-->
<%
pid=request.QueryString("idd")
SortID=request.QueryString("SortID")
id=request.QueryString("SortID")
ids=request.QueryString("ids")
ord=request.QueryString("ord")
typ=request.QueryString("typ")
%>
<!--#include file="titlekeyword.asp"-->
<%
if ids<>"" then
  if  NextNavNull(ids)=0 then
  nid=ids
  end if
  if id="" then
  nid=ids
  else
  nid=SortID
  end if
end if
%>
<title><%if BrowseContent(pid,"PageTitle")<>"" then echo BrowseContent(pid,"PageTitle") else echo BrowseContent(pid,"p_name") end if%></title>
<meta name="keywords" content="<%if BrowseContent(pid,"Keywords")<>"" then echo BrowseContent(pid,"Keywords") else echo pageKeyword end if%>" />
<meta name="description" content="<%if BrowseContent(pid,"Descriptions")<>"" then echo BrowseContent(pid,"Descriptions") else echo pageContent end if%>" />
<link type="text/css" rel="stylesheet" href="css/reset.css" />
<script src="js/jquery-1.10.2.min.js"></script>
</head>
<body>
    
<!--头部开始-->
<!--#include file="topnav.asp"-->  
<!--#include file="banner.asp"--> 
<div class="w1100" style="padding:15px 0;">
<!--#include file="left.asp"--> 
<!--cpleft-->
            <div class="cpright">
            <!--#include file="current.asp"--> 
            <div class="story">
                <div class="agent_con">
                	 <div class="newsShow"><h2><%=BrowseContent(pid,"p_name")%></h2>
                     <h3><span>Browse times：<%=BrowseTimes(pid)%></span><span>Release time：<%=BrowseDatetime(pid)%></span></h3>
                     <div class="newsShowBox fontsizebox">
                    <%=BrowseContent(pid,"p_Description")%>        
</div>
                     <div class="fenyList">
						<div class="prew">Previous：<a href="<%=GetPrevious(SortID,"newshow.asp","None",1)%>"><%=GetPrevious(SortID,"newshow.asp","None",2)%></a></div>
                		<div class="nextw">Next：<a href="<%=GetNext(SortID,"newshow.asp","None",1)%>"><%=GetNext(SortID,"newshow.asp","None",2)%></a></div>
                </div>
                     </div>
                </div>
            </div>
        </div>
            <div class=" clearfix"></div>
</div>



<!--#include file="foot.asp"--> 
</body>
</html>