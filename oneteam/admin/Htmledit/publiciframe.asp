<!--#include file="functionsetting.asp"-->
<!--#include file="security.asp"-->
<HTML>
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK href="sn.css" type=text/css rel=stylesheet>
</HEAD>
<script>
 function sSendURL(sURL){
  returnValue = sURL;
  self.close();
 }
</script>
 <%
 UPID = Request.QueryString("UPID")
 %>
<BODY>
<IFRAME width="100%" height="100%"  src="editupfilesinfo.asp?MAAction=EDUPFInfo<% = GetUpSecSon %>&UPID=<% = UPID %>" frameBorder=0></IFRAME>
</BODY></HTML>