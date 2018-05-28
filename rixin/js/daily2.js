// JavaScript Document
//----------------------------------------------------------------------
//
// 作者: 李淼（nick.lee）
//
// asp.net下的前台日历控件源代码(不刷新页面)

// 时间:2005-3-15

// boyorgril@msn.com
// qq:16503096
//注意：引用请标明出处,谢谢
//----------------------------------------------------------------------

//==================================================== 参数设定部分 =======================================================
var bmoveable=true;  //设置日历是否可以拖动
var _versioninfo=""         //版本信息

//==================================================== web 页面显示部分 =====================================================
var strframe;  //存放日历层的html代码
document.writeln('<iframe id=nickdatelayer scrolling=0 frameborder=0 ></iframe>');
strframe='<style>';
strframe+='input.button{border-right: #9496e1 1px solid;border-top: #9496e1 1px solid;border-left: #9496e1 1px solid;';
strframe+='border-bottom: #9496e1 1px solid;background-color: #fff8ec;font-family:宋体;}';
strframe+='td{font-size: 9pt;font-family:宋体;}';
strframe+='</style>';
strframe+='<scr' + 'ipt>';
strframe+='var datelayerx,datelayery; /*存放日历控件的鼠标位置*/';
strframe+='var bdrag; /*标记是否开始拖动*/';
strframe+='function document.onmousemove() /*在鼠标移动事件中，如果开始拖动日历，则移动日历*/';
strframe+='{if(bdrag && window.event.button==1)';
strframe+=' {var datelayer=parent.document.all.nickdatelayer.style;';
strframe+='  datelayer.posleft += window.event.clientx-datelayerx;/*由于每次移动以后鼠标位置都恢复为初始的位置，因此写法与div中不同*/';
strframe+='  datelayer.postop += window.event.clienty-datelayery;}}';
strframe+='function dragstart()  /*开始日历拖动*/';
strframe+='{var datelayer=parent.document.all.nickdatelayer.style;';
strframe+=' datelayerx=window.event.clientx;';
strframe+=' datelayery=window.event.clienty;';
strframe+=' bdrag=true;}';
strframe+='function dragend(){  /*结束日历拖动*/';
strframe+=' bdrag=false;}';
strframe+='</scr' + 'ipt>';
strframe+='<div onselectstart="return false"><span id=tmpselectyearlayer  ></span>';
strframe+='<span id=tmpselectmonthlayer  ></span>';
strframe+='<table border=1 cellspacing=0 cellpadding=0 width=142 height=160 bordercolor=#9496e1 bgcolor=#9496e1 >';
strframe+='  <tr ><td width=142 height=23  bgcolor=#ffffff><table border=0 cellspacing=1 cellpadding=0 width=140  height=23>';
strframe+='      <tr align=center ><td width=16 align=center bgcolor=#9496e1 ';
strframe+='        title="向前翻 1 月" ><b >&lt;</b>';
strframe+='        </td><td width=60 align=center   ';
strframe+='onmouseover="style.backgroundcolor=\'#c6c7ef\'" onmouseout="style.backgroundcolor=\'white\'" ';
strframe+=' title="点击这里选择年份"><span  id=nickyearhead></span></td>';
strframe+='<td width=48 align=center   onmouseover="style.backgroundcolor=\'#c6c7ef\'" ';
strframe+=' onmouseout="style.backgroundcolor=\'white\'" ';
strframe+='        title="点击这里选择月份"><span id=nickmonthhead ></span></td>';
strframe+='        <td width=16 bgcolor=#9496e1 align=center ';
strframe+='         title="向后翻 1 月" ><b >&gt;</b></td></tr>';
strframe+='    </table></td></tr>';
strframe+='  <tr ><td width=142 height=18 >';
strframe+='<table border=1 cellspacing=0 cellpadding=0 bgcolor=#9496e1 ' + (bmoveable? 'onmousedown="dragstart()" onmouseup="dragend()"':'');
strframe+=' bordercolorlight=#9496e1 bordercolordark=#ffffff width=140 height=20  >';
strframe+='<tr  align=center valign=bottom><td >日</td>';
strframe+='<td >一</td><td >二</td>';
strframe+='<td >三</td><td >四</td>';
strframe+='<td >五</td><td >六</td></tr>';
strframe+='</table></td></tr>';
strframe+='  <tr ><td width=142 height=120 >';
strframe+='    <table border=1 cellspacing=2 cellpadding=0 bordercolorlight=#9496e1 bordercolordark=#ffffff bgcolor=#fff8ec width=140 height=120 >';
var n=0; for (j=0;j<5;j++){ strframe+= ' <tr align=center >'; for (i=0;i<7;i++){
strframe+='<td width=20 height=20 id=nickday'+n+'   onclick=parent.nickdayclick(this.innertext,0)></td>';n++;}
strframe+='</tr>';}
strframe+='      <tr align=center >';
for (i=35;i<39;i++)strframe+='<td width=20 height=20 id=nickday'+i+'   ></td>';
strframe+='        <td colspan=3 align=right ><span onclick=parent.closelayer() ';
strframe+='          title="' + _versioninfo + '"><u>关闭</u></span>&nbsp;</td></tr>';
strframe+='    </table></td></tr><tr ><td >';
strframe+='        <table border=0 cellspacing=1 cellpadding=0 width=100%  bgcolor=#ffffff>';
strframe+='          <tr ><td  align=left><input  type=button class=button value="<<" title="向前翻 1 年" ';
strframe+='             onfocus="this.blur()" ><input  class=button title="向前翻 1 月" type=button ';
strframe+='             value="< " onfocus="this.blur()" ></td><td ';
strframe+='              align=center><input  type=button class=button value=今天 ';
strframe+='             onfocus="this.blur()" title="当前日期" ></td><td ';
strframe+='              align=right><input  type=button class=button value=" >" ';
strframe+='             onfocus="this.blur()" title="向后翻 1 月" class=button ><input ';
strframe+='              type=button class=button value=">>" title="向后翻 1 年" ';
strframe+='             onfocus="this.blur()" ></td>';
strframe+='</tr></table></td></tr></table></div>';

window.frames.nickdatelayer.document.writeln(strframe);
window.frames.nickdatelayer.document.close();  //解决ie进度条不结束的问题

//==================================================== web 页面显示部分 ======================================================
var outobject;
var outbutton;  //点击的按钮
var outdate="";  //存放对象的日期
var odatelayer=window.frames.nickdatelayer.document.all;  //存放日历对象
function setday(tt,obj) //主调函数
{
 if (arguments.length >  2){alert("对不起！传入本控件的参数太多！");return;}
 if (arguments.length == 0){alert("对不起！您没有传回本控件任何参数！");return;}
 var dads  = document.all.nickdatelayer.style;
 var th = tt;
 var ttop  = tt.offsettop;     //tt控件的定位点高
 var thei  = tt.clientheight;  //tt控件本身的高
 var tleft = tt.offsetleft;    //tt控件的定位点宽
 var ttyp  = tt.type;          //tt控件的类型
 while (tt = tt.offsetparent){ttop+=tt.offsettop; tleft+=tt.offsetleft;}
 dads.top  = (ttyp=="image")? ttop+thei : ttop+thei+6;
 dads.left = tleft;
 outobject = (arguments.length == 1) ? th : obj;
 outbutton = (arguments.length == 1) ? null : th; //设定外部点击的按钮
 //根据当前输入框的日期显示日历的年月
 var reg = /^(\d+)-(\d{1,2})-(\d{1,2})$/;
 var r = outobject.value.match(reg);
 if(r!=null){
  r[2]=r[2]-1;
  var d= new date(r[1], r[2],r[3]);
  if(d.getfullyear()==r[1] && d.getmonth()==r[2] && d.getdate()==r[3]){
   outdate=d;  //保存外部传入的日期
  }
  else outdate="";
   nicksetday(r[1],r[2]+1);
 }
 else{
  outdate="";
  nicksetday(new date().getfullyear(), new date().getmonth() + 1);
 }
 dads.display = '';

 event.returnvalue=false;
}

var monhead = new array(12);         //定义阳历中每个月的最大天数
    monhead[0] = 31; monhead[1] = 28; monhead[2] = 31; monhead[3] = 30; monhead[4]  = 31; monhead[5]  = 30;
    monhead[6] = 31; monhead[7] = 31; monhead[8] = 30; monhead[9] = 31; monhead[10] = 30; monhead[11] = 31;

var nicktheyear=new date().getfullyear(); //定义年的变量的初始值
var nickthemonth=new date().getmonth()+1; //定义月的变量的初始值
var nickwday=new array(39);               //定义写日期的数组

function document.onclick() //任意点击时关闭该控件 //ie6的情况可以由下面的切换焦点处理代替
{
  with(window.event)
  { if (srcelement.getattribute("author")==null && srcelement != outobject && srcelement != outbutton)
    closelayer();
  }
}

function document.onkeyup()  //按esc键关闭，切换焦点关闭
  {
    if (window.event.keycode==27){
  if(outobject)outobject.blur();
  closelayer();
 }
 else if(document.activeelement)
  if(document.activeelement.getattribute("author")==null && document.activeelement != outobject && document.activeelement != outbutton)
  {
   closelayer();
  }
  }

function nickwritehead(yy,mm)  //往 head 中写入当前的年与月
  {
 odatelayer.nickyearhead.innertext  = yy + " 年";
    odatelayer.nickmonthhead.innertext = mm + " 月";
  }

function tmpselectyearinnerhtml(stryear) //年份的下拉框
{
  if (stryear.match(/\d/)!=null){alert("年份输入参数不是数字！");return;}
  var m = (stryear) ? stryear : new date().getfullyear();
  if (m < 1000 || m > 9999) {alert("年份值不在 1000 到 9999 之间！");return;}
  var n = m - 10;
  if (n < 1000) n = 1000;
  if (n + 26 > 9999) n = 9974;
  var s = "<select  name=tmpselectyear style='font-size: 12px' "
     s += "onblur='document.all.tmpselectyearlayer.style.display=\"none\"' "
     s += "onchange='document.all.tmpselectyearlayer.style.display=\"none\";"
     s += "parent.nicktheyear = this.value; parent.nicksetday(parent.nicktheyear,parent.nickthemonth)'>\r\n";
  var selectinnerhtml = s;
  n = n-70;
  for (var i = n; i < n + 200; i++)
  {
    if (i == m)
       {selectinnerhtml += "<option  value='" + i + "' selected>" + i + "年" + "</option>\r\n";}
    else {selectinnerhtml += "<option  value='" + i + "'>" + i + "年" + "</option>\r\n";}
  }
  selectinnerhtml += "</select>";
  odatelayer.tmpselectyearlayer.style.display="";
  odatelayer.tmpselectyearlayer.innerhtml = selectinnerhtml;
  odatelayer.tmpselectyear.focus();
}

function tmpselectmonthinnerhtml(strmonth) //月份的下拉框
{
  if (strmonth.match(/\d/)!=null){alert("月份输入参数不是数字！");return;}
  var m = (strmonth) ? strmonth : new date().getmonth() + 1;
  var s = "<select  name=tmpselectmonth style='font-size: 12px' "
     s += "onblur='document.all.tmpselectmonthlayer.style.display=\"none\"' "
     s += "onchange='document.all.tmpselectmonthlayer.style.display=\"none\";"
     s += "parent.nickthemonth = this.value; parent.nicksetday(parent.nicktheyear,parent.nickthemonth)'>\r\n";
  var selectinnerhtml = s;
  for (var i = 1; i < 13; i++)
  {
    if (i == m)
       {selectinnerhtml += "<option  value='"+i+"' selected>"+i+"月"+"</option>\r\n";}
    else {selectinnerhtml += "<option  value='"+i+"'>"+i+"月"+"</option>\r\n";}
  }
  selectinnerhtml += "</select>";
  odatelayer.tmpselectmonthlayer.style.display="";
  odatelayer.tmpselectmonthlayer.innerhtml = selectinnerhtml;
  odatelayer.tmpselectmonth.focus();
}

function closelayer()               //这个层的关闭
  {
    document.all.nickdatelayer.style.display="none";
  }

function ispinyear(year)            //判断是否闰平年
  {
    if (0==year%4&&((year%100!=0)||(year%400==0))) return true;else return false;
  }

function getmonthcount(year,month)  //闰年二月为29天
  {
    var c=monhead[month-1];if((month==2)&&ispinyear(year)) c++;return c;
  }
function getdow(day,month,year)     //求某天的星期几
  {
    var dt=new date(year,month-1,day).getday()/7; return dt;
  }

function nickprevy()  //往前翻 year
  {
    if(nicktheyear > 999 && nicktheyear <10000){nicktheyear--;}
    else{alert("年份超出范围（1000-9999）！");}
    nicksetday(nicktheyear,nickthemonth);
  }
function nicknexty()  //往后翻 year
  {
    if(nicktheyear > 999 && nicktheyear <10000){nicktheyear++;}
    else{alert("年份超出范围（1000-9999）！");}
    nicksetday(nicktheyear,nickthemonth);
  }
function nicktoday()  //today button
  {
 var today;
    nicktheyear = new date().getfullyear();
    nickthemonth = new date().getmonth()+1;
     if (nickthemonth < 10){nickthemonth = "0" + nickthemonth;}
    today=new date().getdate();
     if (today < 10){today = "0" + today;}
    //nicksetday(nicktheyear,nickthemonth);
    if(outobject){
  outobject.value=nicktheyear + "-" + nickthemonth + "-" + today;
    }
    closelayer();
  }
function nickprevm()  //往前翻月份
  {
    if(nickthemonth>1){nickthemonth--}else{nicktheyear--;nickthemonth=12;}
    nicksetday(nicktheyear,nickthemonth);
  }
function nicknextm()  //往后翻月份
  {
    if(nickthemonth==12){nicktheyear++;nickthemonth=1}else{nickthemonth++}
    nicksetday(nicktheyear,nickthemonth);
  }

function nicksetday(yy,mm)   //主要的写程序**********
{
  nickwritehead(yy,mm);
  //设置当前年月的公共变量为传入值
  nicktheyear=yy;
  nickthemonth=mm;

  for (var i = 0; i < 39; i++){nickwday[i]=""};  //将显示框的内容全部清空
  var day1 = 1,day2=1,firstday = new date(yy,mm-1,1).getday();  //某月第一天的星期几
  for (i=0;i<firstday;i++)nickwday[i]=getmonthcount(mm==1?yy-1:yy,mm==1?12:mm-1)-firstday+i+1 //上个月的最后几天
  for (i = firstday; day1 < getmonthcount(yy,mm)+1; i++){nickwday[i]=day1;day1++;}
  for (i=firstday+getmonthcount(yy,mm);i<39;i++){nickwday[i]=day2;day2++}
  for (i = 0; i < 39; i++)
  { var da = eval("odatelayer.nickday"+i)     //书写新的一个月的日期星期排列
    if (nickwday[i]!="")
      {
  //初始化边框
  da.bordercolorlight="#9496e1";
  da.bordercolordark="#ffffff";
  if(i<firstday)  //上个月的部分
  {
   da.innerhtml="<b><font color=gray>" + nickwday[i] + "</font></b>";
   da.title=(mm==1?12:mm-1) +"月" + nickwday[i] + "日";
   da.onclick=function("nickdayclick(this.innertext,-1)");
   if(!outdate)
    da.style.backgroundcolor = ((mm==1?yy-1:yy) == new date().getfullyear() &&
     (mm==1?12:mm-1) == new date().getmonth()+1 && nickwday[i] == new date().getdate()) ?
      "#c6c7ef":"#e0e0e0";
   else
   {
    da.style.backgroundcolor =((mm==1?yy-1:yy)==outdate.getfullyear() && (mm==1?12:mm-1)== outdate.getmonth() + 1 &&
    nickwday[i]==outdate.getdate())? "#ffd700" :
    (((mm==1?yy-1:yy) == new date().getfullyear() && (mm==1?12:mm-1) == new date().getmonth()+1 &&
    nickwday[i] == new date().getdate()) ? "#c6c7ef":"#e0e0e0");
    //将选中的日期显示为凹下去
    if((mm==1?yy-1:yy)==outdate.getfullyear() && (mm==1?12:mm-1)== outdate.getmonth() + 1 &&
    nickwday[i]==outdate.getdate())
    {
     da.bordercolorlight="#ffffff";
     da.bordercolordark="#9496e1";
    }
   }
  }
  else if (i>=firstday+getmonthcount(yy,mm))  //下个月的部分
  {
   da.innerhtml="<b><font color=gray>" + nickwday[i] + "</font></b>";
   da.title=(mm==12?1:mm+1) +"月" + nickwday[i] + "日";
   da.onclick=function("nickdayclick(this.innertext,1)");
   if(!outdate)
    da.style.backgroundcolor = ((mm==12?yy+1:yy) == new date().getfullyear() &&
     (mm==12?1:mm+1) == new date().getmonth()+1 && nickwday[i] == new date().getdate()) ?
      "#c6c7ef":"#e0e0e0";
   else
   {
    da.style.backgroundcolor =((mm==12?yy+1:yy)==outdate.getfullyear() && (mm==12?1:mm+1)== outdate.getmonth() + 1 &&
    nickwday[i]==outdate.getdate())? "#ffd700" :
    (((mm==12?yy+1:yy) == new date().getfullyear() && (mm==12?1:mm+1) == new date().getmonth()+1 &&
    nickwday[i] == new date().getdate()) ? "#c6c7ef":"#e0e0e0");
    //将选中的日期显示为凹下去
    if((mm==12?yy+1:yy)==outdate.getfullyear() && (mm==12?1:mm+1)== outdate.getmonth() + 1 &&
    nickwday[i]==outdate.getdate())
    {
     da.bordercolorlight="#ffffff";
     da.bordercolordark="#9496e1";
    }
   }
  }
  else  //本月的部分
  {
   da.innerhtml="<b>" + nickwday[i] + "</b>";
   da.title=mm +"月" + nickwday[i] + "日";
   da.onclick=function("nickdayclick(this.innertext,0)");  //给td赋予onclick事件的处理
   //如果是当前选择的日期，则显示暗黄色的背景；如果是当前日期，则显示亮紫色的背景
   if(!outdate)
    da.style.backgroundcolor = (yy == new date().getfullyear() && mm == new date().getmonth()+1 && nickwday[i] == new date().getdate())?
     "#c6c7ef":"#e0e0e0";
   else
   {
    da.style.backgroundcolor =(yy==outdate.getfullyear() && mm== outdate.getmonth() + 1 && nickwday[i]==outdate.getdate())?
     "#ffd700":((yy == new date().getfullyear() && mm == new date().getmonth()+1 && nickwday[i] == new date().getdate())?
     "#c6c7ef":"#e0e0e0");
    //将选中的日期显示为凹下去
    if(yy==outdate.getfullyear() && mm== outdate.getmonth() + 1 && nickwday[i]==outdate.getdate())
    {
     da.bordercolorlight="#ffffff";
     da.bordercolordark="#9496e1";
    }
   }
  }
        da.style.cursor="hand"
      }
    else{da.innerhtml="";da.style.backgroundcolor="";da.style.cursor="default"}
  }
}

function nickdayclick(n,ex)  //点击显示框选取日期，主输入函数*************
{
  var yy=nicktheyear;
  var mm = parseint(nickthemonth)+ex; //ex表示偏移量，用于选择上个月份和下个月份的日期
 //判断月份，并进行对应的处理
 if(mm<1){
  yy--;
  mm=12+mm;
 }
 else if(mm>12){
  yy++;
  mm=mm-12;
 }

  if (mm < 10){mm = "0" + mm;}
  if (outobject)
  {
    if (!n) {//outobject.value="";
      return;}
    if ( n < 10){n = "0" + n;}
    outobject.value= yy + "-" + mm + "-" + n ; //注：在这里你可以输出改成你想要的格式
    closelayer();
  }
  else {closelayer(); alert("您所要输出的控件对象并不存在！");}
}

