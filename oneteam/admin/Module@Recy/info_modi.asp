<!-- #include File="../../Include/Security.Asp" -->
<!-- #include File="../../Include/Consts.Asp" -->
<!-- #include File="../../Include/Func.Asp" -->
<!-- #include file="info_cfg.asp" -->
<%
iLanguage = Request.Form("iLanguage")
KeyWords = Request.Form("KeyWords")
	if KeyWords = "" then KeyWords = "关键字"
IDTree = Request.Form("IDTree")
	if IDTree = "" then IDTree = Arr_tpTree(iLanguage)

SrchAllHObj = "<input type=""hidden"" id=""IDTree"" name=""IDTree"" value="""& IDTree &"""><input type=""hidden"" id=""iLanguage"" name=""iLanguage"" value="""& iLanguage &"""><input type=""hidden"" id=""keyWords"" name=""keyWords"" value="""& KeyWords &""">"

Call Gi_sGetLangVar
%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charSet=gb2312">
<link href="../css/css.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../htmledit/optSetting.js"></script>
<script language="javascript" src="../script/func.js"></script>
<script language="javascript" src="../script/blur.js"></script>
</head>
<body>
<!--#include file="info_nav.asp" -->
<br />
<%
Dim Rs,StrSQL,GBAction
GBAction = Request.Form("GBAction")
ID = Request.form("ID")
IDTree = Request.form("IDTree")
iLanguage = Request.form("iLanguage")

Call Gi_sGetLangVar

If ID <> "" And GBAction = "EDNContent"& BGSecSon &"" Then
	StrSQL = "select * from "& StrDBPrefix & "Info where ID="& ID
	Set Rs = fGetRsList(StrSQL)
	If Not Rs.Eof Then
		IDTree       = Rs("IDTree")
		Title        = Rs("Title")
		Intro        = Rs("Intro")
		Content      = Rs("Content")
		KeyWord      = Rs("KeyWord")
		UpLoad_File  = Rs("UpLoad_File")
		UpLoad_Image = Rs("UpLoad_Image")
		State_OnOff  = Rs("State_OnOff")
		ReleaseDate  = Rs("ReleaseDate")
		iLanguage    = Rs("iLanguage")
	End If
Else
	ReleaseDate = Date()
End If

%>
<form method=POST action="info_check.asp" name="AEFContent" onSubmit="JScript:return Gi_validForm('AEFContent','Title','请输入<% = Menu %>标题！');">
  <table width="98%" border="0" cellspacing="2" cellpadding="3" align="center" class="Bgtbtop">
    <input type="hidden" name="GBAction" value="">	
	<input type="hidden" name="PageNum" value="<%=PageNum%>">
	<input type="hidden" name="iLanguage" value="<%=iLanguage%>">
    <tr> 
      <td width="100" align="right" class="bgTdTopGray">标题：</td>
      <td colspan="3" class="Bgtdmain"><input style="width:100%;" class="InputTxt" maxlength="100" size="31" value="<% = Gi_fChgHtmlStr(Title) %>"  name="Title"></td>
      <td width="75" align="right" class="bgTdTopGray">属性设置：</td>
      <td class="Bgtdmain"><% = Is_Out(State_OnOff,"list")%></tr>
    
    <tr>
      <td align="right" class="bgTdTopGray">分类：</td>
      <td width="135" class="Bgtdmain"><input type="hidden" name="ID" value="<% = ID %>"><%sb_tpSelect IDTree,iLanguage,isLeaf%></td>
      <td width="60" align="right" class="bgTdTopGray">关键字：</td>
      <td width="75" class="Bgtdmain"><input  name="KeyWord" class="InputTxt" id="KeyWord" value="<% = KeyWord %>" size="12" maxlength="6"></td>
      <td align="right" class="bgTdTopGray" title="123">发布日期：</td>
      <td class="Bgtdmain"><table width="100%" cellpadding="0" cellspacing="0" border="0">
          <tr>
            <td><input style="width:100%" class="InputTxt" readonly maxlength="10" size="25"  name="ReleaseDate" value="<% = ReleaseDate %>"></td>
            <td width="26"><img onClick="Gi_getOptDate('AEFContent','ReleaseDate');" src="../images/calendar.gif" border="0" align="absmiddle" hspace="5"   style="cursor:hand;"></td>
          <tr>
          </table></td>
    </tr>
    <tr>
      <td rowspan="2" align="right" valign="top" class="bgTdTopGray">简介：</td>
      <td colspan="3" rowspan="2" valign="top" class="Bgtdmain"><textarea style="width:100%;" name="Intro" cols="35" rows="3"><%=Intro%></textarea>      </td>
      <td align="right" class="bgTdTopGray"><input <%=IsUpFile%> name="UpFile" type="button" class="InputBtn" id="UpFile" onFocus="blur()" onClick="Gi_getFileUpLoad('AEFContent','UpLoad_File','../HtmlEdit/','附件文件','delFileTag','delFile','resetFile','prevFile');" value="附件文件" /></td>
      <td class="Bgtdmain">
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><input name="UpLoad_File" type="text" class="InputTxt" id="UpLoad_File" value="<% = UpLoad_File %>" size="31" readonly="READONLY" /></td>
<td><%
R "<span id=""delFileTag"" style=""display:"
If UpLoad_File <> "" Then
	R "block""><input CLASS=""InputBtn"" onfocus=""blur()"" id=""delFile"" name=""delFile"" type=""button"" value=""删除"" onClick=""UpLoad_File.value='';resetFile.disabled='';prevFile.disabled=true;this.disabled=true;"">&nbsp;&nbsp;<input CLASS=""InputBtn"" onfocus=""blur()"" id=""resetFile"" name=""resetFile"" type=""button"" value=""复原"" disabled=true onClick=""UpLoad_File.value='"& UpLoad_File &"';delFile.disabled='';prevFile.disabled='';this.disabled=true; "">"
Else
	R "none""><input CLASS=""InputBtn"" onfocus=""blur()"" id=""delFile"" name=""delFile"" type=""button"" value=""删除"" onClick=""UpLoad_File.value='';document.getElementById('delFileTag').style.display='none';"">&nbsp;&nbsp;<input id=""resetFile"" name=""resetFile"" type=""hidden"" value=""复原"">"
End If
R "&nbsp;&nbsp;<input CLASS=""inputbtn"" onfocus=""blur()"" type=""button"" name=""prevFile"" id=""prevFile"" value=""查看"" onClick=""Gi_winOpen('../htmledit/showuploadfile.asp?UpLoadPath='+ UpLoad_File.value +'&UPType=文件');"">"
R "</span>"
%></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td align="right" class="bgTdTopGray"><input <%=IsUpImage%> name="UpImage" type="button" class="InputBtn" id="UpImage" onFocus="blur()" onClick="Gi_getImageUpLoad('AEFContent','UpLoad_Image','../HtmlEdit/','附件图片','delImageTag','delImage','resetImage','prevImage');" value="附件图片" /></td>
      <td class="Bgtdmain"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><input name="UpLoad_Image" type="text" class="InputTxt" id="UpLoad_Image" value="<% = UpLoad_Image %>" size="31" readonly="READONLY" /></td>
<td><%
R "<span id=""delImageTag"" style=""display:"
If UpLoad_Image <> "" Then
	R "block""><input CLASS=""InputBtn"" onfocus=""blur()"" id=""delImage"" name=""delImage"" type=""button"" value=""删除"" onClick=""UpLoad_Image.value='';resetImage.disabled='';prevImage.disabled=true;this.disabled=true;"">&nbsp;&nbsp;<input CLASS=""InputBtn"" onfocus=""blur()"" id=""resetImage"" name=""resetImage"" type=""button"" value=""复原"" disabled=true onClick=""UpLoad_Image.value='"& UpLoad_Image &"';delImage.disabled='';prevImage.disabled='';this.disabled=true; "">"
Else
	R "none""><input CLASS=""InputBtn"" onfocus=""blur()"" id=""delImage"" name=""delImage"" type=""button"" value=""删除"" onClick=""UpLoad_Image.value='';document.getElementById('delImageTag').style.display='none';"">&nbsp;&nbsp;<input id=""resetImage"" name=""resetImage"" type=""hidden"" value=""复原"">"
End If
R "&nbsp;&nbsp;<input CLASS=""inputbtn"" onfocus=""blur()"" type=""button"" name=""prevImage"" id=""prevImage"" value=""查看"" onClick=""Gi_winOpen('../htmledit/showuploadfile.asp?UpLoadPath='+ UpLoad_Image.value +'&UPType=图片');"">"
R "</span>"
%></td>
        </tr>
      </table></td>
    </tr>
    <tr> 
      <td align="center" class="bgTdTopGray" colspan="6"> 正文</td>
    </tr>
    <tr> 
      <td align="center"  colspan="6" class="Bgtdmain" valign="top"><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" class="Bgtdmain">
          <tr> 
            <td valign="top" height="270"> <input type="hidden" name="Content" value="<%=Server.HTMLEncode(Content)%>"> 
              <iframe id="eWebEditor1" src="../htmledit/ewebeditor.asp?id=Content&style=standard" frameborder="0" scrolling="no" width="100%" height="100%"></iframe>            </td>
          </tr>
          <tr> 
            <td><img src="../images/spacer.gif" width="625" height="0"></td>
          </tr>
        </table></td>
    </tr>
    <tr align="center" class="bgTdTopGray"> 
      <td colspan="6" height="30"><input class="InputBtn" onFocus="blur()" type="submit" name="addedit" 
	<%
		If ID = "" Then 
			Response.Write "value=""添加"& Menu &"内容"" onClick=""GBAction.value='ADNContent"& BGSecSon &"';"" " 
		Else
			Response.Write "value=""修改"& Menu &"内容"" onClick=""GBAction.value='EDNContent"& BGSecSon &"';"" "
		End If
    %>></td>
    </tr>
  </table>		
</td>
</tr>
</table>
</form>
</body>
</html>