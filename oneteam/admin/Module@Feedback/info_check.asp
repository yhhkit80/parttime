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


'修改新闻内容
if GBAction = "EDNContent"& BGSecSon &"" Then
'	If Content) = "" Then Call Gi_sOnErrGoBack("正文内容！")
		'StrSQL = "update  Feedback Set huifu='"& huifu &"'"			
'		StrSQL = StrSQL & ", sh = "& sh &""
'		StrSQL = StrSQL & ", h_time = '"& now() &"'"
'		
'		StrSQL = StrSQL & " Where ID = "& ID
'		fInUpData (StrSQL)
'		
'		Call Gi_sOnSucsReloadOpener ("「回复」操作成功！","info_list.asp")


'删除新闻内容
elseif GBAction = "DELContent"& BGSecSon &"" Then

List_del = Request.Form("DelSel")
	If Len(List_del)<1 Then Gi_sOnErrGoBack ("「系统」缺少操作对象")

'	StrSQL = "delete from "& StrDBPrefix &"Info Where ID in ("& List_del &")"
'	fInUpData(StrSQL)
	StrSQL = "delete from Feedback  Where ID in ("& List_del &")"
	fInUpData(StrSQL)

	Call A ("「删除」操作成功！")
	Call Gi_sOnSucsSubNext ("info_list.asp","<input type=""hidden"" id=""iLanguage"" name=""iLanguage"" value="""& iLanguage &"""><input type=""hidden"" id=""PageNum"" name=""PageNum"" value="""& PageNum &""">")


Else
	Call Gi_sOnSucsGoNext ("「系统」错误，请重新登陆！","../logout.asp")
End If
%>
