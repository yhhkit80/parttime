<!--#include file="../../include/security.asp"-->
<!-- #include file="../../include/consts.asp" -->
<!-- #include file="../../include/Func.asp" -->
<!-- #include file="info_cfg.asp" -->
<%
GBAction = Request("GBAction")
PageNum = Request("PageNum")

ID           = Request.Form("ID")
IDTree       = Request.Form("IDTree")
Title        = Gi_fChgSQLStr(Trim( Request.Form("Title")))
Intro        = Request.Form("Intro")
	if len(Intro)>100 then Call Gi_sOnErrGoBack("��鲻�ó���100���ַ���")
For i = 1 To Request.Form("Content").Count
	Content = Content & Request.Form("Content")(i)
Next
Content      = Gi_fChgSQLStr(Content)
KeyWord      = Request.Form("KeyWord")
UpLoad_Image = Request.Form("UpLoad_Image")
UpLoad_File  = Request.Form("UpLoad_File")
State_OnOff  = Request.Form("OnOff")
ReleaseDate  = Request.Form("ReleaseDate")
iLanguage    = Request.Form("iLanguage")

'�����������
If GBAction = "ADNContent"& BGSecSon &"" Then
'	If Content) = "" Then Call Gi_sOnErrGoBack("�������ݣ�")
		StrSQL = "insert into "& StrDBPrefix &"Info(IDTree,Title,Intro,Content,KeyWord,UpLoad_File,UpLoad_Image,State_OnOff,ReleaseDate,iLanguage) values('"& IDTree &"'"
		StrSQL = StrSQL & ",'"& Title &"'"
		StrSQL = StrSQL & ",'"& Intro &"'"
		StrSQL = StrSQL & ",'"& Content &"'"
		StrSQL = StrSQL & ",'"& KeyWord &"'"
		StrSQL = StrSQL & ",'"& UpLoad_File &"'"
		StrSQL = StrSQL & ",'"& UpLoad_Image &"'"
		StrSQL = StrSQL & ",'"& State_OnOff &"' "
		StrSQL = StrSQL & ",'"& ReleaseDate &"' "
		StrSQL = StrSQL & ","& iLanguage &")"
		fInUpData (StrSQL)
		
		R "<head><link href=""../css/css.css"" rel=""stylesheet"" type=""text/css""><script Language=""javascript"" src=""../script/func.js""></script><script language=""javascript"" src=""../htmledit/optSetting.js""></script><script language=""javascript"" src=""../script/blur.js""></script></head><body><table width=""100%"" height=""100%"" border=""0"" align=""center"" cellpadding=""5"" cellspacing=""5""><form action=""info_modi.asp"" method=""post"" name=""GTADNContent"" onSubmit=""Gi_disAllButton();""><input type=""hidden"" name=""NWTypeID"" value="""& NWTypeID &"""><input type=""hidden"" name=""iLanguage"" value="""& iLanguage &"""><tr><td width=""100%"" height=""100%"" Class=""Bgtdmain""><table  class=""bgTdTopGray"" width=""300"" height=""150"" border=""0"" align=""center"" cellpadding=""10"" cellspacing=""5""><tr><td align=""center"" Class=""Bgtdmain""><br><input onfocus=""blur()"" CLASS=""InputBtn"" type=""submit"" name=""oDsubmit"" value=""�������""><br><br><br><input onfocus=""blur()"" CLASS=""InputBtn"" type=""button"" name=""oDsubmit"" value=""�����б�"" onClick=""location.href='info_list.asp'""><br></td></tr></table></td></tr></table></table>"
		E


'�޸���������
Elseif GBAction = "EDNContent"& BGSecSon &"" Then
'	If Content) = "" Then Call Gi_sOnErrGoBack("�������ݣ�")
		StrSQL = "update  "& StrDBPrefix &"Info Set IDTree='"& IDTree &"'"			
		StrSQL = StrSQL & ", Title = '"& Title &"'"
		StrSQL = StrSQL & ", Intro = '"& Intro &"'"
		StrSQL = StrSQL & ", Content = '"& Content &"'"
		StrSQL = StrSQL & ", KeyWord = '"& KeyWord &"'"
		StrSQL = StrSQL & ", UpLoad_File = '"& UpLoad_File &"'"
		StrSQL = StrSQL & ", UpLoad_Image = '"& UpLoad_Image &"'"
		StrSQL = StrSQL & ", State_OnOff = '"& State_OnOff &"'"
		StrSQL = StrSQL & ", ReleaseDate = '"& ReleaseDate &"'"
		StrSQL = StrSQL & ", iLanguage = "& iLanguage &""
		StrSQL = StrSQL & " where ID = "& ID
		fInUpData (StrSQL)
		Call Gi_sOnSucsReloadOpener ("���޸ġ������ɹ���","info_list.asp?PageNum="&PageNum)

'��ԭ��ɾ��
Elseif GBAction = "reDELContent"& BGSecSon &"" Then

List_del = Request.Form("DelSel")
	If Len(List_del)<1 Then Gi_sOnErrGoBack ("��ϵͳ��ȱ�ٲ�������")

	StrSQL = "Update "& StrDBPrefix &"Info Set IDTree = mid(IDTree,2,Len(IDTree)) where ID in ("& List_del &")"
	fInUpData(StrSQL)

	Call A ("����ԭ�������ɹ���")
	Call Gi_sOnSucsSubNext ("info_list.asp","<input type=""hidden"" id=""iLanguage"" name=""iLanguage"" value="""& iLanguage &"""><input type=""hidden"" id=""PageNum"" name=""PageNum"" value="""& PageNum &""">")

'����ɾ��
Elseif GBAction = "realDELContent"& BGSecSon &"" Then

List_del = Request.Form("DelSel")
	If Len(List_del)<1 Then Gi_sOnErrGoBack ("��ϵͳ��ȱ�ٲ�������")

	StrSQL = "delete from "& StrDBPrefix &"Info where ID in ("& List_del &")"
	fInUpData(StrSQL)

	Call A ("������ɾ���������ɹ���")
	Call Gi_sOnSucsSubNext ("info_list.asp","<input type=""hidden"" id=""iLanguage"" name=""iLanguage"" value="""& iLanguage &"""><input type=""hidden"" id=""PageNum"" name=""PageNum"" value="""& PageNum &""">")

Else
	Call Gi_sOnSucsGoNext ("��ϵͳ�����������µ�½��","logout.asp")
End If
%>