<!-- #include File="../../Include/Security.Asp" -->
<!-- #include File="../../Include/Consts.Asp" -->
<!-- #include File="../../Include/Func.Asp" -->
<!-- #include file="info_cfg.asp" -->
<%
iLanguage = Request("iLanguage")
	if iLanguage = "" then iLanguage = 1
KeyWords = Request.Form("KeyWords")
	if KeyWords = "" then KeyWords = "关键字"
IDTree = Request.Form("IDTree")
	if IDTree = "" then IDTree = Arr_tpTree(iLanguage)

SrchAllHObj = "<input type=""hidden"" id=""IDTree"" name=""IDTree"" value="""& IDTree &"""><input type=""hidden"" id=""iLanguage"" name=""iLanguage"" value="""& iLanguage &"""><input type=""hidden"" id=""keyWords"" name=""keyWords"" value="""& KeyWords &""">"

Call Gi_sGetLangVar
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/css.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../script/func.js"></script>
<script language="javascript" src="../htmledit/optSetting.js"></script>
<script language="javascript" src="../script/blur.js"></script>
<script language="javascript">
var mouseState;
function CheckAll(){
var obji
var boolCheckAll=document.getElementById('checkall').checked;
	for(var i=0;i<document.getElementsByName('DelSel').length;i++){
		document.getElementsByName('DelSel')[i].checked=boolCheckAll;
		if(boolCheckAll){
			document.getElementById('Tr'+(i+1)).style.backgroundColor='<% = select_bg %>';
			document.getElementById('Td'+(i+1)).src='<% = select_1 %>';
		}else{
			document.getElementById('Tr'+(i+1)).style.backgroundColor='';
			document.getElementById('Td'+(i+1)).src='<% = select_0 %>';
		}
	}
}
</script>
</head>
<body onselectstart="return false">
<!--#include file="info_nav.asp" -->
<br />
<%
Dim Rs,StrSQL
Dim iLanguage,GBAction,NWTypeID,SrchAllHObj
Dim CurrentPage,PageSize,PageCount,PrevCurrentPage,NextCurrentPage,TotalCount,PageNum,GetHL

If KeyWords <> "" and KeyWords <> "关键字" Then
	GetHL = true
	KeyWords = Gi_fChgSQLStr(KeyWords)
	StrSQL = StrSQL & " and (Title like '%" & KeyWords & "%' or Keyword like '%" & KeyWords & "%')"
End If

If iLanguage <> "" Then	StrSQL = StrSQL & " and iLanguage="& CInt(iLanguage)
If IDTree <> "0" And IDTree<> "" Then StrSQL= StrSQL & " and IDTree like '"&IDTree&"%'"

Call Gi_sGetPageCount("select count(ID) From "& StrDBPrefix &"Info where 0=0 " & StrSQL)

MySQL = "select top "& PageSize &" * From "& StrDBPrefix &"Info where 0=0 " & StrSQL &  ""
	If PrevCurrentPage > 0 Then MySQL = MySQL & " and ID not in (select top "& PrevCurrentPage*PageSize &" ID From "& StrDBPrefix &"Info where 0=0 "& StrSQL &" Order By  pxid desc, ReleaseDate DESC ,ID DESC)"
MySQL = MySQL & " Order By  pxid desc, ReleaseDate DESC,ID DESC"
Set Rs = fGetRsList(MySQL)

If Rs.Eof Then
%>
<table width="98%" border="0" cellspacing="0" cellpadding="3" align="center" class="Bgtbtop">
  <tr> 
    <td height="63" colspan="2" class="Font14pxwhitestrong"> <table width="100%"  border="0" cellspacing="0" cellpadding="5" >
        <tr> 
          <td height="39" colspan="6"> <table width="100%"  border="0" cellpadding="2" cellspacing="1">
                <tr> 
                  <td height="25" align="Center">对不起，还没有该类数据。</td>
                </tr>
          </table></td>
        </tr>
      </table></td>
  </tr>
</table>
<%
else
%>
<table width="98%" border="0" cellspacing="0" cellpadding="3" align="center" class="Bgtbtop">
  <tr>
    <td>
	<table width="100%"  border="0" cellpadding="3" cellspacing="1" class="tableList">
	<tr class="Bgtdtop Font14pxwhitestrong">
		<td width="30" align="center"><input style="display:none" name="checkall" type="checkbox" id="checkall" onClick="CheckAll();" value="checkbox">选择</td>
		<td width="150" align="center">&nbsp;类别</td>
		<td >名称</td>
		<td width="150" align="center">缩略图</td>
		<td width="70" align="center">排序</td>
		<td width="100" align="center">状态</td>
		<td width="100" align="center">日期</td>
		<td width="50" align="center">操作</td>
	</tr>
<%
RowCount=1
StrID = ""
do while not Rs.eof 

ID = Rs("ID")
	StrID = StrID & "|" & ID
Tree = Rs("IDTree")
Title = Replace(Rs("Title"),"""","")
Title = Replace(Title,"'","")
View = Rs("State_View")
OnOff = Rs("State_OnOff")
IsLock = Rs("IsLock")
	If IsLock = "0" Then LockImg = ""
	If IsLock = "1" Then LockImg = "<img src='../images/lock.jpg' title='被锁定的记录：不能删除或移动'>"
ReleaseDate = Rs("ReleaseDate")
iLanguage = Rs("iLanguage")
upload_image=rs("upload_image")
pxid=rs("pxid")
tpName = Split(Split(static_list,Tree)(1),"|")(0)
'获取父类IDTree
	ParentTree = "."
	Arr_Tree = Split(Tree,".")
	Cot_Tree = Ubound(Arr_Tree)
	For I_Tree = 1 To Cot_Tree - 2
		ParentTree = ParentTree & Arr_Tree(I_Tree) & "."
	Next
tpParent = Split(Split(static_list,ParentTree)(1),"|")(0)
'''

RowCount = RowCount+1

%>  
<form action="info_check.asp" method="post" onSubmit="if(GBAction.value=='DLNContent<% = BGSecSon %>'){if(delCheck==false||ID.value==''){return false;}} Gi_disAllButton();" name="EDDFPInfo">
<input type="hidden" name="GBAction" value="">
<input type="hidden" name="ID" value="<% = ID %>">
<input type="hidden" name="PageNum" value="<% = CurrentPage %>">
<input type="hidden" name="iLanguage" value="<% = iLanguage %>">
	<tr id="Tr<%=RowCount-1%>" class="Bgtdmain" onMouseOver="this.style.backgroundColor='<% = select_bg %>';if(mouseState == 1){document.getElementById('Del<%=RowCount-1%>').checked = !document.getElementById('Del<%=RowCount-1%>').checked;document.getElementById('Del<%=RowCount-1%>').checked = document.getElementById('Del<%=RowCount-1%>').checked;document.getElementById('Td<%=RowCount-1%>').src=(document.getElementById('Del<%=RowCount-1%>').checked)?'<% = select_1 %>':'<% = select_0 %>';}" onMouseOut="if(document.getElementById('Del<%=RowCount-1%>').checked==false){this.style.backgroundColor='';}" onClick="document.getElementById('Td<%=RowCount-1%>').src=(document.getElementById('Del<%=RowCount-1%>').checked)?'<% = select_0 %>':'<% = select_1 %>';document.getElementById('Del<%=RowCount-1%>').checked = !document.getElementById('Del<%=RowCount-1%>').checked;document.getElementById('Del<%=RowCount-1%>').checked = document.getElementById('Del<%=RowCount-1%>').checked;" onMouseDown="mouseState = 1;" onMouseUp="mouseState=0;" style="cursor:pointer;">
	  <td height="30" align="center"><%R LockImg%><img <%If IsLock = 1 Then%>style="display:none"<%End If%> src="<% = select_0 %>" id="Td<%=RowCount-1%>"></td>
		<td align="center" title="上级类别【 <% = tpParent %> 】"><%  = Split(Split(static_list,Tree)(1),"|")(0) %></td>
		<td title="标题全部【 <% = Title %> 】"><% = Gi_GetHighLight(Gi_fGetLenStr(Title,35),KeyWords) %></td>
		<td align="center" ><%if upload_image<>"" then response.Write("<img src='"&upload_image&"' height=50>")%></td>
		<td align="center" ><%=pxid%></td>
		<td align="center" ><% = Is_Out(OnOff,"show")%></td>
		<td align="center" ><% = ReleaseDate%></td>
		<td align="center">
		<input class="InputBtn" onFocus="blur()" type="button" value="修改" name="edit" onClick="if (<% = ID %>!=''){Gi_LocOpenSub('info_modi.asp?PageNum=<%=CurrentPage%>','<input type=hidden name=GBAction value=\'EDNContent<% = BGSecSon %>\'><input type=hidden name=ID value=\'<% = ID %>\'>');}" onMouseOver="this.style.backgroundColor='#E8F0FF'" onMouseOut="this.style.backgroundColor=''">			</td>
	</tr>
	</form>
<%
	Rs.MoveNext
	Loop
Rs.Close
Set Rs = Nothing
%>
	</table></td>
  </tr>
<tr>
  	<td>
<form action="info_check.asp" method="POST" name="MulitOpt" id="MulitOpt" style="margin:0">
<input type="hidden" name="GBAction" value="">
<input type="hidden" name="ID" value="<% = ID %>">
<input type="hidden" name="PageNum" value="<% = CurrentPage %>">
<input type="hidden" name="iLanguage" value="<% = iLanguage %>">
<table width="100%"  border="0" cellpadding="2" cellspacing="1"><tr class="Bgtdmain"><td>
<span style="display:none;">
<%
Arr_Del = Split(StrId,"|")
Cot_Del = Ubound(Arr_Del)
For DelID=1 To Cot_Del
%>
<input type="checkbox" name="DelSel" value="<%=Arr_Del(DelID)%>" id="Del<%=DelID%>">
<%Next%>
</span>
<input class="InputBtn" onFocus="blur()" type="button" name="t" value=" 全选 " onClick="document.getElementById('checkall').checked=true;CheckAll();" onMouseOver="this.style.backgroundColor='#E8F0FF'" onMouseOut="this.style.backgroundColor=''">
<input class="InputBtn" onFocus="blur()" type="button" name="f" value=" 全否 " onClick="document.getElementById('checkall').checked=false;CheckAll();" onMouseOver="this.style.backgroundColor='#E8F0FF'" onMouseOut="this.style.backgroundColor=''">
<strong>|</strong>
<!--
<input name="Submit222" type="button" class="InputBtn" onMouseOver="this.style.backgroundColor='#E8F0FF'" onMouseOut="this.style.backgroundColor=''" value=" 修改 ">
<strong>|</strong>
-->
<input class="InputBtn" type="button" value=" 删除 " onClick="GBAction.value='DELContent<% = BGSecSon %>';if(confirm('即将删除所选项目，确认？')){submit(this.form);Gi_disAllButton();}" onMouseOver="this.style.backgroundColor='#E8F0FF'" onMouseOut="this.style.backgroundColor=''">
<strong>|</strong>
<% = Is_Out(OnOff,"list")%>
<input name="button" type="button" class="InputBtn" onClick="GBAction.value='SetContent<% = BGSecSon %>';if(confirm('即将设置所选项目，确认？')){submit(this.form);Gi_disAllButton();}" onMouseOver="this.style.backgroundColor='#E8F0FF'" onMouseOut="this.style.backgroundColor=''" value=" 设置 ">
<strong>|</strong>
<%sb_tpSelect IDTree,iLanguage,isLeaf%>
<input name="button" type="button" class="InputBtn" onClick="GBAction.value='MovContent<% = BGSecSon %>';if(confirm('即将移动所选项目，确认？')){submit(this.form);Gi_disAllButton();}" onMouseOver="this.style.backgroundColor='#E8F0FF'" onMouseOut="this.style.backgroundColor=''" value=" 移动 "></td>
</tr></table>
</form>
	</td>
  </tr>
  <tr>
    <td height="25" align="right" bgcolor="#c7d8fa" class="Inputtxtlogin"><% Call Gi_sGetPNLinks("button") %></td>
  </tr>
</table>
<%End If%>
</body>
</html>