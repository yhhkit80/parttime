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
<style type="text/css">
.title_menub{color:#8f682f; font-size:14px; font-weight:bold;}
.font{color:#8f682f;}
</style>
<body>
<!--#include file="info_nav.asp" -->
<br />
<%
Dim Rs,StrSQL,GBAction
GBAction = Request.Form("GBAction")
ID = Request("ID")
pagenum = Request("pagenum")
iLanguage = Request.form("iLanguage")

Call Gi_sGetLangVar

If ID <> ""  Then
	fInUpdata("update Feedback set hit=1 where id="&id)
	StrSQL = "select * from Feedback where ID="& ID
	Set Rs = fGetRsList(StrSQL)
	If Not Rs.Eof Then
		

company=rs("company")
address=rs("address")
guojia=rs("guojia")
username=rs("username")
tel=rs("tel")
content=rs("content")
email=rs("email")
market=rs("market")

idtree=rs("idtree")
iLanguage=rs("iLanguage")
releasedate=rs("releasedate")
	End If
Else
	ReleaseDate = Date()
End If

%>
<form method=POST action="info_check.asp" name="AEFContent" onSubmit="JScript:return Gi_validForm('AEFContent','Title','请输入<% = Menu %>标题！');">
<table width="98%" border="0" cellspacing="1" cellpadding="2" align="center" class="Bgtbtop">
  <input type="hidden" name="GBAction" value="">
  <input type="hidden" name="iLanguage2" value="<%=iLanguage%>">
  <input type="hidden" name="id" value="<%=id%>">
  
  <tr>
    <td width="18%" align="right" class="Inputbtn">Company Name：</td>
    <td width="82%" class="Bgtdmain"><%=company%>&nbsp;</td>
    </tr> 
	<tr>
		<td align="right" class="Inputbtn">Address ：</td>
		<td class="Bgtdmain"><%=address%>&nbsp;</td>
	</tr>
	<tr>
	  <td align="right" class="Inputbtn">Country：</td>
    <td class="Bgtdmain"><%=guojia%>&nbsp;</td>
  </tr>
	<tr>
	  <td align="right" class="Inputbtn">Contact Person：</td>
    <td class="Bgtdmain"><%=username%>&nbsp;</td>
  </tr>
	<tr>
	  <td align="right" class="Inputbtn">Tel：</td>
    <td class="Bgtdmain"><%=tel%>&nbsp;</td>
  </tr>
	<tr>
	  <td align="right" class="Inputbtn">Email ：</td>
    <td class="Bgtdmain"><%=email%>&nbsp;</td>
  </tr>
	<tr>
	  <td align="right" class="Inputbtn">Your Market：</td>
    <td class="Bgtdmain"><%=market%>&nbsp;</td>
  </tr>
	<tr>
	  <td align="right" class="Inputbtn">Remarks：</td>
    <td class="Bgtdmain"><%if content<>"" then response.Write(replace(content,vbcrlf,"<br>"))%>&nbsp;</td>
  </tr>
  
  

  <tr>
    <td width="18%" align="right" class="Inputbtn">Add Date ：</td>
    <td class="Bgtdmain"><%=releasedate%>&nbsp;</td>
  </tr>
  <tr>
    <td align="right" valign="top" class="Inputbtn"></td>
    <td align="left" valign="top" class="Bgtdmain"></td>
    </tr>
  <tr align="center" class="bgTdTopGray">
    <td height="30" colspan="2" class="Inputbtn"><input name="addedit" type="button" class="InputTxt"  value=" 返回 " onClick="location.href='info_list.asp?pagenum=<%=pagenum%>&iLanguage=<%=iLanguage%>'"></td>
  </tr>
</table>
</td>
  </tr>
  </table>
</form>
</body>
</html>