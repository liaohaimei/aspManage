<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>table模块快速使用</title>
    <link rel="stylesheet" href="./plugins/layui/css/layui.css" media="all">

</head>
<!--#include file="admin_inc.asp"-->
<body>
 <button class="layui-btn" onclick="fun.popAdd()"> 添加根节点</button>   
<form class="layui-form layui-form-pane" action="">
    <table class="layui-table">
        <thead>
            <tr>
                <th lay-data="{field:'id', width:80, sort: true}">ID</th>
                <th lay-data="{field:'n_name', width:120}">名称</th>
                <th lay-data="{field:'n_cname', width:120, sort: true}">别名</th>
                <th lay-data="{field:'n_status', width:80}">状态</th>
                <th lay-data="{width:200}">操作</th>
            </tr>
        </thead>
        <tbody>
            <%
            Call CategoryList(0, "")
            %>
        </tbody>
    </table>
    </form>
    <script src="../assets/global/plugins/jquery.min.js" type="text/javascript"></script>
    <script src="./plugins/layui/layui.js"></script>
    <script>
        layui.use('table', function() {
            var table = layui.table;
        });
    </script>
    <script>
        layui.use(['form', 'layedit', 'laydate'], function() {
            var form = layui.form,
                layer = layui.layer,
                layedit = layui.layedit,
                laydate = layui.laydate;

            //日期
            laydate.render({
                elem: '#date'
            });
            laydate.render({
                elem: '#date1'
            });

            //创建一个编辑器
            var editIndex = layedit.build('LAY_demo_editor');

            //自定义验证规则
            form.verify({
                title: function(value) {
                    if (value.length < 5) {
                        return '标题至少得5个字符啊';
                    }
                },
                pass: [/(.+){6,12}$/, '密码必须6到12位'],
                content: function(value) {
                    layedit.sync(editIndex);
                }
            });

            //监听指定开关
            form.on('switch(switchTest)', function(data) {
                layer.msg('开关checked：' + (this.checked ? 'true' : 'false'), {
                    offset: '6px'
                });
                layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
            });

            //监听提交
            form.on('submit(demo1)', function(data) {
                layer.alert(JSON.stringify(data.field), {
                    title: '最终的提交信息'
                })
                return false;
            });


        });
    </script>


<script>
var fun = {
    popAdd:function(){//添加、修改
        var par="",
            par2="",
            title="",
            action=0;
        if (arguments[0]!=undefined){
          action=0;
          par="?id="+arguments[0];
        }
        
        if (arguments[1]!=undefined){
          action=arguments[1];
          par2="&ac="+arguments[1];
        }
        action?title="修改":title="添加"
        //iframe层
        layer.open({
          title:title,
          type: 2,
          area: ['90%', '90%'],
          fixed: true, //不固定
          maxmin: true,
          content: 'category_form.asp'+par+par2
        });
      },
      popDel:function(id){//是否删除
        layer.confirm('确定删除？', {icon: 3, title:'提示'}, function(index){
            fun.ajaxDel(id);
            window.location.reload();
            layer.close(index);
        });
      },
      ajaxDel:function(id){
        $.ajax({
               type: "GET",
               url: "category_del.asp",
               data: {pid:id },
               success: function (data) {
                  console.log(data);
                  if(data=="True"){
                  layer.alert('删除成功', {icon: 1});
                  }else{
                  layer.alert('删除失败', {icon: 2});

                  }
               }
        });
      }

    }

</script>
<%    
    '参数LeftText可以很方便的区分父栏目与子栏目之间的'错位'关系
    Function CategoryList(ID, LeftText)
    Dim Rs, Sql, ChildCount

    Sql= "select ID,n_name,n_cname from {pre}Category where parent_id="&ID&" order by id"
    set Rs = dbconn.db(Sql,"records1")

    Do While Not Rs.EOF
    Sql2 = "Select Count(*) from {pre}Category where parent_id = "&Rs(0)&""
    ChildCount = dbconn.db(Sql2,"execute")(0) '子栏目数量
    %>
    <tr>
            <td><%=Rs(0)%></td>
            <td><%=LeftText%>
                <input type="checkbox" name="like1[read]" lay-skin="primary" title="<%=Rs(1)%>">
<div class="layui-unselect layui-form-checkbox" lay-skin="primary"><span><%=Rs(1)%></span><i class="layui-icon"></i></div></td>
            <td><%=Rs(2)%></td>
            <td> <a class="btn"></a> </td>
            <td>
                <a href="javascript:;" class="btn btn-outline btn-circle info btn-xs blue"  onClick="fun.popAdd(<%=Rs(0)%>)">
                                                            <i class="fa fa-plus"></i> 添加子类 </a>
                <a href="javascript:;" class="btn btn-outline btn-circle btn-xs purple" onClick="fun.popAdd(<%=Rs(0)%>,1)">
                                                            <i class="fa fa-edit"></i> 编辑 </a>
                <a href="javascript:;" class="btn btn-outline btn-circle dark btn-xs black" onClick="fun.popDel(<%=Rs(0)%>)">
                                                            <i class="fa fa-trash-o"></i> 删除 </a>

            </td>
        </tr>
    <%   
    If ChildCount > 0 Then Call CategoryList(Rs(0), LeftText & "<span style='color:#DDD;'>|-----</span>") '递归
    Rs.MoveNext
    Loop
    Rs.Close
    Set Rs = Nothing
    End Function
    %>
  
</body>
</html>

