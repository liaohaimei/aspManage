jQuery.cookie = function(name, value, options) {
    if (typeof value != 'undefined') { // name and value given, set cookie
        options = options || {};
        if (value === null) {
            value = '';
            options.expires = -1;
        }
        var expires = '';
        if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
            var date;
            if (typeof options.expires == 'number') {
                date = new Date();
                date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
            } else {
                date = options.expires;
            }
            expires = '; expires=' + date.toUTCString(); // use expires attribute, max-age is not supported by IE
        }
        // CAUTION: Needed to parenthesize options.path and options.domain
        // in the following expressions, otherwise they evaluate to undefined
        // in the packed version for some reason...
        var path = options.path ? '; path=' + (options.path) : '';
        var domain = options.domain ? '; domain=' + (options.domain) : '';
        var secure = options.secure ? '; secure' : '';
        document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
    } else { // only name given, get cookie
        var cookieValue = null;
        if (document.cookie && document.cookie != '') {
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = jQuery.trim(cookies[i]);
                // Does this cookie string begin with the name we want?
                if (cookie.substring(0, name.length + 1) == (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
};
function getElementsByName(tag,name){
    var rtArr=new Array();
    var el=document.getElementsByTagName(tag);
    for(var i=0;i<el.length;i++){
        if(el[i].name==name)
              rtArr.push(el[i]);
    }
    return rtArr;
}
function checkAll(bool,tagname,name)
{
	var checkboxArray;checkboxArray=getElementsByName(tagname,name)
	for (var i=0;i<checkboxArray.length;i++){checkboxArray[i].checked = bool;}
}
function ChangeMenu(way){
	if(way == 1){
		if($('#left_nav').css('display') != 'none'){
			$('#left_nav').css('width','30%');
			$('#right_content').css('width','70%');
			$.cookie('way',1);
		}
	}else if(way == 0){
		if($('#left_nav').css('display') != 'none'){
		    $('#left_nav').css('display','none');
		    $('#main_content').animate({'marginLeft':'0px'},600);
		    $('#right_content').animate({'width':'100%'},600);
		    $('#switch').html('打开菜单');
			//$('#left_nav').css('display','none');
			//$('#main_content').css('marginLeft','0px');
			//$('#right_content').css('width','100%');
			$.cookie('way',0);
		}else{
			$('#left_nav').css('display','');
			$('#main_content').css('marginLeft','12px');
			$('#left_nav').css('width','20%');
			$('#right_content').css('width','80%');
			$('#switch').html('关闭菜单');
			$.cookie('way',2);
		}
	}
}
$(document).ready(function(){
	ChangeMenu($.cookie('way'));
});

function addsave(){
	if(document.getElementById('m_name').value.length==0){
		alert('请填写标题');
		document.getElementById('m_name').focus();
	}else if(
	document.getElementById('m_type').value.length==0){
		alert('请选择分类');
	}else{
		editor.sync();
		editor1.sync();
		editor2.sync();

		document.getElementsByName('addform')[0].submit();
	};
}

function addsave2(){
	if(document.getElementById('m_name').value.length==0){
		alert('请填写标题');
		document.getElementById('m_name').focus();
	}else if(
	document.getElementById('m_type').value.length==0){
		alert('请选择分类');
	}else{
		//editor.sync();
		//editor1.sync();
		//editor2.sync();

		document.getElementsByName('addform')[0].submit();
	};
}


function infosave(){
	if(document.getElementById('m_name').value.length==0){
		alert('请填写标题');
		document.getElementById('m_name').focus();
	}else{
		editor.sync();
		editor1.sync();
		editor2.sync();
		document.getElementsByName('addform')[0].submit();
	};
}

function info(){
	if(document.getElementById('m_name').value.length==0){
		alert('请填写标题');
		document.getElementById('m_name').focus();
	}else{
		document.getElementsByName('addform')[0].submit();
	};
}

function add(){
	if(document.getElementById('m_name').value.length==0){
		alert('请填写标题');
		document.getElementById('m_name').focus();
	}else if(
	document.getElementById('m_type').value.length==0){
		alert('请选择分类');
	}else{
		document.getElementsByName('addform')[0].submit();
	};
}


function usersave(){
	if(document.addform.Email.value.length==0)
	{
		alert('请填写E-amil');
		document.addform.Email.focus();
	}else if(document.addform.UserName.value.length==0){
		alert('请填写用户名');
		document.addform.UserName.focus();
	}else{
		document.addform.submit();
	}
}

function ColumnsAdd(){
		editor.sync();
		editor1.sync();
		editor2.sync();
		document.getElementsByName('addform')[0].submit();
	
	}

function ColumnsEdit(){
		editor.sync();
		editor1.sync();
		editor2.sync();
		document.getElementsByName('editform')[0].submit();
	
	}