<!-- #include File="../../Include/Security.Asp" -->
<%
if instr(session("flag"),"|2|") < 1 then
	response.write("��û��Ȩ�޲鿴����Ŀ")
	response.End()
end if
mName = Replace(Session("mName"),"����","")
mName = Replace(mName,"{","")
mName = Replace(mName,"}","")
Arr_mName   = Split(mName,"###")
Cot_mName = Ubound(Arr_mName)
%>
<!--#include file="../../include/consts.asp"-->
<!--#include file="../../include/func.asp"-->
<!--#include file="../../include/md5.asp"-->
<%
action = request("action")
rstpswd = replace(request.form("password"),"'","")
rstflag = "|"& replace(request.form("flag"),", ","|") &"|"
select case action
	case "add"
		if request.form("username")="" or request.form("realname") = "" then
			response.write("<script language=javascript>alert('�ʺŻ��û����Ʋ���Ϊ��');location.href='adminlist.asp';</script>")
		else
			sql="select * from hs_manageruser where username='"&replace(request("username"),"'","")&"'"
			Set conn = fGetConn
			set rs=server.CreateObject("adodb.recordset")
			rs.open sql,conn,1,3
			if (rs.bof and rs.eof) then 
				rs.addnew
				rs("username")=replace(request.form("username"),"'","")
					if rstpswd<>"" then rs("password")=md5(rstpswd,16)
				rs("realname")=request.form("realname")
				rs("flag")=rstflag
				rs("LogDate")=Date()
				rs("logcount")=0
				rs.update
				response.write("<script language=javascript>alert('�˺����ӳɹ�');location.href='adminlist.asp';</script>")
			else
				response.write("<script language=javascript>alert('�����ӵ��˺��Ѿ�����');location.href='adminlist.asp';</script>")
				response.End()
			end if
			rs.close
			set rs=nothing
		end if
	case "modify"
		sql="select username,password,realname,flag from hs_manageruser where userid="&request("userid")
		set rs=fGetRsList(sql)
		if not(rs.bof and rs.eof) then 
			usernames=trim(rs("username"))
			passwords=trim(rs("password"))
			realnames=trim(rs("realname"))
			flags=rs("flag")
		else
			response.write("<script language=javascript>alert('��ѡ���޸ĵ��˻�������');location.href='adminlist.asp';</script>")
			response.End()
		end if
		rs.close
		set rs=nothing
	case "del"
		if cint(request("userid"))=1 then
			response.write("<script language=javascript>alert('������ɾ��admin�˻�');location.href='adminlist.asp';</script>")
			response.End()
		else
			sql="delete from hs_manageruser where userid="&cint(request("userid"))
			fInUpData(sql)
			response.write("<script language=javascript>alert('�ɹ�ɾ��');location.href='adminlist.asp';</script>")
			response.End()
		end if
	case "modify_do"
		sql="select * from hs_manageruser where username='"&request("username")&"' and userid<>"&request("userid")
		set rs=fGetRsList(sql)
		flag=rstflag
		if rs.bof and rs.eof then
			if rdpswd<>"" then
				fInUpData("update hs_manageruser set username='"&request("username")&"',realname='"&request("realname")&"',[password]='"&md5(rdpswd,16)&"',[flag]='"&flag&"' where userid="&request("userid")&"")
			else
				fInUpData("update hs_manageruser set username='"&request("username")&"',realname='"&request("realname")&"',[flag]='"&flag&"' where userid="&request("userid")&"")
			end if
			response.write("<script language=javascript>alert('���³ɹ�');location.href='adminlist.asp';</script>")
			response.End()
		else
			response.write("<script language=javascript>alert('�û����Ѿ�����,������û���');history.back();</script>")
			response.End()
		end if
		rs.close
		set rs=nothing
	end select
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�Ϻ����١�������Ӫ��ר��</title>
<link href="../css/css.css" rel="stylesheet" type="text/css">
</head>

<body>
<br />
<table width="98%" align="center" class="tableList">
<tr class="Bgtdtop Font14pxwhitestrong">
    <td width="100" height="25" align="center">�ʺ�</td>
    <td align="center">����ԱȨ��</td>
    <td width="100" align="center"><strong>����</strong></td>
</tr>
<%
sql="select username,userid,lastlogdate,flag from hs_manageruser order by userid asc"
set rs=fGetRsList(sql)
do while not rs.eof
	username=rs("username")
	userid=rs("userid")
	if rs("lastlogdate")<>"" then lastlogdate=formatdatetime(rs("lastlogdate"),2)
	flag=rs("flag")
    response.write "<tr><td align='center' height='24' class='bgTdMain'>" & username & "</td><td align='center' class='bgTdMain'>"
For I = 1 To Cot_mName
	if instr(flag,"|"& I &"|") then response.Write("<span style=""width:100px;float:left""><font color=red>"& Arr_mName(I) &"</font></span>")
Next	
	response.Write "</td><td align='center' class='bgTdMain'><a href=adminlist.asp?userid="&userid&"&action=modify>�޸�</a>&nbsp;&nbsp;<a href=adminlist.asp?userid="&userid&"&action=del> ɾ��</a></td></tr>"
rs.movenext
loop
rs.close
set rs=nothing
%>
</table>
<br><br><br>
<form name="form1" method="post" action="adminlist.asp">
<table width="98%" align="center" class="bgTbTop">
  <tr> 
    <td width="100" height="25" align="center" class="Inputbtn">�ʺţ�</td>
    <td width="175" class="bgTdMain"><strong> 
      <input name="username" type="text" class="Inputtxt" id="username" value="<%=usernames%>" maxlength="20">
      </strong></td>
    <td width="100" align="center" class="Inputbtn">���룺</td>
    <td width="175" class="bgTdMain"><input title="���޸����ÿ�" name="password" type="text" class="Inputtxt" id="password" maxlength="20"></td>
    <td width="100" align="center" class="Inputbtn">�û�������</td>
    <td class="bgTdMain"><strong>
      <input type="text" class="Inputtxt" name="realname" id="realname" maxlength="20" value="<%=realnames%>">
    </strong></td>
  </tr>
  <tr> 
    <td height="25" align="center" class="Inputbtn">Ȩ�ޣ�</td>
    <td colspan="5" class="bgTdMain"><%For I = 1 To Cot_mName%><span style="width:100px;float:left"><input type="checkbox" name="flag" value="<% = I%>" <%If InStr(flags,"|"& I &"|") > 0 then Response.Write "checked"%>><%=Arr_mName(I)%></span><%Next%></td>
    </tr>
  <tr> 
      <td height="30" colspan="6" align="center" class="Inputbtn"> 
	  <input type=hidden name='userid' value=<%=request("userid")%>>
        <input type="hidden" name="action" value="<%if action="modify" then
			response.Write("modify_do")
			elseif action="" then
				response.Write("add")
			end if%>">
      <input name="Submit2" type="submit" class="Inputtxt" value="<%if action="modify" then
		response.Write("�޸��˺�")
		else
			response.Write("�����˺�")
		end if%>"></td>
  </tr>
</table>
</form>
</body>
</html>
