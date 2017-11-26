<!--#include file="../../admin_inc.asp"-->
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>后台管理系统</title>
    <link rel="stylesheet" href="../../layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="//at.alicdn.com/t/font_tnyc012u2rlwstt9.css" media="all" />
    <link rel="stylesheet" href="../../css/news.css" media="all" />
</head>
<body>

<div class="layui-fluid">
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>栏目添加</legend>
</fieldset>

<%
pid=getParentId(getPar("id")) '父级ID
cid=getPar("id")              '当前ID
ac=getPar("ac")               '修改状态
if cid<>"" and ac<>0 then
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
<form class="layui-form"  action="?action=<%=getPar("ac")%>&id=<%=getForm("id","get")%>" method="post">
  <div class="layui-form-item">
    <label class="layui-form-label">名称</label>
    <div class="layui-input-block">
      <input type="text" autocomplete="off"  class="layui-input" id="input-name" name="n_name" value="<%=n_name%>" placeholder="名称">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">别名</label>
    <div class="layui-input-block">
      <input type="text" autocomplete="off"  class="layui-input"  id="input-cname" name="n_cname" value="<%=n_cname%>" placeholder="别名">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">所属栏目</label>
    <div class="layui-input-block">
      <select  name="parent_id"  id="input-type">
        <%if ac=0 then%>
          <option value="<%=cid%>"><%=getName(cid)%></option>
        <%else%>
          <%if pid=0 then%><option value="0">顶级</option><%end if%>
          <%Call SelectList(0,cid,"")%>
        <%end if%>
      </select>
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">所属频道</label>
    <div class="layui-input-block">
      <select  name="n_type">
       <option value="1">1</option>
       <option value="2">2</option>
       <option value="3">3</option>
       <option value="4">4</option>
       <option value="5">5</option>
      </select>
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label" for="up-img">图片</label>
    <button type="button" class="layui-btn layui-btn-danger" onclick="pfun.imgUpload()"><i class="layui-icon"></i>上传图片</button>
    <blockquote class="layui-elem-quote layui-quote-nm">
    <ul id="upload_img_wrap"></ul>
    </blockquote>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label" for="up-file">文件</label>
    <button type="button" class="layui-btn" onclick="pfun.fileUpload()"><i class="layui-icon"></i>上传文件</button>
    <blockquote class="layui-elem-quote layui-quote-nm">
    <ul id="upload_file_wrap"></ul>
    </blockquote>
  </div>


  <div class="layui-form-item layui-form-text">
    <label class="layui-form-label">描述</label>
    <div class="layui-input-block">
      <script id="input-description" name="p_description" type="text/plain" style="width:100%;height:500px; position: relative; z-index: 0"></script>
    </div>
  </div>


  <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" type="submit">立即提交</button>
      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
    </div>
  </div>
</form>
</div>

<script src="../../../assets/scripts/jquery.min.js" type="text/javascript"></script>
<script src="../../../assets/layer/layer.js"></script>
<script type="text/javascript" src="../../layui/layui.js"></script>
<script type="text/javascript" charset="utf-8" src="../../../assets/text_ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="../../../assets/text_ueditor/ueditor.all.js"> </script>
<script type="text/javascript" charset="utf-8" src="../../../assets/text_ueditor/lang/zh-cn/zh-cn.js"></script>
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
<script>
layui.use(['form', 'layedit', 'laydate'], function(){
  var form = layui.form
  ,layer = layui.layer
  ,layedit = layui.layedit
  ,laydate = layui.laydate;
  
  //日期
  laydate.render({
    elem: '#date'
  });
  laydate.render({
    elem: '#date1'
  });
  
  //创建一个编辑器
  var editIndex = layedit.build('LAY_demo_editor');
 
  
  
});
</script>

<!--#include file="category_add.asp"-->
</body>
</html>
