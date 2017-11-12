<script src="js/men.js"></script>
<div class="header">
  <div class="index_head">
    <div class="index_head_l"><%=ConfigFileds(1,"copyright")%></div>
    <div class="index_head_r">
      <span class="t"> <i></i>
        Hotline : <%=ContentTel(1)%>　<a href="../">Chinese</a> | <a href="./">English</a>
      </span>
    </div>
  </div>
</div>
<div id="header02">
  <div class="w1100 clear">
    <div class="logo fl">
      <h1>
        <a href="./">
          <img src="images/logo.png" alt="伊尔堡电子" title="伊尔堡电子"></a>
      </h1>
    </div>
    <div class="nav fr">
      <ul>
        <li class="fl <%if ids=1 then echo" on" end if%>">
          <div class="senior">
            <a href="./" <%=NavTarget(1)%> title="<%=ContentTitle(1)%>"><%=ContentTitle(1)%></a>
          </div>
        </li>
        <li class="fl <%if ids=2 then echo" on" end if%>">
          <div class="senior">
            <a href="<%=GetTopIdUrl(2)%>" <%=NavTarget(2)%> title="<%=ContentTitle(2)%>"><%=ContentTitle(2)%></a>
          </div>
        </li>
        <li class="fl <%if ids=3 then echo" on" end if%>">
          <div class="senior">
            <a href="<%=GetTopIdUrl(3)%>" <%=NavTarget(3)%> title="<%=ContentTitle(3)%>"><%=ContentTitle(3)%></a>
          </div>
        </li>
        <li class="fl <%if ids=4 then echo" on" end if%>">
          <div class="senior">
            <a href="<%=GetTopIdUrl(4)%>" <%=NavTarget(4)%> title="<%=ContentTitle(4)%>"><%=ContentTitle(4)%></a>
          </div>
        </li>
        <li class="fl <%if ids=5 then echo" on" end if%>">
          <div class="senior">
            <a href="<%=GetTopIdUrl(5)%>" <%=NavTarget(5)%> title="<%=ContentTitle(5)%>"><%=ContentTitle(5)%></a>
          </div>
        </li>
        <li class="fl <%if ids=6 then echo" on" end if%>">
          <div class="senior">
            <a href="<%=GetTopIdUrl(6)%>" <%=NavTarget(6)%> title="<%=ContentTitle(6)%>"><%=ContentTitle(6)%></a>
          </div>
        </li>

        <li class="fl <%if ids=7 then echo" on" end if%>">
          <div class="senior">
            <a href="<%=GetTopIdUrl(7)%>" <%=NavTarget(7)%> title="<%=ContentTitle(7)%>"><%=ContentTitle(7)%></a>
          </div>
        </li>
      </ul>
    </div>
  </div>
  <div class="sub_nav" style="display: none;"></div>
</div>