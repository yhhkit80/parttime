<br />
<table width="98%" align="Center" class="Bgtbtop">
	<tr>
   		 <td height="25" align="Center" class="Bgtdtop">
<span class="Font14pxwhitestrong">「<%=Menu%>」信 息 管 理 （<%call Gi_sGetLangShow(iLanguage) %>）</span>
		</td>
	</tr>
  <tr>
    <td class="Bgtdmain">
      <table width="100%"  border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td width="10">
		  </td>
          <td><% Call Gi_sGetLangButton ("info_list.asp","") %></td>
          <td align="right">
<form name="SNContent" action="info_list.asp" method="post">
	<input type="hidden" name="iLanguage" id="iLanguage" value="<% = iLanguage %>">
	<%sb_tpSelect IDTree,iLanguage,isLeaf%>
	<input name="KeyWords" type="text" class="InputTxt" value="<%=KeyWords%>" onclick="this.value='';">
	<input type="submit" name="Submit" class="InputBtn" value="搜  索" onmouseover="this.style.backgroundColor='#E8F0FF'" onmouseout="this.style.backgroundColor=''">
</form>
		  </td>
        </tr>
    </table></td>
  </tr>
</table>

