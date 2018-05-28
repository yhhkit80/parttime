<!--#include file="functionsetting.asp"-->
<!--#include file="security.asp"-->
<%
UpLoadPath = Request.QueryString("UpLoadPath")
UPType = Request.QueryString("UPType")
%>
<html>
<head>
<LINK href="sn.css" type=text/css rel=stylesheet>
</head>
<body style="background:#ffffff;margin:5px">
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0" >
		<tr>
			<td align="center">
				<%If UPType = "图片" Then%>
					<table cellpadding="0" cellspacing="0" border="3" bordercolor="#626262" align="center">
						<tr>
							<td align="center">
								<img id="showImg" src="<% = UpLoadPath %>" vspace="0" hspace="0" border="0" align="absmiddle" onClick="window.close();" alt="单击关闭" onLoad="if (this.width>screen.availWidth||this.height>screen.availHeight){window.resizeTo(screen.availWidth,screen.availHeight);}else{window.resizeTo(this.width+40,this.height+105);document.body.scroll='no';}" class="hand">
							</td>
						</tr>
					</table>
				<%Elseif UPType = "文件" Then%>
					<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="3" bordercolor="#626262">
						<tr>
							<td height="100%" align="center">												
								<br>
								<img align="absmiddle" border="0" src="images/FileType_<% = LCase(Right(UpLoadPath,3)) %>.jpg" hspace="2" vspace="2">
								<br>
								<br>
								<span>【<% = Gi_GetFileType(LCase(Right(UpLoadPath,4))) %> 】</span>
								<br>
								<br>
								<br>
								<span><a href="<% = UpLoadPath %>">请使用鼠标右键目标另存为下载>></a></span>
								<br>
								<br>
								<br>
								<br>
								<span style="width:100%;height:30;text-valign:middle" class="hand" onClick="window.close();" onMouseOver="this.style.color='#FF6600'" onMouseOut="this.style.color=''"><br><br>关闭窗口<br><br></span>
								<script>window.resizeTo(300,400);</script>
							</td>
						</tr>
					</table>
				<%End If%>
			</td>
		</tr>
	</table>
</body>
</html>