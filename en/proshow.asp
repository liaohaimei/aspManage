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
<script src="js/cj_sdw_msw.js" type="text/javascript"></script>
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
           <div class="productShowPic fl">
                <div class="box">
                    <div class="tb-booth tb-pic tb-s310">
                        <img src="<%ProDefaultimg pid,"p_img"%>" alt="" rel="<%ProDefaultimg pid,"p_img"%>" class="jqzoom" style="cursor: crosshair;">
                    </div>
                    <div class="tb-picList">
                        <a class="prev"></a><a class="next"></a>
                        <div class="tb-thumb">
                            <ul id="thumblist">
                              <%BrowseContentimg pid,"p_img",2%>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
           <!-- 右侧标题简介 -->
            <div class="productShowTitle fl">
                <h2><%=BrowseContent(pid,"p_name")%></h2>
                <div class="descriptionBox">
                  <strong>Description</strong><br>
                <%=BrowseContent(pid,"p_Description")%>
              </div>
                <div class="productTel">Order Hotline：<span><%=ContentTel(1)%></span></div>
            </div>
            <div class="clearfix"></div>
            <!-- 产品说明标签切换 -->
            <div class="con">
        <div class="tab">
            <ul>
                <li class="hover">Electrical properties</li>
                <li>Output characteristic</li>
                <li>Safety</li>
            </ul>
        </div>
        <div class="main00">
          <div class="content_pro">
            <%=BrowseContent(pid,"p_Introduce")%>
            </div>
          <div class="content_pro" style="display: none;">
          <%=BrowseContent(pid,"p_Introduce2")%>
          </div>
          <div class="content_pro" style="display: none;">
           <%=BrowseContent(pid,"p_Introduce3")%>
          </div>
       </div>
            </div>
            <div class="xgbg">
            	<div class="xgbg_title">Related products</div>
                <div class="products">
                    <ul class="clearfix">
                        <%List ids,SortID,5,"xgproducts"%>
                    </ul>        
                </div>
            </div>
           <div class="fenyList">
				<div class="prew">Previous：<a href="<%=GetPrevious(SortID,"proshow.asp","None",1)%>"><%=GetPrevious(SortID,"proshow.asp","None",2)%></a></div>
                    <div class="nextw">Next：<a href="<%=GetNext(SortID,"proshow.asp","None",1)%>"><%=GetNext(SortID,"proshow.asp","None",2)%></a></div>
                           </div> 
    </div>
            </div>
        </div>
            <div class=" clearfix"></div>
</div>



<!--#include file="foot.asp"--> 
<script type="text/javascript" src="js/imagezoom.min.js"></script>
<script type="text/javascript" src="js/base.js"></script>
<script type="text/javascript">
        $(function () {
            show(0);
            //            $(".main div:first").show();
            //            $(".tab ul li:first").addClass("hover");
            $(".tab ul li").hover(function () {
                var n = $(".tab ul li").index(this);
                show(n)
                //                $(this).addClass("hover").siblings().removeClass("hover");
                //                $(".main div").eq(n).show().siblings().hide();
                //alert(n);

            });
            function show(index) {
                $(".tab ul li").eq(index).addClass("hover").siblings().removeClass("hover");
                $(".main00 div.content_pro").eq(index).show().siblings().hide();

            }

        });
</script>
<script type="text/javascript">
$(document).ready(function(){
    $(".jqzoom").imagezoom();
    $("#thumblist li a").click(function(){
        $(this).addClass("tb-selected");
        $(this).parents().siblings().children("a").removeClass("tb-selected");
        $(".jqzoom").attr('src',$(this).find("img").attr("mid"));
        $(".jqzoom").attr('rel',$(this).find("img").attr("big"));
    });
});
</script>

</body>
</html>