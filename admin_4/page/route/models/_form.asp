<input type="hidden" id="updateid" value="<%=id%>">
<div class="layui-layout-admin site-demo">
  <div class="layui-main">
    <form class="layui-form"  action="models/model.asp?action=<%=typ%>&id=<%=id%>" method="post">
      <div class="layui-form-item">
        <label class="layui-form-label">新路由</label>
        <div class="layui-input-block">
          <input id="inp-route" name="name" value="<%=name%>" type="text" class="layui-input" placeholder="新路由">
        </div>
      </div>
      <div class="layui-form-item">
        <div class="layui-input-block">
          <button class="layui-btn"><%=btnName%></button>
        </div>
      </div>
    </form>
    <form   action="models/model.asp?action=<%=typ%>&id=<%=id%>" method="post">
      <div class="content">
        <select multiple="multiple" id="select1" style="width:calc(50% - 25px); height:200px; float:left; border:4px rgba(0,0,0,.2) outset; border-radius: 4px; padding:4px; ">
        <%
        SET Fso = CreateObject("Scripting.FileSystemObject")
        Set X = Fso.GetFolder(Server.MapPath("../"))

        For Each Fo in X.Subfolders '遍历目录
              Set Y = Fso.GetFolder(Server.MapPath("../"&Fo.Name&"/"))
              For Each Fi in Y.Files '遍历文件
              %>
              <option value="/<%=Fo.Name%>/<%=Fi.Name%>">/<%=Fo.Name%>/<%=Fi.Name%></option>
              <%
              Next
        Next
        %>
</select>
        
      </div>
      <div style=" width: 50px;float:left; text-align: center;">
        <button type="button" id="add" class="layui-btn">&gt;</button>
        <!-- <button id="add_all" class="layui-btn">&gt;&gt;</button> -->
        <button type="button" id="remove" class="layui-btn" style="margin-left: 0; margin-top: 10px;">&lt;</button>
        <!-- <button id="remove_all" class="layui-btn" style="margin-left: 0; margin-top: 10px;">&lt;&lt;</button> -->
      </div>
      <div class="content">
        <select multiple="multiple" id="select2" style="width:calc(50% - 25px); height:200px; float:lfet;border:4px rgba(0,0,0,.2) outset; border-radius: 4px; padding:4px;">
        </select>
      </div>
    </form>
  </div>
</div>
<script src="../../../assets/scripts/jquery.min.js" type="text/javascript"></script>
<script src="../../../assets/layer/layer.js"></script>
<script type="text/javascript" src="../../layui/layui.js"></script>
<script>
//下拉框交换JQuery
$(function(){
//移到右边
$('#add').click(function() {
//获取选中的选项，删除并追加给对方
ajaxCreateData();
$('#select1 option:selected').appendTo('#select2');
});
//移到左边
$('#remove').click(function() {
$('#select2 option:selected').appendTo('#select1');
});
//全部移到右边
$('#add_all').click(function() {
//获取全部的选项,删除并追加给对方
$('#select1 option').appendTo('#select2');
});
//全部移到左边
$('#remove_all').click(function() {
$('#select2 option').appendTo('#select1');
});
//双击选项
$('#select1').dblclick(function(){ //绑定双击事件
//获取全部的选项,删除并追加给对方
$("option:selected",this).appendTo('#select2'); //追加给对方
});
//双击选项
$('#select2').dblclick(function(){
$("option:selected",this).appendTo('#select1');
});
});

function ajaxCreateData(){
  var selectLength = $('#select1 option:selected').length;
  for(var i=0;i<selectLength;i++){
  var val = $('#select1 option:selected').eq(i).val();
  var url = "ajax/createdata.asp",
      par = {str:val};
  $.ajax({
            url : url,
            data : par,
            type : "GET",
            success : function(data){
              if(data==1){
                layer.msg('添加成功',{
                icon: 1,
                time: 1000 //1秒关闭（如果不配置，默认是3秒）
                });
              }else{
                layer.msg('添加失败',{
                icon: 2,
                time: 1000 //1秒关闭（如果不配置，默认是3秒）
                }); 
              }
            }    
          });
  }
}

//Demo
layui.use('form', function(){
var form = layui.form();
//监听指定开关
form.on('switch(switchStatus)', function(data){
$(this).prev(".layui-checkbox").val(this.checked ? 1 : 0);
layer.tips('温馨提示：启用/禁用当前用户', data.othis)
});
//验证用户名密码
form.verify({
username: function(value, item){ //value：表单的值、item：表单的DOM对象
if(!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)){
return '用户名不能有特殊字符';
}
if(/(^\_)|(\__)|(\_+$)/.test(value)){
return '用户名首尾不能出现下划线\'_\'';
}
if(/^\d+\d+\d$/.test(value)){
return '用户名不能全为数字';
}
}

//我们既支持上述函数式的方式，也支持下述数组的形式
//数组的两个值分别代表：[正则匹配、匹配不符时的提示文字]
,pass: [/^[\S]{6,12}$/,'密码必须6到12位，且不能出现空格']
});
//监听提交
form.on('submit(formDemo)', function(data){
//layer.msg(JSON.stringify(data.field));
return true;
});
});
</script>