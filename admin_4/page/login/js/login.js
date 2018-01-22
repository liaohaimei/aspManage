layui.config({
	base : "js/"
}).use(['form','layer'],function(){
	var form = layui.form(),
		layer = parent.layer === undefined ? layui.layer : parent.layer,
		$ = layui.jquery;
	//video背景
	$(window).resize(function(){
		if($(".video-player").width() > $(window).width()){
			$(".video-player").css({"height":$(window).height(),"width":"auto","left":-($(".video-player").width()-$(window).width())/2});
		}else{
			$(".video-player").css({"width":$(window).width(),"height":"auto","left":-($(".video-player").width()-$(window).width())/2});
		}
	}).resize();
	
	//登录按钮事件
	form.on("submit(login)",function(data){
		var username = data.field.username;
		var password = data.field.password;
		var code = data.field.code;
		//加载页面数据
		var url = "data/json_data.asp"  
		var relations = {  
		    sql_class: "wspcms_admin", //表名  
		    sql_top: "",  //取数据总条数 top 10  
		    sql_colums: "id,username,email,status", //列名，用","隔开，如果全部获取，则填写"*"   
		    sql_whereBy: "and username='"+username+"' and password='"+password+"'",  
		    sql_orderBy: "order by id asc"  
		}
		var Datas = '';
		$.post(url,relations, function(data){
			data=JSON.parse(data);
			Datas = data.rows;
			console.log(Datas);
			
		})
		console.log(username);
		console.log(password);
		console.log(code);
		//window.location.href = "../../index.html";
		return false;
	})
})
