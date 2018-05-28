// JavaScript Document


//--插入日历--

function montharr(m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11) {
this[0] = m0;
this[1] = m1;
this[2] = m2;
this[3] = m3;
this[4] = m4;
this[5] = m5;
this[6] = m6;
this[7] = m7;
this[8] = m8;
this[9] = m9;
this[10] = m10;
this[11] = m11;
}
//more javascript from http://www.webjx.com

function calendar() {
var monthNames = "JanFebMarAprMayJunJulAugSepOctNovDec";
var today = new Date();
var thisDay;
var monthDays = new montharr(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

year = today.getYear() +1900;
thisDay = today.getDate();

if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) monthDays[1] = 29;

nDays = monthDays[today.getMonth()];
firstDay = today;
firstDay.setDate(1); // works fine for most systems
testMe = firstDay.getDate();
if (testMe == 2) firstDay.setDate(0);
startDay = firstDay.getDay();

document.write('<table border="1" cellspacing="0" cellpadding="1" align="CENTER" bgcolor="#2F5C9A"><TR><TD><table border="0" cellspacing="1" cellpadding="1" bgcolor="#DFE1E1">');

document.write('<TR><th colspan="7" bgcolor="#fff" width="500px">');
var dayNames = new Array("Sunday","Monday","Tuesday","Wendesday","Thursday","Friday","Saturday");
var monthNames = new Array("January","February","March","April","May","June","July","August","September","October ","November","December ");

var now = new Date();
document.write("<font style=padding-top:10px;padding-bottom:10px;font-size:20pt;Color:#2F5C9A;display:block;background-color:#fff;>" +now.getDate() + " " + monthNames[now.getMonth()]+  " , 2012 " + " " + dayNames[now.getDay()] + "</FONT>");
document.writeln('</TH></TR><TR ><TH BGCOLOR="#2F5C9A" style="padding:3px 10px;"><font style="font-size:12px;Color:White;font-weight:normal">Sun</FONT></TH>');
document.writeln('<th bgcolor="#2F5C9A"  style="padding:3px 10px;"><font style="font-size:12px;Color:White;font-weight:normal">Mon</FONT></TH>');
document.writeln('<TH BGCOLOR="#2F5C9A" style="padding:3px 10px;"><font style="font-size:12px;Color:White;font-weight:normal">Tue</FONT></TH>');
document.writeln('<TH BGCOLOR="#2F5C9A" style="padding:3px 10px;"><font style="font-size:12px;Color:White;font-weight:normal">Wed</FONT></TH>');
document.writeln('<TH BGCOLOR="#2F5C9A" style="padding:3px 10px;"><font style="font-size:12px;Color:White;font-weight:normal">Thu</FONT></TH>');
document.writeln('<TH BGCOLOR="#2F5C9A" style="padding:3px 10px;"><font style="font-size:12px;Color:White;font-weight:normal">Fri</FONT></TH>');
document.writeln('<TH BGCOLOR="#2F5C9A" style="padding:3px 10px;"><font style="font-size:12px;Color:White;font-weight:normal">Sat</FONT></TH>');
document.writeln("</TR><TR>");
column = 0;
for (i=0; i<startDay; i++) {
document.writeln("\n<TD><FONT style=font-size:12px> </FONT></TD>");
column++;
}

for (i=1; i<=nDays; i++) {
if (i == thisDay) {
document.writeln('</TD><td align="CENTER" bgcolor="#ffffff"  style="padding:20px;"><FONT style=font-size:16px;Color:red;><B>')
}
else {
document.writeln('</TD><TD BGCOLOR="#FFFFFF" ALIGN="CENTER" style="padding:20px;"><FONT style=font-size:16px;font-family:Arial;font-weight:bold;Color:#2F5C9A>');
}
document.writeln(i);
if (i == thisDay) document.writeln("</FONT></TD>")
column++;
if (column == 7) {
document.writeln("<TR>");
column = 0;
}
}
document.writeln('<TR><td colspan="7" align="CENTER" style="border:#2F5C9A 1px solid ;valign="TOP" bgcolor="#2F5C9A"><form name="clock" onSubmit="0"><FONT style=font-size:12px;Color:#ffffff>Now Time <INPUT TYPE="Text" NAME="face" size="11px" ALIGN="TOP" style="width:90px"></FONT></TD></TR></TABLE></TD></TR></TABLE></form>');
}
//----日历主要内容结束---


//---------------日历中时间显示的代码--------------
var timerID = null;
var timerRunning = false;
function stopclock (){
if(timerRunning)
clearTimeout(timerID);
timerRunning = false;}

function showtime () {
var now = new Date();
var hours = now.getHours();
var minutes = now.getMinutes();
var seconds = now.getSeconds()
var timevalue = " " + ((hours >12) ? hours -12 :hours)
timevalue += ((minutes < 10) ? ":0" : ":") + minutes
timevalue += ((seconds < 10) ? ":0" : ":") + seconds
timevalue += (hours >= 12) ? " PM" : " AM"
document.clock.face.value = timevalue;
timerID = setTimeout("showtime()",1000);
timerRunning = true;}
function startclock () {
stopclock();
showtime();} 


//---------------日历代码结束--------------//






//---------------写入本机当天日期---------------
var d=new Date();
var monthname=new Array("January","February","March","April","May","June","July","August","September","October","November","December");
//Ensure correct for language. English is "January 1, 2004"
var TODAY = d.getDate() + " " + monthname[d.getMonth()] + ", " + d.getFullYear();
//---------------写入本机当天日期 结束----------//



//---------------让IE6支持li:hover的代码--------
 stuHover = function() {   
var cssRule;    
var newSelector;    
for (var i = 0; i < document.styleSheets.length; i++)    
   for (var x = 0; x < document.styleSheets[i].rules.length ; x++)    
    {    
    cssRule = document.styleSheets[i].rules[x];   
    if (cssRule.selectorText.indexOf("LI:hover") != -1)   
    {    
     newSelector = cssRule.selectorText.replace(/LI:hover/gi, "LI.iehover");    
     document.styleSheets[i].addRule(newSelector , cssRule.style.cssText);   
    }    
   }    
var getElm = document.getElementById("bigleftul").getElementsByTagName("LI");    
for (var i=0; i<getElm.length; i++) {    
   getElm[i].onmouseover=function() {   
    this.className+=" iehover";    
   }    
   getElm[i].onmouseout=function() {   
   this.className=this.className.replace(new RegExp(" iehover\\b"), "");   
   }    
}    
}    
if (window.attachEvent) window.attachEvent("onload", stuHover);   
//---------------让IE6支持li:hover的代码结束--------


