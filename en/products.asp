<!DOCTYPE html>
<html lang="en">
<head><meta name="baidu-site-verification" content="o9BPYkfLYN" />
<meta name="renderer" content="webkit" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="model/publiccn.asp"-->
<%id=request.QueryString("id")
ids=request.QueryString("ids")
keyword=request.QueryString("keyword")
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
  nid=id
  end if
end if
%>
<title><%=pageTitle%></title>
<meta name="keywords" content="<%=pageKeyword%>" />
<meta name="description" content="<%=pageContent%>" />
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
<div style="line-height:25px; "><%=ContentIntroduction(nid)%></div>
                      <div class="product">
                            <ul class="clearfix">
<%List ids,nid,9,"products"%>  
            </ul>
        </div>
<div class="page"><%Listpage ids,nid,9,"products"%></div>  
                 </div>
            </div>
        </div>
            <div class=" clearfix"></div>
</div>



<!--#include file="foot.asp"--> 
</body>
</html>