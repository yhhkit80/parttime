<%
''产品目录树显示
RowCount = 1
Sub get_tpTree(mLevel,mLan,tpID,showLv)
	Dim Rs,StrSQL
	Set Rs = Server.CreateObject("ADODB.Recordset")
	StrSQL = "select * from "& StrDBPrefix &"InfoType where tpParent="& tpID &" and iLanguage="& mLan &" order by pxid desc, ReleaseDate desc,tpID asc"
	Set Rs = fGetRsList(StrSQL)	
	If Not Rs.Eof Then	
		Do While Not Rs.Eof
	tempLv = showLv - 1
		tpID = Rs("tpID")
		tpTree = Rs("tpTree")
		tpLevel = Rs("tpLevel")
		tpName = Rs("tpName")
		isLeaf = Rs("isLeaf")
		isLock = Rs("isLock")
%>
<script>var delCheck=false;</script>
<form action="CheckType.asp" method="post" onsubmit="if(GBAction.value==''||GBAction.value=='ADPType<% = BGSecSon %>'){GBAction.value='ADPType<% = BGSecSon %>'; if (tpName.value==''){return false;}} if(GBAction.value=='GTPType<% = BGSecSon %>'){if(tpID.value==''){return false;}} if(GBAction.value=='DLPType<% = BGSecSon %>'){if(delCheck==false||tpID.value==''){return false;}} Gi_disAllButton();" name="ADFPType">
<input type="hidden" name="GBAction" value="">
<input type="hidden" name="iLanguage" value="<% = iLanguage %>">
<input type="hidden" name="tpImage" value="">
<input type="hidden" name="tpParent" value="<% = tpID %>">
<input type="hidden" name="tpID" value="<% = tpID %>">
<input type="hidden" name="tpTree" value="<% = tpTree %>">
<input type="hidden" name="tpLevel" value="<% = tpLevel+1%>">
<input type="hidden" name="ReleaseDate" value="<% = Date() %>">			
		<%
			R "<tr Class=""Bgtdmain"" onMouseOver=""this.style.backgroundColor='#E8F0FF'"" onMouseOut=""this.style.backgroundColor=''"">"
			
			R "<td title=""完整类别名称【　"& Gi_fChgHtmlStr(tpName) &"　】" + vbcr + "类别所属位置【　"& Gi_fChgHtmlStr(tpTree) &"　】"">"
			For i = 1 To tpLevel-1	
				IIMG = "<img src='../images/II.gif' align=absmiddle><img src='../images/none.gif' align=absmiddle>"
					If i = 1 Then IIMG = "<img src='../images/I.gif' align=absmiddle><img src='../images/none.gif' align=absmiddle>"
				R IIMG
			Next

			IIIMG = "Tminus"
				If tpLevel = 1 Then IIIMG = "ITminus"
			
			If isLeaf = 0 And tempLv < 1 Then
				R "<a href='typelist.asp?tpID="& tpID &"&iLanguage="&iLanguage&"'><img src='../images/Tmax.gif' align=""absmiddle"" border=""0""></a>&nbsp;"
			Else
				R "<img src='../images/"&IIIMG&".gif' align=""absmiddle"">&nbsp;"
			End If
			R ""& Gi_fGetLenStr(tpName,25)
			R "</td>"

			R "<td width=""100"" align=""center"">"'修改删除项
			If isLock < 1 Then R "&nbsp;&nbsp;&nbsp;<input onfocus=""blur()"" CLASS=""InputBtn"" type=""button"" name=""edit"" onClick=""GBAction.value='GTPType"& BGSecSon &"';if(GBAction.value!=''&&tpID.value!=''){submit(this.form);Gi_disAllButton();}"" value=""修改"" onMouseOver=""this.style.backgroundColor='#E8F0FF'"" onMouseOut=""this.style.backgroundColor=''"">&nbsp;&nbsp;<input onfocus=""blur()"" CLASS=""InputBtn"" type=""button"" name=""del"" onClick=""Gi_delConfirm('"& Gi_fChgJsStr(Gi_fChgHtmlStr(tpName)) &"');GBAction.value='DLPType"& BGSecSon &"';if(GBAction.value!=''&&delCheck==true&&tpID.value!=''){submit(this.form);Gi_disAllButton();}"" value=""删除"" onMouseOver=""this.style.backgroundColor='#E8F0FF'"" onMouseOut=""this.style.backgroundColor=''"">&nbsp;&nbsp;"
			R "</td>"

			If tpLevel < mLevel Then '添加项
				R "<td width=""280"" align=""right"">"
			If isLock < 2 Then R "<input type=""text"" Class=""InputTxt"" name=""tpName"" size=""20"">&nbsp;&nbsp;&nbsp;<input style=""width:125"" CLASS=""InputBtn"" onfocus=""blur()"" type=""button"" name=""add"" onClick=""GBAction.value='ADPType"& BGSecSon &"';if(GBAction.value!=''&&tpName.value!=''){submit(this.form);Gi_disAllButton();}"" value=""添加 ("& tpLevel+1 &") 级类别"" onMouseOver=""this.style.backgroundColor='#E8F0FF'"" onMouseOut=""this.style.backgroundColor=''""><img width=""5"" src=""../images/spacer.gif"" border=""0"" align=""absmiddle"">"
				R  "</td>"			
			Else
				R "<td>&nbsp;</td>"
			End If

			R "</tr>"
		%>
</form>
		<%	
			If Cint(tempLv) > 0 Then Call get_tpTree(mLevel,mLan,tpID,tempLv) '递归处
			If tpLevel = 1 Then
				mtpTree = tpTree
				If InStr(1,mtpTree, tpTree, 1) <> 0 Then RowCount = RowCount+1
			End if
			Rs.MoveNext
		Loop
	End If
	Rs.Close
	Set Rs = Nothing									
End Sub
%>