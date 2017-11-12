// JavaScript Document
// writer: www.grwy.net


jQuery(function() {

$(".page-job-list").first().find(".page-job-co").slideDown();$(".page-job-list").click(function(){$(this).find(".page-job-co").slideDown().end().siblings().find(".page-job-co").slideUp();});
	
	$(".help-menu li a,.menu li h6,.footerNav li").append("<span></span>");
	
	$(".menu li h6").append("<em></em>");
	
	$(".menu li").hover(function() {
        $(this).addClass("current").find("ul").show();
    },function() {
		$(this).removeClass("current").find("ul").hide();
    })
	
	
	$(".item").hover(function() {
     //   $(this).find("ol").show();
    },function() {
     //   $(this).find("ol").hide();
    })
	
	$(".item ol li").hover(function() {
        $(this).find("ul").show();
    },function() {
        $(this).find("ul").hide();
    })
	
	
	
	var menuPro = $(".menu-pro")
	
	
	
	
	
	$(".menu li").each(function(){
		//$( '<span class ="on">' + $(this).find("span.en").text() + '</span>' ).appendTo(this)				         
		if($(this).find(menuPro)){
			//$(this).css({position:"relative"})
			}
			
		})
	

		if($(".mneu li").find(menuPro)){
			//alert("65")
			$(this).css({position:"relative"})
			}
	
		
	
	$(".home-advantage-list dl").hover(function() {
        $(this).addClass("current");
    },function() {
		$(this).removeClass("current");
    })
	
	
	
	
    
	$(".home-solution-list dl:first").css({width:666})
	
	$(".product-classify:first").addClass("product-classify-one product-classify-bg")
	
	
	$(".product-classify").hover(function() {

        $(this).addClass("product-classify-bg");
		$(this).siblings().removeClass("product-classify-bg");

    },function() {

        $(this).removeClass("product-classify-bg")
	
    })
	
	
	$(".home-product-list").hover(function(){
		
		},function(){
			$(".product-classify:first").addClass("product-classify-bg")
			})
	
	
    $(".home-advantage-list dl:even").addClass("even") 
	
	
	$(".page-solution-category dl").hover(function() {
        $(this).find("dd.en").stop().animate({bottom:55}, 200);
		$(this).find("dd.cn").stop().animate({bottom:35}, 300);
    },function() {
		$(this).find("dd.en").stop().animate({bottom:35}, 200);
		$(this).find("dd.cn").stop().animate({bottom:15}, 200);
    })
	
	
	
	$(".home-solution-list dl").hover(function() {
		$(this).find("dd").css({background:"#0084cd"})
        $(this).find("dd").stop().animate({top:0}, 200)
    },function() {
        $(this).find("dd").stop().animate({top:190},200,function(){
			$(this).css("background","url(images/solution-bg.png)");
			})
    })
	
	
	
	$(".partnerList li dl").hover(function() {
        $(this).find("dd").stop().animate({bottom:0}, 200)
    },function() {
         $(this).find("dd").stop().animate({bottom:-40}, 200)
    })
	
	

    $(".article").hover(function() {
        $(this).stop().animate({top:-15},200);
    },function() {
        $(this).stop().animate({top:0},200);
    })

		
	$(".page-case-category:lt(2)").css({width:"50%"})
	
	
	
	
	$(".content-faq-list").click(function(){
		$(this).find("dt").addClass("on")
		$(this).find("dt").stop().animate({paddingLeft:43});
		$(this).find("dt em").stop().animate({left:8});
		$(this).find("dd").slideDown();
		
		$(this).siblings().find("dt").removeClass("on")
		$(this).siblings().find("dt").stop().animate({paddingLeft:35});
		$(this).siblings().find("dt em").stop().animate({left:0});
		$(this).siblings().find("dd").slideUp();
		
		});
	
	
	
	

})




