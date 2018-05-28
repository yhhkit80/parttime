<!--#include file="functionsetting.asp"-->
<!--#include file="security.asp"-->
<HTML>
<HEAD>
<title>上传文件</title>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK href="sn.css" type=text/css rel=stylesheet>
<SCRIPT>
 function sCallLib(){
  returnValue = 'enterUpLib';
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
<IFRAME width="100%" height="100%"  src="getupload.asp?UPTName=<%=server.URLEncode(UPTName) %>&UPType=<%=server.URLEncode(UPType)%>&UPFAction=OptUpLoad" frameBorder=0 name="OptUpload"></IFRAME>
</BODY></HTML>