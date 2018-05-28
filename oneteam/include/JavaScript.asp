<SCRIPT LANGUAGE="JavaScript">
<!--
function presskey(eventobject){						//页面上的form元素的位置，第一个form为0，依此类推
if(event.ctrlKey && window.event.keyCode==13){
this.document.forms[eventobject].submit();
}}

function MM_openformWindow(theURL,winName,features) {
for (i=0;i<document.form1.answer.length;i++) {
if (document.form1.answer[i].checked) {
break
}
}
theURL=theURL+"?answer="+document.form1.answer[i].value;
window.open(theURL,winName,features);
}
//-->
</SCRIPT>
