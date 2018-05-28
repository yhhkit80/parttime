<!--#include file="functionsetting.asp"-->
<!--#include file="security.asp"-->
<HTML>
<HEAD>
<title>选择文件库中的文件</title>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK href="sn.css" type=text/css rel=stylesheet>

<SCRIPT>
 function sCallupload(){
  returnValue = 'enterUpLoad';
  self.close();
 }
 function sSendURL(sURL){
  returnValue = sURL;
  self.close();
 }
</SCRIPT>
</HEAD>
 <%
 UPType = Request.QueryString("UPType")
 UPTName = Request.QueryString("UPTName")
 %>
<BODY>
<IFRAME width="100%" height="100%" src="getuplib.asp?UPTName=<% = server.URLEncode(UPTName) %>&UPType=<% = server.URLEncode(UPType) %>&UPFAction=OptUpLib<% = GetUpSecSon %>" frameBorder=0 Name="OptiUpLib"></IFRAME>
</BODY></HTML>