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
	<TR><TD ALIGN=center HEIGHT=100><span class=highlight1><b><%=outHTML(Session("eWebEditor_User"))%>：欢迎您使用本系统</b></span><br><br><br><b><span class=highlight2>为保证系统数据安全，使用完后请点击退出！</span></b></TD></TR>
	<TR>
	  <TD>&nbsp;</TD>
	</TR>
	<TR><TD HEIGHT=30></TD></TR>
	</TABLE>
<%
End Sub
%>