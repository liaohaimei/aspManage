// JavaScript Document
 
//修改某参数的名称
function replaceParamVal(oldUrl, paramName, replaceWith) {
    var re = eval('/(' + paramName + '=)([^&]*)/gi');
    var nUrl = oldUrl.replace(re, paramName + '=' + replaceWith);
    return nUrl;
}
//获取地址某参数的值
function hasParameter(name){
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]);
        return null;
}

//给当前参数添加样式
    $(function () {
		var id=$("input[name=id]").val();
		var idd=$("input[name=idd]").val();
		var f_1=$("input[name=f_1]").val();
		var f_2=$("input[name=f_2]").val();
		var f_3=$("input[name=f_3]").val();
		var f_4=$("input[name=f_4]").val();
		$("#s"+id).find("a:first").addClass("current");
		$("#s"+f_1).find("a:first").addClass("current");
		$("#s"+f_2).find("a:first").addClass("current");
		$("#s"+f_3).find("a:first").addClass("current");
		$("#s"+f_4).find("a:first").addClass("current");
				
		
		url=$("#r"+id).attr("href",$(this).attr("href")+"&url=sigecity").html();
		$("span.url").append(url);
    });



$(function() {
$(".nav div.abbox").hover(function()
{

	$(this).parent().find("a").addClass("hover"); }, function() { $(this).parent().find("a").removeClass("hover");
	 });
	
});
