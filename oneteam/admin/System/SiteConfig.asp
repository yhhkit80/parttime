<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!--#include file="../include/config.asp"-->
<!--#include file="../include/function.asp"-->
<%
dim ObjInstalled,Action,FoundErr,ErrMsg
ObjInstalled=IsObjInstalled("Scripting.FileSystemObject")
Action=trim(request("Action"))
if Action="" then
	Action="ShowInfo"
end if
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�Ϻ����١�������Ӫ��ר��</title>
<link href="../css/css.css" rel="stylesheet" type="text/css">
</head>

<body>
<br>
<%
if Action="SaveConfig" then
	call SaveConfig()
else
	call ShowConfig()
end if
if FoundErr=True then
	response.Redirect("../Error.asp?msg="&ErrMsg&"")
	response.End()
end if

sub ShowConfig()
%>
<form name="form1" method="post" action="">

<table width="98%" align="center" cellpadding="3" class="bgTbTop">
  <tr >
    <td height="22" colspan="2" class="bgTdTop"> <strong class="Font14PXWhiteStrong">��վ��Ϣ����</strong></td>
  </tr>
  <tr class="bgTdMain" >
    <td width="57%" height="25"><strong>��վ���ƣ�</strong></td>
    <td width="43%" height="25">
      <input name="SiteName" type="text" class="InputTxt" id="SiteName" value="<%=SiteName%>" size="40" maxlength="50">
    </td>
  </tr>
  <tr class="bgTdMain" >
    <td height="25"><strong>��վ���⣺</strong></td>
    <td height="25">
      <input name="SiteTitle" type="text" class="InputTxt" id="SiteTitle" value="<%=SiteTitle%>" size="40" maxlength="50">
    </td>
  </tr>
  <tr class="bgTdMain" >
    <td height="25"><strong>��վ��ַ��</strong><br>
    ����д����URL��ַ</td>
    <td height="25">
      <input name="SiteUrl" type="text" class="InputTxt" id="SiteUrl" value="<%=SiteUrl%>" size="40" maxlength="255">
    </td>
  </tr>
  <tr class="bgTdMain" >
    <td height="25"><strong>��վ����:<br>
    </strong>��˾���������</td>
    <td height="25">
      <input name="WebmasterName" type="text" class="InputTxt" id="WebmasterName" value="<%=WebmasterName%>" size="40" maxlength="20">
    </td>
  </tr>
  <tr class="bgTdMain" >
    <td height="25"><strong>վ�����䣺</strong></td>
    <td height="25">
      <input name="WebmasterEmail" type="text" class="InputTxt" id="WebmasterEmail" value="<%=WebmasterEmail%>" size="40" maxlength="100">
    </td>
  </tr>
  <tr class="bgTdMain" >
    <td height="25"><strong>��Ȩ��Ϣ��</strong><br>
    ֧��HTML��ǣ�����ʹ��˫����</td>
    <td height="25">
      <textarea name="Copyright" cols="40" rows="5" class="InputTxt" id="Copyright"><%=Copyright%></textarea></td>
  </tr>
  <tr align="center" class="bgTdMain">
    <td colspan="2"><input name="Action" type="hidden" id="Action" value="SaveConfig">
      <input name="cmdSave" type="submit" class="InputBtn" id="cmdSave" value=" �������� " <% If ObjInstalled=false Then response.write "disabled" %>></td>
  </tr>
</table>
</form>
<%
end sub
%>
</body>
</html>
<%
sub SaveConfig()
	If ObjInstalled=false Then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ķ�������֧�� FSO(Scripting.FileSystemObject)! </li>"
		exit sub
	end if
	dim fso,hf
	set fso=Server.CreateObject("Scripting.FileSystemObject")
	set hf=fso.CreateTextFile(Server.mappath("../include/config.asp"),true)
	hf.write "<" & "%" & vbcrlf
	hf.write "Const SiteName=" & chr(34) & trim(request("SiteName")) & chr(34) & "        '��վ����" & vbcrlf
	hf.write "Const SiteTitle=" & chr(34) & trim(request("SiteTitle")) & chr(34) & "        '��վ����" & vbcrlf
	hf.write "Const SiteUrl=" & chr(34) & trim(request("SiteUrl")) & chr(34) & "        '��վ��ַ" & vbcrlf
	hf.write "Const WebmasterName=" & chr(34) & trim(request("WebmasterName")) & chr(34) & "        'վ������" & vbcrlf
	hf.write "Const WebmasterEmail=" & chr(34) & trim(request("WebmasterEmail")) & chr(34) & "        'վ������" & vbcrlf
	hf.write "Const Copyright=" & chr(34) & trim(request("Copyright")) & chr(34) & "        '��Ȩ��Ϣ" & vbcrlf
	hf.write "%" & ">"
	hf.close
	set hf=nothing
	set fso=nothing
	call WriteSuccessMsg("��վ���ñ���ɹ���")
end sub
%>