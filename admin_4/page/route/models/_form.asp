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
        <select multiple="multiple" id="select1" style="width:calc(50% - 25px); height:350px; float:left; border:4px rgba(0,0,0,.2) outset; border-radius: 4px; padding:4px; ">
        <%
        SET Fso = CreateObject("Scripting.FileSystemObject")
        Set X = Fso.GetFolder(Server.MapPath("../"))

        For Each Fo in X.Subfolders '遍历目录
              Set Y = Fso.GetFolder(Server.MapPath("../"&Fo.Name&"/"))
              For Each Fi in Y.Files '遍历文件
              if checkName("/"&Fo.Name&"/"&Fi.Name)<1 then
              %>
              <option value="/<%=Fo.Name%>/<%=Fi.Name%>">/<%=Fo.Name%>/<%=Fi.Name%></option>
              <%
              end if
              Next
        Next

        function checkName(str)
          where = " where 1=1"
          where = where&" and name='"&str&"'"
          Sql="select count(*) from {pre}auth_item "&where&""
          checkName = dbconn.db(Sql,"execute")(0)
        end function
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
        <select multiple="multiple" id="select2" style="width:calc(50% - 25px); height:350px; float:lfet;border:4px rgba(0,0,0,.2) outset; border-radius: 4px; padding:4px;">

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
getSelectData()
//移到右边
$('#add').click(function() {
//获取选中的选项，删除并追加给对方
ajaxCreateData();
$('#select1 option:selected').appendTo('#select2');
});
//移到左边
$('#remove').click(function() {
ajaxDeleteData();
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
ajaxCreateData();
$("option:selected",this).appendTo('#select2'); //追加给对方
});
//双击选项
$('#select2').dblclick(function(){
ajaxDeleteData();
$("option:selected",this).appendTo('#select1');
});
});

//ajax添加路由
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

//ajax删除路由
function ajaxDeleteData(){
  var selectLength = $('#select2 option:selected').length;
  for(var i=0;i<selectLength;i++){
  var val = $('#select2 option:selected').eq(i).val();
  var url = "ajax/deletedata.asp",
      par = {str:val};
  $.ajax({
            url : url,
            data : par,
            type : "GET",
            success : function(data){
              if(data==1){
                layer.msg('删除成功',{
                icon: 1,
                time: 1000 //1秒关闭（如果不配置，默认是3秒）
                });
              }else{
                layer.msg('删除失败',{
                icon: 2,
                time: 1000 //1秒关闭（如果不配置，默认是3秒）
                }); 
              }
            }    
          });
  }
}

//ajax Get数据
function getSelectData(){
  var url = "data/index_json.asp"  
  var relations = {  
      sql_class: "wspcms_auth_item", //表名  
      sql_top: "",  //取数据总条数 top 10  
      sql_colums: "id,name", //列名，用","隔开，如果全部获取，则填写"*"   
      sql_whereBy: "",  
      sql_orderBy: "order by name asc" 
  }
  var Datas = '';
  $.post(url,relations, function(data){
    data=JSON.parse(data);
    Datas = data.rows;
    if(window.sessionStorage.getItem("sname")){
      var sname = window.sessionStorage.getItem("sname");
      Datas = JSON.parse(sname).concat(Datas);
    }
    renderData(Datas);
   
  })
}


//渲染数据
    function renderData(item){
      var htm = "";
      for(var i=0;i<item.length;i++){

         //console.log(item[i].name);

         htm += '<option value='+item[i].name+'>'+item[i].name+'</option>';
      }
      $("#select2").append(htm);
    }

</script>