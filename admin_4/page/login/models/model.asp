<!--#include file="../../../admin_inc.asp"-->
<script src="../../../../assets/scripts/jquery.min.js" type="text/javascript"></script>
<script src="../../../../assets/layer/layer.js"></script>
<script type="text/javascript" src="../../../layui/layui.js"></script>
<script type="text/javascript" src="../js/controller.js"></script>
<%
dim username:username=ReplaceSymbols(getForm("username","post"))
dim password:password=md5(ReplaceSymbols(getForm("password","post"))&salt)

%>

