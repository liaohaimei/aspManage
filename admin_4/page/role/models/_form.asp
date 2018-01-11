<input type="hidden" id="updateid" value="<%=id%>">
<div class="layui-layout-admin site-demo">  
  <div class="layui-main">
    <form class="layui-form"  action="models/model.asp?action=<%=typ%>&id=<%=id%>" method="post">
      <div class="layui-form-item">
        <label class="layui-form-label">名称</label>
        <div class="layui-input-block">
          <input id="inp-name" name="name" value="<%=name%>" type="text" class="layui-input" placeholder="" onblur="fun.checkName(this);">
        </div>
      </div>
      <div class="layui-form-item">
        <label class="layui-form-label">描述</label>
        <div class="layui-input-block">
          <textarea id="inp-description" name="description" class="layui-textarea"><%=description%></textarea>
        </div>
      </div>
      <div class="layui-form-item">
        <label class="layui-form-label">规则名称</label>
        <div class="layui-input-block">
          <input id="inp-rule_name" name="rule_name" value="<%=rule_name%>" type="text" class="layui-input" placeholder="">
        </div>
      </div>
      <div class="layui-form-item">
        <label class="layui-form-label">数据</label>
        <div class="layui-input-block">
          <textarea id="inp-data" name="data" class="layui-textarea"><%=data%></textarea>
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
    checkName: function (el) { //检查名称是否存在
        var updateid = $("#updateid").val();
        var value = $(el).val();
        var url = "ajax/checkname.asp",
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
                    layer.msg('该名称已存在', {
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

    //验证名称密码
    form.verify({
        username: function (value, item) { //value：表单的值、item：表单的DOM对象
            if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)) {
                return '名称不能有特殊字符';
            }
            if (/(^\_)|(\__)|(\_+$)/.test(value)) {
                return '名称首尾不能出现下划线\'_\'';
            }
            if (/^\d+\d+\d$/.test(value)) {
                return '名称不能全为数字';
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