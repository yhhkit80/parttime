<!--#include file="functionsetting.asp"-->
<!--#include file="security.asp"-->
<%
'==============================================================================
'函数：DeleteFile
'功能：删除文件
'作者：xiaotian
'最后修改：2003-12-30
'==============================================================================
Function DeleteFile(FilePath)
Dim objFSO
Dim file
    On Error Resume Next

    Set objFSO = CreateObject("Scripting.FileSystemObject")
    Set file = objFSO.GetFile(FilePath)
    objFSO.DeleteFile(FilePath)
    Set objFSO = Nothing

	if err.Number <> 0 then
	    DeleteFile = false
	else
	    DeleteFile = true
	end if
End Function
%>

<HTML>
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK href="sn.css" type=text/css rel=stylesheet>
<script  language="JavaScript" src="sn.js"></script>
</HEAD>
<BODY onLoad="Gi_onLoadBlurObj();" style="margin-left:10;margin-top:4;">
<%
Dim UPFAction,UPTName,UPType,MAAction,UpLoadPath
Dim CurrentPage,PageSize,PageCount,PrevCurrentPage,NextCurrentPage,TotalCount,PageNum
PageSize = 20

UPFAction = Server.URLEncode(Request.QueryString("UPFAction"))
UPType = Session.Contents("UPType")
UPTName = Request.QueryString("UPTName")
PNPage = Request.Form("PNPage")
If UPTName = "" Then
	UPTName = Request.Form("UPTName")
End If

SrchAllHObj = "<input type=""hidden"" id=""PNPage"" name=""PNPage"" value=""PNPage""><input type=""hidden"" id=""UPTName"" name=""UPTName"" value="""& UPTName &""">"

Call Gi_fGetUpSetting(UPType)

Dim Rs,StrSQL
MAAction = Request.form("MAAction")
UPID = Request.Form("UPID")

If MAAction = "DLUPFInfo"& GetUpSecSon Then
	If UPID = "" Then
		fOnErrGoBack (UPTName &"ID不能为空！")
	End If

	set rs = fGetRsList("select UPName,UPType from "& StrDBPrefix &"UPInfo where UPID="& UPID)
	if rs(1)="文件" then FilePath = server.MapPath("../../upFile/Uploadfiles/"&rs(0))
	if rs(1)="图片" then FilePath = server.MapPath("../../upFile/Uploadpictures/"&rs(0))

	StrSQL = "delete from "& StrDBPrefix &"UPInfo where UPID="& UPID
	fInUPData(strSQL)
	call DeleteFile(FilePath)
	JS "location.href='libcontents.asp?UPFAction=OLibContents"& GetUpSecSon &"&UPTName="& UPTName &"'"

Elseif MAAction = "EDUPFInfo"& GetUpSecSon Then
UPTName = Request.Form("UPTName")
BriefInfo = Request.Form("BriefInfo")

	If UPID = "" Or UPTName = "" Then
		fOnErrGoBack (UPTName &"ID不能为空！")		
	End If
	StrSQL = "update "& StrDBPrefix &"UPInfo set UPTName='"& UPTName &"',BriefInfo='"& BriefInfo &"' where UPID="& UPID
	fInUPData(strSQL)

	JS "alert('修改成功');parent.sSendURL('"& UPTName &"')"

Elseif UPFAction = "OLibContents"& GetUpSecSon Or PNPage = "PNPage" Then	
	Dim sSQL
	sSQL = " and UPTName = '"& UPTName &"' and UPType = '"& UPType &"' "
	Call Gi_sGetPageCount("select count(UPID) from "& StrDBPrefix &"UPInfo where 0=0 " & sSQL)
	
	If PrevCurrentPage = 0 Then
		StrSQL = "select top "& PageSize &" * from "& StrDBPrefix &"UPInfo where 0=0 "& sSQL &" order by AddDate desc,UPID desc"
	Else
		StrSQL = "select top "& PageSize &" * from "& StrDBPrefix &"UPInfo where 0=0 "& sSQL &" and UPID not in (select top "& PrevCurrentPage*PageSize &" UPID from "& StrDBPrefix &"UPInfo where 0=0 "& sSQL &" order by AddDate desc,UPID desc) order by AddDate desc,UPID desc"
	End If
	Set Rs = fGetRsList(StrSQL)

%>
<FIELDSET><LEGEND>【<font color="#AA0000"><% = UPType %>列表</font>】</LEGEND>
			<table border="0" cellspacing="1" cellpadding="0" height="382">
			  <tr align="center" valign="top">
				<%
				If Not Rs.Eof Then
					Dim m,mWidth,srcIMGShow
					m = 1
					mWidth = "-52"
					Do While Not Rs.Eof 
					UPID = Rs("UPID")
					UPName = Rs("UPName")
					UPTName = Rs("UPTName")
					UPType = Rs("UPType")
					FileSize = Rs("FileSize")
					BriefInfo = Rs("BriefInfo")
				%>
				<td width=100 height="120"><FIELDSET>
					<table width="100%" border=0 cellspacing=0 cellpadding=0 align=center>			
						<tr>
							<td align=center valign="top" height="110">
								<table width="100" height="100" bgcolor="#FFFFFF" border="1" bordercolor="#626262">
								<tr>
									<td align="center">
									<%
									If UPType = "图片" Then									
										srcIMGShow = UpLoadPath & UPName
									Else
										srcIMGShow = "images/FileType_"& LCase(Right(UPName,3)) &".jpg"
									End If
									%>
									<img align="absmiddle" border="0" src="<% = srcIMGShow %>" width="96" height="96" hspace="2" vspace="2" onClick="Gi_winOpenScroll('showuploadfile.asp?UpLoadPath=<% = UpLoadPath & UPName %>&UPType=<% = UPType %>')" onMouseOver="Gi_showHideLayers('<% = UPID %>Contents','','show')" onMouseOut="Gi_showHideLayers('<% = UPID %>Contents','','hide')" class="hand">
									</td>
								</tr>
								</table>					
							<div id="<% = UPID %>default" style="position:absolute; z-index:1; visibility: hidden;">
							<div id="<% = UPID %>Contents" style="position:absolute; z-index:1; top:-20;left:<% = mWidth %>;width:320px; overflow: auto; visibility: hidden;">
								<table onMouseOver="Gi_showHideLayers('<% = UPID %>Contents','','show')" onMouseOut="Gi_showHideLayers('<% = UPID %>Contents','','hide')"  width="100%">
								<tr>
									<td height="20">&nbsp;</td>
								</tr>
								</table>
								<table style="background-color: infobackground; border: 1px #626262 solid;word-break : break-all ;line-height:120%; " width="100%" cellpadding=2 >
									<tr>
										<td align="left" height="30" ><font color="#AA0000" class="hand" >【单击预览<% = UPType %>】</font></td>
									</tr>									
									<tr valign="top">
										<td>【<% = UPType %>名称】：【 <% = UPName %> 】</td>
									</tr>
									<tr valign="top">
										<td>【<% = UPType %>大小】：【<%
																	Dim FiSz
																	FiSz = Int(FileSize / 1024)
																	If FiSz < 1 Then
																		R Round(FileSize / 1024,2) 
																	Else
																		R FiSz
																	End If
																	%> KB 】
										</td>
									</tr>
									</tr>
									<tr valign="top">
										<td>【<% = UPType %>类型】：【<% = Gi_GetFileType(LCase(Right(UPName,4))) %> 】</td>
									</tr>
									<tr valign="top">
										<td>【<% = UPType %>类别】：【<% = UPTName %> 】</td>
									</tr>
									<tr valign="top">
										<td>【<% = UPType %>介绍】：【 <% = BriefInfo %> 】</td>
									</tr>
									<tr valign="top">
										<td align="right" height="30">&nbsp;</td>
									</tr>
								</table>
								</div></div>
							</td>
						</tr>
						<form action="libcontents.asp" method="post" name="<% = UPID %>OptDel" onSubmit="if (MAAction.value=='DLUPFInfo<% = GetUpSecSon %>'){Gi_delSubConfirm('<% = UPName %>'); if (UPID.value==''|| UPTName.value=='' ||delCheck==false){return false;}} Gi_disAllButton();">
						<input type="hidden" id="UPID" name="UPID" value="<% = UPID %>">
						<input type="hidden" id="UPID" name="UPTName" value="<% = UPTName %>">
						<input type="hidden" id="MAAction" name="MAAction" value="">
						<tr>
							<td height=20 align=center>
								<INPUT onMouseOver="this.style.backgroundColor='#E8E4DD'" onMouseOut="this.style.backgroundColor=''" CLASS="iButton" onFocus="blur()" type="button" value="选" style="PADDING-LEFT:4px;PADDING-RIGHT:4px;" onClick="Gi_getLibAddpic('<% = UpLoadPath & UPName %>')" title="选择添加到页面">&nbsp;
								<INPUT onMouseOver="this.style.backgroundColor='#E8E4DD'" onMouseOut="this.style.backgroundColor=''" CLASS="iButton" onFocus="blur()" type="button" value="改" style="PADDING-LEFT:5px;PADDING-RIGHT:5px;color:highlight"  onClick="nRes = showModalDialog('PublicIframe.asp?MAAction=EDUPFInfo<% = GetUpSecSon %>&UPID=<% = UPID %>',null, 'dialogWidth: 410px; dialogHeight: 310px; center: yes; resizable: no; scroll: no; status: no;');if(nRes){parent.location.reload();parent.location.href='GetUpLib.asp?UPType=<% = UPType %>&NUPTName='+nRes+'&UPFAction=OptUpLib<% = GetUpSecSon %>'}" title="修改">&nbsp;
								<INPUT onMouseOver="this.style.backgroundColor='#E8E4DD'" onMouseOut="this.style.backgroundColor=''" CLASS="iButton" onFocus="blur()" type="submit" value="删" style="PADDING-LEFT:4px;PADDING-RIGHT:4px;color:red"  onClick="MAAction.value='DLUPFInfo<% = GetUpSecSon %>'" name="Gi_getSubmit" title="删除">
							</td>
						</form>
						</tr>
					</table>
					</FIELDSET>
				</td>
				<%		
					Rs.MoveNext					
					If m Mod 5=0 Then
						mWidth = "-52"
						R "</tr><tr>"
					Elseif m mod 5 = 1 Then
						mWidth = "-52"
					Elseif m mod 5 = 2 Then
						mWidth = "-52"
					Elseif m mod 5 = 3 Then
						mWidth = "-268"
					Elseif m mod 5 = 4 Then
						mWidth = "-268"
					End If
					m = m + 1
					Loop				
				End If
				Rs.Close
				Set Rs = Nothing
				%>
			  </tr>
				<tr><td></td>
			  </tr>
			</table>
			</table>
			<table width="100%" height="100%"><tr><td width="100%" align="right" valign="buttom"><% Call Gi_sGetPNLinks("button") %><img src="images/spacer.gif" hspace="5" align="absmiddle"></td></tr></table>
		</FIELDSET>
<%
Else
	JS "window.close();"
End If
%>
</BODY>
</HTML>
