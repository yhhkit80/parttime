<!--#include file="functionsetting.asp"-->
<!--#include file="security.asp"-->
<%
Dim UPFAction,UPTName,UPType
Dim ValidFileExt,ValidFileSize,UploadPath
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
%>
<HTML>
<HEAD>
<TITLE>上传<% = UPTName %></TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK href="sn.css" type=text/css rel=stylesheet>
<script  language="JavaScript" src="sn.js"></script>
</HEAD>
<BODY style="margin-left:15;margin-top:4;">

<%
'上传成功,插入相关上传信息到上传信息数据库
If UPFAction = "ADUPInfo"& GetUpSecSon Then
	AddPic = Request.Form("AddPic")
	UPID = Request.Form("UPID")
	BriefInfo = Request.Form("BriefInfo")

	If FileName <> "" And BriefInfo <> "" Then
		strSQL = "update "& StrDBPrefix &"UPInfo set BriefInfo = '"& BriefInfo &"' where UPID="& UPID
		fInUPData (strSQL)		
	End If
	If AddPic<>"" Then
		JS AddPic 
	Else
		JS "window.close();"
	End If

'执行文件上传
Elseif UPFAction = "EexUpLoad"& GetUpSecSon Then
	If UPTName = "" Then
		JS " alert('您已掉线请重新登陆!');window.close();"
	End If
	Call Gi_fGetUpLoad(UPType)

'选择文件上传
Elseif UPFAction = "GetUpLoad"& GetUpSecSon Then
 %>

<TABLE cellSpacing=0 cellPadding=0 width="100%">
  <FORM onSubmit="if(document.forms[0].nlFile.value.length == 0){alert('请选择<% = UPType %>再上传'); return false;} closeWin.disabled=true;backWin.disabled=true;sActiontr.style.display='none';sShowtr.style.display='block';" 
  action="getupload.asp?UPFAction=EexUpLoad<% = GetUpSecSon %>" method=post encType="multipart/form-data">
  <TBODY id=sActiontr>
    <TR align="center"> 
      <TD height="100"> <FIELDSET><LEGEND>【<font color="#AA0000">上传<% = UPType %></font>】</LEGEND> <br>
        <INPUT type=file size=31 name=nlFile>
        <br>
		<div align="left" style="width:100%;margin-left:3px;margin-top:7px;margin-bottom:7px;">
		<% = UPType %>后缀名<font style="font-size:12px;color:#AA0000;font-family:tahoma;font-weight:blod;">【 <% = Replace(ValidFileExt,"|","&nbsp;") %> 】</font>
		<br><% = UPType %>的大小<font style="font-size:12px;color:#AA0000;font-family:tahoma;font-weight:blod;">【 <% = ValidFileSize /1024 %> KB 】</font>
		</div>
        </FIELDSET></TD>
    </TR>
  <TR>
    <TD align=right height="70"><INPUT onMouseOver="this.style.backgroundColor='#E8E4DD'" onMouseOut="this.style.backgroundColor=''" CLASS="iButton" onFocus="blur()"  type="submit" value="上传" name="sAction" id="sAction"> 
<INPUT onMouseOver="this.style.backgroundColor='#E8E4DD'" onMouseOut="this.style.backgroundColor=''" CLASS="iButton" onFocus="blur()" onClick="javascript:window.close();" type="button" value="取消" name="closeWin">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT onMouseOver="this.style.backgroundColor='#E8E4DD'" onMouseOut="this.style.backgroundColor=''" CLASS="iButton" onFocus="blur()" type=button onClick="javascript:location.href = 'GetUpLoad.asp?UPFAction=OptUpLoad';" value="返回" name="backWin">
 </TD></TR></TBODY></FORM><tr id=sShowtr style="display:none"><td align="center"><br><br><FIELDSET><br><br><%=UPType%>正在上传请稍等............<br><br><br></FIELDSET></td>
 </tr></TABLE>

<%
'选择上传文件上传或从文件库中获得
Elseif UPFAction = "OptUpLoad" Then
%>
<SCRIPT language=javascript>
<!--
function sChange(){
	if(document.forms[0].nlSel[0].checked){
		document.forms[0].sAction.value = "上传";
	}else{
		document.forms[0].sAction.value = "选择";
	}
}  

function sGetUpLoadProceed(){
	if(document.forms[0].nlSel[0].checked){
		location.href = "getupload.asp?UPFAction=GetUpLoad<% = GetUpSecSon %>";
	}else{
		parent.sCallLib();
	}
}
//-->
</SCRIPT>

<TABLE cellSpacing=0 cellPadding=0 width="100%">
  <FORM>
  <TR>
      <TD height="100"> <FIELDSET height="150"><LEGEND>【<font color="#AA0000">选择插入<% = UPType %></font>】</LEGEND><br><br>
        <INPUT id=sUoi onClick="sChange();" type=radio CHECKED value=1 name=nlSel><LABEL for=sUoi>上传<% = UPType %></LABEL>
		&nbsp;&nbsp;
		<INPUT id=sSfl onClick="sChange();" type=radio value=2 name=nlSel >
        <LABEL for=sSfl>选择<% = UPType %>库中的<% = UPType %></LABEL> 
		<br>
		<br>
		<br>
		</FIELDSET>
		</TD>
    </TR>
  <TR>
    <TD align=right height="70"><INPUT onMouseOver="this.style.backgroundColor='#E8E4DD'" onMouseOut="this.style.backgroundColor=''" CLASS="iButton" onFocus="blur()" onClick="sGetUpLoadProceed();" type=button value=上传 name=sAction> 
<INPUT onMouseOver="this.style.backgroundColor='#E8E4DD'" onMouseOut="this.style.backgroundColor=''" CLASS="iButton" onFocus="blur()" onClick="javascript: window.close();" type=button value=取消></TD></TR></FORM></TABLE>

<%
Else
	JS "window.close();"
End If
%>
</BODY></HTML>