<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>后台管理员登录</title>
<link href="css/css.css" rel="stylesheet" type="text/css">
</head>

<body>
<br>
<table width="80%"   align="center"  class="bgTbTop">
  <tr>
    <td height="25" align="center" class="bgTdTop"><span class="Font14PXWhiteStrong"> 系 统 错 误</span></td>
  </tr>
  <tr>
    <td bgcolor="#E8E8E8" class="bgTdMain">
      <table width="100%"  border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td> <strong>产生错误的可能原因： </strong> </td>
        </tr>
        <tr>
          <td><%= Request.QueryString("Msg") %></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td align="right"> <a href="javascript:history.go(-1)">&lt;&lt; 返回上一页 </a> </td>
        </tr>
    </table></td>
  </tr>
</table>
</body>
</html>

