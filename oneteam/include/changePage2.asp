<script language="javascript">
<!--
function setPage(thisform,value1){
	thisform.page.value=value1
	thisform.submit();
}
//-->
</script>
<style type="text/css">
<!--
.tip{color:orange;font-weight:bold}
-->
</style>
<%
'TotalPage	:	ҳ����
'TotalRecord:	��¼����
'CurPage:		:��ǰҳ


function changePage2(TotalPage,TotalRecord,Curpage,HrefLink)
%>
	<table border=0 width="100%">
		<tr height=23 align="right">
			<td>
			��ǰҳ:<font class="tip"><%=Curpage%></font>/<font class="tip"><%=TotalPage%></font>&nbsp; &nbsp;
			��¼����:<font class="tip"><%=TotalRecord%></font>��&nbsp; 
<%
'//�������ӵ�״̬
HrefLink	=	"Href=" & HrefLink
if instr(HrefLink,"?")>0 then
	flag	=	"&"
else
	flag	=	"?"
end if
HrefLink	=	HrefLink & flag
if Curpage<>1 then
	PrevPage	=	HrefLink & "page=" & (Curpage-1)
	firstpage	=	HrefLink & "page=1"
end if

if Curpage<>TotalPage then
	nextpage	=	HrefLink & "page=" & (Curpage+1)
	lastpage	=	HrefLink & "page=" & TotalPage
end if
%>

<b>
	<a <%=firstpage%>>��ҳ</a>
	<a <%=Prevpage%>>��ҳ</a>
	<a <%=nextpage%>>��ҳ</a>
	<a <%=lastpage%>>ĩҳ</a>
</b>&nbsp; ��ת��:

<select name="truepage" onchange="setPage(document.frm01,this.value);" style="font-size:9pt;color:gray">
<%
for i=1 to TotalPage
	if i	=	CurPage then
		sel	=	"selected"
	else
		sel	=	""
	end if
	response.write "<option " & sel & " value='" &i & "'>��" & i & "ҳ</option>"
next
%>
</select>ҳ
		</td>
	</tr>
</table>
<%end function%>

