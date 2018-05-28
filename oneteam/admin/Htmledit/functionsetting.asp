<!--#include file="#uploadstream@hs.inc"-->
<%
'数据库相关*******************************************
'****************************************************
'名称: fGetConn
'功能: 建立数据库连接对象
'Set Conn = fGetConn
'---------------------------------------------------
'****************************************************
Const StrDBPrefix = "getDebug_"

Function fGetConn
	Dim ObjConn
	Set ObjConn = Server.CreateObject("ADODB.Connection") 
	ObjConn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="& Server.MapPath("UPLib.mdb")

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


'上传相关设置*************************************
'得到上传类型的相关设定
Function Gi_fGetUpSetting(UPType)
	UPTypeArray = Array("图片","文件")
	ValidFileExtArray = Array("|.jpg|.bmp|.gif|.png|","|.zip|.rar|.doc|.pdf|.xls|.ppt|")
	ValidFileSizeArray = Array("409600","2048000")
	UpLoadPathArray = Array("../../upFile/uploadpictures/","../../upFile/uploadfiles/")

	For i = 0 To UBound(UPTypeArray)
		If UPTypeArray(i) = UPType Then
			ValidFileExt = ValidFileExtArray(i)
			ValidFileSize = ValidFileSizeArray(i)
			UpLoadPath = UpLoadPathArray(i)
		End If
	Next
	i = i+1
End Function

'得到上传类型的相关设定
Function Gi_GetFileType(FileExt)
	FileExtArray = Array(".jpg",".bmp",".gif",".png",".zip",".rar",".pdf",".doc",".xls",".txt","ppt")
	FileExtShowArray = Array(".JPG - JPEG图形文件",".BMP - WINDOWS or OS/2 位图文件",".GIF - CompuServe位图文件",".PNG - 可移植的网络图形文件",".ZIP - 压缩文件",".RAR - 压缩文件 (Eugene Roshall 格式)",".PDF - Adobe Acrobat 可导出文档格式文件",".DOC - Microsoft Word 文档文件",".XLS - Microsoft Excel 文档文件",".TXT - ASCⅡ文本格式文件",".PPT - Microsoft Office PowerPoint 文档文件")

	For i = 0 To UBound(FileExtArray)
		If FileExt = FileExtArray(i) Then
			Gi_GetFileType = FileExtShowArray(i)
		End If
	Next
	i = i+1
End Function
'***********************************************


'执行文件上传
Function Gi_fGetUpLoad(UPType)
	Dim ExeUpLoad,File,FormName,FormPath,FileName,FileExt,UpLoadOk
	UpLoadOk = False
	Set ExeUpLoad = New Gi_UPLoad ''建立上传对象
	FormPath=ExeUPload.Form("FilePath")
	If Right(FormPath,1) <> "/" Then FormPath = FormPath&"/"		'在目录后加(/)

	For Each FormName In ExeUpLoad.ObjFile					'列出所有上传了的文件
		Set File = ExeUpLoad.File(FormName)					'生成一个文件对象
		If File.FileSize < 1 Then
			JS "alert('请先选择你要上传的文件');location.href='GetUpLoad.asp?UPFAction=GetUpLoad"&GetUpSecSon&"';"
		End If
		'JS "alert('"&File.FileSize&"');location.href='GetUpLoad.asp?UPFAction=GetUpLoad"&GetUpSecSon&"';"
		If File.FileSize > ValidFileSize Then
			JS "alert('文件大小超过了限制');location.href='GetUpLoad.asp?UPFAction=GetUpLoad"&GetUpSecSon&"';"
		End If
		FileExt = Lcase(Right(File.FileName,4))
		If Not Instr(1,ValidFileExt, fileExt , 1) <> 0  Then
			JS "alert('该文件格式不允许上传');location.href='GetUpLoad.asp?UPFAction=GetUpLoad"&GetUpSecSon&"';"
		End If		
		Randomize
		RanNum = Int(90000*Rnd)+10000
	'if UPType="文件" then
		FileName = File.FileName
	'else
		FileName = Year(Now) & Month(Now) & Day(Now) & Hour(Now) & Minute(Now) & Second(Now)& RanNum & FileExt	
	'end if
		If File.FileSize > 0 And File.FileSize < ValidFileSize Then		'如果 FileSize > 0 说明有文件数据
		
			File.SaveAs Server.Mappath(UpLoadPath & FileName)		'保存文件

			strSQL = "INSERT INTO "& StrDBPrefix &"UPInfo(UPName,UPTName,UPType,FileSize,BriefInfo) Values("
			strSQL = strSQL & "'" & FileName &"'"
			strSQL = strSQL & ",'"& UPTName &"'"
			strSQL = strSQL & ",'"& UPType &"'"
			strSQL = strSQL & ",'"& File.FileSize &"'"
			strSQL = strSQL & ",'"& BriefInfo &"')"

			fInUpData(strSQL)		
			UpLoadOk = True

			StrSQL = "select top 1 UPID from "& StrDBPrefix &"UPInfo order by UPID desc"
			Set Rs = fGetRsList(StrSQL)
			UPID = Rs("UPID")
			Rs.Close
			Set Rs = Nothing
			R "<head><LINK href='sn.css' type='text/css' rel='stylesheet'></head><body leftMargin=0 TopMargin=0 marginheight=0 marginwidth=0><TABLE cellSpacing=0 cellPadding=0 width='100%'><Form action=GetUpLoad.asp?UPFAction=ADUPInfo"& GetUpSecSon &" method=post name=ADUPInfo onsubmit= Gi_disAllButTon();><input type=""hidden"" name=""UPID"" value="& UPID &"><input type=""hidden"" name=AddPic value=""""><tr><td height=""10"" style=""padding-left:16px"">【<font color=""#AA0000"">"& UPType &"上传成功.........^_^)</font>】</td></tr><TR ><TD> <FIELDSET><LEGEND>【<font color=""#AA0000"">填写上传"& UPType &"说明信息</font>】</LEGEND><div style=""padding-Top:5px;padding-botTom:0px"" ><textarea name=""BriefInfo"" rows=""5"" cols=""47""></textarea></div></FIELDSET></TD></TR><tr><td height=""15"">&nbsp;</td></tr><TR><td align=""right"" width=""100%"" height=""30""><input class=""hand iButton"" type=""button"" style=""width:100%;"" value=""【保存&添加"& UPType &"连接到页面】"" onMouseOver=""this.style.backgroundColor='#E8E4DD'"" onMouseOut=""this.style.backgroundColor=''"" onclick=""AddPic.value='Addpic(\'"& UpLoadPath & FileName &"\')' ;document.ADUPInfo.submit()"" onfocus=""blur()""></td></TR></Form></TABLE></body>"
			E
		End If
		Set File = Nothing
	Next
	
	If Not (UpLoadOk) Then
		JS "alert('超时，传送失败');location.href='getupload.asp?UPFAction=GetUpLoad"& GetUpSecSon &"';"
	End If	
	Set Upload = Nothing
End Function


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
	Str=replace(Str,"'","\'")
	Str=replace(Str,"""","\""")
	Str=replace(Str,chr(13)+chr(10),"\n")
	Gi_fChgJsStr=Str
End Function


'解决数据库单引号问题
Function Gi_fChgSQLStr(Byval Str)
	If IsNull(Str) Then Exit Function
	Str=replace(Str,"'","''")
	Gi_fChgSQLStr=Str
End Function

'显示用户输入的文本，替换特殊字符
Function Gi_fChgHtmlStr(Byval Str)
	If IsNull(Str) Then Exit Function
	Str=replace(Str,"<","&lt;")
	Str=replace(Str,">","&gt;")
	Str=replace(Str,chr(34),"&quot;")             
	Str=replace(Str," ","&nbsp;")
	Str=replace(Str,chr(13)+chr(10),"<br>")         
	Gi_fChgHtmlStr=Str
End Function

Function Gi_fUnChgHtmlStr(Byval Str)
	If IsNull(Str) Then Exit Function
	Str=replace(Str,"&lt;","<")
	Str=replace(Str,"&gt;",">")
	Str=replace(Str,"&quot;",chr(34))             
	Str=replace(Str,"&nbsp;"," ")
	Str=replace(Str,"<br>",chr(13)+chr(10))         
	Gi_fUnChgHtmlStr=Str
End Function

'正则式
Function Gi_fReplaceEx(Patrn,OrgiStr,ReplStr)
	Dim RegEx, Str					' 建立变量。
	Set RegEx = New RegExp			' 建立正则表达式。
	RegEx.Pattern = Patrn			' 设置模式。
	RegEx.IgnoreCase = True			' 设置是否区分大小写。
	Gi_fReplaceEx = RegEx.Replace(OrgiStr, ReplStr)         ' 作替换。
End Function



'出错，提示后返回前页。一般用于FORM提交
Sub Gi_sOnErrGoBack(StrErr)
	R "<script language='javascript'>alert('" & Gi_fChgJsStr(StrErr) & "');"
	R "window.history.go(-1);</script>"
	E
End Sub


'成功，自动表单提交进入指定页面
Sub Gi_sOnSucsSubNext(StrUrl,StrSub)
	R "<form action="""& StrUrl &""" method=""post"" name=""OnSucsSubGoNext"">"& StrSub &"</form><script language=""javascript"">document.OnSucsSubGoNext.submit(OnSucsSubGoNext.form)</script>"
	E
End Sub


'成功，进入指定页面
Sub Gi_sOnSucsGoNext(StrSucs,url)
	R "<script language='javascript'>alert('" & Gi_fChgJsStr(StrSucs) & "');"
	R "window.location='" & url & "';</script>"
	E
End Sub


'出错，提示后关闭当前窗口。
Sub Gi_sOnErrCloseWindow(StrErr)
	R "<script language='javascript'>alert('" & Gi_fChgJsStr(StrErr) & "');"
	R "window.close();</script>"
	E
End Sub


'关闭窗口并刷新父窗口
Sub Gi_sOnSucsReloadOpener(Str)
	R "<script language='javascript'>alert('"& Gi_fChgJsStr(Str) &"');window.opener.window.location.reload();window.close();</script>"
	E
End Sub

'只显示指定数量的内容
Sub Gi_sGetLenStr(Str,Amo)
	If IsNull(Str) Or IsNull(Amo) Then Exit Sub
	If Len(Str) > Amo Then
		R (Left (Gi_fChgHtmlStr(Str),Amo) & ".....")
	Else
		R (Gi_fChgHtmlStr(Str))
	End If
End Sub

'分离数组中指定项目	
Sub Gi_sGetSplitStr(Str,Sep,Ordinal)
	If IsNull(Str) Or IsNull(Sep) Then Exit Sub
	Dim TmpArray
	TmpArray = Split(Str,Sep,-1)
	If Ordinal = "end" Then
		R (Gi_fChgHtmlStr(TmpArray(Ubound(TmpArray))))
	Elseif Ordinal > 0 And Ordinal < Ubound(TmpArray) Then
		R (Gi_fChgHtmlStr(TmpArray(Ordinal)))
	Else
		R (Gi_fChgHtmlStr(Str))
	End If
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
	R "<SCRIPT Language='JavaScript'>alert('"& Gi_fChgJsStr(Str) &"');</SCRIPT>" 
End Sub

Sub JS(Str)
	R "<script language='javascript'>"&Str&"</script>"
End Sub

Sub T(Str)
	R "<SCRIPT Language='JavaScript'>var winname = window.open('', '_blank', 'toolbar=no, menubar=yes, scrollbaRs=yes, resizable=yes ,location=no, status=yes');	winname.document.open('text/html', 'replace');winname.document.writeln('"& Gi_fChgJsStr(Str) &"');	winname.document.close();</SCRIPT>"
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

	CurrentPage=Request.Form("PageNum")
	If CurrentPage = "" Or CurrentPage < 0 Then                                                            
		CurrentPage = 1                                                           
	Else
		CurrentPage = Cint(CurrentPage)
	End If
	
	If PageSize = "" Or PageSize = 0 Then
		PageSize = 15
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
	SPC = "<img src=""images/spacer.gif"" border=""0"" align=""absmiddle"" hspace=""3"">"
	Head = "<table width=""100%""  border=""0"" cellspacing=""2"" cellpadding=""0""><form action="""& URL &""" method=""post"" onSubmit=""if(PageNum.value=='"& CurrentPage &"'||eval(PageNum.value)>'"& PageCount &"'||eval(PageNum.value)<='0'||PageNum.value==''){PageNum.value='';PageNum.focus();return false;} Gi_disAllButton();"" Name=""PageF"">"& SrchAllHObj &"<tr><td align=""right"">"
	Foot = "</td></tr></form></table>"

	GOPG="<input type=""text"" style=""width:28px;height:25px;BORDER-top: buttonshadow 1PX solid;BORDER-left: buttonshadow 1PX solid;BORDER-right: buttonhighlight 1PX solid;BORDER-bottom: buttonhighlight 1PX solid;BACKGROUND-COLOR:threedface;PADDING-LEFT:3px;PADDING-RIGHT:3px;PADDING-TOP:3px;PADDING-BOTTOM:3px;"" name=""PageNum"" maxlength="& Len(PageCount) &" onblur=""if(this.value==''){oGo.disabled=true;}else{oGo.disabled='';}"" onkeypress=""return event.keyCode>=48&&event.keyCode<=57||event.keyCode==46||event.keyCode==13"" onpaste=""return !clipboardData.getData('text').match(/\D/)"" ondragenter=""return false"" style=""ime-mode:Disabled"">&nbsp;&nbsp;<input type=""button"" value=""Go!"" disabled=true Class=""iButton"" name=""oGo"" onClick=""if(PageNum.value!='"& CurrentPage &"'&&eval(PageNum.value)<='"& PageCount &"'&&eval(PageNum.value)>'0'&&PageNum.value!=''){submit(this.form);}else{PageNum.value='';PageNum.focus();}"">"

	If CurrentPage = 1 Then
		SPiece = 1
	Else
		SPiece = (CurrentPage-1)*PageSize+1	
	End If
	
	EPiece = (CurrentPage)*PageSize

	If EPiece > TotalCount Then
		EPiece = TotalCount		
	End If

	If SPiece = EPiece Then
		SEPiece = EPiece
	Else
		SEPiece = SPiece &"-"& EPiece
	End If
	

	R Head '显示Form HEAD

	If PNMode = "button" Then
		AllPiece = "<font class=""cssPage"">{</font>每页 <font class=""cssPage"">"& PageSize &"</font> 条"& SPC &"共 <font class=""cssPage"">"& TotalCount &"</font> 条记录<font class=""cssPage"">}</font>"& SPC &"第 <font class=""cssPage"">"& SEPiece &"</font> 条"& SPC &"第 <font class=""cssPage"">" & CurrentPage & "/" & PageCount & "</font> 页 "& SPC &"</td><td align=""right"">"

		FPY = "<input onMouseOver=""this.style.backgroundColor='#E8E4DD'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""首页"" name=""firstPage"" onClick=""PageNum.value='1';submit(this.form);"">"
		LPY = "<input onMouseOver=""this.style.backgroundColor='#E8E4DD'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""尾页"" name=""lastPage"" onClick=""PageNum.value='"& PageCount &"';submit(this.form);"">"
		PPY = "<input onMouseOver=""this.style.backgroundColor='#E8E4DD'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""上一页"" name=""prevPage"" onClick=""PageNum.value='"& PrevCurrentPage &"';submit(this.form);"">"
		NPY = "<input onMouseOver=""this.style.backgroundColor='#E8E4DD'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""下一页"" name=""nextPage"" onClick=""PageNum.value='"& NextCurrentPage &"';submit(this.form);"">"
		FPN = "<input onMouseOver=""this.style.backgroundColor='#E8E4DD'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""首页"" name=""firstPage"" disabled=true>"
		LPN = "<input onMouseOver=""this.style.backgroundColor='#E8E4DD'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""尾页"" name=""lastPage"" disabled=true>"
		PPN = "<input onMouseOver=""this.style.backgroundColor='#E8E4DD'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""上一页"" name=""nextPage"" disabled=true>"
		NPN = "<input onMouseOver=""this.style.backgroundColor='#E8E4DD'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""下一页"" name=""oDsubmit"" disabled=true>"
	
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
%>
