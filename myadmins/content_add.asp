<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <link href="style/style.css" rel="stylesheet" type="text/css" />
  <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
  <title>后台管理</title>
  <script src="scripts/jquery.min.js"></script>
  <script src="scripts/ord.js" type="text/javascript"></script>
  <script type="text/javascript" charset="utf-8" src="../text_ueditor/ueditor.config.js"></script>
  <script type="text/javascript" charset="utf-8" src="../text_ueditor/ueditor.all.js"> </script>
  <script type="text/javascript" charset="utf-8" src="../text_ueditor/lang/zh-cn/zh-cn.js"></script>
</head>
<body>
  <!--#include file="admin_inc.asp"-->
  <div class="container-fluid">

              <div>
                <form action="?action=add" method="post">
                <div class="form-group">
                  <label for="input-name">名称</label>
                  <div>
                    <input type="text" class="form-control" id="input-name" name="p_name"></div>
                </div>

                <div class="form-group">
                  <label for="input-model">型号</label>
                  <div>
                    <input type="text" class="form-control" id="input-model" name="p_model"></div>
                </div>
                <div class="form-group">
                  <label for="input-type">所属类别</label>
                  <div>
                    <select class="form-control">
                      <option>1</option>
                      <option>2</option>
                      <option>3</option>
                      <option>4</option>
                      <option>5</option>
                    </select>
                  </div>
                </div>

                <div class="form-group">
                  <div>
                    <div class="checkbox">
                      <label>
                        <input type="checkbox" name="isNew">推荐</label>
                    </div>
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
              </div>

            </div>

<script type="text/javascript">
    var ue = UE.getEditor('input-description');
</script>
<!-- 加载编辑器的容器 -->
<textarea id="uploadEditor" style="display: none;"></textarea>
 
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
    }    
  };
</script>
</body>
</html>


<%
dim id : id = getForm("id","get")

dim actType : actType = getForm("acttype","get")
dim updateSql,insertSql
dim p_name:p_name=ReplaceSymbols(getForm("p_name","post")) : if isNul(p_name) then p_name="."
dim p_model:p_model=ReplaceSymbols(getForm("p_model","post"))
dim p_description:p_description=ReplaceSymbols(getForm("p_description","post"))

dim action : action = getForm("action", "get")
if action="add" then
insertSql = "insert into yii_Content(p_name,p_model,p_description) values ('"&p_name&"','"&p_model&"','"&p_description&"')"
conn.db  insertSql,"execute"
end if

%>