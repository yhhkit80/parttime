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
<title>上海火速——网络营销专家</title>
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
    <td height="22" colspan="2" class="bgTdTop"> <strong class="Font14PXWhiteStrong">网站信息配置</strong></td>
  </tr>
  <tr class="bgTdMain" >
    <td width="57%" height="25"><strong>网站名称：</strong></td>
    <td width="43%" height="25">
      <input name="SiteName" type="text" class="InputTxt" id="SiteName" value="<%=SiteName%>" size="40" maxlength="50">
    </td>
  </tr>
  <tr class="bgTdMain" >
    <td height="25"><strong>网站标题：</strong></td>
    <td height="25">
      <input name="SiteTitle" type="text" class="InputTxt" id="SiteTitle" value="<%=SiteTitle%>" size="40" maxlength="50">
    </td>
  </tr>
  <tr class="bgTdMain" >
    <td height="25"><strong>网站地址：</strong><br>
    请添写完整URL地址</td>
    <td height="25">
      <input name="SiteUrl" type="text" class="InputTxt" id="SiteUrl" value="<%=SiteUrl%>" size="40" maxlength="255">
    </td>
  </tr>
  <tr class="bgTdMain" >
    <td height="25"><strong>网站所属:<br>
    </strong>公司或个人姓名</td>
    <td height="25">
      <input name="WebmasterName" type="text" class="InputTxt" id="WebmasterName" value="<%=WebmasterName%>" size="40" maxlength="20">
    </td>
  </tr>
  <tr class="bgTdMain" >
    <td height="25"><strong>站长信箱：</strong></td>
    <td height="25">
      <input name="WebmasterEmail" type="text" class="InputTxt" id="WebmasterEmail" value="<%=WebmasterEmail%>" size="40" maxlength="100">
    </td>
  </tr>
  <tr class="bgTdMain" >
    <td height="25"><strong>版权信息：</strong><br>
    支持HTML标记，不能使用双引号</td>
    <td height="25">
      <textarea name="Copyright" cols="40" rows="5" class="InputTxt" id="Copyright"><%=Copyright%></textarea></td>
  </tr>
  <tr align="center" class="bgTdMain">
    <td colspan="2"><input name="Action" type="hidden" id="Action" value="SaveConfig">
      <input name="cmdSave" type="submit" class="InputBtn" id="cmdSave" value=" 保存设置 " <% If ObjInstalled=false Then response.write "disabled" %>></td>
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
		ErrMsg=ErrMsg & "<br><li>你的服务器不支持 FSO(Scripting.FileSystemObject)! </li>"
		exit sub
	end if
	dim fso,hf
	set fso=Server.CreateObject("Scripting.FileSystemObject")
	set hf=fso.CreateTextFile(Server.mappath("../include/config.asp"),true)
	hf.write "<" & "%" & vbcrlf
	hf.write "Const SiteName=" & chr(34) & trim(request("SiteName")) & chr(34) & "        '网站名称" & vbcrlf
	hf.write "Const SiteTitle=" & chr(34) & trim(request("SiteTitle")) & chr(34) & "        '网站标题" & vbcrlf
	hf.write "Const SiteUrl=" & chr(34) & trim(request("SiteUrl")) & chr(34) & "        '网站地址" & vbcrlf
	hf.write "Const WebmasterName=" & chr(34) & trim(request("WebmasterName")) & chr(34) & "        '站长姓名" & vbcrlf
	hf.write "Const WebmasterEmail=" & chr(34) & trim(request("WebmasterEmail")) & chr(34) & "        '站长信箱" & vbcrlf
	hf.write "Const Copyright=" & chr(34) & trim(request("Copyright")) & chr(34) & "        '版权信息" & vbcrlf
	hf.write "%" & ">"
	hf.close
	set hf=nothing
	set fso=nothing
	call WriteSuccessMsg("网站配置保存成功！")
end sub
%>