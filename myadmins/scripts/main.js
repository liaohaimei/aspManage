var ajax = new AJAX();
ajax.setcharset("GBK");
//�����Զ����ǩ����
function openSelfLabelWin(divid,id){
	$(divid).style.display="block";
	selfLabelWindefault(divid);	
	set($("labelcontent"),"���������...");	
	ajax.get(
		"admin_ajax.asp?id="+id+"&action=getselflabel", 
		function(obj) {
			if(obj.responseText == "err"){
				set($("labelcontent"),"��������");	
			}else{
				set($("labelcontent"),obj.responseText);
			}
		}
	);
}

function selfLabelWindefault(divid){	
	$(divid).style.left=(document.documentElement.clientWidth-568)/2+"px"
	$(divid).style.top=(getScroll()+60)+"px"
}
//���ñ�ǩ
function viewCurrentAdTr(id){
	var adtrObj=getElementsByName("tr","adtr")
	var n=adtrObj.length
	for (var i=0;i<=n-1;i++){
		adtrObj[i].className="";
	}
	$("adtr"+id).className="editlast";
}
//������Ա
function isExistUsername(id){
	var username=$("UserName").value
	if (username.length == 0){
		set($("checkmanagername"),"����Ա���Ʋ���Ϊ��");
		return false; 
	}
	ajax.get(
		"admin_ajax.asp?username="+username+"&action=checkuser&id="+id, 
		function(obj) {
			var value = obj.responseText
			if(value == "no"){
				set($("checkmanagername"),"��������");	
			}else{
				if (value == "1")
					set($("checkmanagername"),"�Ѿ����ڴ˹���Ա�����������");	
				else if (value == "0")
					set($("checkmanagername"),"��ϲ�����û�����");	
			}
		}
	);
}
//�����Ϣ�����Ƿ��ظ�
function checkAboutTitle(){
	ajax.get(
		"admin_ajax.asp?action=checkAboutTitle&m_name="+$('m_name').value,
		function(obj){
			if (obj.responseText == "ok"){set($("m_name_ok"),"<img src='images/yes.gif' border=0></img>");}else{set($("m_name_ok"),"<img src='images/no.gif' border=0></img>");}
		}
	);	
}

//������ű����Ƿ��ظ�
function checkNewsTitle(){
	ajax.get(
		"admin_ajax.asp?action=checkNewsTitle&m_name="+$('m_name').value,
		function(obj){
			if (obj.responseText == "ok"){set($("m_name_ok"),"<img src='images/yes.gif' border=0></img>");}else{set($("m_name_ok"),"<img src='images/no.gif' border=0></img>");}
		}
	);	
}

//���ͼƬ�����Ƿ��ظ�
function checkPhotoTitle(){
	ajax.get(
		"admin_ajax.asp?action=checkPhotoTitle&m_name="+$('m_name').value,
		function(obj){
			if (obj.responseText == "ok"){set($("m_name_ok"),"<img src='images/yes.gif' border=0></img>");}else{set($("m_name_ok"),"<img src='images/no.gif' border=0></img>");}
		}
	);	
}

//��ⰸ�������Ƿ��ظ�
function checkCaseTitle(){
	ajax.get(
		"admin_ajax.asp?action=checkCaseTitle&m_name="+$('m_name').value,
		function(obj){
			if (obj.responseText == "ok"){set($("m_name_ok"),"<img src='images/yes.gif' border=0></img>");}else{set($("m_name_ok"),"<img src='images/no.gif' border=0></img>");}
		}
	);	
}

//������ر����Ƿ��ظ�
function checkDownTitle(){
	ajax.get(
		"admin_ajax.asp?action=checkDownTitle&m_name="+$('m_name').value,
		function(obj){
			if (obj.responseText == "ok"){set($("m_name_ok"),"<img src='images/yes.gif' border=0></img>");}else{set($("m_name_ok"),"<img src='images/no.gif' border=0></img>");}
		}
	);	
}

//����Ʒ�����Ƿ��ظ�
function checkProductTitle(){
	ajax.get(
		"admin_ajax.asp?action=checkProductTitle&m_name="+$('m_name').value,
		function(obj){
			if (obj.responseText == "ok"){set($("m_name_ok"),"<img src='images/yes.gif' border=0></img>");}else{set($("m_name_ok"),"<img src='images/no.gif' border=0></img>");}
		}
	);	
}

//�����Ŀ
function cheak_colume(value){
	if (value!=0){
		$("WebType").attr("disabled",true);
	}
	else{
		$("WebType").attr("disabled",false);
	}
}

function selectPicLink(selectObj,str){
	var selectValue=selectObj.options[selectObj.selectedIndex].value
	if 	(selectValue==str)
		$("tr_m_pic").style.display=""
	else 
		$("tr_m_pic").style.display="none"
}

function htmlToJs(htmlinput,jsinput){
	$(jsinput).value="document.writeln(\""+$(htmlinput).value.replace(/\\/g,"\\\\").replace(/\//g,"\\/").replace(/\'/g,"\\\'").replace(/\"/g,"\\\"").split('\r\n').join("\");\ndocument.writeln(\"")+"\")"
} 

function jstohtml(jsinput,htmlinput){
	$(htmlinput).value=$(jsinput).value.replace(/document.writeln\("/g,"").replace(/document.write\("/g,"").replace(/"\);/g,"").replace(/\\\"/g,"\"").replace(/\\\'/g,"\'").replace(/\\\//g,"\/").replace(/\\\\/g,"\\").replace(/document.writeln\('/g,"").replace(/"\)/g,"").replace(/'\);/g,"").replace(/'\)/g,"")
}

function openAdWin(divid,path,url){
	$(divid).style.display="block";
	selfLabelWindefault(divid);	
	$("adpath").value='<script type=\"text/javascript\" language=\"javascript" src=\"'+url+path.replace("../","")+'\"></script>';	
}

function openHtmlToJsWin(divid){
	$(divid).style.display="block";
	selfLabelWindefault(divid);	
}

function insertHtmlToJsWin(divid,divid2,divid3){
	hide(divid);
	$(divid2).value=$(divid3).value
}

function selectWaterMark(value){
	if (value==1){view("size1");view("size2");view("size3");view("size4");view("size5");}
	if (value==0){hide("size1");hide("size2");hide("size3");hide("size4");hide("size5");}
}

function selectDataBase(value){
	if (value==0){view("acc");for (var i=1;i<=4;i++){hide("mssql"+i);}}
	if (value==1){hide("acc");for (var i=1;i<=4;i++){view("mssql"+i);}}
}

function selecRunMode(value){
	if (value=='dynamic'){hide("static");view("dynamic");hide('ismakeplaytr');}
	if (value=='static'){view("static");hide("dynamic");view('ismakeplaytr');}
}