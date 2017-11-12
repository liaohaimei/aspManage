/* js Document */
/* Author: zq */
/* Time: 2015/3/10*/
$(function(){
	
	$('.nav li:last').find('.nav_name').css('background','none')
	
	/*产品当前*/
	$('.product_list li').hover(function(){
		
		$(this).find('.pro_show').animate({'top':'0'},450)
		
		},function(){
			
			$(this).find('.pro_show').animate({'top':'321px'},450)
			
			})
	
	/*当前位置*/
	var po_wid = $('.position').width();
	$('.line').css('width',1100-po_wid-30+'px')		
	
	/*招聘*/
	$('.job_table tr:even').addClass('cur')
	
	/*下载*/
	$('.load_top').find('.load_icon').click(function(){
		
		var ask_child = $(this).parents('li').children('.load_down');
		
		if(ask_child.is(":visible")){
			
			$(this).parents('li').removeClass('cur')
			ask_child.stop().slideUp(100)
			
			}
			else{
				
				$(this).parents('li').addClass('cur')
				
				ask_child.stop().slideDown(400).end().siblings().removeClass('cur').children('.load_down').stop().slideUp(0);
				
				}
		
		})	
		
		$('.showArea li').hover(function(){
		
		$(this).addClass('cur').siblings().removeClass('cur')
		
		})	
		
	var l = $(".showArea li").length;
   				 	
    $(".showArea ul").width(306 * l);

    var newsIndex = 1;
    $("#gobottom").click(function () {
        if (newsIndex < l) {
            var $wrap = $('.showArea ul')
            $wrap.stop(true, true).animate({
                marginLeft: -newsIndex * 114
            }, 800);
			
            newsIndex++
        }
       
    });

    $("#gotop").click(function () {
        if (newsIndex > 1) {
            var $wrap = $('.showArea ul')
            $wrap.stop(true, true).animate({
                marginLeft: -(newsIndex-2) * 114
            }, 800);
			
            newsIndex--
        }
        
    })	
	
	var $pro_this = $(".pro_dSel li")
			 $pro_this.click(function(){
		 	$(this).addClass('cur').siblings().removeClass('cur')
	 	 	var pro_index = $pro_this.index(this);
	 		$(".pro_Dcon>div").eq(pro_index).show().siblings().hide();
					
		})	
	
	})