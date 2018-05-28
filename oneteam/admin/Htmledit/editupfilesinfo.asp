<!--#include file="functionsetting.asp"-->
<!--#include file="security.asp"-->
<HTML>
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK href="sn.css" type=text/css rel=stylesheet>
<script  language="JavaScript" src="sn.js"></script>
</HEAD>
<BODY onLoad="Gi_onLoadBlurObj();" style="margin-left:15;margin-top:12;">
<%
UPType = Request.QueryString("UPType")
If UPType <> "" Then
	Session.Contents("UPType") = UPType
End If
UPType = Session.Contents("UPType")

UPTName = Request.QueryString("UPTName")
If UPTName <> "" Then
	Session.Contents("UPTName") = UPTName
End If
UPTName = Session.Contents("UPTName")

Call Gi_fGetUpSetting(UPType)

If Server.URLEncode(Request.QueryString("MAAction")) = "EDUPFInfo"& GetUpSecSon Then
	UPID = Request.QueryString("UPID")
	Dim Rs,StrSQL
	StrSQL = "select * from "& StrDBPrefix &"UPInfo where UPID="& UPID
	Set Rs = fGetRsList(strSQL)
	UPID = Rs("UPID")
	UPName = Rs("UPName")
	UPTName = Rs("UPTName")
	UPType = Rs("UPType")
	FileSize = Rs("FileSize")
	BriefInfo = Rs("BriefInfo")
	Rs.Close
	Set Rs = Nothing
%>
	<FIELDSET><LEGEND>修改【<font color="#AA0000"><% = UPTName & UPType %></font>】 信息</LEGEND>
<table width="100%" height="100%" cellspacing="0" cellpadding="5" align="center"  >
	<tr vAlign="top"> 
		<td>
		<table style="word-break : break-all ;line-height:120%; " width="100%" cellpadding=2>							
			<form action="LibContents.asp" method="post" name="<% = UPID %>OptEdit" onSubmit="if (UPID.value==''|| UPTName.value=='' ){return false;} Gi_disAllButton();">
			<input type="hidden" id="UPID" name="UPID" value="<% = UPID %>">
			<input type="hidden" id="MAAction" name="MAAction" value="EDUPFInfo<% = GetUpSecSon %>">
			<tr valign="top">
				<td colspan="2">【<% = UPType %>名称】：【 <font style="color:#000000"><% = UPName %></font> 】</td>
			</tr>
			<tr valign="top">
				<td colspan="2">【<% = UPType %>大小】：【 <font style="color:#000000"><%
																	Dim FiSz
																	FiSz = Int(FileSize / 1024)
																	If FiSz < 1 Then
																		R Round(FileSize / 1024,2) 
																	Else
																		R FiSz
																	End If
																	%> KB</font> 】</td>
			</tr>
			<tr valign="top" >
				<td colspan="2">【<% = UPType %>类型】：【<% = Gi_GetFileType(LCase(Right(UPName,4))) %> 】</td>
			</tr>
			<tr valign="top">
				<td>【<% = UPType %>类别】：</td><td width="256"><select name="UPTName" style="width:100%">
				<%
				If sUPTName = UPTName Then
					R "<option value='"& sUPTName &"' selected>"& sUPTName &"</option>"
				Else
					R "<option value='"& sUPTName &"'>"& sUPTName &"</option>"
				End If
				StrSQL = "select Distinct UPTName from "& StrDBPrefix &"UPInfo where UPType='"& UPType &"' and UPTName<>'"& sUPTName &"' "
				Set Rs = fGetRsList(strSQL) 
				If Not Rs.Eof Then
					Do While Not Rs.Eof 
						If Rs("UPTName") = UPTName Then
							R "<option value='"& UPTName &"' selected>"& Rs("UPTName") &"</option>"
						Else
							R "<option value='"& Rs("UPTName") &"'>"& Rs("UPTName") &"</option>"
						End If
					Rs.MoveNext
					Loop
				End If
				Rs.Close
				Set Rs = Nothing
				%>
				</select></td>
			</tr>
			<tr valign="top">
				<td >【<% = UPType %>介绍】：</td><td><textarea name="BriefInfo" rows="5" style="width:100%"><% = BriefInfo %></textarea></td>
			</tr>
			<tr>
				<td valign="bottom" align="right" height="40" colspan="2" ><INPUT onMouseOver="this.style.backgroundColor='#E8E4DD'" onMouseOut="this.style.backgroundColor=''" CLASS="iButton" onFocus="blur()"  type=submit value=提交 name=sAction>
				<INPUT onMouseOver="this.style.backgroundColor='#E8E4DD'" onMouseOut="this.style.backgroundColor=''" CLASS="iButton" onFocus="blur()" onClick="javascript: window.close();" type=button value=关闭>&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
	</FIELDSET>
</body>
</html>
<%
Else
	JS "window.close();"
End If
%>