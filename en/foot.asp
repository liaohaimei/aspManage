<div class="foot">
  <div class="w1100">
    <div class="fl foot-left">
      <%=ContentTitle(8)%>：<%List2 8,0,"links"%>
    </div>
    <div class="fr foot-serach">

       <form action="search.asp" method="get" id="search" onsubmit="return checkKeyword()">
        <input type="hidden" name="ids" value="3">
        <input name="keyword" id="keyword" type="text" class="sok" placeholder="Enter the keyword you want to search for">
        <input type="image" src="images/index_07.jpg">
         <script>
                    function checkKeyword(){
                        var keyword = $(".sok").val();
                        if(keyword != ''){
                            return true;
                        }else{
                            alert("Please input keywords");
                            return false;
                        }
                    }
                </script>
            </form>

    </div>
  </div>
</div>
<div class="clearfix"></div>
<div class="footer clearfix">
  <div class="w1100">
    <div class="syfoot2">
      <h3><%=ContentTitle(2)%></h3>
      <ul>
        <%TopNavabout2 2,""%>
      </ul>
    </div>
    <div class="syfoot3">
      <h3><%=ContentTitle(3)%></h3>
      <ul>
        <%TopNavabout2 3,""%>
      </ul>
    </div>
    <div class="syfoot3">
      <h3><%=ContentTitle(36)%></h3>
      <ul>
        <%TopNavabout2 36,""%>
      </ul>
    </div>
    <div class="syfoot3">
      <h3><%=ContentTitle(4)%></h3>
      <ul>
        <%TopNavabout2 4,""%>
      </ul>
    </div>
    <div class="syfoot3">
      <h3><%=ContentTitle(5)%></h3>
      <ul>
        <%TopNavabout2 5,""%>
      </ul>
    </div>
    <div class="syfoot6">
      <h3><%=ContentTitle(12)%></h3>
      <%=ContentShow(12)%>
    </div>
    <div class="syfoot4">
      <p >
        <img src="<%=ConfigFileds2(1,"Class_pic")%>" />
        <br />
        Mobile site two-dimensional code
      </p>
    </div>
  </div>
</div>
<div class="foot_bottom">
  <div class="syfoot5">
    <%=ConfigurationContent(1)%>
  </div>
</div>