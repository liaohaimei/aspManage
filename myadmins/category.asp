<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <link href="style/style.css" rel="stylesheet" type="text/css" />
  <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
  <title>后台管理</title>
  <script src="scripts/jquery.min.js"></script>
  <script src="layer/layer.js"></script>
  <script>
function popAdd(){
  var par="";
  if (arguments[0]!=''){
    par="?id="+arguments[0];
  }
  //iframe层
  layer.open({
    title:"批量添加",
    type: 2,
    area: ['90%', '90%'],
    fixed: false, //不固定
    maxmin: true,
    content: 'category_add.asp'+par
  });
}
</script>
</head>
<body>
  <div id="main">
    <!--#include file="top.asp"-->
    <div id="content">
      <!--#include file="left.asp"-->
      <div id="right_content">
        <div id="main_content">

          <div class="container-fluid">
          <div class="form-group">
                  <div>
                    <button type="button" class="btn btn-primary" onClick='popAdd()'>添加</button><button type="button" class="btn btn-primary" onClick='popAdd(16)'>修改</button>
                  </div>
          </div>
          </div>
        </div>
      </div>
    </div>
      <div class="clear"></div>
      <!--#include file="bottom.asp"-->
  </div>
</body>
</html>
