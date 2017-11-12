<!DOCTYPE html>
<html lang="en">
<head><meta name="baidu-site-verification" content="o9BPYkfLYN" />
<meta name="renderer" content="webkit" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="model/publiccn.asp"-->
<%id=request.QueryString("id")
ids=1
keyword=request.QueryString("keyword")
%>
<!--#include file="titlekeyword.asp"-->
<%
if ids<>"" then
    if  NextNavNull(ids)=0 then
    nid=ids
    end if
    if id="" then
    nid=GetDefaultNextID(ids)
    else
    if id<>"" and NextNavNull(id)=1 then
    nid=GetDefaultNextID(id)
    else
    nid=id
    end if
    end if
end if
%>
<title><%=pageTitle%></title>
<meta name="keywords" content="<%=pageKeyword%>" />
<meta name="description" content="<%=pageContent%>" />
<link type="text/css" rel="stylesheet" href="css/reset.css" />

<script src="js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="js/NSW_Index.js"></script>

<script type="text/javascript" src="js/jquery.flexslider-min.js"></script>
<script type="text/javascript">
jQuery(document).ready(function() {
  if(jQuery('.flexslider').length){
	  jQuery('.flexslider').flexslider({
		animation: "slide",
		start: function(slider){
		  jQuery('body').removeClass('loading');
		}
	  });
  }
});
</script>
<script type="text/javascript" src="js/grwy.js"></script>
</head>
<body>
    
<!--头部开始-->
<!--#include file="topnav.asp"-->
<script>
	$(function(){
		var sub_nav = $(".sub_nav");
		$(".nav .n_sub").hover(function(){
			sub_nav.show();	
		},function(){
			sub_nav.hide();	
		})	
	})
</script>  

<div class="flexslider1">
	<ul class="slides">
	  <%Bannerimg(1)%>
	</ul>
</div>
<script src="js/jquery.flexslider-min.js"></script>
<script>
$(function(){
	$('.flexslider1').flexslider({
		directionNav: true,
		pauseOnAction: false
	});
});
</script>
<div class="hza">
    <DIV id="con">
        <UL id="tags">

            <%
            set rsnav= conn.db("select  * from {pre}Navigation where parentid=3 and isShow"&DB_FIELD&"=1  order by sequence,id desc","records1")
            if rsnav.recordCount=0 Then
            Response.Write""
            else
            j=0
            do while not rsnav.eof
            Set rsnavls = Conn.db("SELECT ID FROM {pre}Navigation  where ParentID="&rsnav("id")&" Order By Sequence Asc","records1")
            If Not rsnavls.Eof Then
                prourl = "productsclass.asp"
            else
                prourl = "products.asp"
            end if

            webtype = rsnav("webType")
            lefturl=WebtypeUrl(webtype)
            n=GetPrintIDtop(rsnav("id"))
            previd=GetPrevID(rsnav("id"))
            if rsnav("ClassUrl"&DB_FIELD&"")<>"" then
            url=""&rsnav("ClassUrl"&DB_FIELD&"")&""
            else
            url=""&lefturl&"?id="&rsnav("id")&"&WebType="&rsnav("WebType")&"&ids="&n&"&f_1="&previd&""
            url=RewriteRule(url)
            end if
            sty=""
            if j=0 then
            sty=" class='selectTag'"
            end if
            echo"<LI "&sty&"><A onClick=""selectTag('tagContent"&j&"',this)""  href='javascript:void(0)'>"&rsnav("NavName"&DB_FIELD&"")&"</A></LI>"
            'if NextNavNull(rsnav("id"))=1 then
            'TopNavabout rsnav("id"),""
            'end if
            rsnav.movenext
            j=j+1
            loop
            end if
            rsnav.close
            set rsnav=nothing
            %>


            <ol class="fl cp-title">
                <%=ContentTitle(3)%>
                <br />
                <span class="cp-title-yy"><%=ContentFileds(3,"ClassName")%></span>
            </ol>
        </UL>
        <DIV id="tagContent">
<%
            set rsnav= conn.db("select  * from {pre}Navigation where parentid=3 and isShow"&DB_FIELD&"=1  order by sequence,id desc","records1")
            if rsnav.recordCount=0 Then
            Response.Write""
            else
            j=0
            do while not rsnav.eof
            Set rsnavls = Conn.db("SELECT ID FROM {pre}Navigation  where ParentID="&rsnav("id")&" Order By Sequence Asc","records1")
            If Not rsnavls.Eof Then
                prourl = "productsclass.asp"
            else
                prourl = "products.asp"
            end if

            webtype = rsnav("webType")
            lefturl=WebtypeUrl(webtype)
            n=GetPrintIDtop(rsnav("id"))
            previd=GetPrevID(rsnav("id"))
            if rsnav("ClassUrl"&DB_FIELD&"")<>"" then
            url=""&rsnav("ClassUrl"&DB_FIELD&"")&""
            else
            url=""&lefturl&"?id="&rsnav("id")&"&WebType="&rsnav("WebType")&"&ids="&n&"&f_1="&previd&""
            url=RewriteRule(url)
            end if
            sty=""
            if j=0 then
            sty=" selectTag"
            end if
            %>
            <DIV class="tagContent <%=sty%>" id=tagContent<%=j%>>
                <div class="index-cp-pic">
                    <div class="Solution-pic">

                        <ul>
                             <%ListIsNew rsnav("id"),3,"products","top 5",0%>
                        </ul>

                    </div>
                </div>
            </DIV>
            <%
   
            rsnav.movenext
            j=j+1
            loop
            end if
            rsnav.close
            set rsnav=nothing
            %>


        </DIV>
    </DIV>
    <SCRIPT type=text/javascript>
function selectTag(showContent,selfObj){
    // 操作标签
    var tag = document.getElementById("tags").getElementsByTagName("li");
    var taglength = tag.length;
    for(i=0; i<taglength; i++){
        tag[i].className = "";
    }
    selfObj.parentNode.className = "selectTag";
    // 操作内容
    for(i=0; j=document.getElementById("tagContent"+i); i++){
        j.style.display = "none";
    }
    document.getElementById(showContent).style.display = "block";
    
    
}
</SCRIPT>
    <div class="clearfix"></div>
</div>
<div class="index-about">
<div class="w1100">
  <div class="fl index-about-left"><img src="<%=ContentFileds(13,"Class_pic")%>" width="541" height="350"></div>
    <div class="fr index-about-right">
      <div class="index-about-title"><h2><%=ContentTitle(13)%></h2><span class="index-about-title-yy"><%=ContentFileds(13,"ClassName")%></span>
</div>
      
    <div class="index-about-content">  
           <%=ContentShow(13)%>
    </div>
    <div class="index-about-more"><a href="<%=GetTopIdUrl(13)%>" <%=NavTarget(13)%>>View details</a></div>
    </div>
    <div class="clearfix"></div>
    <div class="index-about-pic">
      	<div id="demo">
  <table border=0 align=center cellpadding=1 cellspacing=1 cellspace=0 >
    <tr>
      <td valign=top id=marquePic1><table width='100%' border='0' cellspacing='0'>
          <tr>
              
              
              <%ListIsNew 14,2,"factory","top 20",0%>
              
              
          </table></td>
      <td id=marquePic2 valign=top></td>
    </tr>
  </table>
</div>
<script type="text/javascript">
var speed=20
marquePic2.innerHTML=marquePic1.innerHTML 
function Marquee(){ 
if(demo.scrollLeft>=marquePic1.scrollWidth){ 
demo.scrollLeft=0 
}else{ 
demo.scrollLeft++ 
} 
} 
var MyMar=setInterval(Marquee,speed) 
demo.onmouseover=function() {clearInterval(MyMar)} 
demo.onmouseout=function() {MyMar=setInterval(Marquee,speed)} 
</script>
        
       
    </div> 
    </div>
  </div>
<div class="ggt-b"></div>
<div class="index-news">
	<div class="index-news-hz">
   	  <div class="fl index-news-left">
        	<div class="index-news-left-title">
        	  <span class="fr news-more"><a href="<%=GetCurrentIdUrl(39)%>" <%=NavTarget(39)%>>MORE+</a></span><%=ContentTitle(39)%>
       	</div>
        	<div class="index-news-left-fl">
<!-- 滚动 -->
<div id="femo" style="OVERFLOW: hidden; WIDTH: 324px;height:280px;">
<div id="femo1">
    
    
    <%ListIsNew 39,36,"faq","top 10",0%>
    
    
                 </div>
<div id="femo2">
    <%ListIsNew 39,36,"faq","top 10",0%> 
    
    
                 </div></div>
<script>
  var femo = document.getElementById("femo");
var femo1 = document.getElementById("femo1");
var femo2 = document.getElementById("femo2");
var speed3=35//速度数值越大速度越慢
femo2.innerHTML=femo1.innerHTML
function Marquee2(){
if(femo2.offsetHeight-femo.scrollTop<=0)
femo.scrollTop-=femo1.offsetHeight
else{
femo.scrollTop++
}
}
var MyMar2=setInterval(Marquee2,speed3);
femo.onmouseover=function() {clearInterval(MyMar2)}
femo.onmouseout=function() {MyMar2=setInterval(Marquee2,speed3)}
</script>
<!-- 滚动 -->
              
                
   	    </div>
      </div>
        <div class="fl index-news-yy"><img src="images/index_27.jpg" width="22" height="361"></div>
        <div class="fr index-news-right">
       	 <div class="index-news-left-title1">
        	 <span class="fr news-more"><a href="<%=GetCurrentIdUrl(37)%>" <%=NavTarget(37)%>>MORE+</a></span><%=ContentTitle(37)%>
       	</div>
             <%ListIsNew 37,36,"newsfirst","top 1",0%>
             <div class="clear"></div>
              <div class="index-news-right-xw">
                     <div class="fl news-right-xwa">
                       <ul>
                           
                           
                           <%ListIsNew 37,36,"news","top 7",0%>
                           
                           
 
                       </ul>
                     </div>
          </div>
        </div>
    </div>
</div>
<!--#include file="foot.asp"--> 
</body>
</html>