<!--#include file="consts.asp"-->
<!--#include file="func.asp"-->
<%
'''
'分页数
Function cpn(x,y)
cpn=Int(x/y)
if x/y>Int(x/y) then cpn=cpn+1
END Function

'根据数字不同返回不同的文字提示
function num2char(num,txt)
ArrTxt=Split(txt,"|")
num2char=ArrTxt(num)
end function

function alert(txt,rdUrl)
if IsNumeric(rdUrl) then
	if rdUrl=0 then
		R "<script>"
			if txt <> "" then R	"alert('"&txt&"');"
		R "window.close();</script>"
	else
		R "<script>"
			if txt <> "" then R "alert('"&txt&"');"
		R "history.back("&rdUrl&");</script>"
	end if
else
	R "<script>"
		if txt <> "" then R "alert('"&txt&"');"
	R "location.href='"&rdUrl&"';</script>"
end if
	response.End()
end function

'分页数
Function cpn(x,y)
cpn=Int(x/y)
if x/y>Int(x/y) then cpn=cpn+1
END Function

'分页段函数
PageZone = 10
MinP = 1
MaxP = MinP * PageZone

Function mmp(x)
MinP = ( x -1 ) * PageZone + 1
MaxP = x * PageZone
END Function

rdpnum=0
Function ShowZone(a,b,c)
rstp = Cint(a) '当前页
	If rstp < 1 Then rstp = 1
pageall = Cint(b) '总页数
UrlCfg = c '连接参数

curZ = cpn(rstp,pagezone)
allZ = cpn(pageall,pagezone)
call mmp(curZ)

ShowZone = ""

'显示首页
if rstp > 1 then
	ShowZone = ShowZone & "<a class=""l4"" title=""首页"" href=""?" & UrlCfg & "&Page=1"">首页</a>"
else
	ShowZone = ShowZone & "首页"
end if
ShowZone = ShowZone & "&nbsp;|&nbsp;"
'if curZ >1 then
'	ShowZone = ShowZone & "<a class=""l4"" title=""前" & pagezone & "页"" href=""?" & UrlCfg & "&Page=" & MinP-1 & """><span style=""font-family:webdings"">7</span></a>"
'else
'	ShowZone = ShowZone & "<span style=""font-family:webdings"">7</span>"
'end if
'ShowZone = ShowZone & "&nbsp;|&nbsp;"
'显示上一页
if rstp > 1 then
	ShowZone = ShowZone & "<a class=""l4"" title=""上一页"" href=""?" & UrlCfg & "&Page=" & rstp-1 & """>上一页</a>"
else
	ShowZone = ShowZone & "上一页"
end if
ShowZone = ShowZone & "&nbsp;|&nbsp;"
''显示中段
'For I = MinP To MaxP
'	if I <= pageall then
'		if I = rstp then
'			ShowZone = ShowZone & "<font class=Font1>" & I & "</font>"
'		else
'			ShowZone = ShowZone & "<a class=""l4"" href=""?" & UrlCfg & "&Page=" & I & """>" & I & "</a>"
'		end if
'	else
''		ShowZone = ShowZone & " " & I & ""
'	end if
'Next
'ShowZone = ShowZone & "&nbsp;|&nbsp;"
'显示下一页
if rstp < pageall then
	ShowZone = ShowZone & "<a class=""l4"" title=""下一页"" href=""?" & UrlCfg & "&Page=" & rstp+1 & """>下一页</a>"
else
	ShowZone = ShowZone & "下一页"
end if
ShowZone = ShowZone & "&nbsp;|&nbsp;"
'显示末段
'if curZ < allZ  then
'	ShowZone = ShowZone & " <a class=""l4"" title=""后" & pagezone & "页"" href=""?" & UrlCfg & "&Page=" & MaxP+1 & """><span style=""font-family:webdings"">8</span></a>"
'else
'	ShowZone = ShowZone & "　<span style=""font-family:webdings"">8</span>"
'end if
'ShowZone = ShowZone & "&nbsp;|&nbsp;"
'显示末页'
if rstp < pageall then
	ShowZone = ShowZone & "<a class=""l4"" title=""尾页"" href=""?" & UrlCfg & "&Page=" & pageall & """>尾页</a>"
else
	ShowZone = ShowZone & "尾页"
end if
	
	ShowZone = ShowZone & "　共"& pageall &"页 每页"& pNum &"条"
	
	ShowZone = ShowZone & "　跳转至：<input name=""turnpage"" type=""text"" class=""input"" id=""turnpage"" size=""3"" maxlength=""2"" style=""text-align:center;"" />&nbsp;<input style=""height:18px;"" type=""button"" class=""input2"" value=""GO"" onclick=""javascript:location.href='?" & UrlCfg & "&Page='+document.getElementById('turnpage').value"" />"


Response.Write ShowZone

END Function

Function ShowZone2(a,b,c)
rstp = Cint(a) '当前页
	If rstp < 1 Then rstp = 1
pageall = Cint(b) '总页数
UrlCfg = c '连接参数

curZ = cpn(rstp,pagezone)
allZ = cpn(pageall,pagezone)
call mmp(curZ)

ShowZone2 = ""

'显示首页
if rstp > 1 then
	ShowZone2 = ShowZone2 & "<a title=""首页"" href=""?" & UrlCfg & "&Page=1"">首页</a>"
else
	ShowZone2 = ShowZone2 & "首页"
end if
ShowZone2 = ShowZone2 & "&nbsp;|&nbsp;"
'if curZ >1 then
'	ShowZone2 = ShowZone2 & "<a title=""前" & pagezone & "页"" href=""?" & UrlCfg & "&Page=" & MinP-1 & """><span style=""font-family:webdings"">7</span></a>"
'else
'	ShowZone2 = ShowZone2 & "<span style=""font-family:webdings"">7</span>"
'end if
'ShowZone2 = ShowZone2 & "&nbsp;|&nbsp;"
'显示上一页
if rstp > 1 then
	ShowZone2 = ShowZone2 & "<a title=""上一页"" href=""?" & UrlCfg & "&Page=" & rstp-1 & """>上一页</a>"
else
	ShowZone2 = ShowZone2 & "上一页"
end if
ShowZone2 = ShowZone2 & "&nbsp;|&nbsp;"
''显示中段
'For I = MinP To MaxP
'	if I <= pageall then
'		if I = rstp then
'			ShowZone2 = ShowZone2 & "<font class=Font1>" & I & "</font>"
'		else
'			ShowZone2 = ShowZone2 & "<a href=""?" & UrlCfg & "&Page=" & I & """>" & I & "</a>"
'		end if
'	else
''		ShowZone2 = ShowZone2 & " " & I & ""
'	end if
'Next
'ShowZone2 = ShowZone2 & "&nbsp;|&nbsp;"
'显示下一页
if rstp < pageall then
	ShowZone2 = ShowZone2 & "<a title=""下一页"" href=""?" & UrlCfg & "&Page=" & rstp+1 & """>下一页</a>"
else
	ShowZone2 = ShowZone2 & "下一页"
end if
ShowZone2 = ShowZone2 & "&nbsp;|&nbsp;"
'显示末段
'if curZ < allZ  then
'	ShowZone2 = ShowZone2 & " <a title=""后" & pagezone & "页"" href=""?" & UrlCfg & "&Page=" & MaxP+1 & """><span style=""font-family:webdings"">8</span></a>"
'else
'	ShowZone2 = ShowZone2 & "　<span style=""font-family:webdings"">8</span>"
'end if
'ShowZone2 = ShowZone2 & "&nbsp;|&nbsp;"
'显示末页'
if rstp < pageall then
	ShowZone2 = ShowZone2 & "<a title=""尾页"" href=""?" & UrlCfg & "&Page=" & pageall & """>尾页</a>"
else
	ShowZone2 = ShowZone2 & "尾页"
end if
	
	ShowZone2 = ShowZone2 & "　共"& pageall &"页 每页"& pNum &"条"
	
	ShowZone2 = ShowZone2 & "　跳转至：<input name=""turnpage"" type=""text"" id=""turnpage"" size=""3"" maxlength=""2"" style=""text-align:center;"" />&nbsp;<input style=""height:18px;"" type=""button"" value=""GO"" onclick=""javascript:location.href='?" & UrlCfg & "&Page='+document.getElementById('turnpage').value"" />"


Response.Write ShowZone2

END Function

Function TstV(Var,Go)
	TstV = ""
If InStr(Var,",")>0 Then
	Tst2A = split(Var,",")
	Count8A = ubound(Tst2A)
	For I = 0 To Count8A
		Execute("Var2 = "&Tst2A(I))
		TstV = TstV & "【<span style=""color:red;background-color:yellow;font-size:12px;font-weight:bold;"">"& Tst2A(I) &" = " & Var2 & "</span>】<br>"
	Next
Else
	Execute("Var2 = "&var)
	TstV = TstV & "【<span style=""color:red;background-color:yellow;font-size:12px;font-weight:bold;"">"& Var &" = " & Var2 & "</span>】"
End If
	Response.Write TstV
If go=1 then
	response.write "　└→参数诊断模式"
	response.End()
Else
	response.write "　└→参数查询模式"
End IF
End Function

Function TxtArea(Txt,LineType)
TxtArea = ""
Line="<br>"
	If LineType<>1 then Line="<p>"
txt=Replace(txt,vbcrlf,vbcr)
Txt2A = split(txt,vbcr)
Count8A  = ubound(Txt2A)
For I = 0 To Count8A
IF Trim(Txt2A(I))<>"" THEN TxtArea = TxtArea & Txt2A(I) & "" & Line & ""
Next
End Function

Function getTypeNameByIDTree(IDTree)
Sql0 = "select tpName from HS_InfoType where tpTree='"&IDTree&"'"
Set Rs0 = fGetRsList(Sql0)
If Not Rs0.Eof then
	getTypeNameByIDTree =  Rs0(0)
Else
	getTypeNameByIDTree = ""
End If
End Function

Function getTypeNameByID(ID)
Sql0 = "select tpName from HS_InfoType where tpID="&ID&""
Set Rs0 = fGetRsList(Sql0)
If Not Rs0.Eof then
	getTypeNameByID =  Rs0(0)
Else
	getTypeNameByID = ""
End If
End Function

Function W(Tree,Title)
	Set Rs = fGetRsList("Select Top 1 Content From HS_Info Where IDTree = '"& Tree &"' And Title = '"& Title &"'")
	If Not Rs.Eof Then
		R Rs(0)
	Else
		R "调用失败"
	End If
	Rs.Close
	Set Rs = Nothing
End Function

function code_l(str)'ace为.
code_l = str
Arr_CodeStr = Split("ab|cd|ef|gh|ij|kl|mn|op|qr|st","|")
for iii=0 to 9
	code_l = Replace(code_l,iii,Arr_CodeStr(iii))
next
end function

function uncode_l(str)
uncode_l = str
Arr_CodeStr = Split("ab|cd|ef|gh|ij|kl|mn|op|qr|st","|")
for iii=0 to 9
	uncode_l = Replace(uncode_l,Arr_CodeStr(iii),iii)
next
end function
%>