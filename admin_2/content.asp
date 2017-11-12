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
                                    <button type="button" class="btn btn-primary" onClick='popAdd()'>添加</button><button type="button" class="btn btn-primary" onClick='popAdd(16)'>修改</button>
                                    <div class="caption">
                                        <i class="icon-social-dribbble font-green"></i>
                                        <span class="caption-subject font-green bold uppercase">Simple Table</span>
                                    </div>
                                    <div class="actions">
                                        <a class="btn btn-circle btn-icon-only btn-default" href="javascript:;">
                                            <i class="icon-cloud-upload"></i>
                                        </a>
                                        <a class="btn btn-circle btn-icon-only btn-default" href="javascript:;">
                                            <i class="icon-wrench"></i>
                                        </a>
                                        <a class="btn btn-circle btn-icon-only btn-default" href="javascript:;">
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
                                                    <th> First Name </th>
                                                    <th> Last Name </th>
                                                    <th> Username </th>
                                                    <th> Status </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td> 1 </td>
                                                    <td> Mark </td>
                                                    <td> Otto </td>
                                                    <td> makr124 </td>
                                                    <td>
                                                        <span class="label label-sm label-success"> Approved </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td> 2 </td>
                                                    <td> Jacob </td>
                                                    <td> Nilson </td>
                                                    <td> jac123 </td>
                                                    <td>
                                                        <span class="label label-sm label-info"> Pending </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td> 3 </td>
                                                    <td> Larry </td>
                                                    <td> Cooper </td>
                                                    <td> lar </td>
                                                    <td>
                                                        <span class="label label-sm label-warning"> Suspended </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td> 4 </td>
                                                    <td> Sandy </td>
                                                    <td> Lim </td>
                                                    <td> sanlim </td>
                                                    <td>
                                                        <span class="label label-sm label-danger"> Blocked </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td> 1 </td>
                                                    <td> Mark </td>
                                                    <td> Otto </td>
                                                    <td> makr124 </td>
                                                    <td>
                                                        <span class="label label-sm label-success"> Approved </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td> 2 </td>
                                                    <td> Jacob </td>
                                                    <td> Nilson </td>
                                                    <td> jac123 </td>
                                                    <td>
                                                        <span class="label label-sm label-info"> Pending </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td> 3 </td>
                                                    <td> Larry </td>
                                                    <td> Cooper </td>
                                                    <td> lar </td>
                                                    <td>
                                                        <span class="label label-sm label-warning"> Suspended </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td> 4 </td>
                                                    <td> Sandy </td>
                                                    <td> Lim </td>
                                                    <td> sanlim </td>
                                                    <td>
                                                        <span class="label label-sm label-danger"> Blocked </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td> 1 </td>
                                                    <td> Mark </td>
                                                    <td> Otto </td>
                                                    <td> makr124 </td>
                                                    <td>
                                                        <span class="label label-sm label-success"> Approved </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td> 2 </td>
                                                    <td> Jacob </td>
                                                    <td> Nilson </td>
                                                    <td> jac123 </td>
                                                    <td>
                                                        <span class="label label-sm label-info"> Pending </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td> 3 </td>
                                                    <td> Larry </td>
                                                    <td> Cooper </td>
                                                    <td> lar </td>
                                                    <td>
                                                        <span class="label label-sm label-warning"> Suspended </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td> 4 </td>
                                                    <td> Sandy </td>
                                                    <td> Lim </td>
                                                    <td> sanlim </td>
                                                    <td>
                                                        <span class="label label-sm label-danger"> Blocked </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td> 1 </td>
                                                    <td> Mark </td>
                                                    <td> Otto </td>
                                                    <td> makr124 </td>
                                                    <td>
                                                        <span class="label label-sm label-success"> Approved </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td> 2 </td>
                                                    <td> Jacob </td>
                                                    <td> Nilson </td>
                                                    <td> jac123 </td>
                                                    <td>
                                                        <span class="label label-sm label-info"> Pending </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td> 3 </td>
                                                    <td> Larry </td>
                                                    <td> Cooper </td>
                                                    <td> lar </td>
                                                    <td>
                                                        <span class="label label-sm label-warning"> Suspended </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td> 4 </td>
                                                    <td> Sandy </td>
                                                    <td> Lim </td>
                                                    <td> sanlim </td>
                                                    <td>
                                                        <span class="label label-sm label-danger"> Blocked </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td> 1 </td>
                                                    <td> Mark </td>
                                                    <td> Otto </td>
                                                    <td> makr124 </td>
                                                    <td>
                                                        <span class="label label-sm label-success"> Approved </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td> 2 </td>
                                                    <td> Jacob </td>
                                                    <td> Nilson </td>
                                                    <td> jac123 </td>
                                                    <td>
                                                        <span class="label label-sm label-info"> Pending </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td> 3 </td>
                                                    <td> Larry </td>
                                                    <td> Cooper </td>
                                                    <td> lar </td>
                                                    <td>
                                                        <span class="label label-sm label-warning"> Suspended </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td> 4 </td>
                                                    <td> Sandy </td>
                                                    <td> Lim </td>
                                                    <td> sanlim </td>
                                                    <td>
                                                        <span class="label label-sm label-danger"> Blocked </span>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
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
  var par="";
  if (arguments[0]!=''){
    par="?id="+arguments[0];
  }
  //iframe层
  layer.open({
    title:"添加",
    type: 2,
    area: ['90%', '90%'],
    fixed: true, //不固定
    maxmin: true,
    content: 'content_add.asp'+par
  });
}
</script>
    </body>

</html>