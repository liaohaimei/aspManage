<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<title>后台管理</title>
<script src="scripts/jquery.min.js"></script>
<script src="scripts/jquery.cookie.js"></script>
<script language="javascript" type="text/javascript" src="datepicker/WdatePicker.js"></script>
		<link rel="stylesheet" href="../TextEditor/UltraEdit/themes/default/default.css" />
		<script charset="utf-8" src="../TextEditor/UltraEdit/kindeditor-min.js"></script>
		<script charset="utf-8" src="../TextEditor/UltraEdit/lang/zh_CN.js"></script>
		<script src="../TextEditor/UltraEdit/kindeditor.js"></script>
<script>
  var editor,editor1,editor2;
  KindEditor.ready(function(K) {
	  editor = K.create('textarea[class="content"]', {
		  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
          fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
          allowFileManager : true,
		  filterMode : false,
		  newlineTag:"br" 
		  
	  });
	  editor1 = K.create('textarea[class="content1"]', {
		  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
          fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
          allowFileManager : true,
		  filterMode : false,
		  newlineTag:"br" 
	  });
	  editor2 = K.create('textarea[class="content2"]', {
		  uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
          fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
          allowFileManager : true,
		  filterMode : false,
		  newlineTag:"br" 
		  
	  });

}); 
</script>
</head>
<body><div id="main"> 
  <!--#include file="top.asp"-->
  <div id="content"> 
    <!--#include file="left.asp"-->
    <div id="right_content">
      <div id="main_content">
        <div class="top_nav"><span></span></div>
        <div class="nav_content" style="line-height:18px;">
          <h1>后台首页
            <%
				dim parentid : parentid = getForm("parentid","get")
				dim pid : pid = getForm("pid","get")
				if pid<>"" and pid<> "0" then
					echo " » " & conn.db("select NavName from {pre}Configuration where Id="&pid,"execute")(0)
				end if 
				%>
            <%
				dim bid : bid = getForm("bid","get")
				if bid<>"" and bid<> "0" then
					echo " » " & conn.db("select NavName from {pre}Configuration where Id="&bid,"execute")(0)
				end if 
				%>
            <%
				dim tid : tid = getForm("tid","get")
				if tid<>"" and tid<> "0" then
					echo " » " & conn.db("select NavName from {pre}Configuration where Id="&tid,"execute")(0)
				end if 
				%>
            <%
				dim sid : sid = getForm("sid","get")
				if sid<>"" and sid<> "0" then
					echo " » " & conn.db("select NavName from {pre}Configuration where Id="&sid,"execute")(0)
				end if 
				%>
            <%
				dim cid : cid = getForm("cid","get")
				if cid<>"" and cid <> "0"  then
					set rsc = conn.db("select WebType,NavName from {pre}Configuration where id="&cid,"records1")
					if not rsc.eof then
					echo " » " & rsc("NavName")
					dim webtype : webtype =  rsc("WebType")
					rsc.close
					set rsc=nothing
					end if
				end if 
				%>
          </h1>
        </div>
        <div class="bottom_nav"><span></span></div>
        <div class="h6"></div>
        <div class="top_nav"><span></span></div>
        <div class="nav_content">
          <div class="h7"></div>
          <%
dim typeArray,topicArray,typeDic,topicDic,keyword,m_state,m_commend,repeat,contentUrl,pTopic
dim action : action = getForm("action", "get")
dim playerArray,InfosArray
dim page,vtype,order
Select  case action
	case "edit" : editInfos
	case "save" : saveInfos
	case else : editInfos
End Select 

Sub editInfos
	dim id,sqlStr,rsObj,m_color,playArray,InfosArray,playTypeCount,InfosTypeCount,i,j,m,n
	
	dim parentid : parentid = getForm("parentid","get")
	dim pid:pid=getForm("pid","get")
	dim bid:bid=getForm("bid","get")
	dim tid:tid=getForm("tid","get")
	dim sid:sid=getForm("sid","get")
	dim cid:cid=getForm("cid","get")
	if cid<>"" Then id=clng(cid) else id=sid
 
	sqlStr = "select *  from {pre}Configuration where ID="&id
	set rsObj = conn.db(sqlStr,"records1")
	if rsObj.eof then die "没找到记录"
%>
          <form method="post" action="?action=save&acttype=edit&parentid=<%=parentid%>&pid=<%=pid%>&bid=<%=bid%>&tid=<%=tid%>&sid=<%=sid%>&cid=<%=cid%>"  name="addform" onSubmit="return validateform()">
            <div class="nav_tools"><span class="save"><a href="javascript:infosave();">保存</a></span><span class="nav_tools_right"></span></div>
            <div class="table">
              <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                  <td align="left" bgcolor="#6b6b6b" style="color:#FFFFFF; font-weight:bold;text-indent:10px;border-right:solid #e5e5e5 1px; border-left:solid #e5e5e5 1px;border-bottom:solid #e5e5e5 1px;" valign="middle">编辑信息</td>
                </tr>
                <tr>
                  <td align="left"><table width="100%" cellpadding="0" cellspacing="0" id="RiseList">
                      <tbody>
                        <tr bgcolor="#e5e5e5">
                          <td width="10%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px; border-left:solid #bbbbbb 1px;">&nbsp;</td>
                          <td width="90%" align="left" valign="middle" style="border-top:solid #bbbbbb 1px;border-right:solid #bbbbbb 1px;">&nbsp;</td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">栏目名称(CN):</td>
                              </tr>
                          </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_name" name="m_name" size="60"  value="<%=rsObj("NavName")%>" />
                            &nbsp;<font color='red'>＊</font></td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">栏目名称(EN):</td>
                              </tr>
                          </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_nameen" name="m_nameen" size="60"  value="<%=rsObj("NavNameen")%>" />
                            &nbsp;<font color='red'>＊</font></td>
                        </tr>

                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">栏目名称(JP):</td>
                              </tr>
                          </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_namejp" name="m_namejp" size="60"  value="<%=rsObj("NavNamejp")%>" />
                            &nbsp;<font color='red'>＊</font></td>
                        </tr>

                        <tr >
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">网站名称(CN):</td>
                              </tr>
                          </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_PageTitle" name="m_PageTitle" size="60"  value="<%=rsObj("PageTitle")%>" />
                            &nbsp;</td>
                        </tr>

                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">网站名称(EN):</td>
                              </tr>
                          </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_PageTitleen" name="m_PageTitleen" size="60"  value="<%=rsObj("PageTitleen")%>" />
                            &nbsp;</td>
                        </tr>

                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">网站名称(JP):</td>
                              </tr>
                          </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_PageTitlejp" name="m_PageTitlejp" size="60"  value="<%=rsObj("PageTitlejp")%>" />
                            &nbsp;</td>
                        </tr>

                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">电话:</td>
                              </tr>
                          </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_Tel" name="m_Tel" size="60"  value="<%=rsObj("Tel")%>" />
                            &nbsp;</td>
                        </tr>
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">地址:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_Address" name="m_Address" size="60"  value="<%=rsObj("Address")%>" />
                            &nbsp;</td>
                        </tr>

                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">地址(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_Addressen" name="m_Addressen" size="60"  value="<%=rsObj("Address")%>" />
                            &nbsp;</td>
                        </tr>


                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">传真:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_Fax" name="m_Fax" size="60"  value="<%=rsObj("Fax")%>" />
                            &nbsp;</td>
                        </tr>

                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">邮箱:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_Email" name="m_Email" size="60"  value="<%=rsObj("Email")%>" />
                            &nbsp;</td>
                        </tr>

                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">招聘收件邮箱:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_BjEmail" name="m_BjEmail" size="60"  value="<%=rsObj("BjEmail")%>" />
                            &nbsp;</td>
                        </tr>

                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">留言收件邮箱:</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <input id="m_MesEmail" name="m_MesEmail" size="60"  value="<%=rsObj("MesEmail")%>" />
                            &nbsp;</td>
                        </tr>
                      <tr style="display:none;">
                        <td  align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;">
                        <table width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="right">二维码:</td>
                            </tr>
                        </table></td>
                        <td colspan="2" align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
                        &nbsp;&nbsp;<%if rsObj("Class_pic")<>"" then echo"<img src='"&rsObj("Class_pic")&"' width='100'/>" end if%><textarea name="m_class_pic"  type="text" id="m_class_pic" /><%=rsObj("Class_pic")%></textarea> <input type="button" id="image1" value="选择图片" />
               <script>
                        KindEditor.ready(function(K) {
                            var editor = K.editor({
                              uploadJson : '../TextEditor/UltraEdit/asp/upload_json.asp',
                              fileManagerJson : '../TextEditor/UltraEdit/asp/file_manager_json.asp',
                                allowFileManager : true
                            });
                            K('#image1').click(function() {
                                editor.loadPlugin('image', function() {
                                    editor.plugin.imageDialog({
                                        imageUrl : K('#m_class_pic').val(),
                                        clickFn : function(url, title, width, height, border, align) {
                                            K('#m_class_pic').val(url);
                                            editor.hideDialog();
                                        }
                                    });
                                });
                            });
                        });
                    </script>
            
                        120*120px</td>
                      </tr>


                        <tr >
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">关键字(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <textarea name="m_Keywords" cols="80" rows="5" id="m_Keywords"><%=rsObj("Keywords")%></textarea></td>
                        </tr>



                        <tr >
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">关键字(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <textarea name="m_Keywordsen" cols="80" rows="5" id="m_Keywordsen"><%=rsObj("Keywordsen")%></textarea></td>
                        </tr>

                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">关键字(JP):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <textarea name="m_Keywordsjp" cols="80" rows="5" id="m_Keywordsjp"><%=rsObj("Keywordsjp")%></textarea></td>
                        </tr>

                        <tr >
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">网站描述(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <textarea name="m_Descriptions" cols="80" rows="5" id="m_Descriptions"><%=rsObj("Descriptions")%></textarea></td>
                        </tr>
                        
                        <tr >
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">网站描述(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <textarea name="m_Descriptionsen" cols="80" rows="5" id="m_Descriptionsen"><%=rsObj("Descriptionsen")%></textarea></td>
                        </tr>
                        
                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">网站描述(JP):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <textarea name="m_Descriptionsjp" cols="80" rows="5" id="m_Descriptionsjp"><%=rsObj("Descriptionsjp")%></textarea></td>
                        </tr>

                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">版权(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <textarea name="m_Copyright" cols="80" rows="5" id="m_Copyright"><%=rsObj("Copyright")%></textarea></td>
                        </tr>

                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">版权(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <textarea name="m_Copyrighten" cols="80" rows="5" id="m_Copyrighten"><%=rsObj("Copyrighten")%></textarea></td>
                        </tr>

                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">版权(JP):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">&nbsp;
                            <textarea name="m_Copyrightjp" cols="80" rows="5" id="m_Copyrightjp"><%=rsObj("Copyrightjp")%></textarea></td>
                        </tr>

                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">底部信息(CN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;">
                          <textarea class="content" name="m_description" id="m_description" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("Describe")%></textarea></td>
                        </tr>
                        <tr>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">底部信息(EN):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"> 
                          <textarea class="content1" name="m_descriptionen" id="m_descriptionen" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("Describeen")%></textarea></td>

                        </tr>

                        <tr style="display:none;">
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px; border-left:solid #dddddd 1px;"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr>
                                <td align="right">底部信息(JP):</td>
                              </tr>
                            </table></td>
                          <td align="left" style="border-top:solid #dddddd 1px;border-right:solid #dddddd 1px;"> 
                          <textarea class="content2" name="m_descriptionjp" id="m_descriptionjp" style="width:100%;height:400px;visibility:hidden;"><%=rsObj("Describejp")%></textarea></td>

                        </tr>


                      </tbody>
                    </table></td>
                </tr>
                <tr>
                  <td align="left" bgcolor="#e5e5e5" style="border:solid #bbbbbb 1px;">&nbsp;
                    <input type="hidden" name="m_id" value="<%=id%>">
                    <input type="hidden" name="m_back" value="<%=request.ServerVariables("HTTP_REFERER")%>" /></td>
                </tr>
              </table>
            </div>
            <div class="nav_tools leftbottom"><span class="save"><a href="javascript:infosave();">保存</a></span><span class="nav_tools_right rightbottom"></span></div>
          </form>
          <%
set rsObj = nothing
End Sub
%>
          <div class="h7"></div>
        </div>
        <div class="bottom_nav"><span></span></div>
      </div>
    </div>
  </div>
  <div class="clear"></div>
  <!--#include file="bottom.asp"--> 
</div>
</body>
</html>
<%
Sub saveInfos
	dim actType : actType = getForm("acttype","get")
	dim updateSql
	dim m_name:m_name=ReplaceSymbols(getForm("m_name","post")) : if isNul(m_name) then die "请填写信息标题"
	dim m_nameen:m_nameen=ReplaceSymbols(getForm("m_nameen","post"))
	dim m_namejp:m_namejp=ReplaceSymbols(getForm("m_namejp","post"))
	
	dim m_Tel:m_Tel=getForm("m_Tel","post")
	dim m_Address:m_Address=ReplaceSymbols(getForm("m_Address","post"))
	dim m_Addressen:m_Addressen=ReplaceSymbols(getForm("m_Addressen","post"))
	dim m_Fax:m_Fax=getForm("m_Fax","post")
	dim m_Email:m_Email=getForm("m_Email","post")
	dim m_BjEmail:m_BjEmail=getForm("m_BjEmail","post")
	dim m_MesEmail:m_MesEmail=getForm("m_MesEmail","post")
	dim m_class_pic:m_class_pic =ReplaceSymbols(getForm("m_class_pic","post"))
	
	dim m_PageTitle:m_PageTitle=ReplaceSymbols(getForm("m_PageTitle","post"))
	dim m_PageTitleen:m_PageTitleen=ReplaceSymbols(getForm("m_PageTitleen","post"))
	dim m_PageTitlejp:m_PageTitlejp=ReplaceSymbols(getForm("m_PageTitlejp","post"))
	dim m_Keywords:m_Keywords=ReplaceSymbols(getForm("m_Keywords","post"))
	dim m_Keywordsen:m_Keywordsen=ReplaceSymbols(getForm("m_Keywordsen","post"))
	dim m_Keywordsjp:m_Keywordsjp=ReplaceSymbols(getForm("m_Keywordsjp","post"))
	dim m_Copyright:m_Copyright=ReplaceSymbols(getForm("m_Copyright","post"))
	dim m_Copyrighten:m_Copyrighten=ReplaceSymbols(getForm("m_Copyrighten","post"))
	dim m_Copyrightjp:m_Copyrightjp=ReplaceSymbols(getForm("m_Copyrightjp","post"))
	dim m_Descriptions:m_Descriptions=ReplaceSymbols(getForm("m_Descriptions","post"))
	dim m_Descriptionsen:m_Descriptionsen=ReplaceSymbols(getForm("m_Descriptionsen","post"))
	dim m_Descriptionsjp:m_Descriptionsjp=ReplaceSymbols(getForm("m_Descriptionsjp","post"))
	dim m_back:m_back=getForm("m_back","post")
	dim m_key:m_key=getForm("m_key","post")
	dim m_description:m_description=ReplaceSymbols(getForm("m_description","post"))
	dim m_descriptionen:m_descriptionen=ReplaceSymbols(getForm("m_descriptionen","post"))
	dim m_descriptionjp:m_descriptionjp=ReplaceSymbols(getForm("m_descriptionjp","post"))
	dim m_desjp:m_desjp=ReplaceSymbols(getForm("m_desjp","post"))
	
	parentid = getForm("parentid","get")
	pid=getForm("pid","get")
	bid=getForm("bid","get")
	tid=getForm("tid","get")
	sid=getForm("sid","get")
	cid=getForm("cid","get")
	
	select case  actType
		case "edit"
			dim m_id:m_id=clng(getForm("m_id","post"))
			updateSql = "NavName='"&m_name&"',NavNameen='"&m_nameen&"',NavNamejp='"&m_namejp&"',Tel='"&m_Tel&"',Address='"&m_Address&"',Addressen='"&m_Addressen&"',Fax='"&m_Fax&"',Email='"&m_Email&"',BjEmail='"&m_BjEmail&"',MesEmail='"&m_MesEmail&"',Class_pic='"&m_class_pic&"',PageTitle='"&m_PageTitle&"',PageTitleen='"&m_PageTitleen&"',PageTitlejp='"&m_PageTitlejp&"',Keywords='"&m_Keywords&"',Keywordsen='"&m_Keywordsen&"',Keywordsjp='"&m_Keywordsjp&"',Copyright='"&m_Copyright&"',Copyrighten='"&m_Copyrighten&"',Copyrightjp='"&m_Copyrightjp&"',Descriptions='"&m_Descriptions&"',Descriptionsen='"&m_Descriptionsen&"',Descriptionsjp='"&m_Descriptionsjp&"',[Describe]='"&m_description&"',[Describeen]='"&m_descriptionen&"',[Describejp]='"&m_descriptionjp&"'"
			updateSql = "update {pre}Configuration set "&updateSql&" where ID="&m_id
			conn.db  updateSql,"execute"
			alertMsg "","?action=edit&parentid="&parentid&"&pid="&pid&"&bid="&bid&"&tid="&tid&"&sid="&sid&"&cid="&cid
	end select
End Sub
%>
