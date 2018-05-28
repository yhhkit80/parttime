<!-- #include File="../../Include/Security.Asp" -->
<!-- #include File="../../Include/Consts.Asp" -->
<!-- #include File="../../Include/Func.Asp" -->
<!-- #include file="info_cfg.asp" -->
<%
iLanguage = Request.Form("iLanguage")
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
	If PrevCurrentPage > 0 Then MySQL = MySQL & " and ID not in (select top "& PrevCurrentPage*PageSize &" ID From "& StrDBPrefix &"Info where 0=0 "& StrSQL &" Order By ReleaseDate DESC ,ID DESC)"
MySQL = MySQL & " Order By ReleaseDate DESC,ID DESC"

Set Rs = fGetRsList(MySQL)
If Rs.Eof Then
%>
<table width="98%" border="0" cellspacing="0" cellpadding="3" align="center" class="Bgtbtop">
  <tr> 
    <td height="63" colspan="2" class="Font14pxwhitestrong"> <table width="100%"  border="0" cellspacing="0" cellpadding="5" >
        <tr> 
          <td colspan="6"> <table width="100%"  border="0" cellpadding="2" cellspacing="1">
                <tr> 
                  <td height="25" align="Center">对不起，没有可以还原的数据。</td>
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
    <td >标题<strong>(还原后的信息类别将被重置，请重新设置)</strong></td>
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
OnOff = Rs("State_OnOff")
ReleaseDate = Rs("ReleaseDate")
iLanguage = Rs("iLanguage")

RowCount = RowCount+1
%>  
<form action="info_check.asp" method="post" onSubmit="if(GBAction.value=='DLNContent<% = BGSecSon %>'){if(delCheck==false||ID.value==''){return false;}} Gi_disAllButton();" name="EDDFPInfo">
<input type="hidden" name="GBAction" value="">
<input type="hidden" name="ID" value="<% = ID %>">
<input type="hidden" name="PageNum" value="<% = CurrentPage %>">
<input type="hidden" name="iLanguage" value="<% = iLanguage %>">
	<tr id="Tr<%=RowCount-1%>" class="Bgtdmain" onMouseOver="this.style.backgroundColor='<% = select_bg %>';if(mouseState == 1){document.getElementById('Del<%=RowCount-1%>').checked = !document.getElementById('Del<%=RowCount-1%>').checked;document.getElementById('Del<%=RowCount-1%>').checked = document.getElementById('Del<%=RowCount-1%>').checked;document.getElementById('Td<%=RowCount-1%>').src=(document.getElementById('Del<%=RowCount-1%>').checked)?'<% = select_1 %>':'<% = select_0 %>';}" onMouseOut="if(document.getElementById('Del<%=RowCount-1%>').checked==false){this.style.backgroundColor='';}" onClick="document.getElementById('Td<%=RowCount-1%>').src=(document.getElementById('Del<%=RowCount-1%>').checked)?'<% = select_0 %>':'<% = select_1 %>';document.getElementById('Del<%=RowCount-1%>').checked = !document.getElementById('Del<%=RowCount-1%>').checked;document.getElementById('Del<%=RowCount-1%>').checked = document.getElementById('Del<%=RowCount-1%>').checked;" onMouseDown="mouseState = 1;" onMouseUp="mouseState=0;" style="cursor:pointer;">
		<td height="30" align="center"><img src="<% = select_0 %>" id="Td<%=RowCount-1%>"></td>
		<td title="标题全部【 <% = Title %> 】"><% = Gi_GetHighLight(Left(Title,70),KeyWords) %></td>
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
<input class="InputBtn" type="button" value=" 还原 " onClick="GBAction.value='reDELContent<% = BGSecSon %>';if(confirm('即将还原所选项目，确认？')){submit(this.form);Gi_disAllButton();}" onMouseOver="this.style.backgroundColor='#E8F0FF'" onMouseOut="this.style.backgroundColor=''">
<strong>|</strong>
<input class="InputBtn" type="button" value=" 彻底删除 " onClick="GBAction.value='realDELContent<% = BGSecSon %>';if(confirm('即将彻底删除所选项目，确认？')){submit(this.form);Gi_disAllButton();}" onMouseOver="this.style.backgroundColor='#E8F0FF'" onMouseOut="this.style.backgroundColor=''">
</td>
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