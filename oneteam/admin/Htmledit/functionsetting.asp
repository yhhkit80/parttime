<!--#include file="#uploadstream@hs.inc"-->
<%
'���ݿ����*******************************************
'****************************************************
'����: fGetConn
'����: �������ݿ����Ӷ���
'Set Conn = fGetConn
'---------------------------------------------------
'****************************************************
Const StrDBPrefix = "getDebug_"

Function fGetConn
	Dim ObjConn
	Set ObjConn = Server.CreateObject("ADODB.Connection") 
	ObjConn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="& Server.MapPath("UPLib.mdb")

	If Err.Number <> 0 Then
		Call A ("���ݿ����Ӳ��ϣ�")
	Else
		Set fGetConn = ObjConn 
		Set ObjConn = Nothing
	End If
End Function

'****************************************************
'����: fGetRsList
'����: ִ�� Sql ��ѯ��䣬���ؼ�¼��
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
		Call A ("fGetRsList����,����!")
	End If

	Conn.Close 
	Set Conn = Nothing
End Function

'****************************************************
'����: fInUpData
'����: ִ�� Sql ��ѯ��䣬���¼�¼��
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
		A ("fInUpData����,����!")
	End If

	Conn.Close 
	Set Conn = Nothing
End Function


'�ϴ��������*************************************
'�õ��ϴ����͵�����趨
Function Gi_fGetUpSetting(UPType)
	UPTypeArray = Array("ͼƬ","�ļ�")
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

'�õ��ϴ����͵�����趨
Function Gi_GetFileType(FileExt)
	FileExtArray = Array(".jpg",".bmp",".gif",".png",".zip",".rar",".pdf",".doc",".xls",".txt","ppt")
	FileExtShowArray = Array(".JPG - JPEGͼ���ļ�",".BMP - WINDOWS or OS/2 λͼ�ļ�",".GIF - CompuServeλͼ�ļ�",".PNG - ����ֲ������ͼ���ļ�",".ZIP - ѹ���ļ�",".RAR - ѹ���ļ� (Eugene Roshall ��ʽ)",".PDF - Adobe Acrobat �ɵ����ĵ���ʽ�ļ�",".DOC - Microsoft Word �ĵ��ļ�",".XLS - Microsoft Excel �ĵ��ļ�",".TXT - ASC���ı���ʽ�ļ�",".PPT - Microsoft Office PowerPoint �ĵ��ļ�")

	For i = 0 To UBound(FileExtArray)
		If FileExt = FileExtArray(i) Then
			Gi_GetFileType = FileExtShowArray(i)
		End If
	Next
	i = i+1
End Function
'***********************************************


'ִ���ļ��ϴ�
Function Gi_fGetUpLoad(UPType)
	Dim ExeUpLoad,File,FormName,FormPath,FileName,FileExt,UpLoadOk
	UpLoadOk = False
	Set ExeUpLoad = New Gi_UPLoad ''�����ϴ�����
	FormPath=ExeUPload.Form("FilePath")
	If Right(FormPath,1) <> "/" Then FormPath = FormPath&"/"		'��Ŀ¼���(/)

	For Each FormName In ExeUpLoad.ObjFile					'�г������ϴ��˵��ļ�
		Set File = ExeUpLoad.File(FormName)					'����һ���ļ�����
		If File.FileSize < 1 Then
			JS "alert('����ѡ����Ҫ�ϴ����ļ�');location.href='GetUpLoad.asp?UPFAction=GetUpLoad"&GetUpSecSon&"';"
		End If
		'JS "alert('"&File.FileSize&"');location.href='GetUpLoad.asp?UPFAction=GetUpLoad"&GetUpSecSon&"';"
		If File.FileSize > ValidFileSize Then
			JS "alert('�ļ���С����������');location.href='GetUpLoad.asp?UPFAction=GetUpLoad"&GetUpSecSon&"';"
		End If
		FileExt = Lcase(Right(File.FileName,4))
		If Not Instr(1,ValidFileExt, fileExt , 1) <> 0  Then
			JS "alert('���ļ���ʽ�������ϴ�');location.href='GetUpLoad.asp?UPFAction=GetUpLoad"&GetUpSecSon&"';"
		End If		
		Randomize
		RanNum = Int(90000*Rnd)+10000
	'if UPType="�ļ�" then
		FileName = File.FileName
	'else
		FileName = Year(Now) & Month(Now) & Day(Now) & Hour(Now) & Minute(Now) & Second(Now)& RanNum & FileExt	
	'end if
		If File.FileSize > 0 And File.FileSize < ValidFileSize Then		'��� FileSize > 0 ˵�����ļ�����
		
			File.SaveAs Server.Mappath(UpLoadPath & FileName)		'�����ļ�

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
			R "<head><LINK href='sn.css' type='text/css' rel='stylesheet'></head><body leftMargin=0 TopMargin=0 marginheight=0 marginwidth=0><TABLE cellSpacing=0 cellPadding=0 width='100%'><Form action=GetUpLoad.asp?UPFAction=ADUPInfo"& GetUpSecSon &" method=post name=ADUPInfo onsubmit= Gi_disAllButTon();><input type=""hidden"" name=""UPID"" value="& UPID &"><input type=""hidden"" name=AddPic value=""""><tr><td height=""10"" style=""padding-left:16px"">��<font color=""#AA0000"">"& UPType &"�ϴ��ɹ�.........^_^)</font>��</td></tr><TR ><TD> <FIELDSET><LEGEND>��<font color=""#AA0000"">��д�ϴ�"& UPType &"˵����Ϣ</font>��</LEGEND><div style=""padding-Top:5px;padding-botTom:0px"" ><textarea name=""BriefInfo"" rows=""5"" cols=""47""></textarea></div></FIELDSET></TD></TR><tr><td height=""15"">&nbsp;</td></tr><TR><td align=""right"" width=""100%"" height=""30""><input class=""hand iButton"" type=""button"" style=""width:100%;"" value=""������&���"& UPType &"���ӵ�ҳ�桿"" onMouseOver=""this.style.backgroundColor='#E8E4DD'"" onMouseOut=""this.style.backgroundColor=''"" onclick=""AddPic.value='Addpic(\'"& UpLoadPath & FileName &"\')' ;document.ADUPInfo.submit()"" onfocus=""blur()""></td></TR></Form></TABLE></body>"
			E
		End If
		Set File = Nothing
	Next
	
	If Not (UpLoadOk) Then
		JS "alert('��ʱ������ʧ��');location.href='getupload.asp?UPFAction=GetUpLoad"& GetUpSecSon &"';"
	End If	
	Set Upload = Nothing
End Function


'�鿴�����ֶ������Ƿ����
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

'ȷ�ϴ�ֵ
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


'����ļ���׺��
Function Gi_fGetFileExtName(FileName)
	Dim Pos
	Pos = InStrRev (FileName,".")
	If Pos > 0 Then 
		Gi_fGetFileExtName = Mid (FileName,Pos+1)
	Else
		Gi_fGetFileExtName =  ""
	End If
End Function 

'��˳��������ɫ
Function Gi_fChgBgColor(i,Sep,Color)
	If IsNull(i) Or IsNull(Sep) Then Exit Function
	Dim TmpArray
	TmpArray = Split(Color,Sep,-1)	
	Gi_fChgBgColor = TmpArray( i mod (Ubound(TmpArray)+1))
End Function

'��֤���̴���ʱ�����***********************************
'�滻JAVA�ű��е������ַ�
Function Gi_fChgJsStr(Byval Str)
	If IsNull(Str) Then Exit Function
	Str=replace(Str,"'","\'")
	Str=replace(Str,"""","\""")
	Str=replace(Str,chr(13)+chr(10),"\n")
	Gi_fChgJsStr=Str
End Function


'������ݿⵥ��������
Function Gi_fChgSQLStr(Byval Str)
	If IsNull(Str) Then Exit Function
	Str=replace(Str,"'","''")
	Gi_fChgSQLStr=Str
End Function

'��ʾ�û�������ı����滻�����ַ�
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

'����ʽ
Function Gi_fReplaceEx(Patrn,OrgiStr,ReplStr)
	Dim RegEx, Str					' ����������
	Set RegEx = New RegExp			' ����������ʽ��
	RegEx.Pattern = Patrn			' ����ģʽ��
	RegEx.IgnoreCase = True			' �����Ƿ����ִ�Сд��
	Gi_fReplaceEx = RegEx.Replace(OrgiStr, ReplStr)         ' ���滻��
End Function



'������ʾ�󷵻�ǰҳ��һ������FORM�ύ
Sub Gi_sOnErrGoBack(StrErr)
	R "<script language='javascript'>alert('" & Gi_fChgJsStr(StrErr) & "');"
	R "window.history.go(-1);</script>"
	E
End Sub


'�ɹ����Զ����ύ����ָ��ҳ��
Sub Gi_sOnSucsSubNext(StrUrl,StrSub)
	R "<form action="""& StrUrl &""" method=""post"" name=""OnSucsSubGoNext"">"& StrSub &"</form><script language=""javascript"">document.OnSucsSubGoNext.submit(OnSucsSubGoNext.form)</script>"
	E
End Sub


'�ɹ�������ָ��ҳ��
Sub Gi_sOnSucsGoNext(StrSucs,url)
	R "<script language='javascript'>alert('" & Gi_fChgJsStr(StrSucs) & "');"
	R "window.location='" & url & "';</script>"
	E
End Sub


'������ʾ��رյ�ǰ���ڡ�
Sub Gi_sOnErrCloseWindow(StrErr)
	R "<script language='javascript'>alert('" & Gi_fChgJsStr(StrErr) & "');"
	R "window.close();</script>"
	E
End Sub


'�رմ��ڲ�ˢ�¸�����
Sub Gi_sOnSucsReloadOpener(Str)
	R "<script language='javascript'>alert('"& Gi_fChgJsStr(Str) &"');window.opener.window.location.reload();window.close();</script>"
	E
End Sub

'ֻ��ʾָ������������
Sub Gi_sGetLenStr(Str,Amo)
	If IsNull(Str) Or IsNull(Amo) Then Exit Sub
	If Len(Str) > Amo Then
		R (Left (Gi_fChgHtmlStr(Str),Amo) & ".....")
	Else
		R (Gi_fChgHtmlStr(Str))
	End If
End Sub

'����������ָ����Ŀ	
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
		R "��"
	Else
		R "��"
	End If

End Sub


'�������************************************************************
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
'��ҳ����
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
	

	R Head '��ʾForm HEAD

	If PNMode = "button" Then
		AllPiece = "<font class=""cssPage"">{</font>ÿҳ <font class=""cssPage"">"& PageSize &"</font> ��"& SPC &"�� <font class=""cssPage"">"& TotalCount &"</font> ����¼<font class=""cssPage"">}</font>"& SPC &"�� <font class=""cssPage"">"& SEPiece &"</font> ��"& SPC &"�� <font class=""cssPage"">" & CurrentPage & "/" & PageCount & "</font> ҳ "& SPC &"</td><td align=""right"">"

		FPY = "<input onMouseOver=""this.style.backgroundColor='#E8E4DD'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""��ҳ"" name=""firstPage"" onClick=""PageNum.value='1';submit(this.form);"">"
		LPY = "<input onMouseOver=""this.style.backgroundColor='#E8E4DD'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""βҳ"" name=""lastPage"" onClick=""PageNum.value='"& PageCount &"';submit(this.form);"">"
		PPY = "<input onMouseOver=""this.style.backgroundColor='#E8E4DD'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""��һҳ"" name=""prevPage"" onClick=""PageNum.value='"& PrevCurrentPage &"';submit(this.form);"">"
		NPY = "<input onMouseOver=""this.style.backgroundColor='#E8E4DD'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""��һҳ"" name=""nextPage"" onClick=""PageNum.value='"& NextCurrentPage &"';submit(this.form);"">"
		FPN = "<input onMouseOver=""this.style.backgroundColor='#E8E4DD'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""��ҳ"" name=""firstPage"" disabled=true>"
		LPN = "<input onMouseOver=""this.style.backgroundColor='#E8E4DD'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""βҳ"" name=""lastPage"" disabled=true>"
		PPN = "<input onMouseOver=""this.style.backgroundColor='#E8E4DD'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""��һҳ"" name=""nextPage"" disabled=true>"
		NPN = "<input onMouseOver=""this.style.backgroundColor='#E8E4DD'"" onMouseOut=""this.style.backgroundColor=''"" CLASS=""iButton"" onfocus=""blur()"" type=""button"" value=""��һҳ"" name=""oDsubmit"" disabled=true>"
	
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
	
	R AllPiece '��ʾ��ǰҳ������״��
	If CurrentPage <= 1 And   PageCount <> 1 Then 
		R GOPG & SPC & FPN & SPC & PPN & SPC & NPY & SPC & LPY & SPC
	Elseif CurrentPage>1 And CLng(CurrentPage) < PageCount Then 
		R GOPG & SPC & FPY & SPC & PPY & SPC & NPY & SPC & LPY & SPC
	Elseif (CLng(CurrentPage) = PageCount) And PageCount<>1 Then 
		R GOPG & SPC & FPY & SPC & PPY & SPC & NPN & SPC & LPN & SPC
	End If

	R Foot '��ʾForm FOOT

End Sub
%>
