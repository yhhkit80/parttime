<BR />
<table width="98%" align="Center" class="Bgtbtop">
  <tr>
    <td height="25" align="Center" class="Bgtdtop">
		<span class="Font14pxwhitestrong"> 类 别 管 理 （<%call Gi_sGetLangShow(iLanguage) %>）</span></td>
  </tr>
  <tr>
    <td class="Bgtdmain">
      <table width="100%"  border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td><%Call Gi_sGetLangButton ("TypeList.asp","综合类别") %></td>
          <td align="right">
<form action="CheckType.asp" method="post" onSubmit="if(GBAction.value==''||GBAction.value=='ADPType<% = BGSecSon %>'){GBAction.value='ADPType<% = BGSecSon %>'} if (tpName.value==''){return false;}else{Gi_disAllButton();}" name="ADFPType">
		<input type="hidden" name="GBAction" value="">
		<input type="hidden" name="iLanguage" value="<% = iLanguage %>">
		<input type="hidden" name="tpImage" value="">
		<input type="hidden" name="tpParent" value="0">		
		<input type="hidden" name="tpTree" value=".0.">
		<input type="hidden" name="tpLevel" value="1">
		<input type="hidden" name="ReleaseDate" value="<% = Date() %>">
        <input class="InputTxt" type="text" name="tpName" />&nbsp;&nbsp;&nbsp;<input class="InputBtn" onFocus="blur()" type="button" onClick="GBAction.value='ADPType<% = BGSecSon %>';if(GBAction.value!=''&&tpName.value!=''){submit(this.form);Gi_disAllButton();}" name="add" value="添加 (1) 级类别" onMouseOver="this.style.backgroundColor='#E8F0FF'" onMouseOut="this.style.backgroundColor=''" style="color:#900;">
</form>		  </td>
        </tr>
    </table></td>
  </tr>
</table>

