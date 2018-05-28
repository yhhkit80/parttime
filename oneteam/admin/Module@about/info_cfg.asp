<%
if instr(session("flag"),"|3|") < 1 then
	response.write("您没有权限查看此栏目")
	response.End()
end if
'HS后台Little版
'-ver sp1.0 2006-11-03'
'-ver sp1.1 2006-11-14
'+++以下部分为基本参数设置+++'

Dim Menu
	Menu = "ABOUT US"
Dim Arr_tpTree(1)
	Arr_tpTree(1) = ".0.1."

Dim IsLeaf
	IsLeaf = 0

	Str_Is = "top|new|hot|hide|index"
	Arr_Is = Split(Str_Is,"|")
	Cot_Is = Ubound(Arr_Is)
	Str_Is_Alt = "推荐|置新|置热|隐藏|首页"
	Arr_Is_Alt = Split(Str_Is_Alt,"|")
	Cot_Is_Alt = Ubound(Arr_Is_Alt)	
	Str_Is_Set = "none|none|none|none|none"'这里的参数插入到Input属性中,none例外”
	Arr_Is_Set = Split(Str_Is_Set,"|")
	Cot_Is_Set = Ubound(Arr_Is_Set)
		Function Is_Out(Str,Typed)
		Select Case Typed
		Case "list"
			Is_Out = ""
				For I = 0 To Cot_Is
					If InStr(Lcase(Str),Arr_Is(I)) > 0 then Arr_Is_Set(I) = Arr_Is_Set(I) & " checked"
					If Arr_Is_Set(I) <> "none" Then Is_Out = Is_Out & "<input "& Arr_Is_Set(I) &" name=""OnOff"" type=""checkbox"" value="""& Arr_Is(I) &""">"& Arr_Is_Alt(I) &""
				Next
			Is_Out = Is_Out & "</font>"
		Case "show"		
			Is_Out = "<font color=""#990000"">"
				For I = 0 To Cot_Is
					If Arr_Is_Set(I) <> "none" Then
						If InStr(Lcase(Str),Arr_Is(I)) > 0 then
							Is_Out = Is_Out & "<img src=""../Images/set_"& Arr_Is(I) &"_on.jpg"" title=""【"& Arr_Is_Alt(I) &"】开"&"启"">&nbsp;"
						Else
							Is_Out = Is_Out & "<img src=""../Images/set_"& Arr_Is(I) &"_off.jpg"" title=""【"& Arr_Is_Alt(I) &"】关"&"闭"">&nbsp;"
						End If
					End If
				Next
			Is_Out = Is_Out & "</font>"
		End Select
		End Function

Dim IsUpFile,IsUpImage
	IsUpFile  = "disabled"
	IsUpImage = ""

Dim Arr_tpSelectBgColor(10)
	Arr_tpSelectBgColor(1) = "#990000"
	Arr_tpSelectBgColor(2) = "#202020"
	Arr_tpSelectBgColor(3) = "#606060"
	Arr_tpSelectBgColor(4) = "#909090"
	Arr_tpSelectBgColor(5) = "#B0B0B0"
	Arr_tpSelectBgColor(6) = "#C0C0C0"

Dim Static_List

Dim select_bg,select_1,select_0
	select_bg = "#E8F0FF"
	select_1 = "../Images/set_On.jpg"
	select_0 = "../Images/set_Off.jpg"

Sub sb_tpSelect(IDTree,iLanguage,IsLeaf)
R "<select class=""InputTxt"" name=""IDTree"" id=""IDTree"" style=""background-color:#808080;color:#efefef;"">"
	Set Rs = fGetRsList("select tpID,tpTree,tpName,tpLevel from "& StrDBPrefix &"InfoType where tpTree like '"&Arr_tpTree(iLanguage)&"%' and IsLeaf >= " & IsLeaf & " and iLanguage="& iLanguage &" order by tpTree asc,tpParent asc")
	If Not Rs.Eof Then
		Do While Not Rs.Eof
		rdID    = Rs(0)
		rdTree  = Rs(1)
		rdName  = Rs(2)
		rdLevel = Rs(3)
		block = ""
		For I=2 To rdLevel
			block = block & "&nbsp;&nbsp;"
		Next
		block = block & "+--"
		static_list = static_list & "|" & rdTree & rdName	
		rdName = block & rdName
			R "<option value="""& rdTree &""" style=""background-color:"&Arr_tpSelectBgColor(rdLevel)&""""
				If rdTree = IDTree Then R " selected "
			R ">" & rdName & "</option>" & vbLf
		Rs.MoveNext
		Loop
	Else
		R "<option value=""0"">暂无任何类别</option>"
	End If
	Rs.Close
	Set Rs = Nothing
R "</select>"
End Sub

Function getSthBySql(Sql)
Set Rs0 = fGetRsList(Sql)
If Not Rs0.Eof then
	getSthBySql =  Rs0(0)
Else
	getSthBySql = ""
End If
End Function
%>