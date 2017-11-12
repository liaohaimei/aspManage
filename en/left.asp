<input type="hidden" name="id" value="<%=request.QueryString("id")%>" />
<input type="hidden" name="idd" value="<%=request.QueryString("idd")%>" />
<input type="hidden" name="f_1" value="<%=request.QueryString("f_1")%>" />
<input type="hidden" name="f_2" value="<%=request.QueryString("f_2")%>" />
<input type="hidden" name="f_3" value="<%=request.QueryString("f_3")%>" />
<input type="hidden" name="f_4" value="<%=request.QueryString("f_4")%>" />
<div class="proLeftbox">
  <div class="proLeft">
    <h3><%=ContentTitle(ids)%></h3>
    <dl>
      <%if NextNavNull(ids)=0  then LeftNone(ids) else LeftMenu(ids) end if%>
    </dl>
  </div>

  <div class="contactn mt10 mb10 mb10">
    <div class="t05"><%=ContentTitle(10)%></div>
    <div class="subnr">
      <%=ContentShow(10)%>
    </div>
  </div>
</div>
<script type="text/javascript" src="js/leftnav.js"></script> 