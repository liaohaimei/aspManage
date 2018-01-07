<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>用户总数--layui后台管理模板</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="format-detection" content="telephone=no">
  <link rel="stylesheet" href="../../layui/css/layui.css" media="all" />
  <link rel="stylesheet" href="//at.alicdn.com/t/font_tnyc012u2rlwstt9.css" media="all" />
  <link rel="stylesheet" href="../../css/user.css" media="all" />
</head>
<body class="childrenBody">
  <blockquote class="layui-elem-quote news_search">
    <div class="layui-inline">
        <div class="layui-input-inline">
          <input type="text" value="" placeholder="请输入关键字" class="layui-input search_input">
        </div>
        <a class="layui-btn search_btn">查询</a>
    </div>
    <div class="layui-inline">
      <a class="layui-btn layui-btn-normal " onclick="fun.popCreate()">添加用户</a>
    </div>
    <div class="layui-inline">
      <a class="layui-btn layui-btn-danger batchDel">批量删除</a>
    </div>
    <div class="layui-inline">
      <div class="layui-form-mid layui-word-aux">　本页面刷新后除新添加的文章外所有操作无效，关闭页面所有数据重置</div>
    </div>
  </blockquote>
  <div class="layui-form users_list">
      <table class="layui-table">
        <colgroup>
        <col width="50">
        <col>
        <col width="18%">
        <col width="8%">
        <col width="12%">
        <col width="12%">
        <col width="18%">
        <col width="15%">
        </colgroup>
        <thead>
        <tr>
          <th><input type="checkbox" name="" lay-skin="primary" lay-filter="allChoose" id="allChoose"></th>
          <th>路由</th>
          <th></th>
          <th></th>
          <th></th>
          <th></th>
          <th>更新时间</th>
          <th>操作</th>
        </tr> 
        </thead>
        <tbody class="users_content"></tbody>
    </table>
  </div>
  <div id="page"></div>
  <div id="pageDemo"></div>
  <script src="../../../assets/scripts/jquery.min.js" type="text/javascript"></script>
  <script src="../../../assets/layer/layer.js"></script>
  <script type="text/javascript" src="../../layui/layui.js"></script>
  <script type="text/javascript" src="js/controller.js"></script>
</body>
</html>