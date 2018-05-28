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
if Title<>"" then Title=replace(title,"&nbsp;"," ")
Intro        = Gi_fChgSQLStr(Request.Form("Intro"))
'	if len(Intro)>200 then Call Gi_sOnErrGoBack("简介不得超过200个字符！")
For i = 1 To Request.Form("Content").Count
	Content = Content & Request.Form("Content")(i)
Next
Content      = Gi_fChgSQLStr(Content)
KeyWord      = Request.Form("KeyWord")
UpLoad_Image = Request.Form("UpLoad_Image")
UpLoad_Image1 = Request.Form("UpLoad_Image1")
UpLoad_File  = Request.Form("UpLoad_File")
State_OnOff  = Request.Form("OnOff")
ReleaseDate  = Request.Form("ReleaseDate")
iLanguage    = Request.Form("iLanguage")

pxid=Request.Form("pxid")
if not isnumeric(pxid) then pxid=0
if pxid="" then pxid=0

'添加新闻内容
If GBAction = "ADNContent"& BGSecSon &"" Then
'	If Content) = "" Then Call Gi_sOnErrGoBack("正文内容！")
		StrSQL = "insert into "& StrDBPrefix &"Info(IDTree,Title,Intro,Content,KeyWord,UpLoad_File,UpLoad_Image,UpLoad_Image1,State_OnOff,ReleaseDate,pxid,iLanguage) values('"& IDTree &"'"
		StrSQL = StrSQL & ",'"& Title &"'"
		StrSQL = StrSQL & ",'"& Intro &"'"
		StrSQL = StrSQL & ",'"& Content &"'"
		StrSQL = StrSQL & ",'"& KeyWord &"'"
		StrSQL = StrSQL & ",'"& UpLoad_File &"'"
		StrSQL = StrSQL & ",'"& UpLoad_Image &"'"
		StrSQL = StrSQL & ",'"& UpLoad_Image1 &"'"
		StrSQL = StrSQL & ",'"& State_OnOff &"' "
		StrSQL = StrSQL & ",'"& ReleaseDate &"' "
		StrSQL = StrSQL & ","& pxid &" "
		StrSQL = StrSQL & ","& iLanguage &")"
		fInUpData (StrSQL)
		
		R "<head><link href=""../css/css.css"" rel=""stylesheet"" type=""text/css""><script Language=""javascript"" src=""../script/func.js""></script><script language=""javascript"" src=""../htmledit/optSetting.js""></script><script language=""javascript"" src=""../script/blur.js""></script></head><body><table width=""100%"" height=""100%"" border=""0"" align=""center"" cellpadding=""5"" cellspacing=""5""><form action=""info_modi.asp?iLanguage="&iLanguage&""" method=""post"" name=""GTADNContent"" onSubmit=""Gi_disAllButton();""><input type=""hidden"" name=""iLanguage"" value="""& iLanguage &"""><tr><td width=""100%"" height=""100%"" Class=""Bgtdmain""><table  class=""bgTdTopGray"" width=""300"" height=""150"" border=""0"" align=""center"" cellpadding=""10"" cellspacing=""5""><tr><td align=""center"" Class=""Bgtdmain""><br><input onfocus=""blur()"" CLASS=""InputBtn"" type=""submit"" name=""oDsubmit"" value=""继续添加""><br><br><br><input onfocus=""blur()"" CLASS=""InputBtn"" type=""button"" name=""oDsubmit"" value=""返回列表"" onClick=""location.href='info_list.asp?iLanguage="&iLanguage&"'""><br></td></tr></table></td></tr></form></table>"
		E


'修改新闻内容
Elseif GBAction = "EDNContent"& BGSecSon &"" Then
'	If Content) = "" Then Call Gi_sOnErrGoBack("正文内容！")
		StrSQL = "update  "& StrDBPrefix &"Info Set IDTree='"& IDTree &"'"			
		StrSQL = StrSQL & ", Title = '"& Title &"'"
		StrSQL = StrSQL & ", Intro = '"& Intro &"'"
		StrSQL = StrSQL & ", Content = '"& Content &"'"
		StrSQL = StrSQL & ", KeyWord = '"& KeyWord &"'"
		StrSQL = StrSQL & ", UpLoad_File = '"& UpLoad_File &"'"
		StrSQL = StrSQL & ", UpLoad_Image = '"& UpLoad_Image &"'"
		StrSQL = StrSQL & ", UpLoad_Image1 = '"& UpLoad_Image1 &"'"
		StrSQL = StrSQL & ", State_OnOff = '"& State_OnOff &"'"
		StrSQL = StrSQL & ", ReleaseDate = '"& ReleaseDate &"'"
		StrSQL = StrSQL & ", pxid = "& pxid &""
		StrSQL = StrSQL & ", iLanguage = "& iLanguage &""
		StrSQL = StrSQL & " Where ID = "& ID
		fInUpData (StrSQL)
		
		Call Gi_sOnSucsReloadOpener ("「修改」操作成功！","info_list.asp?PageNum="&PageNum&"&iLanguage="&iLanguage)


'删除新闻内容
Elseif GBAction = "DELContent"& BGSecSon &"" Then

List_del = Request.Form("DelSel")
	If Len(List_del)<1 Then Gi_sOnErrGoBack ("「系统」缺少操作对象")

'	StrSQL = "delete from "& StrDBPrefix &"Info Where ID in ("& List_del &")"
'	fInUpData(StrSQL)
	StrSQL = "Update "& StrDBPrefix &"Info Set IDTree = '@"& IDTree &"' Where ID in ("& List_del &") And IsLock<>1"
	fInUpData(StrSQL)

	Call A ("「删除」操作成功！")
	Call Gi_sOnSucsSubNext ("info_list.asp","<input type=""hidden"" id=""iLanguage"" name=""iLanguage"" value="""& iLanguage &"""><input type=""hidden"" id=""PageNum"" name=""PageNum"" value="""& PageNum &""">")

Elseif GBAction = "MovContent"& BGSecSon &"" Then

List_del = Request.Form("DelSel")
Mov_Tree = Request.Form("IDTree")
	If Len(List_del)<1 Then Gi_sOnErrGoBack ("「系统」缺少操作对象")

	StrSQL = "Update "& StrDBPrefix &"Info Set IDTree = '"&Mov_Tree&"' Where ID in ("& List_del &") And IsLock<>1"
	fInUpData(StrSQL)
	
	Call A ("「移动」操作成功！")
	Call Gi_sOnSucsSubNext ("info_list.asp","<input type=""hidden"" id=""iLanguage"" name=""iLanguage"" value="""& iLanguage &"""><input type=""hidden"" id=""PageNum"" name=""PageNum"" value="""& PageNum &""">")

Elseif GBAction = "SetContent"& BGSecSon &"" Then

List_del = Request.Form("DelSel")
State_OnOff = Request.Form("OnOff")
	If Len(List_del)<1 Then Gi_sOnErrGoBack ("「系统」缺少操作对象")

	StrSQL = "Update "& StrDBPrefix &"Info Set State_OnOff = '"& State_OnOff &"' Where ID in ("& List_del &") And IsLock<>1"
	fInUpData(StrSQL)
	
	Call A ("「设置」操作成功！")
	Call Gi_sOnSucsSubNext ("info_list.asp","<input type=""hidden"" id=""iLanguage"" name=""iLanguage"" value="""& iLanguage &"""><input type=""hidden"" id=""PageNum"" name=""PageNum"" value="""& PageNum &""">")

Else
	Call Gi_sOnSucsGoNext ("「系统」错误，请重新登陆！","logout.asp")
End If
%>
