<SCRIPT RUNAT=SERVER LANGUAGE=VBSCRIPT>
	Dim Gi_UpLoadStream
	Class Gi_UPLoad
		Dim ObjForm,ObjFile,Version
		Public Function Form(strForm)
			strForm = LCase(strForm)
			If Not ObjForm.exists(strForm) Then
				Form = ""
			Else
				Form = ObjForm(strForm)
			End If
		End Function

		Public Function File(strFile)
			strFile = LCase(strFile)
			If Not ObjFile.Exists(strFile) Then
				Set File = New FileInfo
			Else
				Set File = ObjFile(strFile)
			End If
		End Function

		Private Sub Class_Initialize 
			Dim RequestData,GetStart,VbCrlf,GetInfo,iInfoStart,UpInfoEnd,UpStream,UpStart,TheFile
			Dim GetFormValue,TheFileName
			Dim UpFindStart,UpFindEnd
			Dim UpFormStart,UPFormEnd,UpFormName

			Version="Globeidea.Group FileUPLoad Version 1.0"
			Set ObjForm = Server.Createobject("Scripting.Dictionary")
			Set ObjFile = Server.Createobject("Scripting.Dictionary")
			If Request.Totalbytes < 1 Or Request.Totalbytes > 3004700000 Then Exit Sub
			Set UpStream = Server.Createobject("Adodb.Stream")
			Set Gi_UpLoadStream = Server.Createobject("Adodb.Stream")
			Gi_UpLoadStream.Type = 1
			Gi_UpLoadStream.Mode = 3
			Gi_UpLoadStream.Open		
			Gi_UpLoadStream.Write  Request.BinaryRead (Request.TotalBytes)
			Gi_UpLoadStream.Position = 0
			RequestData = Gi_UpLoadStream.Read 

			UpFormStart = 1
			UPFormEnd = LenB(RequestData)
			VbCrlf = ChrB(13) & ChrB(10)
			GetStart = MidB(RequestData,1, InStrB(UpFormStart,RequestData,VbCrlf)-1)
			UpStart = LenB(GetStart)
			UpFormStart = UpFormStart+UpStart+1
			While (UpFormStart + 10) < UPFormEnd 
				UpInfoEnd = InStrB(UpFormStart,RequestData,VbCrlf & VbCrlf)+3
				UpStream.Type = 1
				UpStream.Mode = 3
				UpStream.Open
				Gi_UpLoadStream.Position = UpFormStart
				Gi_UpLoadStream.CopyTo UpStream,UpInfoEnd-UpFormStart
				UpStream.Position = 0
				UpStream.Type = 2
				UpStream.Charset ="gb2312"
				GetInfo = UpStream.ReadText
				UpStream.Close
			
			'取得表单项目名称
				UpFormStart = InStrB(UpInfoEnd,RequestData,GetStart)
				UpFindStart = InStr(22,GetInfo,"name=""",1)+6
				UpFindEnd = InStr(UpFindStart,GetInfo,"""",1)
				UpFormName = lcase(Mid (GetInfo,UpFindStart,UpFindEnd-UpFindStart))
				
				If InStr (45,GetInfo,"filename=""",1) > 0 Then
				'如果是文件
					Set TheFile=New FileInfo
					'取得文件名
					UpFindStart = InStr(UpFindEnd,GetInfo,"filename=""",1)+10
					UpFindEnd = InStr(UpFindStart,GetInfo,"""",1)
					TheFileName = Mid (GetInfo,UpFindStart,UpFindEnd-UpFindStart)
					TheFile.FileName=GetFileName(TheFileName)
					TheFile.FilePath=GetFilePath(TheFileName)
					'取得文件类型
					UpFindStart = InStr(UpFindEnd,GetInfo,"Content-Type: ",1)+14
					UpFindEnd = InStr(UpFindStart,GetInfo,VbCr)
					TheFile.FileType = Mid (GetInfo,UpFindStart,UpFindEnd-UpFindStart)
					TheFile.FileStart = UpInfoEnd
					TheFile.FileSize = UpFormStart -UpInfoEnd -3
					TheFile.FormName = UpFormName
					If Not ObjFile.Exists(UpFormName) Then
					ObjFile.Add UpFormName,TheFile
					End If
				Else
				'如果是表单项目
					UpStream.Type = 1
					UpStream.Mode = 3
					UpStream.Open
					Gi_UpLoadStream.Position = UpInfoEnd 
					Gi_UpLoadStream.CopyTo UpStream,UpFormStart-UpInfoEnd-3
					UpStream.Position = 0
					UpStream.Type = 2
					UpStream.Charset = "gb2312"
					GetFormValue = UpStream.ReadText 
					UpStream.Close
					If ObjForm.Exists(UpFormName) Then
						ObjForm(UpFormName)=ObjForm(UpFormName)&", "&GetFormValue		  
					Else
						ObjForm.Add UpFormName,GetFormValue
					End If
				End If
				UpFormStart = UpFormStart+UpStart+1
			Wend
			RequestData = ""
			Set UpStream = Nothing
		End Sub

		Private Sub Class_Terminate  
			If Request.TotalBytes > 0 And Request.Totalbytes < 3004700000 Then
				ObjForm.RemoveAll
				ObjFile.RemoveAll
				Set ObjForm = Nothing
				Set ObjFile = Nothing
				Gi_UpLoadStream.Close
				set Gi_UpLoadStream = Nothing
			End If
		End Sub
   
 
		Private Function GetFilePath(FullPath)
			If FullPath <> "" Then
				GetFilePath = Left(FullPath,InStrRev(FullPath, "\"))
			Else
				GetFilePath = ""
			End If
		End  Function
 
		Private Function GetFileName(FullPath)
			If FullPath <> "" Then
				GetFileName = Mid(FullPath,InStrRev(FullPath, "\")+1)
			Else
				GetFileName = ""
			End If
		End  Function
	End Class

Class FileInfo
	Dim FormName,FileName,FilePath,FileSize,FileType,FileStart
	Private Sub Class_Initialize 
		FileName = ""
		FilePath = ""
		FileSize = 0
		FileStart = 0
		FormName = ""
		FileType = ""
	End Sub

	Public Function SaveAs(FullPath)
		Dim Dr
		SaveAs = True
		If Trim(FullPath) = "" Or FileStart = 0 Or FileName = "" or Right(FullPath,1) = "/" Then Exit Function
		Set Dr = CreateObject("Adodb.Stream")
		Dr.Mode=3
		Dr.Type=1
		Dr.Open
		Gi_UpLoadStream.Position = FileStart
		Gi_UpLoadStream.Copyto Dr,FileSize
		Dr.SaveToFile FullPath,2
		Dr.Close
		Set Dr = Nothing 
		SaveAs = False
	End Function
End Class

</SCRIPT>