<%

'ǿ����������·��ʷ���������ҳ�棬�����Ǵӻ����ȡҳ��
Response.Buffer = True 
Response.Expires = -1
Response.Expiresabsolute = Now() - 1 
Response.Expires = 0 
Response.Cachecontrol = "No-cache" 
'��Ҫ��ʹ������ֵ�ͼƬ�������
%>

<!--#include file="../../Include/Consts.Asp" -->
<!--#include file="../../Include/Func.Asp" -->
<!--#include file="../../Include/md5.Asp" -->

<%
Dim Action,Founderr,Errmsg
Action=Trim(Request("Action"))
If Action="Login" Then
	Call Chklogin()
Else
	Call Main()
End If
If Founderr=True Then
	Response.Redirect("../Error.Asp?msg="&Errmsg&"")
End If
%>


<%
Sub Chklogin()
	Dim Sql,Rs
	Dim Username,Password,Checkcode,Rndpassword
	Username=Replace(Trim(request.form("Username")),"'","")
	Password=md5(Replace(Trim(request.form("Password")),"'",""),16)
	Checkcode=Replace(Trim(request.form("Checkcode")),"'","")
	If Username="" Then
		Founderr=True
		Errmsg=Errmsg & "<Br><Li>�û�������Ϊ�գ�</Li>"
	End If
	If Password="" Then
		Founderr=True
		Errmsg=Errmsg & "<Br><Li>���벻��Ϊ�գ�</Li>"
	End If
	If Checkcode="" Then
		Founderr=True
		Errmsg=Errmsg & "<Br><Li>��֤�벻��Ϊ�գ�</Li>"
	End If
	If Trim(Session("Checkcode"))="" Then
		Founderr=True
		Errmsg=Errmsg & "<Br><Li>���¼ʱ������������·��ص�¼ҳ����е�¼��</Li>"
	End If
	If Checkcode<>Cstr(Session("Checkcode")) Then
		Founderr=True
		Errmsg=Errmsg & "<Br><Li>�������ȷ�����ϵͳ�����Ĳ�һ�£����������롣</Li>"
	End If
	If Founderr=True Then
		Exit Sub
	End If
	
	StrSQL="Select * From "&StrDBPrefix&"ManagerUser Where UserName='"&UserName&"' And Password='"&Password&"'"
	Set Rs=fGetRsList(StrSQL)
	If Rs.Bof And Rs.Eof Then
		Founderr=True
		Errmsg=Errmsg & "<Br><Li>�û�����������󣡣���</Li>"
	Else
		If Password<>Rs("Password") Then
			Founderr=True
			Errmsg=Errmsg & "<Br><Li>�û�����������󣡣���</Li>"
		End If
	End If
	
	If Founderr=True Then
		Session("Adminname")=""
		Session("Adminpassword")=""
		Session("Rndpassword")=""
		Rs.Close
		Set Rs=Nothing
		Exit Sub
	End If
	
	'StrSQL = "update  "& StrDBPrefix &"ManagerUser Set LastLogDate='"& Now() &"', LogCount = "& Rs("LogCount")+1 &" Where UserName='"&UserName&"' And Password='"&Password&"'"
	'fInUpData (StrSQL)

	Session("Adminname")=Rs("Username")
	Session("Adminpassword")=Rs("Password")
	Session("flag")=Rs("flag")
	Rs.Close
	Set Rs=Nothing
	Response.Redirect "../Index.Asp"
	
End Sub
%>

<%
Sub Main()
%>
<html>
<head>
<meta http-equiv="Content-type" content="Text/Html; Charset=Gb2312">
<title>��̨����Ա��¼</title>
<link href="../Css/Css.Css" rel="Stylesheet" type="Text/Css">
<script language=Javascript>
<!--
function Setfocus()
{
if (document.Login.Username.Value=="")
	document.Login.Username.Focus();
else
	document.Login.Username.Select();
}
function Checkform()
{
	if(document.Login.Username.Value=="")
	{
		alert("�������û�����");
		document.Login.Username.Focus();
		return false;
	}
	if(document.Login.Password.Value == "")
	{
		alert("���������룡");
		document.Login.Password.Focus();
		return false;
	}
	if (document.Login.Checkcode.Value==""){
       alert ("������������֤�룡");
       document.Login.Checkcode.Focus();
       return false;
    }
}

function CheckBrowser() 
{
  var app=navigator.appName;
  var verStr=navigator.appVersion;
  if (app.indexOf('Netscape') != -1) {
    alert("Hotslaes��ʾ��\n    ��ʹ�õ���Netscape����������ܻᵼ���޷�ʹ�ú�̨�Ĳ��ֹ��ܡ�������ʹ�� IE6.0 �����ϰ汾��");
  } 
  else if (app.indexOf('Microsoft') != -1) {
    if (verStr.indexOf("MSIE 3.0")!=-1 || verStr.indexOf("MSIE 4.0") != -1 || verStr.indexOf("MSIE 5.0") != -1 || verStr.indexOf("MSIE 5.1") != -1)
      alert("Hotslaes��ʾ��\n    ����������汾̫�ͣ����ܻᵼ���޷�ʹ�ú�̨�Ĳ��ֹ��ܡ�������ʹ�� IE6.0 �����ϰ汾��");
  }
}
//-->
</script>
</head>

<body onLoad="document.Login.Username.focus()" oncontextmenu="return false" onselectstart="return false">
<table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="450" valign="Top"><table width="317" border="0" align="Center" cellpadding="0" cellspacing="0">
      <tr>
        <td><img src="../Images/Top_login.Jpg" width="317" height="147"></td>
      </tr>
      <tr>
        <td height="150" align="Center" valign="Bottom" background="../Images/Bg_login.Jpg">
		<form action="login.asp" method="Post" name="Login" target="_parent" id="Login" onSubmit="return Checkform();">
            <table width="80%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td width="60" align="Left" ><img src="../Images/Txt_username.Gif" width="52" height="7"></td>
                <td align="Left" ><input name="Username" type="Text" class="Inputtxtlogin" id="Username"  onMouseOver="this.style.background='#ffffff';" onMouseOut="this.style.background='#f3f3f3'" size="15" >                  </td>
              </tr>
              <tr>
                <td align="Left"><img src="../Images/Txt_password.Gif" width="52" height="7"></td>
                <td align="Left"><input name="Password" type="Password" class="Inputtxtlogin" id="Password" onMouseOver="this.style.background='#ffffff';" onMouseOut="this.style.background='#f3f3f3'" size="15"></td>
              </tr>
              <tr>
                <td align="Left"><img src="../Images/Txt_verify.Gif" width="41" height="7"></td>
                <td align="Left"><input name="Checkcode" type="Text" class="Inputtxtlogin" id="Checkcode" onMouseOver="this.style.background='#ffffff';" onMouseOut="this.style.background='#f3f3f3'" size="4" maxlength="4">
				<%
				randomize
				num = Round(8999*rnd+1000) '��������ֵ
				num2 = num
				session("CheckCode")=num
				response.write "<B><font size=2 style='background-color:#FFE96E'>"&num&"</font></B>"
				%></td>
              </tr>
              <tr>
                <td><input name="Action" type="Hidden" id="Action" value="Login"></td>
                <td align="Left"><input name="Imagefield" type="Image" src="../Images/Btn_login.Jpg" width="45" height="14" border="0"></td>
              </tr>
            </table>
        </form></td>
      </tr>
      <tr>
        <td><img src="../Images/Down_login.Jpg" width="317" height="166"></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
<% End Sub%>
