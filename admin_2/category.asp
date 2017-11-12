<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
    <!--<![endif]-->
    <!-- BEGIN HEAD -->

    <head>
        <meta charset="utf-8" />
        <title>Metronic | Basic Datatables</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <meta content="" name="description" />
        <meta content="" name="author" />
        <!-- BEGIN GLOBAL MANDATORY STYLES -->
        <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
        <!-- END GLOBAL MANDATORY STYLES -->
        <!-- BEGIN THEME GLOBAL STYLES -->
        <link href="../assets/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
        <link href="../assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME GLOBAL STYLES -->
        <!-- BEGIN THEME LAYOUT STYLES -->
        <link href="../assets/layouts/layout2/css/layout.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/layouts/layout2/css/themes/default.min.css" rel="stylesheet" type="text/css" id="style_color" />
        <link href="../assets/layouts/layout2/css/custom.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME LAYOUT STYLES -->
        <link rel="shortcut icon" href="favicon.ico" /> </head>
    <!-- END HEAD -->

    <body class="page-header-fixed page-sidebar-closed-hide-logo page-container-bg-solid">
        <!-- BEGIN HEADER -->
        <!--#include file="header.asp"-->
        <!-- END HEADER -->
        <!-- BEGIN HEADER & CONTENT DIVIDER -->
        <div class="clearfix"> </div>
        <!-- END HEADER & CONTENT DIVIDER -->
        <!-- BEGIN CONTAINER -->
        <div class="page-container">
            <!-- BEGIN SIDEBAR -->
            <!--#include file="sidebar.asp"-->
            <!-- END SIDEBAR -->
            <!-- BEGIN CONTENT -->
            <div class="page-content-wrapper">
                <!-- BEGIN CONTENT BODY -->
                <div class="page-content">
                    <!-- BEGIN PAGE HEADER-->
                    <!-- BEGIN THEME PANEL -->
                    <!--#include file="set.asp"-->
                    <!-- END THEME PANEL -->
                    <h3 class="page-title"> Basic Datatables
                        <small>basic datatable samples</small>
                    </h3>
                    <div class="page-bar">
                        <ul class="page-breadcrumb">
                            <li>
                                <i class="icon-home"></i>
                                <a href="index.html">Home</a>
                                <i class="fa fa-angle-right"></i>
                            </li>
                            <li>
                                <span>Tables</span>
                            </li>
                        </ul>
                        <div class="page-toolbar">
                            <div class="btn-group pull-right">
                                <button type="button" class="btn btn-fit-height grey-salt dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="1000" data-close-others="true"> Actions
                                    <i class="fa fa-angle-down"></i>
                                </button>
                                <ul class="dropdown-menu pull-right" role="menu">
                                    <li>
                                        <a href="#">
                                            <i class="icon-bell"></i> Action</a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="icon-shield"></i> Another action</a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="icon-user"></i> Something else here</a>
                                    </li>
                                    <li class="divider"> </li>
                                    <li>
                                        <a href="#">
                                            <i class="icon-bag"></i> Separated link</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!-- END PAGE HEADER-->
                    <div class="row">
                        <div class="col-md-12">
                            <!-- BEGIN SAMPLE TABLE PORTLET-->
                            <div class="portlet light ">
                                <div class="portlet-title">
                                    <div class="btn-group">
                                        <button id="sample_editable_1_new" class="btn sbold green" onClick="popAdd()"> 添加
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                     <div class="btn-group">
                                        <button id="sample_editable_1_new" class="btn sbold red" onClick="popAdd(1)"> 修改
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                    <div class="actions">
                                        <a class="btn btn-icon-only btn-default" href="javascript:;">
                                            <i class="icon-cloud-upload"></i>
                                        </a>
                                        <a class="btn btn-icon-only btn-default" href="javascript:;">
                                            <i class="icon-wrench"></i>
                                        </a>
                                        <a class="btn btn-icon-only btn-default" href="javascript:;">
                                            <i class="icon-trash"></i>
                                        </a>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <div class="table-scrollable">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th> # </th>
                                                    <th> 名称 </th>
                                                    <th> 别名 </th>
                                                    <th> 状态 </th>
                                                    <th> 操作 </th>
                                                </tr>
                                            </thead>
                                            <tbody>



    <%
    Call CategoryList(0, "")
    %>


                                                                                               
                                            </tbody>
                                        </table>
                                        <%=getRunTime()%>
                                    </div>
                                </div>
                            </div>
                            <!-- END SAMPLE TABLE PORTLET-->
                        </div>
                    </div>

                </div>
                <!-- END CONTENT BODY -->
            </div>
            <!-- END CONTENT -->
            <!-- BEGIN QUICK SIDEBAR -->
            <a href="javascript:;" class="page-quick-sidebar-toggler">
                <i class="icon-login"></i>
            </a>

            <!-- END QUICK SIDEBAR -->
        </div>
        <!-- END CONTAINER -->
        <!-- BEGIN FOOTER -->
        <!--#include file="footer.asp"-->
        <!-- END FOOTER -->
        <!--[if lt IE 9]>
        <script src="../assets/global/plugins/respond.min.js"></script>
        <script src="../assets/global/plugins/excanvas.min.js"></script> 
        <![endif]-->
        <!-- BEGIN CORE PLUGINS -->
        <script src="../assets/global/plugins/jquery.min.js" type="text/javascript"></script>
        <script src="../assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="../assets/global/plugins/js.cookie.min.js" type="text/javascript"></script>
        <script src="../assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
        <script src="../assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
        <script src="../assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
        <script src="../assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
        <!-- END CORE PLUGINS -->
        <!-- BEGIN THEME GLOBAL SCRIPTS -->
        <script src="../assets/global/scripts/app.min.js" type="text/javascript"></script>
        <!-- END THEME GLOBAL SCRIPTS -->
        <!-- BEGIN THEME LAYOUT SCRIPTS -->
        <script src="../assets/layouts/layout2/scripts/layout.min.js" type="text/javascript"></script>
        <script src="../assets/layouts/layout2/scripts/demo.min.js" type="text/javascript"></script>
        <script src="../assets/layouts/global/scripts/quick-sidebar.min.js" type="text/javascript"></script>
        <!-- END THEME LAYOUT SCRIPTS -->

<script src="../assets/layer/layer.js"></script>
  <script>
function popAdd(){
  var par="",
      title="",
      action=0;
  if (arguments[0]!=''){
    par="?id="+arguments[0];
  }
  if (arguments[1]!=''){
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
            <td><%=LeftText%><label class="mt-checkbox mt-checkbox-outline" style="margin-bottom: 0;"><%=Rs(1)%>
                            <input type="checkbox" value="1" name="isNew">
                            <span></span>
                        </label></td>
            <td><%=Rs(2)%></td>
            <td> <a class="btn"></a> </td>
            <td>
                <a href="javascript:;" class="btn btn-outline btn-circle info btn-xs blue"  onClick="popAdd(<%=Rs(0)%>)">
                                                            <i class="fa fa-plus"></i> 添加子类 </a>
                <a href="javascript:;" class="btn btn-outline btn-circle btn-xs purple" onClick="popAdd(<%=Rs(0)%>,1)">
                                                            <i class="fa fa-edit"></i> 编辑 </a>
                <a href="javascript:;" class="btn btn-outline btn-circle dark btn-xs black">
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