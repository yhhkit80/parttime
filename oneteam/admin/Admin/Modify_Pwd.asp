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
 '�޸Ĺ���Ա����
sql="update "& StrDBPrefix &"ManagerUser set [PassWord] = '"& password &"' where username='"&session("Adminname")&"'"
fInUpData(sql)

	response.Write("<script>alert('�޸�����ɹ����´ε�¼ʱ�ǵû���������Ŷ��');location.href='../index.asp'</script>")
	
	response.End()
end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
<link href="../css/css.css" rel="stylesheet" type="text/css">
<script language=javascript>
function check()
{
  if(document.form1.Password.value=="")
    {
      alert("���벻��Ϊ�գ�");
	  document.form1.Password.focus();
      return false;
    }
    
  if((document.form1.Password.value)!=(document.form1.PwdConfirm.value))
    {
      alert("��ʼ������ȷ�����벻ͬ��");
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
    <td height="25" colspan="2" align="center" class="bgTdTopGray"><span class="Font14PXWhiteStrong"> ����Ա�޸�����</span></td>
  </tr>
  <tr>
    <td width="39%" class="bgTdMain"><strong> �� �� ��</strong></td>
    <td width="61%" class="bgTdMain"><%= Session("Adminname") %></td>
  </tr>
  <tr>
    <td class="bgTdMain"><strong> �� �� �룺</strong></td>
    <td  class="bgTdMain"><input name="Password" type="password" class="InputTxt">
    </td>
  </tr>
  <tr>
    <td class="bgTdMain"><strong> ȷ�����룺</strong></td>
    <td  class="bgTdMain"><input name="PwdConfirm" type="password" class="InputTxt">
    </td>
  </tr>
  <tr>
    <td class="bgTdMain"><span class="tdbg">
      <input name="Action" type="hidden" id="Action" value="Modify">
    </span></td>
    <td class="bgTdMain"><input name="Submit" type="submit" class="InputBtn" value="�ύ">
        <input name="Submit2" type="button" class="InputBtn" value="����"  onClick="history.back()" ></td>
  </tr>
</table>
</form>
</body>
</html>
