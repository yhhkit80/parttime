<!-- #include File="../../Include/Security.Asp" -->
<!-- #include File="../../Include/Consts.Asp" -->
<!-- #include File="../../Include/Func.Asp" -->
<!-- #include file="../../include/func@type.asp" -->
<%
if instr(session("flag"),"|1|") < 1 then
	response.write("您没有权限查看此栏目")
	response.End()
end if
Dim Rs,StrSQL
Dim CurrentPage,PageSize,PageCount,PrevCurrentPage,NextCurrentPage,TotalCount,PageNum
Dim iLanguage,tpID,GBAction

GBAction =  Request.Form("GBAction")
tpID = Request("tpID")
	If tpID = "" Then tpID = 0
	rstID = tpID
iLanguage = Request("iLanguage")

Call Gi_sGetLangVar
%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charSet=gb2312">
<link href="../css/css.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../script/func.js"></script>
<!--#include file="../htmledit/optSetting.asp"-->
<script language="javascript" src="../script/blur.js"></script>
</head>
<body onkeydown="if(event.keyCode==13&&event.ctrlKey)if(Gi_validForm('EDFPType','tpName','请输入<% = ZHModule %>类别名称')){Gi_ceSub('EDFPType')}">
<!--#include file="include_nav.asp" -->
<BR />
<table width="98%"  border="0" cellspacing="5" cellpadding="3" align="center">
<%
If GBAction = "ModifyNWType"& BGSecSon &"" And tpID<>"" Then
	StrSQL = "select * from "& StrDBPrefix & "InfoType where tpID="& tpID
	Set Rs = fGetRsList(StrSQL)
	If Not Rs.Eof Then
		tpName  = Rs("tpName")
		tpInfo  = Rs("tpInfo")
		tpImage = Rs("tpImage")
		iLanguage = Rs("iLanguage")
		ReleaseDate = Rs("ReleaseDate")
		UpLoad_Image1=rs("UpLoad_Image1")
		info=rs("info")
		pxid=rs("pxid")
	End If
	Rs.Close
	Set Rs = Nothing
%>
	<tr>
		<td><input class="InputBtn" type="button" onFocus="blur()" value="修改类别"></td>
	</tr>
	<tr>
		<td>
		<table width="100%"  border="0" cellpadding="3" cellspacing="2" class="Bgtbtop">
					<form method="post"  action="CheckType.asp" name="EDFPType" onSubmit="if (tpName.value==''){return false;} Gi_disAllButton();">
					<input type="hidden" value="NWPType<% = BGSecSon %>" name="GBAction" >
					<input type="hidden" value="0" name="pxid" >
					  <tr>
						<td width="15%" height="25" align="right" class="Inputbtn">类别名称：</td>
						<td width="35%" class="Bgtdmain">
						<input style="width:100%" class="InputTxt" id="tpName" maxlength="25" size="31" name="tpName" value="<% = Gi_fUnChgHtmlStr(tpName) %>"></td>
						<td width="15%" height="25" align="right" class="Inputbtn">选择语言：</td>
						<td class="Bgtdmain"><% Call Gi_sGetLangCheckbox (iLanguage,"","") %></td>
					  </tr>
					 <!-- <tr>
					    <td align="right" valign="top" class="Inputbtn">排序：</td>
					    <td valign="top" class="Bgtdmain"><input class="InputTxt" id="pxid" maxlength="4" size="8" name="pxid" value="<% = pxid %>">
					      数字大的显示在前面</td>
					    <td height="25" align="right" class="Inputbtn">&nbsp;</td>
					    <td class="Bgtdmain">&nbsp;</td>
				      </tr>-->
					  <tr>
					  	<td align="right" valign="top" class="Inputbtn">简介：</td>
					  	<td valign="top" class="Bgtdmain"><input style="width:100%" class="InputTxt" id="tpinfo" maxlength="25" size="31" name="tpinfo" value="<% = Gi_fUnChgHtmlStr(tpinfo) %>"></td>
					  	<td height="25" align="right" class="Inputbtn">&nbsp;</td>
					  	<td class="Bgtdmain">&nbsp;</td>
				  	</tr>
					  <tr>
					    <td align="right" valign="top" class="Inputbtn"><input <%=tpImage%> name="Up_tpImage" type="button" class="InputBtn" id="Up_tpImage" onFocus="blur()" title="图片规格：344×228" onClick="Gi_getImageUpLoad('EDFPType','tpImage','../HtmlEdit/','类别图片','delImageTag','delImage','resetImage','prevImage');" value="类别图片" style="cursor:pointer;background-color:#990000;color:#FFFFFF;" /></td>
					    <td valign="top" class="Bgtdmain"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td><input name="tpImage" type="text" class="InputTxt" id="tpImage" value="<% = tpImage %>" /></td>
                            <td><%
R "<span id=""delImageTag"" style=""display:"
If tpImage <> "" Then
	R "block""><input CLASS=""InputBtn"" onfocus=""blur()"" id=""delImage"" name=""delImage"" type=""button"" value=""删除"" onClick=""tpImage.value='';resetImage.disabled='';prevImage.disabled=true;this.disabled=true;"">&nbsp;&nbsp;<input CLASS=""InputBtn"" onfocus=""blur()"" id=""resetImage"" name=""resetImage"" type=""button"" value=""复原"" disabled=true onClick=""tpImage.value='"& tpImage &"';delImage.disabled='';prevImage.disabled='';this.disabled=true; "">"
Else
	R "none""><input CLASS=""InputBtn"" onfocus=""blur()"" id=""delImage"" name=""delImage"" type=""button"" value=""删除"" onClick=""tpImage.value='';document.getElementById('delImageTag').style.display='none';"">&nbsp;&nbsp;<input id=""resetImage"" name=""resetImage"" type=""hidden"" value=""复原"">"
End If
R "&nbsp;&nbsp;<input CLASS=""inputbtn"" onfocus=""blur()"" type=""button"" name=""prevImage"" id=""prevImage"" value=""查看"" onClick=""Gi_winOpen('../htmledit/showuploadfile.asp?UpLoadPath='+ tpImage.value +'&UPType=图片');"">"
R "</span>"
%>                            </td>
                          </tr>
                        </table></td>
					    <td height="25" align="right" class="Inputbtn">发布日期：</td>
					    <td class="Bgtdmain"><table width="100%" cellpadding="0" cellspacing="0" border="0">
                          <tr>
                            <td><input  name="ReleaseDate" class="InputTxt" id="ReleaseDate" style="width:100%" value="<% = ReleaseDate %>" size="25" maxlength="10" readonly></td>
                            <td width="26"><img onClick="Gi_getOptDate('EDFPType','ReleaseDate');" src="../images/calendar.gif" border="0" align="absmiddle" hspace="5"  class="hAnd" alt="选择日期"></td>
                          <tr>
                                                </table></td>
					  </tr>
					  
					  <tr>
					    <td align="right" valign="top" class="Inputbtn" height="300">类别介绍：</td>
					    <td colspan="3" valign="top" class="Bgtdmain">

<input type="hidden" name="info" value="<%=Server.HTMLEncode(info)%>"><iframe id="eWebEditor1" src="../htmledit/ewebeditor.asp?id=info&style=hs_default" frameborder="0" scrolling="no" width="100%" height="100%"></iframe>						</td>
				      </tr>
					  <tr>
					    <td height="25" colspan="4" align="center" class="Inputbtn">
					      <input type="hidden" value="<% = tpID %>" name="tpID" >
                          <input style="width:45%"  class="InputTxt" onFocus="blur()" type="button" value="保存" name="edit" onClick="if(Gi_validForm('EDFPType','tpName','请输入<% = ZHModule %>类别名称')){submit(this.form);Gi_disAllButton();}">
                          &nbsp;&nbsp;&nbsp;&nbsp;
                          <input style="width:45%" class="InputTxt" onFocus="blur()" type="reset" value="重置" name="reset">					    </td>
				      </tr>
				 </form>
			  		  </table>
		</td>
	</tr>
</table>
<% End If %>
<table width="98%" border="0" cellspacing="0" cellpadding="3" align="center" class="Bgtbtop">

<tr><td><table width="100%"  border="0" cellpadding="0" cellspacing="1" class="tableList"><%Call get_tpTree(MaxLevel,iLanguage,tpID,4)%>	</table></td></tr>
</table>
</body>
</html>