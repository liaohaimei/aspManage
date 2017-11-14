<!--#include file="admin_inc.asp"-->

<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
    <!--<![endif]-->
    <!-- BEGIN HEAD -->

    <head>
        <meta charset="utf-8" />
        <title>Metronic | Basic Datatables</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <meta content="" name="description" />
        <meta content="" name="author" />
        <!-- BEGIN GLOBAL MANDATORY STYLES -->
        <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
        <!-- END GLOBAL MANDATORY STYLES -->
        <!-- BEGIN THEME GLOBAL STYLES -->
        <link href="../assets/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
        <link href="../assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME GLOBAL STYLES -->
        <!-- BEGIN THEME LAYOUT STYLES -->
        <link href="../assets/layouts/layout2/css/layout.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/layouts/layout2/css/themes/default.min.css" rel="stylesheet" type="text/css" id="style_color" />
        <link href="../assets/layouts/layout2/css/custom.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME LAYOUT STYLES -->
        <link rel="shortcut icon" href="favicon.ico" /> </head>
    <!-- END HEAD -->

    <body class="page-header-fixed page-sidebar-closed-hide-logo page-container-bg-solid">
        <!-- BEGIN HEADER -->
        
        <!-- END HEADER -->
        <!-- BEGIN HEADER & CONTENT DIVIDER -->
        <div class="clearfix"> </div>
        <!-- END HEADER & CONTENT DIVIDER -->
        <!-- BEGIN CONTAINER -->

        <div class="container-fluid" style="background: #eef1f5;">
        <div class="page-content">
                    <!-- BEGIN PAGE HEADER-->
                    <!-- BEGIN THEME PANEL -->
                    
                    <!-- END THEME PANEL -->
                    <h3 class="page-title"></h3>
                    <div class="page-bar">
                        <ul class="page-breadcrumb">
                            <li>
                                <i class="fa fa-angle-right"></i>
                            </li>
                            <li>
                                <span>栏目添加</span>
                            </li>
                        </ul>
                       </div>
                    <!-- END PAGE HEADER-->
                    <div class="portlet light">
                      <div class="row">
                          <div class="col-md-12">
                              <!-- BEGIN SAMPLE TABLE PORTLET-->
<%
cid=getPar("id")
if cid<>"" then
sql = "select * from {pre}Category where ID = "&cid
set rsObj = dbconn.db(sql,"records1")
if not rsObj.eof then
parent_id=rsObj("parent_id")
n_name=rsObj("n_name")
n_cname=rsObj("n_cname")
n_description=rsObj("n_description")
end if
rsObj.close : set rsObj=nothing
end if
%>
                <form action="?action=<%=getPar("ac")%>&id=<%=getForm("id","get")%>" method="post">
                <div class="form-group">
                  <label for="input-name">名称</label>
                  <div>
                    <input type="text" class="form-control" id="input-name" name="n_name" value="<%=n_name%>"></div>
                </div>

                <div class="form-group">
                  <label for="input-cname">别名</label>
                  <div>
                    <input type="text" class="form-control" id="input-cname" name="n_cname" value="<%=n_cname%>"></div>
                </div>
                <div class="form-group">
                  
                  <label for="input-type">所属栏目</label>
                  <div>
                    <select name="parent_id"  id="input-type" class="form-control">
                      <%
                      pid=getParentId(getPar("id"))
                      cid=getPar("id")
                      ac=getPar("ac")
                      %>
                      <%if ac=0 then%>
                        <option value="<%=cid%>"><%=getName(cid)%></option>
                      <%else%>
                        <%if pid=0 then%><option value="0">顶级</option><%end if%>
                        <%Call SelectList(0,cid,"")%>
                      <%end if%>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label for="input-channel">所属频道</label>
                  <div>
                    <select name="n_type" class="form-control">
                      <option value="1">1</option>
                      <option value="2">2</option>
                      <option value="3">3</option>
                      <option value="4">4</option>
                      <option value="5">5</option>
                    </select>
                  </div>
                </div>

                <div class="form-group">
                    <div class="mt-checkbox-list">
                        <label class="mt-checkbox mt-checkbox-outline"> 推荐
                            <input type="checkbox" value="1" name="isNew">
                            <span></span>
                        </label>
                    </div>
                </div>

                <div class="form-group">
                  <label for="up-img">图片</label>
                  <button type="button" id="j_upload_img_btn" onclick="pfun.imgUpload()">多图上传</button>
                  <ul id="upload_img_wrap"></ul>
                  <label for="up-img">文件</label>
                  <button type="button" id="j_upload_file_btn" onclick="pfun.fileUpload()">附件上传</button>
                  <ul id="upload_file_wrap"></ul>
                </div>

                <div class="form-group">
                  <label for="input-description">描述</label>
                  <div>
                    <script id="input-description" name="p_description" type="text/plain" style="width:100%;height:500px;"></script>
                   
                  </div>
                </div>

                <div class="form-group">
                  <div>
                    <button type="submit" class="btn btn-primary">保存</button>
                  </div>
                </div>
              </form>
                              <!-- END SAMPLE TABLE PORTLET-->
                          </div>
                      </div>
                    </div>

        </div>
        </div>
        <!-- END CONTAINER -->
        <!-- BEGIN FOOTER -->

        <!-- END FOOTER -->
        <!--[if lt IE 9]>
        <script src="../assets/global/plugins/respond.min.js"></script>
        <script src="../assets/global/plugins/excanvas.min.js"></script> 
        <![endif]-->
        <!-- BEGIN CORE PLUGINS -->
        <script src="../assets/global/plugins/jquery.min.js" type="text/javascript"></script>
        <script src="../assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="../assets/global/plugins/js.cookie.min.js" type="text/javascript"></script>
        <script src="../assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
        <script src="../assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
        <script src="../assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
        <script src="../assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
        <!-- END CORE PLUGINS -->
        <!-- BEGIN THEME GLOBAL SCRIPTS -->
        <script src="../assets/global/scripts/app.min.js" type="text/javascript"></script>
        <!-- END THEME GLOBAL SCRIPTS -->
        <!-- BEGIN THEME LAYOUT SCRIPTS -->
        <script src="../assets/layouts/layout2/scripts/layout.min.js" type="text/javascript"></script>
        <script src="../assets/layouts/layout2/scripts/demo.min.js" type="text/javascript"></script>
        <script src="../assets/layouts/global/scripts/quick-sidebar.min.js" type="text/javascript"></script>
        <!-- END THEME LAYOUT SCRIPTS -->


<script src="../assets/layer/layer.js"></script>
<script type="text/javascript" charset="utf-8" src="../assets/text_ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="../assets/text_ueditor/ueditor.all.js"> </script>
<script type="text/javascript" charset="utf-8" src="../assets/text_ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript">
    var ue = UE.getEditor('input-description');
</script>
<!-- 加载编辑器的容器 -->
<!-- <textarea id="uploadEditor" style="display: none;"></textarea> -->
 
<!-- 使用ue -->
<script type="text/javascript">
    // 实例化编辑器，这里注意配置项隐藏编辑器并禁用默认的基础功能。
 var uploadEditor = UE.getEditor("uploadEditor", {
        isShow: false,
        focus: false,
        enableAutoSave: false,
        autoSyncData: false,
        autoFloatEnabled:false,
        wordCount: false,
        sourceEditor: null,
        scaleEnabled:true,
        toolbars: [["insertimage", "attachment"]]
    });
 
    // 监听多图上传和上传附件组件的插入动作
    uploadEditor.ready(function () {
        uploadEditor.addListener("beforeInsertImage", fun._beforeInsertImage);
        uploadEditor.addListener("afterUpfile",fun._afterUpfile);
    });
 
    // 自定义按钮绑定触发多图上传和上传附件对话框事件
  var pfun = {
    imgUpload:function(){
      var dialog = uploadEditor.getDialog("insertimage");
      dialog.title = '多图上传';
      dialog.render();
      dialog.open();
    },
    fileUpload:function(){
      var dialog = uploadEditor.getDialog("attachment");
      dialog.title = '附件上传';
      dialog.render();
      dialog.open();
    }
  };
  var fun = {
    _beforeInsertImage:function(t, result){// 多图上传动作
      var imageHtml = '';
      for(var i in result){
          imageHtml += '<li><img src="'+result[i].src+'" alt="'+result[i].alt+'"></li>';
      }
      $("#upload_img_wrap").html(imageHtml);      
    },
    _afterUpfile:function(t, result){// 附件上传
      var fileHtml = '';
      for(var i in result){
          fileHtml += '<li><a href="'+result[i].url+'" target="_blank">'+result[i].url+'</a></li>';
      }
      $("#upload_file_wrap").html(fileHtml);      
    },
    _alertMes:function(){
      layer.msg('添加成功', {btn: ['继续添加', '退出添加'],no: function(index, layero){},btn2: function(index, layero){window.parent.location.reload();parent.layer.closeAll();}});
    },
    _alertSuccess:function(){
      layer.msg('修改成功',{
        icon: 1,
        time: 2000 //2秒关闭（如果不配置，默认是3秒）
      },function(){window.parent.location.reload();parent.layer.closeAll();});
    }    
  };
</script>
<!--#include file="category_add.asp"-->
</body>
</html>
