<script type="text/javascript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>


<script type="text/javascript">
//添加到收藏夹   
function AddToFavorite()   
{   
    if (document.all){   
       window.external.addFavorite(document.URL,document.title);   
    }else if (window.sidebar){   
       window.sidebar.addPanel(document.title, document.URL, "");   
    }   
}   

//设为首页   
function setHomepage(){   
    if (document.all){   
    document.body.style.behavior='url(#default#homepage)';   
    document.body.setHomePage(document.URL);   
}else if (window.sidebar){   
        if(window.netscape){   
       try{    
          netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");    
       }catch (e){    
                    alert( "该操作被浏览器拒绝，如果想启用该功能，请在地址栏内输入 about:config,然后将项 signed.applets.codebase_principal_support 值该为true" );    
       }   
        }    
    var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components. interfaces.nsIPrefBranch);   
    prefs.setCharPref('browser.startup.homepage',document.URL);   
    }   
} 
//添加到收藏夹
function AddToFavorite()
{
    if (document.all){
       window.external.addFavorite(document.URL,document.title);
    }else if (window.sidebar){
       window.sidebar.addPanel(document.title, document.URL, "");
    }
}

//设为首页
function setHomepage(){
if (document.all){
    document.body.style.behavior='url(#default#homepage)';
    document.body.setHomePage(document.URL);
}else if (window.sidebar){
   if(window.netscape){
       try{ 
          netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect"); 
       }catch (e){ 
       alert( "该操作被浏览器拒绝，如果想启用该功能，请在地址栏内输入 about:config,然后将项 signed.applets.codebase_principal_support 值该为true" ); 
       }
   } 
    var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components. interfaces.nsIPrefBranch);
    prefs.setCharPref('browser.startup.homepage',document.URL);
}
}
</script>