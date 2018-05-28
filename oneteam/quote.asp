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


function check_feedback(ff)
{
	if(ff.company.value=="")
	{
		alert("Please input Company Name");
		ff.company.focus();
		return false;
	}
	if(ff.address1.value=="")
	{
		alert("Please input Address");
		ff.address1.focus();
		return false;
	}
	if(ff.guojia.value=="")
	{
		alert("Please input Country");
		ff.guojia.focus();
		return false;
	}
	if(ff.username.value=="")
	{
		alert("Please input Contact Person");
		ff.username.focus();
		return false;
	}
	if(ff.telphone.value=="")
	{
		alert("Please input Tel");
		ff.telphone.focus();
		return false;
	}
	
	if(ff.email.value.indexOf("@")==-1 || ff.email.value.indexOf(".")==-1 )
	{
		alert("Please input Email");
		ff.email.focus();
		return false;
	}
	return true;
}


//-->
</script>
<title>QUOTE</title></HEAD>
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
	 <div id="topright2">QUOTE  </div>
	 <div id="topright3"><a href="#"><img src="img/msn.jpg" /></a><a href="#"><img src="img/skype.jpg" /></a><a href="#"><img src="img/yahoo.jpg" /></a></div>
	 <div id="topright4">HOME  <span class="gt">&gt;</span> QUOTE</div> 
  </div> <!--END topright-->

  
  <div id="mainright">
   <DIV id="mainrighttop"><span class="protitle">&gt;&gt;QUOTE </span></DIV>
   <div id="maintext">
     <div id="quote">
	 <p class="bluename">Personal and Company Contact Information</p>
	 </div>

     <div id="quoteform">
       <DIV class="">
         <form id="form2" name="form2" method="post" action="submit.asp" onsubmit="return check_feedback(this)">
           <table width="100%" border="0" cellspacing="0" cellpadding="3" class="ordertab">
             <tr>
               <th>*Company Name :</th>
               <td><input name="company" type="text" id="company" size="60" maxlength="200" /></td>
             </tr>
             <tr>
               <th>*Address :</th>
               <td><input name="address1" type="text" id="address1" size="30" maxlength="200" /></td>
             </tr>
             <tr>
               <th>*Country:</th>
               <td><input name="guojia" type="text" id="guojia" size="30" maxlength="200" /></td>
             </tr>
             <tr>
               <th>*Contact Person:</th>
               <td><input name="username" type="text" id="username" size="30" maxlength="200" /></td>
             </tr>
             <tr>
               <th>*Tel :</th>
               <td><input name="telphone" type="text" id="telphone" size="30" maxlength="200" /></td>
             </tr>
             <tr>
               <th>*Email :</th>
               <td><input name="email" type="text" id="email" size="30" maxlength="200" /></td>
             </tr>
             <tr>
               <th>Your Market:</th>
               <td><input name="market" type="text" id="market" size="30" maxlength="200" /></td>
             </tr>
             <tr>
               <th valign="top">Remarks: </th>
               <td><textarea name="content" cols="60" rows="8" id="content"></textarea></td>
             </tr>
             <tr>
               <td height="1"></td>
               <td></td>
             </tr>
           </table>
            <div style="text-align:center; margin-top:15px;"><input type="submit" name="Submit" value=" OK " /></div>
         </form>
         
         </DIV>
	    </div></div><!--END maintext-->
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
	dh("quote1")
</script>
</body>
</html>
