<!--#include file = "Include/Startup.asp"-->
<!--#include file = "admin_private.asp"-->
<%

sPosition = ""

Call Header()
Call Content()
Call Footer()


Sub Content()
%>
	<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 WIDTH="100%">
	<TR><TD ALIGN=right>&nbsp;</TD>
	</TR>
	<TR><TD ALIGN=center HEIGHT=100><span class=highlight1><b><%=outHTML(Session("eWebEditor_User"))%>����ӭ��ʹ�ñ�ϵͳ</b></span><br><br><br><b><span class=highlight2>Ϊ��֤ϵͳ���ݰ�ȫ��ʹ����������˳���</span></b></TD></TR>
	<TR>
	  <TD>&nbsp;</TD>
	</TR>
	<TR><TD HEIGHT=30></TD></TR>
	</TABLE>
<%
End Sub
%>