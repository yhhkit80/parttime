<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%
option explicit
response.buffer=true	
Const PurviewLevel=1
Const PurviewLevel_Channel=0
Const PurviewLevel_Others=""
%>
<%
'声明待检测数组
Dim ObjTotest(26,4)

ObjTotest(0,0) = "MSWC.AdRotator"
ObjTotest(1,0) = "MSWC.BrowserType"
ObjTotest(2,0) = "MSWC.NextLink"
ObjTotest(3,0) = "MSWC.Tools"
ObjTotest(4,0) = "MSWC.Status"
ObjTotest(5,0) = "MSWC.Counters"
ObjTotest(6,0) = "IISSample.ContentRotator"
ObjTotest(7,0) = "IISSample.PageCounter"
ObjTotest(8,0) = "MSWC.PermissionChecker"
ObjTotest(9,0) = "Scripting.FileSystemObject"
ObjTotest(9,1) = "(FSO 文本文件读写)"
ObjTotest(10,0) = "adodb.connection"
ObjTotest(10,1) = "(ADO 数据对象)"
	
ObjTotest(11,0) = "SoftArtisans.FileUp"
ObjTotest(11,1) = "(SA-FileUp 文件上传)"
ObjTotest(12,0) = "SoftArtisans.FileManager"
ObjTotest(12,1) = "(SoftArtisans 文件管理)"
ObjTotest(13,0) = "LyfUpload.UploadFile"
ObjTotest(13,1) = "(刘云峰的文件上传组件)"
ObjTotest(14,0) = "Persits.Upload.1"
ObjTotest(14,1) = "(ASPUpload 文件上传)"
ObjTotest(15,0) = "w3.upload"
ObjTotest(15,1) = "(Dimac 文件上传)"

ObjTotest(16,0) = "JMail.SmtpMail"
ObjTotest(16,1) = "(Dimac JMail 邮件收发) <a href='http://www.ajiang.net'>中文手册下载</a>"
ObjTotest(17,0) = "CDONTS.NewMail"
ObjTotest(17,1) = "(虚拟 SMTP 发信)"
ObjTotest(18,0) = "Persits.MailSender"
ObjTotest(18,1) = "(ASPemail 发信)"
ObjTotest(19,0) = "SMTPsvg.Mailer"
ObjTotest(19,1) = "(ASPmail 发信)"
ObjTotest(20,0) = "DkQmail.Qmail"
ObjTotest(20,1) = "(dkQmail 发信)"
ObjTotest(21,0) = "Geocel.Mailer"
ObjTotest(21,1) = "(Geocel 发信)"
ObjTotest(22,0) = "IISmail.Iismail.1"
ObjTotest(22,1) = "(IISmail 发信)"
ObjTotest(23,0) = "SmtpMail.SmtpMail.1"
ObjTotest(23,1) = "(SmtpMail 发信)"
	
ObjTotest(24,0) = "SoftArtisans.ImageGen"
ObjTotest(24,1) = "(SA 的图像读写组件)"
ObjTotest(25,0) = "W3Image.Image"
ObjTotest(25,1) = "(Dimac 的图像读写组件)"

public IsObj,VerObj

'检查预查组件支持情况及版本

dim i
for i=0 to 25
	on error resume next
	IsObj=false
	VerObj=""
	dim TestObj
	set TestObj=server.CreateObject(ObjTotest(i,0))
	If -2147221005 <> Err then		'感谢网友iAmFisher的宝贵建议
		IsObj = True
		VerObj = TestObj.version
		if VerObj="" or isnull(VerObj) then VerObj=TestObj.about
	end if
	ObjTotest(i,2)=IsObj
	ObjTotest(i,3)=VerObj
next

'检查组件是否被支持及组件版本的子程序
sub ObjTest(strObj)
	on error resume next
	IsObj=false
	VerObj=""
	dim TestObj
	set TestObj=server.CreateObject (strObj)
	If -2147221005 <> Err then		'感谢网友iAmFisher的宝贵建议
		IsObj = True
		VerObj = TestObj.version
		if VerObj="" or isnull(VerObj) then VerObj=TestObj.about
	end if	
End sub
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>上海火速——网络营销专家</title>
<link href="../css/css.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {	color: #FFFFFF;
	font-weight: bold;
}
.style2 {color: #FFFFFF}

-->
</style>
</head>

<body>
<table width="98%"   align="center"  class="bgTbTop">
  <tr>
    <td height="25" align="center" class="bgTdTop"><span class="style1"><strong>服 务 器 信 息</strong></span></td>
  </tr>
  <tr>
    <td class="bgTdMain">    <span class="FontStrong">是否支持ASP</span><br>
出现以下情况即表示您的空间不支持ASP： <br>
1、访问本文件时提示下载。 <br>
2、访问本文件时看到类似“&lt;%@ Language="VBScript" %&gt;”的文字。 </td>
  </tr>
</table>
<br>
<table width=98% align="center" class="bgTbTop">
  <tr  height=18>
    <td align=left class="bgTdTop" > <span class="FontStrong style2">服务器的有关参数</span></td>
  </tr>
  <tr  height=18>
    <td align=left class="bgTdMain"><table width="100%"  border="0" cellspacing="0" cellpadding="2">
        <tr  height=18>
          <td align=left class="bgTdMain">&nbsp;服务器名</td>
          <td class="bgTdMain">&nbsp;<%=Request.ServerVariables("SERVER_NAME")%></td>
        </tr>
        <tr  height=18>
          <td align=left class="bgTdMain">&nbsp;服务器IP</td>
          <td class="bgTdMain">&nbsp;<%=Request.ServerVariables("LOCAL_ADDR")%></td>
        </tr>
        <tr  height=18>
          <td align=left class="bgTdMain">&nbsp;服务器端口</td>
          <td class="bgTdMain">&nbsp;<%=Request.ServerVariables("SERVER_PORT")%></td>
        </tr>
        <tr  height=18>
          <td align=left class="bgTdMain">&nbsp;服务器时间</td>
          <td class="bgTdMain">&nbsp;<%=now%></td>
        </tr>
        <tr  height=18>
          <td align=left class="bgTdMain">&nbsp;IIS版本</td>
          <td class="bgTdMain">&nbsp;<%=Request.ServerVariables("SERVER_SOFTWARE")%></td>
        </tr>
        <tr  height=18>
          <td align=left class="bgTdMain">&nbsp;脚本超时时间</td>
          <td class="bgTdMain">&nbsp;<%=Server.ScriptTimeout%> 秒</td>
        </tr>
        <tr  height=18>
          <td align=left class="bgTdMain">&nbsp;本文件路径</td>
          <td class="bgTdMain">&nbsp;<%=server.mappath(Request.ServerVariables("SCRIPT_NAME"))%></td>
        </tr>
        <tr  height=18>
          <td align=left class="bgTdMain">&nbsp;服务器CPU数量</td>
          <td class="bgTdMain">&nbsp;<%=Request.ServerVariables("NUMBER_OF_PROCESSORS")%> 个</td>
        </tr>
        <tr  height=18>
          <td align=left class="bgTdMain">&nbsp;服务器解译引擎</td>
          <td class="bgTdMain">&nbsp;<%=ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %></td>
        </tr>
        <tr  height=18>
          <td align=left class="bgTdMain">&nbsp;服务器操作系统</td>
          <td class="bgTdMain">&nbsp;<%=Request.ServerVariables("OS")%></td>
        </tr>
    </table></td>
  </tr>
</table>
<br>
<table width=98% align="center" class="bgTbTop">
  <tr  height=18>
    <td align=left class="bgTdTop" > <span class="FontStrong style2"> ■ IIS自带的ASP组件</span></td>
  </tr>
  <tr  height=18>
    <td align=left class="bgTdMain"><table width="100%"  border="0" cellspacing="0" cellpadding="2" style="border-collapse: collapse">
      <%For i=1 to 10%>
      <tr>
        <td width="50%" align=left>&nbsp;<%=ObjTotest(i,0) & "" & ObjTotest(i,1)%></td>
        <td width="50%" align=left>
          &nbsp;
<%
		If Not ObjTotest(i,2) Then 
			Response.Write "<font color=red><b>×</b></font>"
		Else
			Response.Write "<b>√</b> <a title='" & ObjTotest(i,3) & "'>" & left(ObjTotest(i,3),11) & "</a>"
		End If%></td>
      </tr>
      <%next%>
    </table></td>
  </tr>
</table>
<br>
<table width=98% align="center" class="bgTbTop">
  <tr  height=18>
    <td align=left class="bgTdTop" > <span class="FontStrong  style2">■常见的文件上传和管理组件</span></td>
  </tr>
  <tr  height=18>
    <td align=left class="bgTdMain"><table width="100%"  border="0" cellspacing="0" cellpadding="2">
	<%For i=11 to 15%>
        <tr height="18" class=bgTdMain>
          <td width="50%" align=left>&nbsp;<%=ObjTotest(i,0) & "" & ObjTotest(i,1)%></td>
          <td width="50%" align=left>&nbsp;
              <%
		If Not ObjTotest(i,2) Then 
			Response.Write "<font color=red><b>×</b></font>"
		Else
			Response.Write "<b>√</b> <a title='" & ObjTotest(i,3) & "'>" & left(ObjTotest(i,3),11) & "</a>"
		End If%></td>
        </tr>
	<% next %>
    </table></td>
  </tr>
</table>
<br>
<table width=98% align="center" class="bgTbTop">
  <tr  height=18>
    <td align=left class="bgTdTop" > <span class="FontStrong  style2">■常见的收发邮件组件</span></td>
  </tr>
  <tr  height=18>
    <td align=left class="bgTdMain"><table width="100%"  border="0" cellspacing="0" cellpadding="2">
       <%For i=16 to 23%>
        <tr height="18" class=bgTdMain>
          <td width="50%" align=left>&nbsp;<%=ObjTotest(i,0) & "" & ObjTotest(i,1)%></td>
          <td width="50%" align=left>&nbsp;
              <%
		If Not ObjTotest(i,2) Then 
			Response.Write "<font color=red><b>×</b></font>"
		Else
			Response.Write "<b>√</b> <a title='" & ObjTotest(i,3) & "'>" & left(ObjTotest(i,3),11) & "</a>"
		End If%></td>
        </tr>
        <% next %>
    </table></td>
  </tr>
</table>
<br>
</body>
</html>
