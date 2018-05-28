<!-- #include File="../Include/Security.Asp" -->
<html>
<head>
<meta http-equiv="Content-type" content="Text/Html; Charset=gb2312">
<title>上海火速——网络营销专家</title>
<link href="Css/Css.Css" rel="Stylesheet" type="Text/Css">
<style type="Text/Css">
<!--
Body {
	Background-color: #afafaf;
}
-->
</style>
<script language=Javascript>
function Showsubmenu(Sid)
{
Whichel = eval("Submenu" + Sid);
if (Whichel.style.display == "none")
{
eval("Submenu" + Sid + ".style.display='';");
}
else
{
eval("Submenu" + Sid + ".style.display='none';");
}
}
</script>
</head>

<body>
<table width="165"  border="0" align="Center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="10" align="Center"><img src="Images/Space.Gif" width="1" height="1"></td>
  </tr>
  <tr>
    <td align="Center"><img src="Images/Title_nav.Gif" width="165" height="42"></td>
  </tr>
</table>
<table width="165"  border="0" align="Center" cellpadding="0" cellspacing="0" class="Tbmenuborder">
  <tr>
    <td height="25" background="Images/Title_bg_quit.Jpg" class="Menutitle"><span><a href="Admin_main.Asp" target="Main">管理首页</a> | <a href="Loginout.Asp" target="_parent">退出</a></span></td>
  </tr>
  <tr>
    <td align="Center" class="Bgleftmenu"><table width="140"  border="0" cellspacing="1" cellpadding="1">
      <tr>
        <td align="Left">用户名：<%=Session("Adminname")%><%'= Session("Admin_power") %></td>
      </tr>

    </table></td>
  </tr>
</table>
<!-- #include file="../include/BGMenu.asp" -->
<script language="javascript">
for (var i=0;i<mName.length;i++){
var wHead
wHead='<Table Width="100%"  Border="0" Cellspacing="0" Cellpadding="0"><Tr><Td Height="10" Align="Center"><Img Src="Images/Space.Gif" Width="1" Height="1"></Td></Tr></Table>';
wHead=wHead+'<Table Width="165"  Border="0" Align="Center" Cellpadding="0" Cellspacing="0" Class="Tbmenuborder">';
wHead=wHead+'<Tr><Td Height="25" Background="Images/Title_bg_menu'+(i+1)+'.Jpg" Class="Menutitle"  Id="Menutitle'+i+'" Onclick="Showsubmenu('+i+')" Style="Cursor:hand;"><Span>';
wHead=wHead+mName[i];
wHead=wHead+'</Span></Td></Tr><Tr>';
wHead=wHead+'<Td Align="Center" Class="Bgleftmenu" Style="Display:none" Id="Submenu'+i+'"><Table Width="140"  Border="0" Cellspacing="1" Cellpadding="1">';
wHead=wHead+'<Tr><Td Align="Left">';
document.write(wHead);

for (var x=0;x<smName[i].length;x++){
var sclassName = "s"+i+"s"+x
var sHead
sHead='<A hidefocus="true" id="'+sclassName+'" href="'+smLinks[i][x]+'" target="Main" onClick="Gi_getSMClassName('+sclassName+');">'
+smName[i][x]+'</A><BR>';
document.write(sHead);
}
document.write(' </Td></Tr></Table></Td></Tr></Table>');
}

</script>

<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="10" align="Center"><img src="Images/Space.Gif" width="1" height="1"></td>
  </tr>
</table>
</body>
</html>
