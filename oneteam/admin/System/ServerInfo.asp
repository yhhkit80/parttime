<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%
option explicit
response.buffer=true	
Const PurviewLevel=1
Const PurviewLevel_Channel=0
Const PurviewLevel_Others=""
%>
<%
'�������������
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
ObjTotest(9,1) = "(FSO �ı��ļ���д)"
ObjTotest(10,0) = "adodb.connection"
ObjTotest(10,1) = "(ADO ���ݶ���)"
	
ObjTotest(11,0) = "SoftArtisans.FileUp"
ObjTotest(11,1) = "(SA-FileUp �ļ��ϴ�)"
ObjTotest(12,0) = "SoftArtisans.FileManager"
ObjTotest(12,1) = "(SoftArtisans �ļ�����)"
ObjTotest(13,0) = "LyfUpload.UploadFile"
ObjTotest(13,1) = "(���Ʒ���ļ��ϴ����)"
ObjTotest(14,0) = "Persits.Upload.1"
ObjTotest(14,1) = "(ASPUpload �ļ��ϴ�)"
ObjTotest(15,0) = "w3.upload"
ObjTotest(15,1) = "(Dimac �ļ��ϴ�)"

ObjTotest(16,0) = "JMail.SmtpMail"
ObjTotest(16,1) = "(Dimac JMail �ʼ��շ�) <a href='http://www.ajiang.net'>�����ֲ�����</a>"
ObjTotest(17,0) = "CDONTS.NewMail"
ObjTotest(17,1) = "(���� SMTP ����)"
ObjTotest(18,0) = "Persits.MailSender"
ObjTotest(18,1) = "(ASPemail ����)"
ObjTotest(19,0) = "SMTPsvg.Mailer"
ObjTotest(19,1) = "(ASPmail ����)"
ObjTotest(20,0) = "DkQmail.Qmail"
ObjTotest(20,1) = "(dkQmail ����)"
ObjTotest(21,0) = "Geocel.Mailer"
ObjTotest(21,1) = "(Geocel ����)"
ObjTotest(22,0) = "IISmail.Iismail.1"
ObjTotest(22,1) = "(IISmail ����)"
ObjTotest(23,0) = "SmtpMail.SmtpMail.1"
ObjTotest(23,1) = "(SmtpMail ����)"
	
ObjTotest(24,0) = "SoftArtisans.ImageGen"
ObjTotest(24,1) = "(SA ��ͼ���д���)"
ObjTotest(25,0) = "W3Image.Image"
ObjTotest(25,1) = "(Dimac ��ͼ���д���)"

public IsObj,VerObj

'���Ԥ�����֧��������汾

dim i
for i=0 to 25
	on error resume next
	IsObj=false
	VerObj=""
	dim TestObj
	set TestObj=server.CreateObject(ObjTotest(i,0))
	If -2147221005 <> Err then		'��л����iAmFisher�ı�����
		IsObj = True
		VerObj = TestObj.version
		if VerObj="" or isnull(VerObj) then VerObj=TestObj.about
	end if
	ObjTotest(i,2)=IsObj
	ObjTotest(i,3)=VerObj
next

'�������Ƿ�֧�ּ�����汾���ӳ���
sub ObjTest(strObj)
	on error resume next
	IsObj=false
	VerObj=""
	dim TestObj
	set TestObj=server.CreateObject (strObj)
	If -2147221005 <> Err then		'��л����iAmFisher�ı�����
		IsObj = True
		VerObj = TestObj.version
		if VerObj="" or isnull(VerObj) then VerObj=TestObj.about
	end if	
End sub
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�Ϻ����١�������Ӫ��ר��</title>
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
    <td height="25" align="center" class="bgTdTop"><span class="style1"><strong>�� �� �� �� Ϣ</strong></span></td>
  </tr>
  <tr>
    <td class="bgTdMain">    <span class="FontStrong">�Ƿ�֧��ASP</span><br>
���������������ʾ���Ŀռ䲻֧��ASP�� <br>
1�����ʱ��ļ�ʱ��ʾ���ء� <br>
2�����ʱ��ļ�ʱ�������ơ�&lt;%@ Language="VBScript" %&gt;�������֡� </td>
  </tr>
</table>
<br>
<table width=98% align="center" class="bgTbTop">
  <tr  height=18>
    <td align=left class="bgTdTop" > <span class="FontStrong style2">���������йز���</span></td>
  </tr>
  <tr  height=18>
    <td align=left class="bgTdMain"><table width="100%"  border="0" cellspacing="0" cellpadding="2">
        <tr  height=18>
          <td align=left class="bgTdMain">&nbsp;��������</td>
          <td class="bgTdMain">&nbsp;<%=Request.ServerVariables("SERVER_NAME")%></td>
        </tr>
        <tr  height=18>
          <td align=left class="bgTdMain">&nbsp;������IP</td>
          <td class="bgTdMain">&nbsp;<%=Request.ServerVariables("LOCAL_ADDR")%></td>
        </tr>
        <tr  height=18>
          <td align=left class="bgTdMain">&nbsp;�������˿�</td>
          <td class="bgTdMain">&nbsp;<%=Request.ServerVariables("SERVER_PORT")%></td>
        </tr>
        <tr  height=18>
          <td align=left class="bgTdMain">&nbsp;������ʱ��</td>
          <td class="bgTdMain">&nbsp;<%=now%></td>
        </tr>
        <tr  height=18>
          <td align=left class="bgTdMain">&nbsp;IIS�汾</td>
          <td class="bgTdMain">&nbsp;<%=Request.ServerVariables("SERVER_SOFTWARE")%></td>
        </tr>
        <tr  height=18>
          <td align=left class="bgTdMain">&nbsp;�ű���ʱʱ��</td>
          <td class="bgTdMain">&nbsp;<%=Server.ScriptTimeout%> ��</td>
        </tr>
        <tr  height=18>
          <td align=left class="bgTdMain">&nbsp;���ļ�·��</td>
          <td class="bgTdMain">&nbsp;<%=server.mappath(Request.ServerVariables("SCRIPT_NAME"))%></td>
        </tr>
        <tr  height=18>
          <td align=left class="bgTdMain">&nbsp;������CPU����</td>
          <td class="bgTdMain">&nbsp;<%=Request.ServerVariables("NUMBER_OF_PROCESSORS")%> ��</td>
        </tr>
        <tr  height=18>
          <td align=left class="bgTdMain">&nbsp;��������������</td>
          <td class="bgTdMain">&nbsp;<%=ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %></td>
        </tr>
        <tr  height=18>
          <td align=left class="bgTdMain">&nbsp;����������ϵͳ</td>
          <td class="bgTdMain">&nbsp;<%=Request.ServerVariables("OS")%></td>
        </tr>
    </table></td>
  </tr>
</table>
<br>
<table width=98% align="center" class="bgTbTop">
  <tr  height=18>
    <td align=left class="bgTdTop" > <span class="FontStrong style2"> �� IIS�Դ���ASP���</span></td>
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
			Response.Write "<font color=red><b>��</b></font>"
		Else
			Response.Write "<b>��</b> <a title='" & ObjTotest(i,3) & "'>" & left(ObjTotest(i,3),11) & "</a>"
		End If%></td>
      </tr>
      <%next%>
    </table></td>
  </tr>
</table>
<br>
<table width=98% align="center" class="bgTbTop">
  <tr  height=18>
    <td align=left class="bgTdTop" > <span class="FontStrong  style2">���������ļ��ϴ��͹������</span></td>
  </tr>
  <tr  height=18>
    <td align=left class="bgTdMain"><table width="100%"  border="0" cellspacing="0" cellpadding="2">
	<%For i=11 to 15%>
        <tr height="18" class=bgTdMain>
          <td width="50%" align=left>&nbsp;<%=ObjTotest(i,0) & "" & ObjTotest(i,1)%></td>
          <td width="50%" align=left>&nbsp;
              <%
		If Not ObjTotest(i,2) Then 
			Response.Write "<font color=red><b>��</b></font>"
		Else
			Response.Write "<b>��</b> <a title='" & ObjTotest(i,3) & "'>" & left(ObjTotest(i,3),11) & "</a>"
		End If%></td>
        </tr>
	<% next %>
    </table></td>
  </tr>
</table>
<br>
<table width=98% align="center" class="bgTbTop">
  <tr  height=18>
    <td align=left class="bgTdTop" > <span class="FontStrong  style2">���������շ��ʼ����</span></td>
  </tr>
  <tr  height=18>
    <td align=left class="bgTdMain"><table width="100%"  border="0" cellspacing="0" cellpadding="2">
       <%For i=16 to 23%>
        <tr height="18" class=bgTdMain>
          <td width="50%" align=left>&nbsp;<%=ObjTotest(i,0) & "" & ObjTotest(i,1)%></td>
          <td width="50%" align=left>&nbsp;
              <%
		If Not ObjTotest(i,2) Then 
			Response.Write "<font color=red><b>��</b></font>"
		Else
			Response.Write "<b>��</b> <a title='" & ObjTotest(i,3) & "'>" & left(ObjTotest(i,3),11) & "</a>"
		End If%></td>
        </tr>
        <% next %>
    </table></td>
  </tr>
</table>
<br>
</body>
</html>
