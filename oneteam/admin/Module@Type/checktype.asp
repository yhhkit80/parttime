<!--#include file="../../include/security.asp"-->
<!-- #include file="../../include/consts.asp" -->
<!-- #include file="../../include/func.asp" -->
<!-- #include file="../../include/func@type.asp" -->
<%
if instr(session("flag"),"|1|") < 1 then
	response.write("您没有权限查看此栏目")
	response.End()
end if
GBAction = Request("GBAction")
PageNum = Request("PageNum")

tpID = Request.Form("tpID")
tpName = Gi_fChgSQLStr(Trim(Request.Form("tpName")))
tpInfo = Gi_fChgSQLStr(Request.Form("tpInfo"))
tpImage = Request.Form("tpImage")
If Request.Form("delIMGFile") = 1 or InStr(1,tpImage, "images/nopic" , 1) <> 0 Then
	tpImage = ""
End If
tpParent = Request.Form("tpParent")
tpTree = Request.Form("tpTree")
tpLevel = Request.Form("tpLevel")
ReleaseDate = Request.Form("ReleaseDate")
iLanguage = Request.Form("iLanguage")
RDLPType = Request.Form("RDLPType")
UpLoad_Image1=request.Form("UpLoad_Image1")
info=Gi_fChgSQLStr(request.Form("info"))
pxid=request.Form("pxid")
if not isnumeric(pxid) then pxid=0
if pxid="" then pxid=0
'添加产品类别


If GBAction = "ADPType"& BGSecSon &"" Then
	If tpName = "" Then
		Call Gi_sOnErrGoBack ("类别名称不能为空！")
	End If
		StrSQL ="insert into "& StrDBPrefix &"InfoType(tpName,tpInfo,tpImage,tpParent,tpTree,UpLoad_Image1,tpLevel,ReleaseDate,info,pxid,iLanguage) values('"& tpName &"' "
		StrSQL = StrSQL & ",'"& tpInfo &"' "
		StrSQL = StrSQL & ",'"& tpImage &"' "
		StrSQL = StrSQL & ","& tpParent &" "
		StrSQL = StrSQL & ",'"& tpTree &"' "
		StrSQL = StrSQL & ",'"& UpLoad_Image1 &"' "
		StrSQL = StrSQL & ","& tpLevel &" "
		StrSQL = StrSQL & ",'"& ReleaseDate &"' "
		StrSQL = StrSQL & ",'"& info &"' "
		StrSQL = StrSQL & ","& pxid &""
		StrSQL = StrSQL & ","& iLanguage &") "
		
		fInUpData(StrSQL)

		StrSQL = "update "& StrDBPrefix &"InfoType set IsLeaf=0 where tpID="& tpParent
		fInUpData(StrSQL)

		StrSQL = "select MAX(tpID) from "& StrDBPrefix &"InfoType "
		Set Rs = fGetRsList(StrSQL)
		If Not Rs.Eof Then
			CurID = Rs(0)
			StrSQL = "update "& StrDBPrefix &"InfoType set tpTree='"& tpTree & CurID & ".'" &" where tpID=" & CurID
			fInUpData(StrSQL)
		End If	
		Call A ("综合类别添加成功！")
		Call Gi_sOnSucsSubNext ("TypeList.asp","<input type=""hidden"" id=""iLanguage"" name=""iLanguage"" value="""& iLanguage &""">")


'修改产品类别
Elseif GBAction = "NWPType"& BGSecSon &"" Then
	If tpID = "" Or tpName = "" Then
		Call Gi_sOnErrGoBack("类别ID不能为空！")
	End If
		StrSQL = "update  "& StrDBPrefix &"InfoType set tpName='"& tpName &"' "
		StrSQL = StrSQL & ", tpImage = '"& tpImage &"' "
		StrSQL = StrSQL & ", tpInfo = '"& tpInfo &"' "
		StrSQL = StrSQL & ", UpLoad_Image1 = '"& UpLoad_Image1 &"' "
		StrSQL = StrSQL & ", ReleaseDate = '"& ReleaseDate &"' "
		StrSQL = StrSQL & ", info = '"& info &"' "
		StrSQL = StrSQL & ", pxid = "& pxid &" "
		StrSQL = StrSQL & ", iLanguage = "& iLanguage &" "
		StrSQL = StrSQL & " where tpID = "& tpID
		fInUpData(StrSQL)

		Call A ("综合类别修改成功！")
		Call Gi_sOnSucsSubNext ("TypeList.asp","<input type=""hidden"" id=""iLanguage"" name=""iLanguage"" value="""& iLanguage &""">")

'删除产品类别
Elseif GBAction = "DLPType"& BGSecSon &"" Then
	If tpID = "" Then
		Call Gi_sOnErrGoBack ("类别ID不能为空！")
	End If
		If Not Gi_fCheckIDFieldExsit ("select * from "& StrDBPrefix &"Info where IDTree like'%"& tpTree &"%' ","该产品类别下面存在相关产品，不能删除该类别！请删除相关产品后再删除此类别！") Then			
			Dim TmpPID
			StrSQL = "select tpParent from "& StrDBPrefix & "InfoType where tpTree='"& tpTree&"'"
			Set Rs = fGetRsList(StrSQL)
			TmpPID = Rs(0)
			If Not Gi_fCheckCMFieldExsit ("select * from "& StrDBPrefix &"InfoType where (tpTree like '%" & tpTree & "%') And (tpTree <> '"& tpTree &"')") And RDLPType = "" Then
				R "<script language='javascript'>var Qus;Qus=confirm('该产品类别下面存在子类别删除时将删除此类别下 {( 所有 )} 子类别，确认删除此类别以及所有子类别？\n\n请按确认，取消将返回！');"&_
				"if(Qus==false){"&_
				"document.write('<form action=""TypeList.asp"" method=""post"" name=""OnSucsSubGoNext""><input type=""hidden"" id=""iLanguage"" name=""iLanguage"" value="""& iLanguage &"""></form><script language=""javascript"">document.OnSucsSubGoNext.submit(OnSucsSubGoNext.Form)<\/script>');"&_
				"}else{"&_
				"document.write('<form action=""CheckType.asp"" method=""post"" name=""OnSucsSubGoNext""><input type=""hidden"" id=""iLanguage"" name=""iLanguage"" value="""& iLanguage &"""><input type=""hidden"" id=""tpID"" name=""tpID"" value="""& tpID &"""><input type=""hidden"" id=""tpTree"" name=""tpTree"" value="""& tpTree &"""><input type=""hidden"" id=""GBAction"" name=""GBAction"" value=""DLPType"& BGSecSon &"""><input type=""hidden"" id=""RDLPType"" name=""RDLPType"" value=""yes""></form><script language=""javascript"">document.OnSucsSubGoNext.submit(OnSucsSubGoNext.Form)<\/script>');}</script>"
				E
			End If

				StrSQL = "delete from "& StrDBPrefix & "InfoType where tpTree Like '%." & tpID & ".%'"
				fInUpData(StrSQL)
				
				StrSQL = "select * from "& StrDBPrefix & "InfoType where tpParent="& TmpPID
				Set Rs = fGetRsList(StrSQL)
				If Rs.Eof Then
					StrSQL = "update "& StrDBPrefix & "InfoType set IsLeaf=1 where tpID="& TmpPID
					fInUpData(StrSQL)
				End If
				Call A ("综合类别删除成功！")
				Call Gi_sOnSucsSubNext ("TypeList.asp","<input type=""hidden"" id=""iLanguage"" name=""iLanguage"" value="""& iLanguage &""">")
		End If

'判断进入修改页面
Elseif GBAction = "GTPType"& BGSecSon &"" Then
	If tpID = "" Then
		Call Gi_sOnErrGoBack ("类别ID不能为空！")
	End If
	Call Gi_sOnSucsSubNext ("TypeList.asp","<input type=""hidden"" name=""GBAction"" value=""ModifyNWType"& BGSecSon &"""><input type=""hidden"" name=""tpID"" value="""& tpID &""">")

Else
	Call Gi_sOnSucsGoNext ("您已经掉线，请重新登陆！","../logout.asp")
End If
%>
