<!-- #include File="../Include/Security.Asp" -->
<%

Dim Theinstalledobjects(17)
Theinstalledobjects(0) = "Mswc.Adrotator"
Theinstalledobjects(1) = "Mswc.Browsertype"
Theinstalledobjects(2) = "Mswc.Nextlink"
Theinstalledobjects(3) = "Mswc.Tools"
Theinstalledobjects(4) = "Mswc.Status"
Theinstalledobjects(5) = "Mswc.Counters"
Theinstalledobjects(6) = "Iissample.Contentrotator"
Theinstalledobjects(7) = "Iissample.Pagecounter"
Theinstalledobjects(8) = "Mswc.Permissionchecker"
Theinstalledobjects(9) = "Scripting.Filesystemobject"
Theinstalledobjects(10) = "Adodb.Connection"
    
Theinstalledobjects(11) = "Softartisans.Fileup"
Theinstalledobjects(12) = "Softartisans.Filemanager"
Theinstalledobjects(13) = "Jmail.Smtpmail"
Theinstalledobjects(14) = "Cdonts.Newmail"
Theinstalledobjects(15) = "Persits.Mailsender"
Theinstalledobjects(16) = "Lyfupload.Uploadfile"
Theinstalledobjects(17) = "Persits.Upload.1"
%>

<%
Function Isobjinstalled(Strclassstring)
	On Error Resume Next
	Isobjinstalled = False
	Err = 0
	Dim Xtestobj
	Set Xtestobj = Server.Createobject(Strclassstring)
	If 0 = Err Then Isobjinstalled = True
	Set Xtestobj = Nothing
	Err = 0
End Function
%>


<Html>
<Head>
<Meta Http-equiv="Content-type" Content="Text/Html; Charset=Gb2312">
<title></title>
<Link Href="Css/Css.Css" Rel="Stylesheet" Type="Text/Css">
<Style Type="Text/Css">
<!--
.Style1 {
	Color: #ffffff;
	Font-weight: Bold;
}
-->
</Style>
</Head>

<Body >
<br />
<Table Width="98%" Align="Center" Class="Bgtbtop">
  <Tr>
    <Td Height="25" Align="Center" Class="Bgtdtop"><Span Class="Font14pxwhitestrong">服 务 器 信 息</Span></Td>
  </Tr>
  <Tr>
    <Td Class="Bgtdmain">
      <Table Width="100%"  Border="0" Cellspacing="0" Cellpadding="3">
        <Tr>
          <Td><Table Cellpadding="2" Cellspacing="1" Border="0" Width="100%" Class="Border" Align=Center>

            <Tr>
              <Td Width="50%"  Class="Tdbg" Height=23>服务器类型：<%=Request.Servervariables("Os")%>(Ip:<%=Request.Servervariables("Local_addr")%>)</Td>
              <Td Width="50%" Class="Tdbg">脚本解释引擎：<%=Scriptengine & "/"& Scriptenginemajorversion &"."&Scriptengineminorversion&"."& Scriptenginebuildversion %></Td>
            </Tr>
            <Tr>
              <Td Width="50%" Class="Tdbg" Height=23>站点物理路径：<%=Request.Servervariables("Appl_physical_path")%></Td>
              <Td Width="50%" Class="Tdbg">数据库地址：</Td>
            </Tr>
            <Tr>
              <Td Width="50%" Class="Tdbg" Height=23>Fso文本读写：
                  <%If Not Isobjinstalled(Theinstalledobjects(9)) Then%>
                  <Font Color="Red"><B>×</B></Font>
                  <%Else%>
                  <B>√</B>
                  <%End If%></Td>
              <Td Width="50%" Class="Tdbg">数据库使用：
                  <%If Not Isobjinstalled(Theinstalledobjects(10)) Then%>
                  <Font Color="Red"><B>×</B></Font>
                  <%Else%>
                  <B>√</B>
                  <%End If%></Td>
            </Tr>
            <Tr>
              <Td Width="50%" Class="Tdbg" Height=23>Jmail组件支持：
                  <%If Not Isobjinstalled(Theinstalledobjects(13)) Then%>
                  <Font Color="Red"><B>×</B></Font>
                  <%Else%>
                  <B>√</B>
                  <%End If%></Td>
              <Td Width="50%" Class="Tdbg">Cdonts组件支持：
                  <%If Not Isobjinstalled(Theinstalledobjects(14)) Then%>
                  <Font Color="Red"><B>×</B></Font>
                  <%Else%>
                  <B>√</B>
                  <%End If%></Td>
            </Tr>
            <Tr>
              <Td Class="Tdbg" Height=23>　</Td>
              <Td Align="Right" Class="Tdbg"><A Href="System/Serverinfo.Asp">点此查看更详细的服务器信息>>></A></Td>
            </Tr>
          </Table></Td>
        </Tr>
    </Table></Td>
  </Tr>
</Table>
</Body>
</Html>
