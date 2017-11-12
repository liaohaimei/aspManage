function orderChange(el,id){
	var val = $(el).val();
	$.ajax({
	url:"ordermod.asp",
	data: { oid: id,orderval:val },
		success: function (data) {
			$(el).val(val);
			$(el).next(".status").html("修改成功").css({color:"green"});
		},
		error: function(){
			$(el).next(".status").html("修改失败").css({color:"red"});
			}
	});
	}

function navNameChange(el,id){
	var val = $(el).val();
	
	$.ajax({
	url:"navnamemod.asp",
	data: { oid: id,navname:val },
		success: function (data) {
			$(el).val(val);
			$(el).next(".status").html("修改成功").css({color:"green"});
		},
		error: function(){
			$(el).next(".status").html("修改失败").css({color:"red"});
			}
	});
	}

function navOrdChange(el,id){
	var val = $(el).val();
	
	$.ajax({
	url:"navordmod.asp",
	data: { oid: id,navord:val },
		success: function (data) {
			$(el).val(val);
			$(el).next(".status").html("√").css({color:"green"});
		},
		error: function(){
			$(el).next(".status").html("×").css({color:"red"});
			}
	});
	}
