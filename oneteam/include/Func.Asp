<%
'JS " document.title='"& cCompanyName &"' "

'数据库相关*******************************************
'****************************************************
'名称: fGetConn
'功能: 建立数据库连接对象
'Set Conn = fGetConn
'---------------------------------------------------
'****************************************************

Function fGetConn
	Dim ObjConn
	Set ObjConn = Server.CreateObject("ADODB.Connection") 
	ObjConn.Open StrConn

	If Err.Number <> 0 Then
		Call A ("数据库连接不上！")
	Else
		Set fGetConn = ObjConn 
		Set ObjConn = Nothing
	End If
End Function

'****************************************************
'名称: fGetRsList
'功能: 执行 Sql 查询语句，返回记录集
'---------------------------------------------------
'Set Rs = fGetRsList(StrSQL)
'---------------------------------------------------
'****************************************************
Function fGetRsList(StrSQL)	
	Dim Conn,Rs
	Set Rs = Server.CreateObject("ADODB.RecordSet")
	Set Conn = Server.CreateObject("ADODB.Connection")
	Set Conn = fGetConn

	Rs.CuRsorLocation = 3

	Rs.Open StrSQL, Conn,1,3
	Rs.ActiveConnection = Nothing

	Set fGetRsList = Rs

	If Err.Number <> 0 Then	
		Call A ("fGetRsList错误,请检查!")
	End If

	Conn.Close 
	Set Conn = Nothing
End Function

'****************************************************
'名称: fInUpData
'功能: 执行 Sql 查询语句，更新记录集
'---------------------------------------------------
'StrSQL = "update & insert  "
'fInUpData(StrSQL)
'---------------------------------------------------
'****************************************************
Function fInUpData(StrSQL)
	Dim Conn
	Set Conn = Server.CreateObject("ADODB.Connection")
	Set Conn = fGetConn
	Conn.Execute(StrSQL)

	If Err.Number <> 0 Then
		A ("fInUpData错误,请检查!")
	End If

	Conn.Close 
	Set Conn = Nothing
End Function

'搜索字段加亮
Function Gi_GetHighLight(Str,KeyWords)
	If Not(GetHL) And IsNull(KeyWords) Then Exit Function	
	Gi_GetHighLight = Replace(Str,KeyWords,"<span style=""color:#f00;background-color:#FFFF00;font-weight:bold; "">"& KeyWords &"</span>")	
	
End Function

'正则式
Function Gi_fReplaceEx(Patrn,OrgiStr,ReplStr)
	Dim RegEx						' 建立变量。
	Set RegEx = New RegExp			' 建立正则表达式。
	RegEx.Pattern = Patrn			' 设置模式。
	RegEx.IgnoreCase = False			' 设置是否区分大小写。
	Set Matches = RegEx.Execute(OrgiStr)
	Gi_fReplaceEx = RegEx.Replace(OrgiStr,ReplStr)         ' 作替换。
End Function


function getParaStr(obj,length,defaultValue)
	dim tempValue
	tempValue	=	Trim(Request(obj))
	tempValue	=	Replace(tempValue,"'","")
	
	if tempValue	=	"" or isnull(tempValue) then
		tempValue	=	defaultValue
	end if
	
	if length>0 then
		tempValue	=	left(tempValue,length)
	end if
	getParaStr	=	tempValue
end function

function getParaNum(obj,Ntype,defaultValue)
	dim tempValue
	tempValue	=	Trim(Request(obj))
	tempValue	=	Replace(tempValue,"'","")
	if tempValue	=	"" or isnull(tempValue) or not isNumeric(tempValue) then
		if isNumeric(defaultValue) then
			tempValue	=	defaultValue
		else
			tempValue	=	0
		end if
	end if
	
	select case ucase(Ntype)
		case "I"
			tempValue	=	Cint(tempValue)
		case "L"
			tempValue	=	Clng(tempValue)
	end select
	getParaNum	=	tempValue
end function

'查看插入字段内容是否存在
Function Gi_fCheckIDFieldExsit(StrCheckSQL,StrAlert)
	Dim Rs
	Set Rs = Server.CreateObject("ADODB.RecordSet")
	Set Rs = fGetRsList(StrCheckSQL)
	If Not Rs.Eof Then
		Gi_sOnErrGoBack (StrAlert)
		Gi_fCheckIDFieldExsit = True
	Else
		Gi_fCheckIDFieldExsit = False
	End If
	Rs.Close
	Set Rs = Nothing
End Function

function formatDate(obj,T_type)
	dim TempValue
	if not isDate(obj) then exit function
	T_year	=	year(obj)
	T_Month	=	month(obj)
	T_Day		=	Day(obj)
	T_Month	=	Right("00" & T_Month,2)
	T_Day=	Right("00" & T_Day,2)

	select case T_Type
		case "N"
			TempValue	=	T_year & "年" & T_month & "月" & T_day & "日"
		case "M"
			TempValue	= T_month & "/" & T_day 
		case else
			TempValue	=	T_Year & T_type & T_Month & T_type & T_Day
	end select
	formatDate	=	tempValue
end function

function formatDate2(obj)
	dim TempValue
	if not isDate(obj) then exit function
	weeks	=	Weekday(obj)
	select case weeks
		case 1
			TempValue="日"
		case 2
			TempValue="一"
		case 3
			TempValue="二"
		case 4
			TempValue="三"
		case 5
			TempValue="四"
		case 6
			TempValue="五"
		case 7
			TempValue="六"
	end select
	formatDate2	="星期"&TempValue
end function



'确认传值
Function Gi_fCheckCMFieldExsit(StrCheckSQL)
	Dim Rs
	Set Rs = Server.CreateObject("ADODB.RecordSet")
	Set Rs = fGetRsList(StrCheckSQL)
	If Not Rs.Eof Then
		Gi_fCheckCMFieldExsit = False
	Else
		Gi_fCheckCMFieldExsit = True
	End If
	Rs.Close
	Set Rs = Nothing
End Function


'获得文件后缀名
Function Gi_fGetFileExtName(FileName)
	Dim Pos
	Pos = InStrRev (FileName,".")
	If Pos > 0 Then 
		Gi_fGetFileExtName = Mid (FileName,Pos+1)
	Else
		Gi_fGetFileExtName =  ""
	End If
End Function 

'按顺序交替获得颜色
Function Gi_fChgBgColor(i,Sep,Color)
	If IsNull(i) Or IsNull(Sep) Then Exit Function
	Dim TmpArray
	TmpArray = Split(Color,Sep,-1)	
	Gi_fChgBgColor = TmpArray( i mod (Ubound(TmpArray)+1))
End Function

'验证过程触发时间相关***********************************
'替换JAVA脚本中的特殊字符
Function Gi_fChgJsStr(Byval Str)
	If IsNull(Str) Then Exit Function
	Str = Replace(Str,"'","\'")
	Str = Replace(Str,"""","\""")
	Str = Replace(Str,chr(13)+chr(10),"\n")
	Gi_fChgJsStr = Str
End Function


'解决数据库单引号问题
Function Gi_fChgSQLStr(Byval Str)
	If IsNull(Str) Then Exit Function
	Str = replace(Str,"'","''")
	Gi_fChgSQLStr = Str
End Function

'显示用户输入的文本，替换特殊字符
Function Gi_fChgHtmlStr(Byval Str)
	If IsNull(Str) Then Exit Function
	Str = Replace(Str,"<","&lt;")
	Str = Replace(Str,">","&gt;")
	Str = Replace(Str,chr(34),"&quot;")             
	Str = Replace(Str," ","&nbsp;")
	Str = Replace(Str,chr(13)+chr(10),"<br>")         
	Gi_fChgHtmlStr = Str
End Function

Function Gi_fUnChgHtmlStr(Byval Str)
	If IsNull(Str) Then Exit Function
	Str = Replace(Str,"&lt;","<")
	Str = Replace(Str,"&gt;",">")
	Str = Replace(Str,"&quot;",chr(34))             
	Str = Replace(Str,"&nbsp;"," ")
	Str = Replace(Str,"<br>",chr(13)+chr(10))         
	Gi_fUnChgHtmlStr = Str
End Function

'只显示指定数量的内容
Function Gi_fGetLenStr(Str,Amo)
	If IsNull(Str) Or IsNull(Amo) Then Exit Function
	If Len(Str) > Amo Then
		Gi_fGetLenStr = Left (Str,Amo) & "..."
	Else
		Gi_fGetLenStr = Str
	End If
End Function

'分离数组中指定项目	
Function Gi_fGetSplitStr(Str,Sep,Ordinal)
	If IsNull(Str) Or IsNull(Sep) Then Exit Function
	Dim TmpArray
	TmpArray = Split(Str,Sep,-1)
	If Ordinal = "end" Then
		Gi_fGetSplitStr = Gi_fChgHtmlStr(TmpArray(Ubound(TmpArray)))
	Elseif Ordinal > 0 And Ordinal < Ubound(TmpArray) Then
		Gi_fGetSplitStr = Gi_fChgHtmlStr(TmpArray(Ordinal))
	Else
		Gi_fGetSplitStr = Gi_fChgHtmlStr(Str)
	End If
End Function

'出错，提示后返回前页。一般用于FORM提交
Sub Gi_sOnErrGoBack(StrErr)
	R "<script Language=""JScript"">alert('" & Gi_fChgJsStr(StrErr) & "');"
	R "window.history.go(-1);</script>"
	E
End Sub


'成功，自动表单提交进入指定页面
Sub Gi_sOnSucsSubNext(StrUrl,StrSub)
	R "<form action="""& StrUrl &""" method=""post"" name=""OnSucsSubGoNext"">"& StrSub &"</form><script Language=""JScript"">document.OnSucsSubGoNext.submit(OnSucsSubGoNext.form)</script>"
	E
End Sub


'成功，进入指定页面
Sub Gi_sOnSucsGoNext(StrSucs,url)
	R "<script Language=""JScript"">alert('" & Gi_fChgJsStr(StrSucs) & "');"
	R "window.location='" & url & "';</script>"
	E
End Sub


'出错，提示后关闭当前窗口。
Sub Gi_sOnErrCloseWindow(StrErr)
	R "<script Language=""JScript"">alert('" & Gi_fChgJsStr(StrErr) & "');"
	R "window.close();</script>"
	E
End Sub


'关闭窗口并刷新父窗口
Sub Gi_sOnSucsReloadOpener(Str,url)
	R "<script Language=""JScript"">alert('"& Gi_fChgJsStr(Str) &"');location.href='"& url &"';</script>"
	E
End Sub


Sub Gi_sGetTrueOrFalse(Str,Sep,StrValue)
	If IsNull(Str) Or IsNull(StrValue) Then Exit Sub
	Dim TmpArray
	TmpArray = Split(StrValue,Sep,-1)
	If Str Then
		R TmpArray(0)
	Else 
		R TmpArray(1)		
	End If
End Sub


Sub Gi_sGetIMGShow(IMG)
	If IMG = "" Then
		R "无"
	Else
		R "有"
	End If

End Sub


'测试相关************************************************************
Sub A(Str)
	R "<script Language=""JScript"">alert('"& Gi_fChgJsStr(Str) &"');</script>" 
End Sub

Sub JS(Str)
	R "<script Language=""JScript"">"&Str&"</script>"
End Sub

Sub T(Str)
	R "<script Language=""JScript"">var winname = window.open('', '_blank', 'toolbar=no, menubar=yes, scrollbaRs=yes, resizable=yes ,location=no, status=yes');	winname.document.open('text/html', 'replace');winname.document.writeln('"& Gi_fChgJsStr(Str) &"');	winname.document.close();</script>"
End Sub

Sub R(Str)
	Response.Write Str
End Sub

Sub E()
	Response.End
End Sub


'*************************************************************
'翻页程序
Sub Gi_sGetPageCount(StrSQL)
	Dim Rs,Conn
	Set Rs = Server.CreateObject("ADODB.RecordSet")
	Set Rs = fGetRsList(StrSQL)
		TotalCount = Rs(0)
	Rs.Close
	Set Rs = Nothing

	CurrentPage = Request("PageNum")
	If CurrentPage = "" Or len(CurrentPage)=0 Then                                                            
		CurrentPage = 1                                                           
	Else
		CurrentPage = Cint(CurrentPage)
	End If
	
	If PageSize = "" Or PageSize = 0 Then
		PageSize = 10
	End If

	PageCount = TotalCount / PageSize 
	If PageCount < 1 Then
		PageCount = 1
	End If
	
	If PageCount <> Fix (PageCount) Then
		PageCount = Fix (PageCount)+1
	End If

	PageCount = Cint (PageCount)
	If CurrentPage > PageCount Then
		CurrentPage = PageCount
	End If
	PrevCurrentPage=CurrentPage-1                                                                                                      
	NextCurrentPage=CurrentPage+1  
End Sub

Sub Gi_sGetPNLinks(PNMode)
	Dim Head,Foot,SPC,FPY,LPY,NPY,PPY,FPN,LPN,NPN,PPN,GTD,GOPG,AllPiece,URL
	Dim SPiece,EPiece
	URL = Request.ServerVariables("URL")
	SPC = "<img src=""../images/spacer.gif"" border=""0"" align=""absmiddle"" hspace=""3"">"
	Head = "<table width=""100%""  border=""0"" cellspacing=""2"" cellpadding=""0""><form action="""& URL &""" method=""post"" onSubmit=""if(PageNum.value=='"& CurrentPage &"'||eval(PageNum.value)>'"& PageCount &"'||eval(PageNum.value)<='0'||PageNum.value==''){PageNum.value='';PageNum.focus();return false;} Gi_disAllButton();"" Name=""PageF"">"& SrchAllHObj &"<tr><td height=""100%"" align=""right"">"
	Foot = "</td></tr></form></table>"

	GOPG="<input type=""text"" style=""width:28px;height:23px;BORDER-top: buttonshadow 1PX solid;BORDER-left: buttonshadow 1PX solid;BORDER-right: buttonhighlight 1PX solid;BORDER-bottom: buttonhighlight 1PX solid;BACKGROUND-COLOR:#D5E1FB;PADDING-LEFT:3px;PADDING-RIGHT:3px;PADDING-TOP:3px;PADDING-BOTTOM:3px;"" name=""PageNum"" maxlength="& Len(PageCount) &" onblur=""if(this.value==''){oGo.disabled=true;}else{oGo.disabled='';}"" onkeypress=""return event.keyCode>=48&&event.keyCode<=57||event.keyCode==46||event.keyCode==13"" onpaste=""return !clipboardData.getData('text').match(/\D/)"" ondragenter=""return false"" style=""ime-mode:Disabled"">&nbsp;&nbsp;<input type=""button"" value=""Go!"" disabled=true Class=""iButton"" name=""oGo"" onClick=""if(PageNum.value!='"& CurrentPage &"'&&eval(PageNum.value)<='"& PageCount &"'&&eval(PageNum.value)>'0'&&PageNum.value!=''){submit(this.form);}else{PageNum.value='';PageNum.focus();}"">"

	If CurrentPage = 1 Then
		SPiece = 1
	Else
		SPiece = (CurrentPage-1)*PageSize+1	
	End If
	
	EPiece = (CurrentPage)*PageSize

	If EPiece > TotalCount Then
		EPiece = TotalCount		
	End If

	If SPiece => EPiece Then
		SEPiece = EPiece
	Else
		SEPiece = SPiece &"-"& EPiece
	End If
	

	R Head '显示Form HEAD

	If PNMode = "button" Then
		AllPiece = "<font class=""cssPage"">{</font>每页 <font class=""cssPage"">"& PageSize &"</font> 条"& SPC &"共 <font class=""cssPage"">"& TotalCount &"</font> 条记录<font class=""cssPage"">}</font>"& SPC &"第 <font class=""cssPage"">"& SEPiece &"</font> 条"& SPC &"第 <font class=""cssPage"">" & CurrentPage & "/" & PageCount & "</font> 页 "& SPC
		FPY = "<input onMouseOver=""this.style.backgroundColor='#E8F0FF'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""首页"" name=""firstPage"" onClick=""PageNum.value='1';submit(this.form);"">"
		LPY = "<input onMouseOver=""this.style.backgroundColor='#E8F0FF'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""尾页"" name=""lastPage"" onClick=""PageNum.value='"& PageCount &"';submit(this.form);"">"
		PPY = "<input onMouseOver=""this.style.backgroundColor='#E8F0FF'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""上一页"" name=""prevPage"" onClick=""PageNum.value='"& PrevCurrentPage &"';submit(this.form);"">"
		NPY = "<input onMouseOver=""this.style.backgroundColor='#E8F0FF'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""下一页"" name=""nextPage"" onClick=""PageNum.value='"& NextCurrentPage &"';submit(this.form);"">"
		FPN = "<input onMouseOver=""this.style.backgroundColor='#E8F0FF'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""首页"" name=""firstPage"" disabled=true>"
		LPN = "<input onMouseOver=""this.style.backgroundColor='#E8F0FF'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""尾页"" name=""lastPage"" disabled=true>"
		PPN = "<input onMouseOver=""this.style.backgroundColor='#E8F0FF'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""上一页"" name=""nextPage"" disabled=true>"
		NPN = "<input onMouseOver=""this.style.backgroundColor='#E8F0FF'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""下一页"" name=""oDsubmit"" disabled=true>"
	
	Elseif PNMode = "" Then
		AllPiece = AllPiece
		GOPG = GOPGFG
		FPY = FPYFG
		LPY = LPYFG
		PPY = PPYFG
		NPY = NPYFG
		FPN = FPNFG
		LPN = LPNFG
		PPN = PPNFG
		NPN = NPNFG

	Else
	End If
	
	R AllPiece '显示但前页面数据状况
	If CurrentPage <= 1 And   PageCount <> 1 Then 
		R GOPG & SPC & FPN & SPC & PPN & SPC & NPY & SPC & LPY & SPC
	Elseif CurrentPage>1 And CLng(CurrentPage) < PageCount Then 
		R GOPG & SPC & FPY & SPC & PPY & SPC & NPY & SPC & LPY & SPC
	Elseif (CLng(CurrentPage) = PageCount) And PageCount<>1 Then 
		R GOPG & SPC & FPY & SPC & PPY & SPC & NPN & SPC & LPN & SPC
	End If

	R Foot '显示Form FOOT

End Sub


'********************************************************
'语言相关*************************************************
'语言显示
Sub Gi_sGetLangVar
	If iLanguage = "" Or cOptiLang = 1  Then
		iLanguage = 1
	End If
End Sub

Sub Gi_sGetLangShow(iLang)
	If iLang = "1" Then 
		R cConfiLangType_01
	Elseif iLang = "2" Then
		R cConfiLangType_02
	Elseif iLang = "3" Then
		R cConfiLangType_03
	End If
End Sub

'语言填写选择
Sub Gi_sGetLangCheckbox(BLan,Fn,Objn)
	Dim ChkL1,ChkL2,ChkL3
	Dim OnClk1,OnClk2,OnClk3

	If Fn <> "" And Objn <> "" Then
		OnClk1 = "onClick=""changeRadio('"& Fn &"','"& Objn &"',1);"" "
		OnClk2 = "onClick=""changeRadio('"& Fn &"','"& Objn &"',2);"" "
		OnClk3 = "onClick=""changeRadio('"& Fn &"','"& Objn &"',3);"" "
	End If

	If BLan = 1 Or BLan = "" Then
		ChkL1 = "checked"
	Elseif BLan = 2 Then
		ChkL2 = "checked"
	Elseif BLan = 3 Then
		ChkL3 ="checked"
	End If

	 If cOptiLang >= 1 Then
	 R "<input onfocus=""blur()"" type=""radio"" name=""iLanguage"" value=""1"" "& ChkL1 &" "& OnClk1 &" > " &_
						  ""& cConfiLangType_01 &"&nbsp;&nbsp;"
	 End If

	If cOptiLang >= 2 Then
	 R "<input onfocus=""blur()"" type=""radio"" name=""iLanguage"" value=""2"" "& ChkL2 &" "& OnClk2 &"> " &_
						  ""& cConfiLangType_02 &"&nbsp;&nbsp;"
	 End If

	If cOptiLang >= 3 Then
	 R "<input onfocus=""blur()"" type=""radio"" name=""iLanguage"" value=""3"" "& ChkL3 &" "& OnClk3 &"> " &_
						  ""& cConfiLangType_03 &"&nbsp;&nbsp;"
	 End If
End Sub

'语言选择按钮
Sub Gi_sGetLangButton(strUrl,Module)
	If iLanguage = "" Then
		iLang = 0
	Else
		iLang = CInt(iLanguage)
	End If
	
	R "<table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0""><form action="""& strUrl &""" method=""post"" Name=""iLanguageF""><input type=""hidden"" id=""iLanguage"" name=""iLanguage"" value=""""><tr><td class=""PADDTD"">"

	If cOptiLang >= 1 Then
		R "<input CLASS=""InputBtn"" onfocus=""blur()""  type=""button"" value="""& cConfiLangType_01 & Module &"列表"" name=""GOTiLANG"" onClick=""iLanguage.value='1';if("& iLang &"!=iLanguage.value){submit(this.form);}"" onMouseOver=""this.style.backgroundColor='#E8F0FF'"" onMouseOut=""this.style.backgroundColor=''"">&nbsp;&nbsp;"
	End If

	If cOptiLang >= 2 Then
		R "<input CLASS=""InputBtn"" onfocus=""blur()""  type=""button"" value="""& cConfiLangType_02 & Module &"列表"" name=""GOTiLANG"" onClick=""iLanguage.value='2';if("& iLang &"!=iLanguage.value){submit(this.form);}"" onMouseOver=""this.style.backgroundColor='#E8F0FF'"" onMouseOut=""this.style.backgroundColor=''"">&nbsp;&nbsp;"
	End If

	If cOptiLang >= 3 Then
		R "<input CLASS=""InputBtn"" onfocus=""blur()""  type=""button"" value="""& cConfiLangType_03 & Module &"列表"" name=""GOTiLANG"" onClick=""iLanguage.value='3';if("& iLang &"!=iLanguage.value){submit(this.form);}"" onMouseOver=""this.style.backgroundColor='#E8F0FF'"" onMouseOut=""this.style.backgroundColor=''"">&nbsp;&nbsp;"
	End If

	R "</td></tr></form></table>"
End Sub

'获得本页url的request.servervariables("")集合
Sub Gi_sShowSV()
	R "<TABLE border=1><!-- Table Header --><TR><TD><B>Variables</B></TD><TD><B>value</B></TD></TR>"
	For Each Ob In Request.ServerVariables
		R "<TR><TD>"& Ob &"</TD><TD>"& Request.ServerVariables (Ob) &"</TD></TR>"
	Next
	R "</TABLE>"	
End Sub

'***********************************************
'函数名：JoinChar
'作  用：向地址中加入 ? 或 &
'参  数：strUrl  ----网址
'返回值：加了 ? 或 & 的网址
'***********************************************
function JoinChar(strUrl)
	if strUrl="" then
		JoinChar=""
		exit function
	end if
	if InStr(strUrl,"?")<len(strUrl) then 
		if InStr(strUrl,"?")>1 then
			if InStr(strUrl,"&")<len(strUrl) then 
				JoinChar=strUrl & "&"
			else
				JoinChar=strUrl
			end if
		else
			JoinChar=strUrl & "?"
		end if
	else
		JoinChar=strUrl
	end if
end function

function IsValidEmail(email)
dim names, name, i, c
'Check for valid syntax in an email address.
IsValidEmail = true
names = Split(email, "@")
if UBound(names) <> 1 then
   IsValidEmail = false
   exit function
end if
for each name in names
   if Len(name) <= 0 then
     IsValidEmail = false
     exit function
   end if
   for i = 1 to Len(name)
     c = Lcase(Mid(name, i, 1))
     if InStr("abcdefghijklmnopqrstuvwxyz_-.", c) <= 0 and not IsNumeric(c) then
       IsValidEmail = false
       exit function
     end if
   next
   if Left(name, 1) = "." or Right(name, 1) = "." then
      IsValidEmail = false
      exit function
   end if
next
if InStr(names(1), ".") <= 0 then
   IsValidEmail = false
   exit function
end if
i = Len(names(1)) - InStrRev(names(1), ".")
if i <> 2 and i <> 3 then
   IsValidEmail = false
   exit function
end if
if InStr(email, "..") > 0 then
   IsValidEmail = false
end if
end function

Function SafeRequest(ParaName) 
Dim ParaValue 
ParaValue=Request(ParaName)
if IsNumeric(ParaValue) = True then
	SafeRequest=ParaValue
	exit Function
elseIf Instr(LCase(ParaValue),"select ") > 0 or Instr(LCase(ParaValue),"insert ") > 0 or Instr(LCase(ParaValue),"delete from") > 0 or Instr(LCase(ParaValue),"count(") > 0 or Instr(LCase(ParaValue),"drop table") > 0 or Instr(LCase(ParaValue),"update ") > 0 or Instr(LCase(ParaValue),"truncate ") > 0 or Instr(LCase(ParaValue),"asc(") > 0 or Instr(LCase(ParaValue),"mid(") > 0 or Instr(LCase(ParaValue),"char(") > 0 or Instr(LCase(ParaValue),"xp_cmdshell") > 0 or Instr(LCase(ParaValue),"exec master") > 0 or Instr(LCase(ParaValue),"net localgroup administrators") > 0  or Instr(LCase(ParaValue)," and ") > 0 or Instr(LCase(ParaValue),"net user") > 0 or Instr(LCase(ParaValue)," or ") > 0 then
	Response.Write "<script language='javascript'>"
	Response.Write "alert('非法的请求!');"  '发现SQL注入攻击提示信息
	Response.Write "history.go(-1);"  '发现SQL注入攻击转跳网址
	Response.Write "<script>"
	Response.end
else
	SafeRequest=ParaValue
End If
End function

sub pages(n,p,intRecordCount,MaxPerPage,currentPage,keyword)
	if n<>0 then
	response.write"<table width=""98%"" border=""0"" align=""center"" cellpadding=""5"" cellspacing=""0"">"&vbcrlf
  	response.write"<tr>"&vbcrlf
    response.write"<td height=""20"" align=""center"">共<b>"&intRecordCount&"</b>条信息&nbsp;&nbsp;&nbsp;每页<b>"&MaxPerPage&"</b>条&nbsp;&nbsp;&nbsp;页次：<b> "&currentPage&"</b>/<b>"&n&" </b>页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"&vbcrlf
		if currentPage=1 then
		response.write "<font face=webdings>9</font>"&vbcrlf
		else
		response.write "<a href='?page=1"&keyword&"' title='首页'><font face=webdings>9</font></a>   "&vbcrlf
		end if
		if p*MaxPerPage>0 then
		response.write "<a href='?page="&Cstr(p*MaxPerPage)&""&keyword&"' title='上十页'><font face=webdings>7</font></a>   "&vbcrlf
		end if
		for ii=p*MaxPerPage+1 to P*MaxPerPage+MaxPerPage
			if ii=currentPage then
			response.write " ["&Cstr(ii)&"] "&vbcrlf
			else
			response.write " <a href='?page="&Cstr(ii)&""&keyword&"'>"+Cstr(ii)+"</a> "&vbcrlf
			end if
			if ii=n then exit for
		next
		if ii<n then
		response.write "<a href='?page="&Cstr(ii)&""&keyword&"' title='下十页'><font face=webdings>8</font></a>   "&vbcrlf
		end if
		if currentPage=n then
		response.write "<font face=webdings>:</font>   "&vbcrlf
		else
		response.write "<a href='?page="&Cstr(n)&""&keyword&"' title='尾页'><font face=webdings>:</font></a>   "&vbcrlf
		end if
		response.write"</td>"&vbcrlf
		response.write"</tr>"&vbcrlf
		response.write"</table>"&vbcrlf
	end if
end sub


sub pages_en(n,p,intRecordCount,MaxPerPage,currentPage,keyword)
	if n<>0 then
	response.write"<table width=""98%"" border=""0"" align=""center"" cellpadding=""5"" cellspacing=""0"">"&vbcrlf
  	response.write"<tr>"&vbcrlf
    response.write"<td height=""20"" align=""center"">Altogether <b>"&intRecordCount&"</b> information&nbsp;&nbsp;&nbsp;<b> "&currentPage&"</b>/<b>"&n&" </b>pages&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"&vbcrlf
		if currentPage=1 then
		response.write "<font face=webdings>9</font>"&vbcrlf
		else
		response.write "<a href='?page=1"&keyword&"' title='First Page'><font face=webdings>9</font></a>   "&vbcrlf
		end if
		if p*MaxPerPage>0 then
		response.write "<a href='?page="&Cstr(p*MaxPerPage)&""&keyword&"' title='previous 10'><font face=webdings>7</font></a>   "&vbcrlf
		end if
		for ii=p*MaxPerPage+1 to P*MaxPerPage+MaxPerPage
			if ii=currentPage then
			response.write " ["&Cstr(ii)&"] "&vbcrlf
			else
			response.write " <a href='?page="&Cstr(ii)&""&keyword&"'>"+Cstr(ii)+"</a> "&vbcrlf
			end if
			if ii=n then exit for
		next
		if ii<n then
		response.write "<a href='?page="&Cstr(ii)&""&keyword&"' title='next 10'><font face=webdings>8</font></a>   "&vbcrlf
		end if
		if currentPage=n then
		response.write "<font face=webdings>:</font>   "&vbcrlf
		else
		response.write "<a href='?page="&Cstr(n)&""&keyword&"' title='End Page'><font face=webdings>:</font></a>   "&vbcrlf
		end if
		response.write"</td>"&vbcrlf
		response.write"</tr>"&vbcrlf
		response.write"</table>"&vbcrlf
	end if
end sub



sub pages_ft(n,p,intRecordCount,MaxPerPage,currentPage,keyword)
	if n<>0 then
	response.write"<table width=""98%"" border=""0"" align=""center"" cellpadding=""5"" cellspacing=""0"">"&vbcrlf
  	response.write"<tr>"&vbcrlf
    response.write"<td height=""20"" align=""center"">共<b>"&intRecordCount&"</b>條信息&nbsp;&nbsp;&nbsp;每頁<b>"&MaxPerPage&"</b>條&nbsp;&nbsp;&nbsp;頁次：<b> "&currentPage&"</b>/<b>"&n&" </b>頁&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"&vbcrlf
		if currentPage=1 then
		response.write "<font face=webdings>9</font>"&vbcrlf
		else
		response.write "<a href='?page=1"&keyword&"' title='首頁'><font face=webdings>9</font></a>   "&vbcrlf
		end if
		if p*MaxPerPage>0 then
		response.write "<a href='?page="&Cstr(p*MaxPerPage)&""&keyword&"' title='上十頁'><font face=webdings>7</font></a>   "&vbcrlf
		end if
		for ii=p*MaxPerPage+1 to P*MaxPerPage+MaxPerPage
			if ii=currentPage then
			response.write " ["&Cstr(ii)&"] "&vbcrlf
			else
			response.write " <a href='?page="&Cstr(ii)&""&keyword&"'>"+Cstr(ii)+"</a> "&vbcrlf
			end if
			if ii=n then exit for
		next
		if ii<n then
		response.write "<a href='?page="&Cstr(ii)&""&keyword&"' title='下十頁'><font face=webdings>8</font></a>   "&vbcrlf
		end if
		if currentPage=n then
		response.write "<font face=webdings>:</font>   "&vbcrlf
		else
		response.write "<a href='?page="&Cstr(n)&""&keyword&"' title='尾頁'><font face=webdings>:</font></a>   "&vbcrlf
		end if
		response.write"</td>"&vbcrlf
		response.write"</tr>"&vbcrlf
		response.write"</table>"&vbcrlf
	end if
end sub









sub states(strings)
if strings<>"" then
arr = split(""&strings&"",",")
for i=0 to ubound(arr)
if rtrim(arr(i)) <> "" then
if rtrim(arr(i))="new" then
response.write "<img src=../../images/index/index_icon_02.gif>"
end if
end if
next
end if
end sub

'防SQL注入攻击
Function SafeRequest(ParaName) 
Dim ParaValue 
ParaValue=ParaName
if IsNumeric(ParaValue) = True then
	SafeRequest=ParaValue
	exit Function
elseIf Instr(LCase(ParaValue),"select ") > 0 or Instr(LCase(ParaValue),"insert ") > 0 or Instr(LCase(ParaValue),"delete from") > 0 or Instr(LCase(ParaValue),"count(") > 0 or Instr(LCase(ParaValue),"drop table") > 0 or Instr(LCase(ParaValue),"update ") > 0 or Instr(LCase(ParaValue),"truncate ") > 0 or Instr(LCase(ParaValue),"asc(") > 0 or Instr(LCase(ParaValue),"mid(") > 0 or Instr(LCase(ParaValue),"char(") > 0 or Instr(LCase(ParaValue),"xp_cmdshell") > 0 or Instr(LCase(ParaValue),"exec master") > 0 or Instr(LCase(ParaValue),"net localgroup administrators") > 0  or Instr(LCase(ParaValue)," and ") > 0 or Instr(LCase(ParaValue),"net user") > 0 or Instr(LCase(ParaValue)," or ") > 0 then
	Response.Write "<script language='javascript'>"
	Response.Write "alert('发现非法字符,请注意您的行为!');"  '发现SQL注入攻击提示信息
	Response.Write "history.go(-1);"  '发现SQL注入攻击转跳网址
	Response.Write "</script>"
	Response.end
else
	SafeRequest=ParaValue
End If
End function
'----------------------------------

Function stripHTML(htmlStr)
Dim regEx
SET regEx = New Regexp
regEx.IgnoreCase = True
regEx.Global = True
regEx.Pattern = "<.+?>"
htmlStr = regEx.Replace(htmlStr,"")
htmlStr = Replace(htmlStr, "<","&lt;")
htmlStr = Replace(htmlStr, ">","&gt;")
htmlStr = Replace(htmlStr,chr(10),"")
htmlStr = Replace(htmlStr,chr(13),"")

stripHTML = htmlStr
SET regEx = Nothing
'htmlStr=left(stripHTML,num)&"..."
'response.Write(left(stripHTML,75)&"...")
End Function


'--------------------------

Function CheckStringLength(txt)
txt=trim(txt)
x = len(txt)
y = 0
for ii = 1 to x
  if asc(mid(txt,ii,1))<0 or asc(mid(txt,ii,1))>255 then
    y = y + 2
  else
    y = y + 1
  end if
next
CheckStringLength = y
End Function

'"************* 截取字符串 **************
Function interstring(txt,length)
txt=trim(txt)
x = len(txt)
y = 0
if x >= 1 then
for ii = 1 to x
if asc(mid(txt,ii,1)) < 0 or asc(mid(txt,ii,1)) >255 then
   y = y + 2
else
   y = y + 1
end if
  if y >= length then
     txt = left(trim(txt),ii)&"…" '"字符串限长
  exit for
end if
next
   interstring = txt
else
   interstring = ""
end if
End Function 


function htmlstr(Byval str)
	If IsNull(Str) Then Exit Function
	Str = replace(Str,"'","''")
	Str=server.HTMLEncode(str)
	htmlstr=str
end function
%>
<script language="javascript" runat="server">
function getPageInfo(MaxPerPage,totalPage,absolutePage,keyword){
 if(isNaN(totalPage))totalPage=1;
 var pgStr="";
 var has1=absolutePage-5>=1;
 var has2=absolutePage+5<=totalPage;
 var begin=end=1;
 if(has1 && has2){
   begin=absolutePage-4;
   end=absolutePage+5;
 }else if(!has1 && has2){
   begin=1;
   end=totalPage>=10?10:totalPage;
 }else if(has1 && !has2){
   begin=totalPage-9;begin=begin<1?1:begin;
   end=totalPage;
 }else{
   begin=1;
   end=totalPage;
 }

pgStr="共："+totalPage+"页信息&nbsp;&nbsp;每页："+MaxPerPage+"条&nbsp;&nbsp;页次："+absolutePage+"/"+totalPage+"&nbsp;&nbsp;"

if(absolutePage>1){
  pgStr+='<a href="?page=1'+keyword+'" class=a_gray><img src=img/uppage/first.gif></a> ';
 }else{
  //pgStr+='<img src=../../images/uppage/first.gif>';
 }
 
 if(absolutePage>1){
  pgStr+='<a href="?page='+eval(absolutePage-1)+keyword+'" class=a_gray><img src=img/uppage/pro.gif></a> ';
 }else{
 // pgStr+='上一页 ';
 }
 for(i=begin;i<=end;i++){
  pgStr+=' <a href="?page='+i+keyword+'" class=a_gray';
  if(i==absolutePage)pgStr+=' style="color:#ff0000;font-weight:bold;"';
  pgStr+='>'+i+'</a>';
 }
 if(absolutePage<totalPage){
  pgStr+=' <a href="?page='+eval(absolutePage+1)+keyword+'" class=a_gray><img src=img/uppage/next.gif></a>';
 }else{
 // pgStr+=' 下一页'
 }
  if(absolutePage<totalPage){
  pgStr+=' <a href="?page='+totalPage+keyword+'" class=a_gray><img src=img/uppage/last.gif></a>';
 }else{
  //pgStr+=' <font face=webdings title=末页>:</font>'
 }
 
 return pgStr;
}

</script>
<script language="javascript" runat="server">
function getPageInfo_en(MaxPerPage,totalPage,absolutePage,keyword){
 if(isNaN(totalPage))totalPage=1;
 var pgStr="";
 var has1=absolutePage-5>=1;
 var has2=absolutePage+5<=totalPage;
 var begin=end=1;
 if(has1 && has2){
   begin=absolutePage-4;
   end=absolutePage+5;
 }else if(!has1 && has2){
   begin=1;
   end=totalPage>=10?10:totalPage;
 }else if(has1 && !has2){
   begin=totalPage-9;begin=begin<1?1:begin;
   end=totalPage;
 }else{
   begin=1;
   end=totalPage;
 }

pgStr="Page&nbsp;"+absolutePage+"/"+totalPage+"&nbsp;&nbsp;"

if(absolutePage>1){
  pgStr+='<a href="?page=1'+keyword+'" class=a_gray><img src=img/uppage/first.gif></a> ';
 }else{
  //pgStr+='<img src=../../images/uppage/first.gif>';
 }
 
 if(absolutePage>1){
  pgStr+='<a href="?page='+eval(absolutePage-1)+keyword+'" class=a_gray><img src=img/uppage/pro.gif></a> ';
 }else{
 // pgStr+='上一页 ';
 }
 for(i=begin;i<=end;i++){
  pgStr+=' <a href="?page='+i+keyword+'" class=a_gray';
  if(i==absolutePage)pgStr+=' style="color:#ff0000;font-weight:bold;"';
  pgStr+='>'+i+'</a>';
 }
 if(absolutePage<totalPage){
  pgStr+=' <a href="?page='+eval(absolutePage+1)+keyword+'" class=a_gray><img src=img/uppage/next.gif></a>';
 }else{
 // pgStr+=' 下一页'
 }
  if(absolutePage<totalPage){
  pgStr+=' <a href="?page='+totalPage+keyword+'" class=a_gray><img src=img/uppage/last.gif></a>';
 }else{
  //pgStr+=' <font face=webdings title=末页>:</font>'
 }
 
 
 return pgStr;
}



	
function getPageInfo_n(MaxPerPage,totalPage,absolutePage,keyword){
 if(isNaN(totalPage))totalPage=1;
 var pgStr="";
 var has1=absolutePage-2>=1;
 var has2=absolutePage+2<=totalPage;
 var begin=end=1;
 if(has1 && has2){
   begin=absolutePage-1;
   end=absolutePage+2;
 }else if(!has1 && has2){
   begin=1;
   end=totalPage>=4?4:totalPage;
 }else if(has1 && !has2){
   begin=totalPage-3;begin=begin<1?1:begin;
   end=totalPage;
 }else{
   begin=1;
   end=totalPage;
 }

	pgStr="<table width='100%' border='0' cellspacing='0' cellpadding='0'><tr><td width='36%' valign='top'>"

 if(absolutePage>1){
  pgStr+='<a href="?page='+eval(absolutePage-1)+keyword+'" id=Previous>上八张</a> ';
 }else{
  pgStr+='<span id=Previous>上八张</span> ';
 }
 pgStr+="</td><td width='35%' align='center' valign='top'>"
 
 if(absolutePage>2 && totalPage>4)
 {
  pgStr+=' <a href="?page=1'+keyword+'">1</a>';
 }
 if(absolutePage>3 && totalPage>5)
 {
  pgStr+=' <a href="#">...</a>';
 }
 
 for(i=begin;i<=end;i++){
  pgStr+=' <a href="?page='+i+keyword+'"';
  if(i==absolutePage)pgStr+='  id="p1"';
  pgStr+='>'+i+'</a>';
 }
 

 if(absolutePage<(totalPage-3) && totalPage>5)
 {
  pgStr+=' <a href="#">...</a>';
 }
 if(absolutePage<(totalPage-2) && totalPage>4)
 {
  pgStr+=' <a href="?page='+totalPage+keyword+'">'+totalPage+'</a>';
 }
 
 pgStr+="</td><td width='37%' align='right' valign='top'>"
 if(absolutePage<totalPage){
  pgStr+=' <a href="?page='+eval(absolutePage+1)+keyword+'" id=next>下八张</a>';
 }else{
  pgStr+=' <span id=next>下八张</span>'
 }
 pgStr+="</td></tr></table>"
 
 return pgStr;
}

</script>
<script language="javascript" runat="server">
function getPageInfo_jp(MaxPerPage,totalPage,absolutePage,keyword){
 if(isNaN(totalPage))totalPage=1;
 var pgStr="";
 var has1=absolutePage-5>=1;
 var has2=absolutePage+5<=totalPage;
 var begin=end=1;
 if(has1 && has2){
   begin=absolutePage-4;
   end=absolutePage+5;
 }else if(!has1 && has2){
   begin=1;
   end=totalPage>=10?10:totalPage;
 }else if(has1 && !has2){
   begin=totalPage-9;begin=begin<1?1:begin;
   end=totalPage;
 }else{
   begin=1;
   end=totalPage;
 }

pgStr="合計："+totalPage+"&nbsp;&nbsp;ページ："+MaxPerPage+"&nbsp;&nbsp;ページ："+absolutePage+"/"+totalPage+"&nbsp;&nbsp;"

if(absolutePage>1){
  pgStr+='<a href="?page=1'+keyword+'" class=a_gray><font face=webdings title=ホーム>9</font></a> ';
 }else{
  pgStr+='<font face=webdings title=ホーム>9</font>';
 }
 
 if(absolutePage>1){
  pgStr+='<a href="?page='+eval(absolutePage-1)+keyword+'" class=a_gray><font face=webdings title=前>7</font></a> ';
 }else{
 // pgStr+='上一页 ';
 }
 for(i=begin;i<=end;i++){
  pgStr+=' <a href="?page='+i+keyword+'" class=a_gray';
  if(i==absolutePage)pgStr+=' style="color:#ff0000;font-weight:bold;"';
  pgStr+='>'+i+'</a>';
 }
 if(absolutePage<totalPage){
  pgStr+=' <a href="?page='+eval(absolutePage+1)+keyword+'" class=a_gray><font face=webdings title=次の>8</font></a>';
 }else{
 // pgStr+=' 下一页'
 }
  if(absolutePage<totalPage){
  pgStr+=' <a href="?page='+totalPage+keyword+'" class=a_gray><font face=webdings title=最後のページ>:</font></a>';
 }else{
  pgStr+=' <font face=webdings title=最後のページ>:</font>'
 }
 
 return pgStr;
}

</script>