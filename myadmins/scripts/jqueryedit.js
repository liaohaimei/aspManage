$(function() { 



//修改数据=============================================================================
//_field_name:修改的字段名称
//_field_id:修改的id值
//newtxt:修改后的内容
function Update(newtxt,_field_id,_field_name){
	
	//ajax开始=======================================
    $.ajax({
        type: "POST",
        url: "ajax_edit.asp",
        data: { Lan_name: newtxt,id:_field_id,field_name:_field_name},   //id:新的排列对应的ID,order：原排列顺序
        success: function (data, st) {
		alert(data);
        },
        error: function () {
		alert("没有找到页面!");
        },
        beforeSend: function () {
           // alert("正在为您努力的加载中...");
        }

    });
    //ajax结束=======================================
	
}
//修改数据=============================================================================end




//获取class为caname的元素 
$(".caname").click(function() { 
var td = $(this); 
var txt = td.text(); 
var input = $("<input type='text'value='" + txt + "'/>"); 
td.html(input); 

input.click(function() { return false; }); 
//获取焦点 
input.trigger("focus"); 
//文本框失去焦点后提交内容，重新变为文本 
input.blur(function() { 
var newtxt = $(this).val(); //修改后的值
//判断文本有没有修改 
if (newtxt != txt) { 
td.html(newtxt); 
a=td.html(newtxt).html(); 
//不需要使用数据库的这段可以不需要 
var _id = $.trim(td.parent().find("td:eq(1)").text()); //修改的id
var _field_name = $(td).attr("id"); //字段
var _field_type = $(td).attr("axis"); //字段类型

if (_field_type=="number")
{ 
 var str=$("#MyTable #"+_field_name).html();
	if(IsNumber(str)==false || str=="")
	{
		alert("排序请勿填写非数字或空值");
		window.location.reload();
		return;
		}
}

if (_field_type=="date")
{ 
 var str=$("#MyTable #"+_field_name).html();
	if(CheckDate(str)==true || str=="")
	{
		alert("您输入的日期不正确！\n 请注意日期格式（如：2007/07/17或2007-07-17）或闰年！");
		window.location.reload();
		return;
		}

}

//ajax开始=======================================
Update(newtxt,_id,_field_name) 
//ajax结束=======================================

} 
else 
{ 
td.html(newtxt); 
} 
}); 
});



//修改下拉框的值
$("#MyTable select").change(function(){
var _id=$(this).parent().parent().find("td:eq(1)").text();//修改的id
var _field_name=$(this).parent().attr("id");//字段
var _field_type=$(this).parent().attr("axis");//字段类型
var newtxt =$(this).val();//修改的值
//ajax开始=======================================
Update(newtxt,_id,_field_name)
//ajax结束=======================================

});



//判断所选择的字段类型追加相对应的搜索框
$("select[name=searchtype]").change(function(){
var fieldtype=$(this).find("option:selected").val();//字段的类型
var fieldname=$(this).find("option:selected").attr("data-id");//字段名称
switch (fieldtype)
{ 
		case "3":
            //str = "自动编号/数字"
			break;
        case "6":
            //str = "货币"
			break;
        case "7":
            //str = "日期/时间"
			break;
        case "11":
            //str = "是/否"
			break;
        case "202":
            //str = "文本"
$("select[name=searchtype]").after(""+fieldname+":<input name='"+fieldname+"' type='text' />");
			break;
        case "203":
            //str = "备注/超链接"
$("select[name=searchtype]").after(""+fieldname+":<input name='"+fieldname+"' type='text' />");
			break;
        case "205":
			break;
	
	}

});


//决断是否为数字
function IsNumber(str){
if(!isNaN(str)){
	return true;
}
	else
	{
	return false;
	}
}


//判断输入的日期是否正确
function CheckDate(INDate){ 
if (INDate==""){return true;}
if(INDate.indexOf('-',0)!=-1){separate="-"}
else{
	if(INDate.indexOf('/',0)!=-1){separate="/"}
	else {return true;}
	}
	area=INDate.indexOf(separate,0)
	//获取年份
	subYY=INDate.substr(0,area)
	if(isNaN(subYY) || subYY<=0){
		return true;
	}		
	//转换月份
	subMM=INDate.substr(area+1,INDate.indexOf(separate,area+1)-(area+1))
	if(isNaN(subMM) || subMM<=0){
		return true;
	}
	if(subMM.length<2){subMM="0"+subMM}
	//转换日
	area=INDate.lastIndexOf(separate)
	subDD=INDate.substr(area+1,INDate.length-area-1)
	if(isNaN(subDD) || subDD<=0){
		return true;
	}
	if(eval(subDD)<10){subDD="0"+eval(subDD)}
	NewDate=subYY+"-"+subMM+"-"+subDD
	if(NewDate.length!=10){return true;}
    if(NewDate.substr(4,1)!="-"){return true;}
    if(NewDate.substr(7,1)!="-"){return true;}
	var MM=NewDate.substr(5,2);
	var DD=NewDate.substr(8,2);
	if((subYY%4==0 && subYY%100!=0)||subYY%400==0){ //判断是否为闰年
		if(parseInt(MM)==2){
			if(DD>29){return true;}
		}
	}else{
		if(parseInt(MM)==2){
			if(DD>28){return true;}
		}	
	}
	var mm=new Array(1,3,5,7,8,10,12); //判断每月中的最大天数
	for(i=0;i< mm.length;i++){
		if (parseInt(MM) == mm[i]){
			if(parseInt(DD)>31){
				return true;
			}else{
				return false;
			}
		}
	}
   if(parseInt(DD)>30){return true;}
   if(parseInt(MM)>12){return true;}
   return false;
   } 


//function isDate(dateString){
//	if(dateString==""){
//		alert("请输入日期");
//		window.location.reload();
//		return;
//		
//	}		
//	if(CheckDate(dateString)){
//		alert("您输入的日期不正确！\n 请注意日期格式（如：2007/07/17或2007-07-17）或闰年！");
//		window.location.reload();
//		return;
//		
//	}
//}
 

//全部选择
$("#cb_all").click(function() {
    $("#MyTable input[name='checkbox']").each(function() {
        $(this).attr("checked", true);
    });
});

//取消选择
$("#cb_cancelAll").click(function() {
    $("#MyTable input[name='checkbox']").each(function() {
        $(this).attr("checked", false);
    });
});

//反向选择
$("#cb_antiAll").click(function() {
    $("input[name='checkbox']").each(function() {
        $(this).attr("checked", !this.checked);
    });
});

}); 

