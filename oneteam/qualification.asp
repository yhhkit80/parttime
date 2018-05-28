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
<title>QUALIFICATION</title>
 <link rel="stylesheet" href="lightbox.css" type="text/css" media="screen" />
<script type="text/javascript" src="script/prototype.js"></script>
<script type="text/javascript" src="script/scriptaculous.js?load=effects"></script>
<script type="text/javascript" src="script/lightbox.js"></script> 
</HEAD>
<BODY>
<!--wholetop-->
<!--#include file="top.asp"-->
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
	 <div id="topright2">QUALIFICATION  </div>
	 <div id="topright3"><a href="#"><img src="img/msn.jpg" /></a><a href="#"><img src="img/skype.jpg" /></a><a href="#"><img src="img/yahoo.jpg" /></a></div>
	 <div id="topright4">HOME  <span class="gt">&gt;</span> QUALIFICATION</div> 
  </div> <!--END topright-->

  
  <div id="mainright">
   <DIV id="mainrighttop"><span class="protitle">&gt;&gt;QUALIFICATION </span></DIV>
   <div id="maintext">
       <div id="list"> 
	   <div class="qualist">
 
         <ul class="quaul">
		 <%
		 idtree=".0.3."
			set rs=fGetRsList("select * from hs_info where idtree='"&idtree&"' order by pxid desc,releasedate desc,id desc")
			if not(rs.bof and rs.eof) then
				page=request("page")
				if page="" or not isnumeric(page) then
					page=1
				end if
				currentPage=page
				if currentpage="" then
					currentpage=1
				else
					currentpage=clng(currentpage)
				end if
				MaxPerPage =12
				RecordCount = rs.RecordCount
				if not rs.RecordCount=0 then
					rs.MoveFirst
				end if
				
				if (currentPage-1)*MaxPerPage<RecordCount and currentPage>1 then
					rs.move (currentPage-1)*MaxPerPage
				end if
				
				jj=0
				do while jj<MaxPerPage and not rs.eof
					jj=jj+1
			%>
	      <li><a href="<%=imgurl(rs("upload_image1"))%>" rel="lightbox[plants]" title="<%=rs("title")%>"><img src="<%=imgurl(rs("upload_image"))%>" class="quaimg" alt="<%=rs("title")%>"/><b><%=rs("title")%></b></a></li>
	      <%
						rs.movenext
					loop
					
					if RecordCount mod MaxPerPage =0 then
						n= RecordCount \ MaxPerPage
					else
						n= (RecordCount \ MaxPerPage)+1
					end if
					if currentpage-1 mod MaxPerPage =0 then
						p=(currentpage-1) \ MaxPerPage
					else
						p=(currentpage-1) \ MaxPerPage
					end if
				else
					response.Write("<li>Data compilation...</li>")
				end if
				
				keyword=""
				%>   

	   </ul>

      </div><!--END classqualist-->

     </div><!--END list-->
	 
	 
	<div id="page">
	 <%if RecordCount>MaxPerPage then response.Write(getPageInfo_en(MaxPerPage,n,currentpage,keyword))%>
	
	</div>

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
	dh("qualification")
</script>
</body>
</html>
