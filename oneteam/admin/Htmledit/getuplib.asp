<!--#include file="functionsetting.asp"-->
<!--#include file="security.asp"-->
<%
Dim UPFAction,UPTName,UPType
UPFAction = Server.URLEncode(Request.QueryString("UPFAction"))
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

If UPFAction = "OptUpLib"& GetUpSecSon Then

Dim Rs,StrSQL
StrSQL = "select Distinct UPTName from "& StrDBPrefix &"UPInfo where UPType = '"& UPType &"' and UPTname<>'"& UPTname &"' "
Set Rs = fGetRsList(strSQL)
%>
<HTML>
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK href="sn.css" type=text/css rel=stylesheet>
<script  language="JavaScript" src="sn.js"></script>
 </HEAD>
<BODY onLoad="Gi_onLoadBlurObj();" style="margin-left:10;">
<table>
<tr>
	<td><table width="100%" height="100%" cellspacing="0" cellpadding="5" align="center" bordercolorlight="#999999" bordercolordark="#FFFFFF" >
	<tr vAlign="top"> 
		<td width="118"  align="center" ><FIELDSET><LEGEND>【<font color="#AA0000"><%=UPType%>类别</font>】</LEGEND>
		<!-- 读取列表 -->
		<table width="100%"  height="381" cellspacing="0" cellpadding="2" align="center">
		<tr><td height="2"></td></tr>
			<tr vAlign="top"> 
				<td width="100%" align="center" valign="top" >
				<div style="overflow:auto;height:335;width:100%"> 
					<table width="100%"  cellspacing="0" cellpadding="0" align="center">	
					<tr valign="top"> 
							<td width="100%" height="15" onMouseOver="this.style.backgroundColor='#E8E4DD'" onMouseOut="this.style.backgroundColor=''" onClick="libContents.location.href='libcontents.asp?UPFAction=OLibContents<% = GetUpSecSon %>&UPTName=<% = UPTName %>' "><FIELDSET>
								<span class="hand" style="width:100%;"><% = UPTName %></span>
							</FIELDSET>
							</td>
						</tr>					
						<%
						If Not Rs.Eof Then
							Do While Not Rs.Eof%>
						<tr valign="top"> 
							<td width="100%" height="15" onMouseOver="this.style.backgroundColor='#E8E4DD'" onMouseOut="this.style.backgroundColor=''" onClick="libContents.location.href='libcontents.asp?UPFAction=OLibContents<% = GetUpSecSon %>&UPTName=<% = Rs("UPTName") %>' "><FIELDSET>
								<span class="hand" style="width:100%; "><% = Rs("UPTName") %></span>
							</FIELDSET>
							</td>
						</tr>
						<%
							Rs.MoveNext
							Loop
						End If
						Rs.Close
						Set Rs = Nothing
						%>
					</table>
				</div>
			</td>
			</tr>
			<tr> 
				<td  height="25"  align="center" >
				<INPUT onMouseOver="this.style.backgroundColor='#E8E4DD'" onMouseOut="this.style.backgroundColor=''" CLASS="iButton" onFocus="blur()" onClick="parent.OptiUpLib.location.href='getuplib.asp?UPType=<% = UPType %>&UPFAction=OptUpLib<% = GetUpSecSon %>';" type=button value=刷 title="刷新"   >
				<INPUT onMouseOver="this.style.backgroundColor='#E8E4DD'" onMouseOut="this.style.backgroundColor=''" CLASS="iButton" onFocus="blur()" onClick="parent.sCallupload();disAllSub();" type=button value=返 title="返回"  >
				<INPUT onMouseOver="this.style.backgroundColor='#E8E4DD'" onMouseOut="this.style.backgroundColor=''" CLASS="iButton" onFocus="blur()" onClick="javascript: window.close();" type=button value=关 title="关闭" style="color:red"  >
				</td>
			</tr>
		</table>				
	<!-- 读取列表 -->
  	</FIELDSET>
</td>
</tr>
</table>
</td>
	<td valign="top"><table><tr valign="top"  height="445">
	<td valign="top" bgcolor="threedface" width="682"><iframe src='libcontents.asp?UPFAction=OLibContents<% = GetUpSecSon %>&UPTName=<% = server.URLEncode(UPTName) %>' name='libContents' height='100%' width='100%' scrolling='yes' marginheight='0' frameborder='0'></iframe></td>
  </tr>
</table></td>
</tr>
</table>
</BODY>
</HTML>
<%
Else
	JS "window.close();"	
End If
%>