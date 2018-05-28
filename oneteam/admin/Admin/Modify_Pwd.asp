<!-- #include File="../../Include/Security.Asp" -->
<!--#include file="../../Include/consts.asp"-->
<!-- #include File="../../Include/Func.Asp" -->
<!-- #include File="../../Include/md5.Asp" -->
<%
if trim(session("AdminName")) = "" then
    response.Redirect "../Login.asp"
end if
%>
<%
Action =request("Action")

password=md5(trim(Request("Password")),16)

if Action = "Modify" then
 '修改管理员密码
sql="update "& StrDBPrefix &"ManagerUser set [PassWord] = '"& password &"' where username='"&session("Adminname")&"'"
fInUpData(sql)

	response.Write("<script>alert('修改密码成功！下次登录时记得换用新密码哦！');location.href='../index.asp'</script>")
	
	response.End()
end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="../css/css.css" rel="stylesheet" type="text/css">
<script language=javascript>
function check()
{
  if(document.form1.Password.value=="")
    {
      alert("密码不能为空！");
	  document.form1.Password.focus();
      return false;
    }
    
  if((document.form1.Password.value)!=(document.form1.PwdConfirm.value))
    {
      alert("初始密码与确认密码不同！");
	  document.form1.PwdConfirm.select();
	  document.form1.PwdConfirm.focus();	  
      return false;
    }
}
</script>
</head>

<body>
<br>
<form action="Modify_Pwd.asp" method="post" name="form1" target="_parent"  onsubmit="javascript:return check();">

<table width="400"   align="center"  class="bgTbTop">
  <tr>
    <td height="25" colspan="2" align="center" class="bgTdTopGray"><span class="Font14PXWhiteStrong"> 管理员修改密码</span></td>
  </tr>
  <tr>
    <td width="39%" class="bgTdMain"><strong> 用 户 名</strong></td>
    <td width="61%" class="bgTdMain"><%= Session("Adminname") %></td>
  </tr>
  <tr>
    <td class="bgTdMain"><strong> 新 密 码：</strong></td>
    <td  class="bgTdMain"><input name="Password" type="password" class="InputTxt">
    </td>
  </tr>
  <tr>
    <td class="bgTdMain"><strong> 确认密码：</strong></td>
    <td  class="bgTdMain"><input name="PwdConfirm" type="password" class="InputTxt">
    </td>
  </tr>
  <tr>
    <td class="bgTdMain"><span class="tdbg">
      <input name="Action" type="hidden" id="Action" value="Modify">
    </span></td>
    <td class="bgTdMain"><input name="Submit" type="submit" class="InputBtn" value="提交">
        <input name="Submit2" type="button" class="InputBtn" value="返回"  onClick="history.back()" ></td>
  </tr>
</table>
</form>
</body>
</html>
