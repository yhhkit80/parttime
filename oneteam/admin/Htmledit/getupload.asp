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
<TITLE>�ϴ�<% = UPTName %></TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK href="sn.css" type=text/css rel=stylesheet>
<script  language="JavaScript" src="sn.js"></script>
</HEAD>
<BODY style="margin-left:15;margin-top:4;">

<%
'�ϴ��ɹ�,��������ϴ���Ϣ���ϴ���Ϣ���ݿ�
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

'ִ���ļ��ϴ�
Elseif UPFAction = "EexUpLoad"& GetUpSecSon Then
	If UPTName = "" Then
		JS " alert('���ѵ��������µ�½!');window.close();"
	End If
	Call Gi_fGetUpLoad(UPType)

'ѡ���ļ��ϴ�
Elseif UPFAction = "GetUpLoad"& GetUpSecSon Then
 %>

<TABLE cellSpacing=0 cellPadding=0 width="100%">
  <FORM onSubmit="if(document.forms[0].nlFile.value.length == 0){alert('��ѡ��<% = UPType %>���ϴ�'); return false;} closeWin.disabled=true;backWin.disabled=true;sActiontr.style.display='none';sShowtr.style.display='block';" 
  action="getupload.asp?UPFAction=EexUpLoad<% = GetUpSecSon %>" method=post encType="multipart/form-data">
  <TBODY id=sActiontr>
    <TR align="center"> 
      <TD height="100"> <FIELDSET><LEGEND>��<font color="#AA0000">�ϴ�<% = UPType %></font>��</LEGEND> <br>
        <INPUT type=file size=31 name=nlFile>
        <br>
		<div align="left" style="width:100%;margin-left:3px;margin-top:7px;margin-bottom:7px;">
		<% = UPType %>��׺��<font style="font-size:12px;color:#AA0000;font-family:tahoma;font-weight:blod;">�� <% = Replace(ValidFileExt,"|","&nbsp;") %> ��</font>
		<br><% = UPType %>�Ĵ�С<font style="font-size:12px;color:#AA0000;font-family:tahoma;font-weight:blod;">�� <% = ValidFileSize /1024 %> KB ��</font>
		</div>
        </FIELDSET></TD>
    </TR>
  <TR>
    <TD align=right height="70"><INPUT onMouseOver="this.style.backgroundColor='#E8E4DD'" onMouseOut="this.style.backgroundColor=''" CLASS="iButton" onFocus="blur()"  type="submit" value="�ϴ�" name="sAction" id="sAction"> 
<INPUT onMouseOver="this.style.backgroundColor='#E8E4DD'" onMouseOut="this.style.backgroundColor=''" CLASS="iButton" onFocus="blur()" onClick="javascript:window.close();" type="button" value="ȡ��" name="closeWin">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT onMouseOver="this.style.backgroundColor='#E8E4DD'" onMouseOut="this.style.backgroundColor=''" CLASS="iButton" onFocus="blur()" type=button onClick="javascript:location.href = 'GetUpLoad.asp?UPFAction=OptUpLoad';" value="����" name="backWin">
 </TD></TR></TBODY></FORM><tr id=sShowtr style="display:none"><td align="center"><br><br><FIELDSET><br><br><%=UPType%>�����ϴ����Ե�............<br><br><br></FIELDSET></td>
 </tr></TABLE>

<%
'ѡ���ϴ��ļ��ϴ�����ļ����л��
Elseif UPFAction = "OptUpLoad" Then
%>
<SCRIPT language=javascript>
<!--
function sChange(){
	if(document.forms[0].nlSel[0].checked){
		document.forms[0].sAction.value = "�ϴ�";
	}else{
		document.forms[0].sAction.value = "ѡ��";
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
      <TD height="100"> <FIELDSET height="150"><LEGEND>��<font color="#AA0000">ѡ�����<% = UPType %></font>��</LEGEND><br><br>
        <INPUT id=sUoi onClick="sChange();" type=radio CHECKED value=1 name=nlSel><LABEL for=sUoi>�ϴ�<% = UPType %></LABEL>
		&nbsp;&nbsp;
		<INPUT id=sSfl onClick="sChange();" type=radio value=2 name=nlSel >
        <LABEL for=sSfl>ѡ��<% = UPType %>���е�<% = UPType %></LABEL> 
		<br>
		<br>
		<br>
		</FIELDSET>
		</TD>
    </TR>
  <TR>
    <TD align=right height="70"><INPUT onMouseOver="this.style.backgroundColor='#E8E4DD'" onMouseOut="this.style.backgroundColor=''" CLASS="iButton" onFocus="blur()" onClick="sGetUpLoadProceed();" type=button value=�ϴ� name=sAction> 
<INPUT onMouseOver="this.style.backgroundColor='#E8E4DD'" onMouseOut="this.style.backgroundColor=''" CLASS="iButton" onFocus="blur()" onClick="javascript: window.close();" type=button value=ȡ��></TD></TR></FORM></TABLE>

<%
Else
	JS "window.close();"
End If
%>
</BODY></HTML>