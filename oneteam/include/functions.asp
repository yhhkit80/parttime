<%
sub newslist(num,newdate,idtree,url,len1,len2,ifradio)
	sql="select top "&num&" newsid,newstitle,releasedate from ns_newscontent where idtree='"&idtree&"' order by istop desc,releasedate desc,newsid desc"
	set rs=fGetRsList(sql)
	if not rs.eof then
	%>
	<table width="92%"  border="0" cellspacing="0" cellpadding="0">
	  <%
	  do while not rs.eof
		newstitle=rs("newstitle")
		if datediff("d",rs("releasedate"),date())<newdate then
			newstitle=left(newstitle,len1)
			action="<img src=""../../images/new/new.jpg"" width=""31"" height=""11"">"
		else
			newstitle=left(newstitle,len2)
			action=""
		end if
	  %>
	  <tr align="left" height="18">
	  	<%if ifradio=1 then%>
		<td width="12" align="center"><img src="../../images/new/lit.jpg" width="5" height="5"></td>
		<%elseif ifradio=2 then%>
		<td width="12" align="left"><img src="../../images/business/lit2.jpg" width="9" height="8"></td>
		<%end if%>
		<td> <a href="<%=url%>?newsid=<%=rs("newsid")%>">
		<%=newstitle%>
		</a><%=action%></td>
	  </tr>
	  <%
	  rs.movenext
	  loop
	  %>
  </table>
 <%
	end if
	rs.close
	set rs=nothing
end sub 
 %> 
<%


sub pages(n,p,intRecordCount,MaxPerPage,currentPage,keyword)
	if n<>0 then
	response.write"<table width=""98%"" border=""0"" align=""center"" cellpadding=""5"" cellspacing=""0"">"&vbcrlf
  	response.write"<tr>"&vbcrlf
    response.write"<td height=""40"" align=""center"">共<b>"&intRecordCount&"</b>条信息&nbsp;&nbsp;&nbsp;每页<b>"&MaxPerPage&"</b>条&nbsp;&nbsp;&nbsp;页次<b>"&currentPage&"</b>/<b>"&n&" </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"&vbcrlf
		if currentPage=1 then
			response.write "<font face=webdings>9</font>"&vbcrlf
		else
			response.write "<a href='?page=1"&keyword&"' title='首页'><font face=webdings>9</font></a>   "&vbcrlf
		end if
		if currentpage-1 mod 10 =0 then
			p=(currentpage-1) \ 10
		else
			p=(currentpage-1) \ 10
		end if
		MaxPerPage=10
		if currentpage>2 then
			id=currentpage-1
		else
			id=1
		end if
		if currentpage<n then
			id2=currentpage+1
		else
			id2=n
		end if
		if p*MaxPerPage>0 then
		'response.write "<a href='?page="&Cstr(p*MaxPerPage)&""&keyword&"' title='上十页'><font face=webdings>7</font></a>   "&vbcrlf
		response.write "<a href='?page="&Cstr(id)&""&keyword&"' title='上一页'><font face=webdings>7</font></a>   "&vbcrlf
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
		response.write "<a href='?page="&Cstr(id2)&""&keyword&"' title='下一页'><font face=webdings>8</font></a>   "&vbcrlf
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

'****************
'随机密码
'****************
function makePassword(byVal maxLen) 
	Dim strNewPass 
	Dim whatsNext, upper, lower, intCounter 
	Randomize 
	
	For intCounter = 1 To maxLen 
		whatsNext = Int((1 - 0 + 2) * Rnd + 0) 
		If whatsNext = 0 Then 
			upper = 90 
			lower = 65 
		Else 
			if whatsNext=1 then
				upper=122
				lower=97
			else
				upper = 57 
				lower = 48 
			end if
		End If 
		strNewPass = strNewPass&Chr(Int((upper - lower + 1) * Rnd + lower))
	Next 
	makePassword = strNewPass 
end function 
%>