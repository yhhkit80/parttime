<%
'产品目录树显示
RowCount = 1
Sub Gi_sGetNWTypeTree(mLevel,mLan,NWTypeID)
	Dim Rs,StrSQL
	Set Rs = Server.CreateObject("ADODB.Recordset")
	StrSQL = "select * from "& StrDBPrefix &"NewsType where ParentID="& NWTypeID &" and iLanguage="& mLan &" order by ReleaseDate,NWTypeID desc"
	Set Rs = fGetRsList(StrSQL)	
	If Not Rs.Eof Then	
		Do While Not Rs.Eof
		NWTypeID = Rs("NWTypeID")
		IDTree = Rs("IDTree")
		NWTypeLevel = Rs("NWTypeLevel")
		NWTypeName = Rs("NWTypeName")		
		%>
		<script>var delCheck=false;</script>
		<form action="CheckNewsType.asp" method="post" onsubmit="if(GBAction.value==''||GBAction.value=='ADPType<% = BGSecSon %>'){GBAction.value='ADPType<% = BGSecSon %>'; if (NWTypeName.value==''){return false;}} if(GBAction.value=='GTPType<% = BGSecSon %>'){if(NWTypeID.value==''){return false;}} if(GBAction.value=='DLPType<% = BGSecSon %>'){if(delCheck==false||NWTypeID.value==''){return false;}} Gi_disAllButton();" Name="ADFPType">
			<tr Class="Bgtdmain">		
				<input type="hidden" name="GBAction" value="">
				<input type="hidden" name="iLanguage" value="<% = iLanguage %>">
				<input type="hidden" name="NWTypeIMG" value="0">
				<input type="hidden" name="ParentID" value="<% = NWTypeID %>">
				<input type="hidden" name="NWTypeID" value="<% = NWTypeID %>">
				<input type="hidden" name="IDTree" value="<% = IDTree %>">
				<input type="hidden" name="NWTypeLevel" value="<% = NWTypeLevel+1%>">
				<input type="hidden" name="ReleaseDate" value="<% = Date() %>">			
		<%
			R "<td height=""30"" title=""完整类别名称【　"& Gi_fChgHtmlStr(NWTypeName) &"　】"">"
			For i = 1 To NWTypeLevel-1	
				If i = 1 Then
					IIMG = "<img src='../images/I.gif' align=absmiddle><img src='../images/none.gif' align=absmiddle>"
				Else
					IIMG = "<img src='../images/II.gif' align=absmiddle><img src='../images/none.gif' align=absmiddle>"
				End If
				R IIMG
			Next

			If NWTypeLevel = 1 Then
				IIIMG = "ITminus"
			Else
				IIIMG = "Tminus"
			End If
			
			R "<img src='../images/"&IIIMG&".gif' align=""absmiddle"">&nbsp;"
			R ""& Gi_fGetLenStr(NWTypeName,25)&nwtypeid
			R "</td><td align=""center"" width=""115"">"
			R "&nbsp;&nbsp;&nbsp;<input onfocus=""blur()"" CLASS=""InputBtn"" type=""button"" name=""edit"" onClick=""GBAction.value='GTPType"& BGSecSon &"';if(GBAction.value!=''&&NWTypeID.value!=''){submit(this.form);Gi_disAllButton();}"" value=""修改"">&nbsp;&nbsp;<input onfocus=""blur()"" CLASS=""InputBtn"" type=""button"" name=""del"" onClick=""Gi_delConfirm('"& Gi_fChgJsStr(Gi_fChgHtmlStr(NWTypeName)) &"');GBAction.value='DLPType"& BGSecSon &"';if(GBAction.value!=''&&delCheck==true&&NWTypeID.value!=''){submit(this.form);Gi_disAllButton();}"" value=""删除"">&nbsp;&nbsp;</td>"
			
			If NWTypeLevel < mLevel Then
				R "<td align=right width=290>"
				R "<input type=""text"" Class=""InputTxt"" name=""NWTypeName"" size=""20"">&nbsp;&nbsp;&nbsp;<input style=""width:125"" CLASS=""InputBtn"" onfocus=""blur()"" type=""button"" name=""add"" onClick=""GBAction.value='ADPType"& BGSecSon &"';if(GBAction.value!=''&&NWTypeName.value!=''){submit(this.form);Gi_disAllButton();}"" value=""添加 ("& NWTypeLevel+1 &") 级类别""><img width=""5"" src=""../images/spacer.gif"" border=""0"" align=""absmiddle""></td>"			
			Else
				R "<td align=""right"" width=""290"">&nbsp;</td>"
			End If
		%>
		</tr>
		</form>
		<%			
			Call Gi_sGetNWTypeTree(mLevel,mLan,NWTypeID)
			If NWTypeLevel = 1 Then
				mIDTree = IDTree
				If InStr(1,mIDTree, IDTree, 1) <> 0 Then
					RowCount = RowCount+1
				End If
			End if
			Rs.MoveNext
		Loop
	End If
	Rs.Close
	Set Rs = Nothing									
End Sub

Sub Gi_sGetNewsTypeSelect(mIDTree,miLanguage,mIsLeaf)
	Dim Rs,StrSQL
	Set Rs = Server.CreateObject("ADODB.Recordset")
	StrSQL = "select * from "& StrDBPrefix &"NewsType where 0=0"
	If miLanguage <> "" Then
		StrSQL = StrSQL & " and iLanguage="& miLanguage
	End If
	If mIsLeaf <> "" Then
		StrSQL = StrSQL &" and IsLeaf<>0 "
	End If

	StrSQL = StrSQL & " order by IDTree desc,ParentID desc"
	Set Rs = fGetRsList(StrSQL)
	If Not Rs.Eof Then
		Do While Not Rs.Eof
		iIDTree = Rs("IDTree")
		NWTypeLevel = Rs("NWTypeLevel")

			R "<option value="""& iIDTree &""""
			If mIDTree = iIDTree Then R" selected "
			R ">"& Gi_fChgHtmlStr(Gi_fGetIDTreeName(iIDTree,NWTypeLevel)) & "</option>"& vbLf
			Rs.MoveNext
		Loop
	Else
		R "<option value=""0"">没有"& NWModule &"类别</option>"
	End If
	Rs.Close
	Set Rs = Nothing
end Sub

Function Gi_fGetIDTreeName(mIDTree,mLevel)
	Dim Tmp,TmpArray
	Gi_fGetIDTreeName = ""
	Tmp = Mid(mIDTree,2,Len(mIDTree)-2)
	TmpArray = split(Tmp,".")
	Dim i
	For i = 1 To mLevel
		Gi_fGetIDTreeName = Gi_fGetIDTreeName & Gi_fGetNWTypeName(TmpArray(i))
		If i < mLevel Then
			Gi_fGetIDTreeName = Gi_fGetIDTreeName & cLinkSign
		End If
	Next
End Function

Function Gi_fGetNWTypeName(mID)
	Dim Rs,StrSQL
	Set Rs = Server.CreateObject("ADODB.Recordset")
	StrSQL = "select * from "& StrDBPrefix &"NewsType where NWTypeID="& mID
	Set Rs = fGetRsList(StrSQL)
	If Not Rs.Eof Then
		Gi_fGetNWTypeName = Rs("NWTypeName")
	Else
		Gi_fGetNWTypeName = ""
	End If
	Rs.Close
	Set Rs = Nothing
End Function

'前台调用函数
Function Gi_fGetNewsTypeList(miLanguage,misLeaf,mNWTypeLevel)
	Dim Rs,StrSQL
	StrSQL = "select * from "& StrDBPrefix &"NewsType where 0=0"

	If miLanguage <> "" Then
		StrSQL = StrSQL &" and iLanguage="& CInt(miLanguage)
	End If
	If misLeaf <> "" Then
		StrSQL = StrSQL &" and IsLeaf<>0"
	End If
	If mNWTypeLevel <> "" Then
		StrSQL = StrSQL &" and NWTypeLevel="& CInt(mNWTypeLevel)
	End If
	
	StrSQL = StrSQL & " order by IDTree desc, ParentID desc"
	Set Gi_fGetNewsTypeList = fGetRsList(StrSQL)
End Function


Function Gi_fGetNewsTypeFG(Top,miLanguage,mIDTree)
	Dim StrSQL 	
	If Top <> "" Then
		StrSQL = "select top "& Top &" * from "& StrDBPrefix &"NewsType where 0=0 "
	Else
		StrSQL = "select * from "& StrDBPrefix &"NewsType where 0=0 "
	End If
	If miLanguage <> "" Then '选择语言
		StrSQL = StrSQL & " and iLanguage="& CInt(miLanguage)
	End If
	If mIDTree <> "" Then '选择类别
		StrSQL = StrSQL & " and IDTree='"& IDTree &"'"
	End If	
	StrSQL = StrSQL & " order by ReleaseDate desc,IDTree desc"	

	Set Gi_fGetNewsTypeFG = fGetRsList(StrSQL)
End Function

Function Gi_fGetNewsInfoFG(Top,miLanguage,mIDTree,mNewsID)
	Dim StrSQL
	StrSQL = ""
	If miLanguage <> "" Then '选择语言
		StrSQL = StrSQL & " and iLanguage="& CInt(miLanguage)
	End If
	If mIDTree <> "" Then '选择类别
		StrSQL = StrSQL & " and IDTree='"& CInt(mIDTree) &"'"
	End If
	If mNewsID <> "" Then '选择产品ID
		StrSQL = StrSQL & " and NewsID="& CInt(mNewsID)
	End If
	Call Gi_fGetPageCount("select count(NewsID) from "& StrDBPrefix &"NewsInfo where 0=0 " & StrSQL )
	If Top = "" then
		Top = PageSize
		ShowPNLinks = "show"
	End If
	If PrevCurrentPage = 0 Then
		Set Gi_fGetNewsInfoFG = fGetRsList("select top "& Top &" * from "& StrDBPrefix &"NewsInfo where 0=0 and HPagedisplay=1" & StrSQL & " order by ReleaseDate desc,NewsID desc")
	Else
		Set Gi_fGetNewsInfoFG = fGetRsList("select top "& Top &" * from "& StrDBPrefix &"NewsInfo where 0=0 and HPagedisplay=1" & StrSQL & " and NewsID not in (select top "& PrevCurrentPage*Top &" NewsID from "& StrDBPrefix &"NewsInfo order by NewsID desc) order by ReleaseDate desc,NewsID desc")
	End If	
End Function

Function Gi_fGetSearchNewsFG(miLanguage,mIDTree,mKeyWords)
	Dim StrSQL
	If miLanguage <> "" Then '选择语言
		StrSQL = StrSQL & " and "& StrDBPrefix &"NewsInfo.iLanguage="& CInt(miLanguage)
	End If
	If mIDTree <> "" Then '选择类别
		StrSQL = StrSQL & " and "& StrDBPrefix &"NewsInfo.IDTree='"& IDTree & "'"
	End If
	If KeyWords <> "" Then '搜索新闻
		StrSQL = StrSQL & " and ("& StrDBPrefix &"NewsInfo.NewsName like '%"& KeyWords &"%' or "& StrDBPrefix &"NewsInfo.BriefInfo like '%"& KeyWords &"%')"
	End If
	Call Gi_fGetPageCount("select count(NewsID) from "& StrDBPrefix &"NewsInfo where 0=0 " & StrSQL )
	
	ShowPNLinks = "show"
	If PrevCurrentPage = 0 Then
		Set Gi_fGetSearchNewsFG = fGetRsList("select top "& PageSize &" "& StrDBPrefix &"NewsInfo.*,"& StrDBPrefix &"NewsType.NWTypeName from "& StrDBPrefix &"NewsInfo INNER JOIN "& StrDBPrefix &"NewsType ON "& StrDBPrefix &"NewsInfo.IDTree = "& StrDBPrefix &"NewsType.IDTree where 0=0 and HPagedisplay=1 " & StrSQL & " order by "& StrDBPrefix &"NewsInfo.IDTree desc,"& StrDBPrefix &"NewsInfo.ReleaseDate desc,"& StrDBPrefix &"NewsInfo.NewsID desc")	
	Else
		Set Gi_fGetSearchNewsFG = fGetRsList("select top "& PageSize &" "& StrDBPrefix &"NewsInfo.*,"& StrDBPrefix &"NewsType.NWTypeName from "& StrDBPrefix &"NewsInfo INNER JOIN "& StrDBPrefix &"NewsType ON "& StrDBPrefix &"NewsInfo.IDTree = "& StrDBPrefix &"NewsType.IDTree where 0=0 and HPagedisplay=1 " & StrSQL & " and NewsID not in (select top "& PrevCurrentPage*PageSize &" NewsID from "& StrDBPrefix &"NewsInfo order by NewsID desc) order by "& StrDBPrefix &"NewsInfo.IDTree desc,"& StrDBPrefix &"NewsInfo.ReleaseDate desc,"& StrDBPrefix &"NewsInfo.NewsID desc")
	End If
End Function
%>

<%
Function ListProductIndex(ParentID,mTop)
%>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
<tr>
<%
Dim Rs,StrSQL
Set Rs = Server.CreateObject("ADODB.Recordset")
StrSQL = "select * from "& StrDBPrefix &"NewsType where ParentID="& ParentID
Set Rs = fGetRsList(StrSQL)

Do while not Rs.eof
%>
<td height=275>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
        <%
	select case Rs("NWTypeID")
	%>
	<%
		case 1
	%>
	<tr>
	      <td width="137" height=20 align="center" bgcolor="FDF632" class="BR"><a href="../kinds/ProductList.asp?ParentID=<%=Rs("NWTypeID")%>&IDTree=<%=Rs("IDTree")%>" target='_blank'><img src="../../images/cn/index/word01.gif" width="137" height="20" border=0></a></td>
	</tr>
	<%
		case 2
	%>
	<tr>
	      <td width="131" height=20 align="center" bgcolor="0064A0" class="BR"><a href="../kinds/ProductList.asp?ParentID=<%=Rs("NWTypeID")%>&IDTree=<%=Rs("IDTree")%>" target='_blank'><img src="../../images/cn/index/word02.gif" width="131" height="20" border=0></a></td>
	</tr>
	<%
		case 3
	%>
	<tr>
	      <td width="136" height=20 align="center" bgcolor="FF0000" class="BR"><a href="../kinds/ProductList.asp?ParentID=<%=Rs("NWTypeID")%>&IDTree=<%=Rs("IDTree")%>" target='_blank'><img src="../../images/cn/index/word03.gif" width="136" height="20" border=0></a></td>
	</tr>
	<%
		case else
	%>
	<tr>
	  <td width="120" class="TypeTitle" align=center> 
		<%=Rs("NWTypeName")%>
	</td>
	</tr>
	<%
	end select
	%>
	<tr>
	  <td align="center" valign="top">
	    <table width="98%" border="0" cellspacing="0" cellpadding="0" height="100%">
	      <tr>
		        <td align="center" height=100> <a href="../kinds/ProductList.asp?ParentID=<%=Rs("NWTypeID")%>&IDTree=<%=Rs("IDTree")%>" target='_blank'><img src="<%=Rs("NWTypeIMG")%>" width="115" height="86" vspace="9" border=0></a> 
                </td>
	      </tr>
	     <tr>
		        <td align="right"> 
                  <%
	      call GetSubProduct (Rs("IDTree"),mTop)
	      %>
                </td>
	      </tr>
	      <tr>
		<td height="30" align="right" class="LINK2">&nbsp;</td>
	      </tr>
	  </table>
	  </td>
	  </tr>
	<tr>
	  <td align="right" valign="top" class="BTBR" height=20>
		<span class="LINK2"><a href="../kinds/ProductList.asp?ParentID=<%=Rs("NWTypeID")%>&IDTree=<%=Rs("IDTree")%>">更多&gt;&gt;</a></span></td>
	</tr>
	</table>
</td>
<%
	Rs.movenext
Loop
%>
</tr>
</table>
<%
Rs.close
set Rs = nothing
End Function
%>

<%
Function ListProductSubIndex(ParentID)
%>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
<tr>
<%
Dim Rs,StrSQL
Set Rs = Server.CreateObject("ADODB.Recordset")
StrSQL = "select * from "& StrDBPrefix &"NewsType where ParentID="& ParentID
Set Rs = fGetRsList(StrSQL)
dim i
i = 1
Do while not Rs.eof
%>
  <td valign="top">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr align="center">
      <td height="20" bgcolor="005891" class="LINK2"><a href="../kinds/ProductList.asp?ParentID=<%=Rs("NWTypeID")%>&IDTree=<%=Rs("IDTree")%>" target='_blank'><span style="color:#FFFFFF"><%=Rs("NWTypeName")%></span></a></td>
      <td width="19">&nbsp;</td>
    </tr>
    <tr>
      <td height="112" align="center">
      <img src="<%=Rs("NWTypeIMG")%>" width="115" height="86" vspace="9">
      </td>
      <td>&nbsp;</td>
    </tr>
  </table>
  </td>
  <%
  If i mod 4 =0 Then
	response.write "</tr><tr>"
  End If  
  %>
<%
	Rs.movenext
	 i = i +1
Loop
%>
</tr>
</table>
<%
Rs.close
set Rs = nothing
End Function
%>

<%
Function ListSubProduct(mIDTree)
%>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
<tr>
<%
Dim Rs,StrSQL
Set Rs = Server.CreateObject("ADODB.Recordset")
StrSQL = "select * from "& StrDBPrefix &"NewsInfo where IDTree like '%"& mIDtree &"%'"
Set Rs = fGetRsList(StrSQL)
dim i
i = 1
Do while not Rs.eof
%>
  <td valign="top">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr align="center">
      <td height="20" bgcolor="005891" class="LINK2"><a href="../kinds/ProductDetail.asp?NewsID=<%=Rs("NewsID")%>&IDTree=<%=Rs("IDTree")%>" target='_blank'><span style="color:#FFFFFF"><%=Rs("NewsName")%></span></a></td>
      <td width="19">&nbsp;</td>
    </tr>
    <tr>
      <td height="112" align="center">
      <a href="../kinds/ProductDetail.asp?NewsID=<%=Rs("NewsID")%>&IDTree=<%=Rs("IDTree")%>" target='_blank'><img src="<%=Rs("NewsIMG")%>" width="115" height="86" vspace="9" border=0></a>
      </td>
      <td>&nbsp;</td>
    </tr>
  </table>
  </td>
  <%
  If i mod 4 =0 Then
	response.write "</tr><tr>"
  End If  
  %>
<%
	Rs.movenext
	 i = i +1
Loop
%>
</tr>
</table>
<%
Rs.close
set Rs = nothing
End Function
%>

<%
Function GetSubProduct(mIDtree,mTop)
	Dim Rs,StrSQL
	Set Rs = Server.CreateObject("ADODB.Recordset")
	StrSQL = "select Top "&mTop&" * from "& StrDBPrefix &"NewsInfo where IDTree like '%"& mIDtree &"%'"
	Set Rs = fGetRsList(StrSQL)
	
	Do while not Rs.eof		
	%>
	<tr>
		<td class="gay">&nbsp;&nbsp;<a href="../kinds/ProductDetail.asp?NewsID=<%=Rs("NewsID")%>&IDTree=<%=Rs("IDTree")%>" target='_blank'><%=Rs("NewsName")%></a></td>
	 </tr>
	<%
		Rs.movenext
	Loop
	Rs.close
	set Rs = nothing
End Function
%>

<%
Function ProductDetail(mPID)
	Dim Rs,StrSQL
	Set Rs = Server.CreateObject("ADODB.Recordset")
	StrSQL = "select * from "& StrDBPrefix &"NewsInfo where NewsID="& mPID
	Set Rs = fGetRsList(StrSQL)
	
	Do while not Rs.eof		
	%>
	<b><%=Rs("NewsName")%></b>
	<hr noshade size=1 color=Gray>
	 <%=Rs("NewsInfo")%>
	<%
		Rs.movenext
	Loop
	Rs.close
	set Rs = nothing
End Function
%>

<%
Function ListProductType(ParentID)
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="10">&nbsp;</td>
      <td>&nbsp;</td>
    </tr>

<%
Dim Rs,StrSQL
Set Rs = Server.CreateObject("ADODB.Recordset")
StrSQL = "select * from "& StrDBPrefix &"NewsType where ParentID="& ParentID
Set Rs = fGetRsList(StrSQL)

Do while not Rs.eof
%>
    <tr>
      <td height="20">&nbsp;</td>
      <td class="LINK3"><a href="../kinds/ProductList.asp?ParentID=<%=Rs("NWTypeID")%>&IDTree=<%=Rs("IDTree")%>"><%=Rs("NWTypeName")%></a></td>
    </tr>
<%
	Rs.movenext
Loop
%>
</table>
<%
Rs.close
set Rs = nothing
End Function
%>

<%
Function ProductTypeInfo(ParentID)
	Dim Rs,StrSQL
	Set Rs = Server.CreateObject("ADODB.Recordset")
	StrSQL = "select * from "& StrDBPrefix &"NewsType where NWTypeID ="& ParentID
	Set Rs = fGetRsList(StrSQL)
	If not Rs.eof Then	
	%>
	<p class="gay"><strong><%=Rs("NWTypeName")%>介绍</strong>：
	<%=Gi_fChgHtmlStr(Rs("BriefInfo"))%>
	</p>
	<%
	End If
	Rs.close
	set Rs = nothing
End Function
%>