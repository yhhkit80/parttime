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
'TotalPage	:	页总数
'TotalRecord:	记录总数
'CurPage:		:当前页


function changePage2(TotalPage,TotalRecord,Curpage,HrefLink)
%>
	<table border=0 width="100%">
		<tr height=23 align="right">
			<td>
			当前页:<font class="tip"><%=Curpage%></font>/<font class="tip"><%=TotalPage%></font>&nbsp; &nbsp;
			记录总数:<font class="tip"><%=TotalRecord%></font>条&nbsp; 
<%
'//控制链接的状态
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
	<a <%=firstpage%>>首页</a>
	<a <%=Prevpage%>>上页</a>
	<a <%=nextpage%>>下页</a>
	<a <%=lastpage%>>末页</a>
</b>&nbsp; 跳转到:

<select name="truepage" onchange="setPage(document.frm01,this.value);" style="font-size:9pt;color:gray">
<%
for i=1 to TotalPage
	if i	=	CurPage then
		sel	=	"selected"
	else
		sel	=	""
	end if
	response.write "<option " & sel & " value='" &i & "'>第" & i & "页</option>"
next
%>
</select>页
		</td>
	</tr>
</table>
<%end function%>

