<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="style.css" rel="stylesheet" type="text/css"/>

<script type="text/JavaScript">
<!--
function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}
//-->
</script>
</HEAD>
<BODY>
<!--wholetop-->
<!--#include file="top.asp"-->
<%
id=request("id")
if id<>"" and IsNumeric(id) then
	set rs=fGetRsList("select * from hs_info where id="&id)
	
	if rs.recordcount>=1 then
		id=rs("id")
		title=rs("title")
		content=rs("content")
		releasedate=rs("releasedate")
		upload_file=rs("upload_file")
		upload_image1=rs("upload_image1")
		idtree=rs("idtree")
	end if
	rs.close
	set rs=nothing
end if		
menuname=tp_name(idtree)		

%>
<!--END wholetop-->


<!--main-->
<div id="main">

 <!--left-->

  <!--#include file="left.asp"-->  
 <!--END left-->
 

 <!--right--> 
 <div id="right">
 
  <div id="topright">
     <div id="topright1"><img src="img/circle.jpg" /></div>
	 <div id="topright2">PRODUCTS DETAILS  </div>
	 <div id="topright3"><a href="#"><img src="img/msn.jpg" /></a><a href="#"><img src="img/skype.jpg" /></a><a href="#"><img src="img/yahoo.jpg" /></a></div>
	 <div id="topright4">HOME  <span class="gt">&gt;</span> PRODUCTS<span class="gt">&gt;</span> <%=tp_name(idtree)%></div> 
  </div> <!--END topright-->

  
  <div id="mainright">
   <DIV id="mainrighttop"><span class="protitle">&gt;&gt;<%=tp_name(idtree)%></span></DIV>
   <div id="maintext">
       <div id="detail1"> 
	   <div id="detailimg"><img class="detailimg" src="<%=imgurl(upload_image1)%>" alt="<%=title%>" /></div>
	   <div id="detailpictittle" class="detailpictittle"><%=title%></div>
	   </div>
	 <div id="pro1"><%=content%></div>
   </div><!--END maintext-->
   <DIV id="mainrightbottom"><img src="img/mainrightbottom.jpg" /></DIV>

  </DIV><!--END mainright-->
 
 
 </div> 
 <!--END right-->

</div>  <!--END MAIN-->  


<!-- footer-->

  <!--#include file="bottom.asp"-->  
 <!--END footer-->

<div id="footdiv"></div>
<script language="javascript">
	dh("index")
</script>
</body>
</html>
