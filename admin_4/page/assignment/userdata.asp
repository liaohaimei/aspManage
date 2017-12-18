<!DOCTYPE html>  
<html lang="zh-cn">  
<head>  
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />  
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalabel=no" />  
    <meta name="renderer" content="webkit" />  
    <script type="text/javascript" src="../../js/json2.js"></script>  
    <script src="../../../assets/scripts/jquery.min.js" type="text/javascript"></script> 
 
    <script type="text/javascript">  
        var url = "index_json.asp"  
        var relations = {  
            sql_class: "wspcms_admin", //表名  
            sql_top: "",  //取数据总条数 top 10  
            sql_colums: "id,username,email", //列名，用","隔开，如果全部获取，则填写"*"   
            sql_whereBy: "",  
            sql_orderBy: "order by id asc"  
        }  
        $.post(  
            url,  
        relations,  
            function (data) {  
                $('#ajax_data').html(JSON.stringify(data));  
                var total = data.total;  
                //$('#ajax_data').html(total);
            }  
        , "json"  
        );  
  
            function strToJson(str) {  
                var json = eval('(' + str + ')');  
                return json;  
            }   
    </script>  
</head>  
<body>  
 
    <div id="ajax_data" class="tips radius min-height">  
    </div>  
</body>  
</html>