<%
'HS后台Little版
'-ver sp1.0 2006-11-03'
'-ver sp1.1 2006-11-14
'+++以下部分为基本参数设置+++'

'各提示项内动态文字
Dim Menu
	Menu = "回收站"
'各信息列表起始IDTree
Dim Arr_tpTree(4)
	Arr_tpTree(1) = "@"
	Arr_tpTree(2) = "@"
	Arr_tpTree(3) = "@"
'显示@0 仅树末端@1
Dim IsLeaf
	IsLeaf = 0

'属性参数配置
	Str_Is = "top|new|hot|hide|index"
	Arr_Is = Split(Str_Is,"|")
	Cot_Is = Ubound(Arr_Is)
	Str_Is_Alt = "置顶|置新|置热|隐藏|首页"
	Arr_Is_Alt = Split(Str_Is_Alt,"|")
	Cot_Is_Alt = Ubound(Arr_Is_Alt)	
	Str_Is_Set = "|||none|none"'这里的参数插入到Input属性中,none例外”
	Arr_Is_Set = Split(Str_Is_Set,"|")
	Cot_Is_Set = Ubound(Arr_Is_Set)
'附加函数——列表状态项显示函数
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

'上传参数配置
Dim IsUpFile,IsUpImage
	IsUpFile  = "disabled"
	IsUpImage = ""

'下拉框体色彩
Dim Arr_tpSelectBgColor(10)
	Arr_tpSelectBgColor(1) = "#990000"
	Arr_tpSelectBgColor(2) = "#202020"
	Arr_tpSelectBgColor(3) = "#606060"
	Arr_tpSelectBgColor(4) = "#909090"
	Arr_tpSelectBgColor(5) = "#B0B0B0"
	Arr_tpSelectBgColor(6) = "#C0C0C0"

'下拉框体中的目录树静态列表
Dim Static_List

'数据列表色彩配置
Dim select_bg,select_1,select_0
	select_bg = "#E8F0FF"
	select_1 = "../Images/set_On.jpg"
	select_0 = "../Images/set_Off.jpg"
'+++结束<br />

'下拉框体获取函数
Sub sb_tpSelect(IDTree,iLanguage,IsLeaf)
R "<select class=""InputTxt"" name=""IDTree"" id=""IDTree"" style=""background-color:#808080;color:#efefef;"">"
	Set Rs = fGetRsList("select tpID,tpTree,tpName,tpLevel from "& StrDBPrefix &"InfoType where tpTree like '"&Arr_tpTree(iLanguage)&"%' and IsLeaf >= " & IsLeaf & " and iLanguage="& iLanguage &" order by tpTree asc,tpParent asc")
	If Not Rs.Eof Then
		Do While Not Rs.Eof
		rdID    = Rs(0)
		rdTree  = Rs(1)
		rdName  = Rs(2)
		rdLevel = Rs(3)
'下拉框选项头设置
		block = ""
		For I=2 To rdLevel
			block = block & "&nbsp;&nbsp;"
		Next
		block = block & "+--"
'静态记录下拉框项内容到字符串static_list
		static_list = static_list & "|" & rdTree & rdName	
		rdName = block & rdName
'输出下拉框项内容
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

%>