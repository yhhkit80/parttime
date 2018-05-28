<!-- #include File="../../Include/Security.Asp" -->
<!-- #include File="../../Include/Consts.Asp" -->
<!-- #include File="../../Include/Func.Asp" -->
<!-- #include file="info_cfg.asp" -->
<%
iLanguage = Request("iLanguage")
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
iLanguage = Request("iLanguage")
PageNum = Request("PageNum")
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
		UpLoad_Image1 = Rs("UpLoad_Image1")
		State_OnOff  = Rs("State_OnOff")
		ReleaseDate  = Rs("ReleaseDate")
		iLanguage    = Rs("iLanguage")
		pxid=rs("pxid")
	End If
Else
	pxid=0
	ReleaseDate = Date()
End If

%>
<form method=POST action="info_check.asp" name="AEFContent" onSubmit="JScript:return Gi_validForm('AEFContent','Title','请输入<% = Menu %>标题！');">
  <table width="98%" border="0" cellspacing="2" cellpadding="3" align="center" class="Bgtbtop">
    <input type="hidden" name="GBAction" value="">
	<input type="hidden" name="PageNum" value="<%=PageNum%>">
	<input type="hidden" name="iLanguage" value="<%=iLanguage%>">
	<input type="hidden" name="pxid" value="<%=pxid%>">
    <tr> 
      <td width="100" align="right" class="Inputbtn">名称：</td>
      <td width="300" class="Bgtdmain"><input style="width:300px;" class="InputTxt" maxlength="100" size="20" value="<% = Gi_fChgHtmlStr(Title) %>"  name="Title"></td>
      <td width="100" align="right" class="Inputbtn">属性：</td>
      <td class="Bgtdmain"><% = Is_Out(State_OnOff,"list")%>      </tr>
    <tr>
      <td align="right" class="Inputbtn">分类：</td>
      <td class="Bgtdmain"><input type="hidden" name="ID" value="<% = ID %>">
      <%sb_tpSelect IDTree,iLanguage,isLeaf%></td>
      <td align="right" class="Inputbtn">发布日期：</td>
      <td class="Bgtdmain"><table width="300" cellpadding="0" cellspacing="0" border="0">
        <tr>
          <td><input style="width:100%" class="InputTxt" readonly maxlength="10" size="25"  name="ReleaseDate" value="<% = ReleaseDate %>"></td>
          <td width="26"><img onClick="Gi_getOptDate('AEFContent','ReleaseDate');" src="../images/calendar.gif" border="0" align="absmiddle" hspace="5"   style="cursor:hand;"></td>
        <tr>
            </table></td>
    </tr>
	 <tr>
      <td height="300" align="right" valign="top" class="Inputbtn">详细内容：</td>
      <td height="300" colspan="3" class="Bgtdmain">&nbsp;<input type="hidden" name="Content" value="<%=Server.HTMLEncode(Content)%>">
        <iframe id="eWebEditor1" src="../htmledit/ewebeditor.asp?id=Content&style=hs_default" frameborder="0" scrolling="no" width="100%" height="100%"></iframe></td>
    </tr>
    <tr align="center" class="bgTdTopGray"> 
      <td height="30" colspan="4" class="Inputbtn"><input class="InputTxt" onFocus="blur()" type="submit" name="addedit" 
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