
 <div id="left">
 	<div id="proleft">
    <ul>
	<%
	set rs_left=fGetRsList("select * from hs_infotype where tptree like '.0.2.%' and tplevel=2 order by pxid desc,releasedate desc ,tpid asc")
	do while not rs_left.eof
	%>
	 <li><a href="index.asp?idtree=<%=rs_left("tptree")%>" <%if idtree=rs_left("tptree")  then %> style="width:199px;height:28px;display:block;color:#fff;background-color: #6496C8;"<%end if%>><span class="jiantou">&gt;</span><%=rs_left("tpname")%></a></li>
	<%
	rs_left.movenext
	loop
	rs_left.close
	set rs_left=nothing
	%>
	 </ul>
   </div>
   <!--END proleft-->
  
  <div id="tel"><img src="img/tel.jpg" />  </div>
  
 </div>