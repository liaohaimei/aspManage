<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<title>批量添加</title>
<script src="scripts/jquery.min.js"></script>
<script src="layer/layer.js"></script>
<link rel="stylesheet" href="../TextEditor/UltraEdit/themes/default/default.css" />
<script charset="utf-8" src="../TextEditor/UltraEdit/kindeditor-min.js"></script>
<script charset="utf-8" src="../TextEditor/UltraEdit/lang/zh_CN.js"></script>
<script src="../TextEditor/UltraEdit/kindeditor.js"></script>
<!--#include file="admin_inc.asp"-->
<style>
#J_imageView .thumbnail{ overflow: hidden;}
</style>
</head>
<body>
<div class="container">
  <%
  cid=getForm("cid","get")
  %>
  <input class="cid" type="hidden" name="cid" value="<%=cid%>">


<div class="form-group">
  <fieldset class="images_box" style="padding:5px 5px 0px 5px;">
    <div class="form-group">
      <label for="names">图片列表</label>
      <div id="J_imageView" class="row"> </div>
    </div>
  </fieldset>

  <input type="button" class="btn btn-default" id="J_selectImage" value="批量上传" />
  <script>
      KindEditor.ready(function(K) {
          var editor = K.editor({
            uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
            fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
              allowFileManager : true
          });
          K('#J_selectImage').click(function() {
              editor.loadPlugin('multiimage', function() {
                  editor.plugin.multiImageDialog({
                      clickFn : function(urlList) {
                          var div = K('#J_imageView');
                          var imgs=$(".imgs");
                          var names=$(".names");
                          K.each(urlList, function(i, data) {
                            div.append('<div class="col-xs-2 col-md-1"><a href="javascript:void(0)" class="thumbnail"><img  src="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '"/><input type="hidden"  name="m_p_img"  value="' + data.url.replace('/TextEditor/UltraEdit/asp/../../..', '') + '"/></a></div>');
                                  imgs.append(data.url.replace('/TextEditor/UltraEdit/asp/../../..', '')+'\n');
                                  names.append('图片名称'+(i+1)+'\n');


                          });
                           changeImgH($("#J_imageView .thumbnail"));
                          editor.hideDialog();
                      }
                  });
              });
          });
      });
  </script>
  <input type="button" class="btn btn-default" id="imagesv" value="网络图片+本地图片" />
  <script>
      KindEditor.ready(function(K) {
          var editor = K.editor({
            uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
            fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
              allowFileManager : true
          });
          K('#imagesv').click(function() {
              editor.loadPlugin('image', function() {
                  editor.plugin.imageDialog({
                      imageUrl : K('#m_p_img').val(),
                      clickFn : function(url, title, width, height, border, align) {
                        var div = K('#J_imageView');
                        var imgs=$(".imgs");
                        var names=$(".names");
                        div.append('<div class="col-xs-2 col-md-1"><a href="javascript:void(0)" class="thumbnail"><img src="' + url + '"/><input type="hidden"  name="m_p_img"  value="' + url + '"/></a></div>');
                       imgs.append(url.replace('/TextEditor/UltraEdit/asp/../../..', '')+'\n');
                       names.append('图片名称'+'\n');

                       changeImgH($("#J_imageView .thumbnail"));
                       editor.hideDialog();

                      }
                  });
              });
          });
      });
  </script>
</div>



<div class="form-group">
  <label for="names">图片名称　　<span class="label label-danger">注：每一个路径独占一行，必须与图片路径个数一致</span></label>
  <textarea class="names form-control" name="names" rows="5" placeholder="名称"></textarea>
</div>
  <div class="form-group">
    <label for="imgs">图片路径　　<span class="label label-danger">注：每一个路径独占一行，必须与名称个数一致</span></label>
    <textarea class="imgs form-control" name="imgs" rows="5" placeholder="图片路径"></textarea>
  </div>


<div class="form-group">
    <button type="button" class="btn btn-danger tj">保　存</button>
</div>

</div>

  <script>
    $(function(){
      $(".tj").on("click",function(){
        var cid = $(".cid").val();
        var names = $(".names").val();
        var imgs = $(".imgs").val();
        var arr=names.split("\n");
        var arrimg=imgs.split("\n");
        var arrLength = arr.length;

        if(arr[arrLength-1]==""){
          arrLength--;
        }
        var n=0;
        for(var i=0; i<arrLength;i++){
          ajaxAdd(cid,arr[i],arrimg[i]);
          n=i;
        }
        if(n==arrLength-1){
          parent.layer.msg('<span style="color:#FFF;">添加成功</span>');
          setTimeout(function(){
            closeParentiframe();
            parent.location.reload();
          },5000);


        }

      });


    })

    //关闭父级ifram
    function closeParentiframe(){
      parent.layer.closeAll();
    }
    //ajax添加数据
    function ajaxAdd(cid,name1,img){
      $.ajax({
               type: "GET",
               url: "batchAjax.asp",
               data: {cid:cid, p_name: name1, p_img:img },
               success: function (data) {
                  console.log(data);

               }
     });

    }

      $(function () {
           //改变列表元素高度
           changeImgH($("#J_imageView .thumbnail"));
       });
       //窗口改变时大小改变列表元素高度
       $(window).on("resize", function () {
           changeImgH($("#J_imageView .thumbnail"));
       });


    //改变列表高度
    function changeImgH(that){
      var imgW = that.width();
      that.height(imgW);
    }
  </script>
  <style>
.textarea-wrap{ border-radius: 5px 0 5px 0; margin-left: -1px; height: 115px !important;}
  </style>
  <script src="scripts/auto-line-number.js"></script>
  <script>
  	$(".form-control").setTextareaCount({
  		width: "30px",
  		bgColor: "#F3F3F3",
  		color: "#333",
  		display: "inline-block"
  	});
  </script>
</body>
</html>
