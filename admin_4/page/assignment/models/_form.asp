<input type="hidden" id="updateid" value="<%=id%>">
<div class="layui-layout-admin site-demo">  
  <div class="layui-main">
    <form class="layui-form"  action="models/model.asp?action=<%=typ%>&id=<%=id%>" method="post">
      <div class="layui-form-item">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-block">
          <input type="text" autocomplete="off"  class="layui-input" id="input-username" name="username" value="<%=username%>" placeholder="用户名" lay-verify="username" onblur="fun.checkAdminuser(this);">
        </div>
      </div>
      <div class="layui-form-item">
        <label class="layui-form-label">邮箱</label>
        <div class="layui-input-block">
          <input type="text" autocomplete="off"  class="layui-input"  id="input-email" name="email" value="<%=email%>" placeholder="邮箱"  lay-verify="email" onblur="fun.checkAdminemail(this);">
        </div>
      </div>

      <div class="layui-form-item <%=sty%>">
        <label class="layui-form-label">修改密码</label>
        <div class="layui-input-block">
          <input type="radio" name="editpwd" value="0" title="不修改"  data-v="" checked>
          <input type="radio" name="editpwd" value="1" title="修改" data-v="pass">
        </div>
      </div>
      <div class="layui-form-item">
        <label class="layui-form-label">密码</label>
        <div class="layui-input-block">
          <input type="password" autocomplete="off"  class="layui-input"  id="input-password" name="password" value="" placeholder="密码" <%if id="" then%> lay-verify="pass" <%end if%>>
        </div>
      </div>

       <div class="layui-form-item">
        <label class="layui-form-label">状态</label>
        <div class="layui-input-block">
        	<input class="layui-checkbox" type="hidden" name="status" value="1">
        	<input type="checkbox" <%if status=1 or status="" then echo" checked" end if%>  lay-filter="switchStatus" lay-skin="switch" lay-text="启用|禁用" >
        </div>
      </div>

      <div class="layui-form-item">
        <div class="layui-input-block">
          <button class="layui-btn" lay-submit lay-filter="formDemo"><%=btnName%></button>
        </div>
      </div>
    </form>
  </div>
</div>

<script src="../../../assets/scripts/jquery.min.js" type="text/javascript"></script>
<script src="../../../assets/layer/layer.js"></script>
<script type="text/javascript" src="../../layui/layui.js"></script>
<script>
var fun = {
    checkAdminuser: function (el) { //检查用户名是否存在
            var updateid = $("#updateid").val();
            var value = $(el).val();
            var url = "ajax/checkadminuser.asp",
                par = {
                    str: value,
                    updateid: updateid
                };
            $.ajax({
                url: url,
                type: "GET",
                data: par,
                success: function (data) {
                    if (data >= 1) {
                        layer.msg('该用户名已存在', {
                            icon: 2,
                            time: 2000 //2秒关闭（如果不配置，默认是3秒）
                        });
                    }
                }
            });
        },
        checkAdminemail: function (el) { //检查用户邮箱是否存在
            var updateid = $("#updateid").val();
            var value = $(el).val();
            var url = "ajax/checkadminemail.asp",
                par = {
                    str: value,
                    updateid: updateid
                };
            $.ajax({
                url: url,
                type: "GET",
                data: par,
                success: function (data) {
                    if (data >= 1) {
                        layer.msg('该邮箱已存在', {
                            icon: 2,
                            time: 2000 //2秒关闭（如果不配置，默认是3秒）
                        });
                    }
                }
            });
        }

}

//Demo
layui.use('form', function () {
    var form = layui.form();

    //监听指定开关
    form.on('switch(switchStatus)', function (data) {
        $(this).prev(".layui-checkbox").val(this.checked ? 1 : 0);
        layer.tips('温馨提示：启用/禁用当前用户', data.othis)
    });

    //验证用户名密码
    form.verify({
        username: function (value, item) { //value：表单的值、item：表单的DOM对象
            if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)) {
                return '用户名不能有特殊字符';
            }
            if (/(^\_)|(\__)|(\_+$)/.test(value)) {
                return '用户名首尾不能出现下划线\'_\'';
            }
            if (/^\d+\d+\d$/.test(value)) {
                return '用户名不能全为数字';
            }
        }

        //我们既支持上述函数式的方式，也支持下述数组的形式
        //数组的两个值分别代表：[正则匹配、匹配不符时的提示文字]
        , pass: [
            /^[\S]{6,12}$/, '密码必须6到12位，且不能出现空格'
        ]
    });

    //监听提交
    form.on('submit(formDemo)', function (data) {
        //layer.msg(JSON.stringify(data.field));
        return true;
    });

});
</script>