// JavaScript Document 导航条，鼠标滑过左边出现右边二级导航
function menuFix() {
var sfEls = document.getElementById("nav").getElementsByTagName("li");
for (var i=0; i<sfEls.length; i++) {
sfEls[i].onmouseover=function() {
this.className+=(this.className.length>0? " ": "") + "show";
}
sfEls[i].onmouseout=function() {
this.className=this.className.replace(new RegExp("( ?|^)show\\b"), "");
}
}
}
window.onload=menuFix;




