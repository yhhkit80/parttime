<!--#include file="../../include/security.asp"-->
<!-- #include file="../../include/consts.asp" -->
<!-- #include file="../../include/Func.asp" -->
<!-- #include file="info_cfg.asp" -->
<%
GBAction = Request("GBAction")
PageNum = Request.Form("PageNum")

ID = Request.Form("ID")


huifu = Request.Form("huifu")
sh  = Request.Form("sh")

iLanguage    = Request.Form("iLanguage")


'�޸���������
if GBAction = "EDNContent"& BGSecSon &"" Then
'	If Content) = "" Then Call Gi_sOnErrGoBack("�������ݣ�")
		'StrSQL = "update  Feedback Set huifu='"& huifu &"'"			
'		StrSQL = StrSQL & ", sh = "& sh &""
'		StrSQL = StrSQL & ", h_time = '"& now() &"'"
'		
'		StrSQL = StrSQL & " Where ID = "& ID
'		fInUpData (StrSQL)
'		
'		Call Gi_sOnSucsReloadOpener ("���ظ��������ɹ���","info_list.asp")


'ɾ����������
elseif GBAction = "DELContent"& BGSecSon &"" Then

List_del = Request.Form("DelSel")
	If Len(List_del)<1 Then Gi_sOnErrGoBack ("��ϵͳ��ȱ�ٲ�������")

'	StrSQL = "delete from "& StrDBPrefix &"Info Where ID in ("& List_del &")"
'	fInUpData(StrSQL)
	StrSQL = "delete from Feedback  Where ID in ("& List_del &")"
	fInUpData(StrSQL)

	Call A ("��ɾ���������ɹ���")
	Call Gi_sOnSucsSubNext ("info_list.asp","<input type=""hidden"" id=""iLanguage"" name=""iLanguage"" value="""& iLanguage &"""><input type=""hidden"" id=""PageNum"" name=""PageNum"" value="""& PageNum &""">")


Else
	Call Gi_sOnSucsGoNext ("��ϵͳ�����������µ�½��","../logout.asp")
End If
%>
