<!-- #include File="../Include/Security.Asp" -->
<Html>
<Head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>上海火速——网络营销专家</title>
<Link Href="Css/Css.Css" Rel="Stylesheet" Type="Text/Css">
<Style Type="Text/Css">
<!--
Body {
	Background-color: #e1e1e1;
}
-->
</Style>
<script>
var displayBar=true;
function switchBar(obj)
{
	if (displayBar)
	{
		parent.Frame.cols="0,*";
		displayBar=false;
		obj.src="Images/txt_Open.gif";
		obj.title="打开左边管理导航菜单";
	}
	else{
		parent.Frame.cols="180,*";
		displayBar=true;
		obj.src="Images/txt_Close.gif";
		obj.title="关闭左边管理导航菜单";
	}
}
</Script>
</Head>

<Body>

<Table Width="100%" height="24"  Border="0" Cellpadding="0" Cellspacing="0">
  <Tr valign="middle">
    <Td width="100" style="padding-left:20px;"><Img Onclick="switchBar(this)" title="关闭左边管理导航菜单" Style="Cursor:hand" src="Images/Txt_close.Gif" Width="52" Height="15"></Td>
    <Td></Td>
    <Td style="padding-right:20px; text-align:right;">网站管理系统</Td>
  </Tr>
</Table>
</Body>
</Html>
