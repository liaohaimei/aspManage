layui.config({
	//base : "js/"
}).use(['form','layer','jquery','laypage'],function(){
	var form = layui.form(),
		layer = parent.layer === undefined ? layui.layer : parent.layer,
		laypage = layui.laypage,
		$ = layui.jquery;

	//加载页面数据
	var url = "data/index_json.asp"  
	var relations = {  
	    sql_class: "wspcms_admin", //表名  
	    sql_top: "",  //取数据总条数 top 10  
	    sql_colums: "id,username,email,status", //列名，用","隔开，如果全部获取，则填写"*"   
	    sql_whereBy: "",  
	    sql_orderBy: "order by id asc"  
	}
	var Datas = '';
	$.post(url,relations, function(data){
		data=JSON.parse(data);
		Datas = data.rows;
		if(window.sessionStorage.getItem("susername")){
			var susername = window.sessionStorage.getItem("susername");
			Datas = JSON.parse(susername).concat(Datas);
		}
		//执行加载数据的方法
		usersList();
	})

	//查询
	$(".search_btn").click(function(){
		var userArray = [];
		if($(".search_input").val() != ''){
			var index = layer.msg('查询中，请稍候',{icon: 16,time:false,shade:0.8});
            setTimeout(function(){
            	$.ajax({
					url : url,
					type : "post",
					data : relations,
					dataType : "json",
					success : function(data){
						if(window.sessionStorage.getItem("susername")){
							var susername = window.sessionStorage.getItem("susername");
							Datas = JSON.parse(susername).concat(data);
						}else{
							Datas = data.rows;
						}
						for(var i=0;i<Datas.length;i++){
							var usersStr = Datas[i];
							var selectStr = $(".search_input").val();
		            		function changeStr(data){
		            			var dataStr = '';
		            			var showNum = data.split(eval("/"+selectStr+"/ig")).length - 1;
		            			if(showNum > 1){
									for (var j=0;j<showNum;j++) {
		            					dataStr += data.split(eval("/"+selectStr+"/ig"))[j] + "<i style='color:#03c339;font-weight:bold;'>" + selectStr + "</i>";
		            				}
		            				dataStr += data.split(eval("/"+selectStr+"/ig"))[showNum];
		            				return dataStr;
		            			}else{
		            				dataStr = data.split(eval("/"+selectStr+"/ig"))[0] + "<i style='color:#03c339;font-weight:bold;'>" + selectStr + "</i>" + data.split(eval("/"+selectStr+"/ig"))[1];
		            				return dataStr;
		            			}
		            		}
		            		//用户名
		            		if(usersStr.username.indexOf(selectStr) > -1){
			            		usersStr["username"] = changeStr(usersStr.username);
		            		}
		            		//用户邮箱
		            		if(usersStr.email.indexOf(selectStr) > -1){
			            		usersStr["email"] = changeStr(usersStr.email);
		            		}
		            		/*//性别
		            		if(usersStr.userSex.indexOf(selectStr) > -1){
			            		usersStr["userSex"] = changeStr(usersStr.userSex);
		            		}
		            		*/
		            		if(usersStr.username.indexOf(selectStr)>-1 || usersStr.email.indexOf(selectStr)>-1 ){
		            			userArray.push(usersStr);
		            		}
		            	}
		            	Datas = userArray;
		            	usersList(Datas);
					}
				})
            	
                layer.close(index);
            },2000);
		}else{
			layer.msg("请输入需要查询的内容");
		}
	})


	//批量删除
	$(".batchDel").click(function(){
		var $checkbox = $('.users_list tbody input[type="checkbox"][name="id"]');
		var $checked = $('.users_list tbody input[type="checkbox"][name="id"]:checked');
		if($checkbox.is(":checked")){
			layer.confirm('确定删除选中的信息？',{icon:3, title:'提示信息'},function(index){
				var index = layer.msg('删除中，请稍候',{icon: 16,time:false,shade:0.8});
	            setTimeout(function(){
	            	//删除数据
	            	for(var j=0;j<$checked.length;j++){
	            		for(var i=0;i<Datas.length;i++){
							if(Datas[i].id == $checked.eq(j).parents("tr").attr("data-id")){
	            			var url = "delete.asp",
    							id = Datas[i].id,
    						    par = {delid:id};
    						    $.ajax({
    						      url : url,
    						      data : par,
    						      type : "GET",
    						      success : function(data){
    						        if(data==1){
    						        	layer.msg('删除成功',{
    						        	icon: 1,
    						        	time: 1000 //2秒关闭（如果不配置，默认是3秒）
    						        	});
    						        }else{
    						        	layer.msg('删除失败',{
    						        	icon: 2,
    						        	time: 1000 //2秒关闭（如果不配置，默认是3秒）
    						        	});	
    						        }
    						      }    
    						    });
								Datas.splice(i,1);
								usersList(Datas);
							}
						}
	            	}
	            	$('.users_list thead input[type="checkbox"]').prop("checked",false);
	            	form.render();
	                layer.close(index);
					layer.msg("删除成功");
	            },2000);
	        })
		}else{
			layer.msg("请选择需要删除的文章");
		}
	})

    //全选
	form.on('checkbox(allChoose)', function(data){
		var child = $(data.elem).parents('table').find('tbody input[type="checkbox"]:not([name="status"])');
		child.each(function(index, item){
			item.checked = data.elem.checked;
		});
		form.render('checkbox');
	});

	//通过判断文章是否全部选中来确定全选按钮是否选中
	form.on("checkbox(choose)",function(data){
		var child = $(data.elem).parents('table').find('tbody input[type="checkbox"]:not([name="show"])');
		var childChecked = $(data.elem).parents('table').find('tbody input[type="checkbox"]:not([name="show"]):checked')
		if(childChecked.length == child.length){
			$(data.elem).parents('table').find('thead input#allChoose').get(0).checked = true;
		}else{
			$(data.elem).parents('table').find('thead input#allChoose').get(0).checked = false;
		}
		form.render('checkbox');
	})

	//操作

	$("body").on("click",".del-data",function(){  //删除
		var _this = $(this);
		layer.confirm('确定删除此用户？',{icon:3, title:'提示信息'},function(index){

			var url = "delete.asp",
				id =_this.attr("data-id"),
			    par = {delid:id};
			    $.ajax({
			      url : url,
			      data : par,
			      type : "GET",
			      success : function(data){
			        if(data==1){
			        	layer.msg('删除成功',{
			        	icon: 1,
			        	time: 2000 //2秒关闭（如果不配置，默认是3秒）
			        	});
			        }else{
			        	layer.msg('删除失败',{
			        	icon: 2,
			        	time: 2000 //2秒关闭（如果不配置，默认是3秒）
			        	});	
			        }
			      }    
			    });
			_this.parents("tr").remove();
			for(var i=0;i<Datas.length;i++){
				if(Datas[i].id == _this.attr("data-id")){
					Datas.splice(i,1);
					usersList(Datas);
				}
			}
			layer.close(index);
		});
	})

	 //监听指定开关
	  form.on('switch(isShow)', function(data){
	  	var val = this.checked ? 1 : 0;
	    var url = "ajax/updateadminstatus.asp",
			id = $(this).parents("tr").attr("data-id"),
		    par = {updateid:id,str:val};
		    $.ajax({
		      url : url,
		      data : par,
		      type : "GET",
		      success : function(data){
		        if(data==1){
		        	layer.msg('修改成功',{
		        	icon: 1,
		        	time: 1000 //2秒关闭（如果不配置，默认是3秒）
		        	});
		        }else{
		        	layer.msg('修改失败',{
		        	icon: 2,
		        	time: 1000 //2秒关闭（如果不配置，默认是3秒）
		        	});	
		        }
		      }    
		    });
	    //layer.tips('温馨提示：启用/禁用当前用户', data.othis)
	  });

	function usersList(){

		//渲染数据
		function renderDate(data,curr){
			var dataHtml = '';
			currData = Datas.concat().splice(curr*nums-nums, nums);
			if(currData.length != 0){
				for(var i=0;i<currData.length;i++){
					var id 			=	currData[i].id,
						username	= 	currData[i].username,
						email  		= 	currData[i].email,
						status		= 	Boolean(currData[i].status)?status="checked":status="";
					dataHtml += '<tr data-id="'+id+'">'
			    	+  '<td><input type="checkbox" value="'+id+'" name="id" lay-skin="primary" lay-filter="choose"></td>'
			    	+  '<td class="text-left">'+username+'</td>'
			    	+  '<td class="text-left">'+email+'</td>'
			    	+  '<td>'+currData[i].userSex+'</td>'
			    	+  '<td>'+currData[i].userGrade+'</td>'
			    	+  '<td><input type="checkbox" name="status" lay-skin="switch" lay-text="启用|禁用" lay-filter="isShow"'+status+'></td>'
			    	+  '<td>'+currData[i].userEndTime+'</td>'
			    	+  '<td>'
					+    '<a class="layui-btn layui-btn-primary layui-btn-mini users_edit" onclick="fun.popView('+id+')"><i class="iconfont icon-edit"></i> 查看</a>'
					+    '<a class="layui-btn layui-btn-mini users_edit" onclick="fun.popUpdate('+id+')"><i class="iconfont icon-edit"></i> 编辑</a>'
					+    '<a class="layui-btn layui-btn-danger layui-btn-mini del-data" data-id="'+id+'"><i class="layui-icon">&#xe640;</i> 删除</a>'
			        +  '</td>'
			    	+'</tr>';
				}
			}else{
				dataHtml = '<tr><td colspan="8">暂无数据</td></tr>';
			}
		    return dataHtml;
		}

		//分页
		var nums = 10; //每页出现的数据量
		laypage({
			cont : "page",
			pages : Math.ceil(Datas.length/nums),
			skip: true,
			jump : function(obj){
				$(".users_content").html(renderDate(Datas,obj.curr));
				$('.users_list thead input[type="checkbox"]').prop("checked",false);
		    	form.render();
			}
		})
	}



        
})

var fun = {
    	popView:function(id){//添加
    	var index = layui.layer.open({
			title : "分配",
			type : 2,
			content : "view.asp?id="+id+"",
			success : function(layero, index){
				setTimeout(function(){
					layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
						tips: 3
					});
				},500)
			}
		})
		//改变窗口大小时，重置弹窗的高度，防止超出可视区域（如F12调出debug的操作）
		$(window).resize(function(){
			layui.layer.full(index);
		})
		layui.layer.full(index);
      	},
    	popCreate:function(){//添加
    	var index = layui.layer.open({
			title : "创建角色",
			type : 2,
			content : "create.asp",
			success : function(layero, index){
				setTimeout(function(){
					layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
						tips: 3
					});
				},500)
			}
		})
		//改变窗口大小时，重置弹窗的高度，防止超出可视区域（如F12调出debug的操作）
		$(window).resize(function(){
			layui.layer.full(index);
		})
		layui.layer.full(index);
      	},
      	popUpdate:function(id){//添加
    	var index = layui.layer.open({
			title : "更新角色",
			type : 2,
			content : "update.asp?id="+id+"",
			success : function(layero, index){
				setTimeout(function(){
					layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
						tips: 3
					});
				},500)
			}
		})
		//改变窗口大小时，重置弹窗的高度，防止超出可视区域（如F12调出debug的操作）
		$(window).resize(function(){
			layui.layer.full(index);
		})
		layui.layer.full(index);
      	},
      	updateStatus:function(el,id){//删除当前一条数据
      		var _this = $(el);
      		console.log(_this.val());
      		
      	},
      	_alertMes:function(){//添加成功
	      	layer.msg('添加成功', {
	      	  	btn: ['继续添加', '退出添加'],
	      	  	yes: function(index, layero){
	      	  		history.go(-1);
	      	  	},
	      	  	btn2: function(index, layero){
	      	  		window.parent.location.reload();
	      	  		parent.layer.closeAll();
	      	  	}
	      	},function(){window.parent.location.reload();parent.layer.closeAll();});
      	},
      	_alertSuccess:function(){//修改成功
			layer.msg('修改成功',{
				icon: 1,
				time: 2000 //2秒关闭（如果不配置，默认是3秒）
			},function(){window.parent.location.reload();parent.layer.closeAll();});
      	},
      	_alertFail:function(){//修改成功
			layer.msg('操作失败',{
				icon: 2,
				time: 2000 //2秒关闭（如果不配置，默认是3秒）
			},function(){window.parent.location.reload();parent.layer.closeAll();});
      	}

}