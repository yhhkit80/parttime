<%
Dim ActionFrom
ActionFrom = Request.ServerVariables("HTTP_REFERER")

If Instr (1, ActionFrom, Request.ServerVariables("HTTP_HOST"), 1) = 0 And ActionFrom <> "" Then
	JS "window.close();"	
End If


'上传安全考虑
Dim GetUpSecSon
GetUpSecSon = Session.Contents("GetUpSecSon")
If GetUpSecSon = "" Then
	Dim  RndNum
	Randomize
	RndNum = Int(90000*Rnd)+10000 
	Session.Contents("GetUpSecSon") = Server.URLEncode ( StrReverse( Request.Servervariables("HTTP_USER_AGENT") & Year(Now) & Month(Now) & Day(Now) & Hour(Now) & Minute(Now) & Second(Now) & RndNum ) )
End If
%>