// JavaScript Document
//----------------------------------------------------------------------
//
// ����: ����nick.lee��
//
// asp.net�µ�ǰ̨�����ؼ�Դ����(��ˢ��ҳ��)

// ʱ��:2005-3-15

// boyorgril@msn.com
// qq:16503096
//ע�⣺�������������,лл
//----------------------------------------------------------------------

//==================================================== �����趨���� =======================================================
var bmoveable=true;  //���������Ƿ�����϶�
var _versioninfo=""         //�汾��Ϣ

//==================================================== web ҳ����ʾ���� =====================================================
var strframe;  //����������html����
document.writeln('<iframe id=nickdatelayer scrolling=0 frameborder=0 ></iframe>');
strframe='<style>';
strframe+='input.button{border-right: #9496e1 1px solid;border-top: #9496e1 1px solid;border-left: #9496e1 1px solid;';
strframe+='border-bottom: #9496e1 1px solid;background-color: #fff8ec;font-family:����;}';
strframe+='td{font-size: 9pt;font-family:����;}';
strframe+='</style>';
strframe+='<scr' + 'ipt>';
strframe+='var datelayerx,datelayery; /*��������ؼ������λ��*/';
strframe+='var bdrag; /*����Ƿ�ʼ�϶�*/';
strframe+='function document.onmousemove() /*������ƶ��¼��У������ʼ�϶����������ƶ�����*/';
strframe+='{if(bdrag && window.event.button==1)';
strframe+=' {var datelayer=parent.document.all.nickdatelayer.style;';
strframe+='  datelayer.posleft += window.event.clientx-datelayerx;/*����ÿ���ƶ��Ժ����λ�ö��ָ�Ϊ��ʼ��λ�ã����д����div�в�ͬ*/';
strframe+='  datelayer.postop += window.event.clienty-datelayery;}}';
strframe+='function dragstart()  /*��ʼ�����϶�*/';
strframe+='{var datelayer=parent.document.all.nickdatelayer.style;';
strframe+=' datelayerx=window.event.clientx;';
strframe+=' datelayery=window.event.clienty;';
strframe+=' bdrag=true;}';
strframe+='function dragend(){  /*���������϶�*/';
strframe+=' bdrag=false;}';
strframe+='</scr' + 'ipt>';
strframe+='<div onselectstart="return false"><span id=tmpselectyearlayer  ></span>';
strframe+='<span id=tmpselectmonthlayer  ></span>';
strframe+='<table border=1 cellspacing=0 cellpadding=0 width=142 height=160 bordercolor=#9496e1 bgcolor=#9496e1 >';
strframe+='  <tr ><td width=142 height=23  bgcolor=#ffffff><table border=0 cellspacing=1 cellpadding=0 width=140  height=23>';
strframe+='      <tr align=center ><td width=16 align=center bgcolor=#9496e1 ';
strframe+='        title="��ǰ�� 1 ��" ><b >&lt;</b>';
strframe+='        </td><td width=60 align=center   ';
strframe+='onmouseover="style.backgroundcolor=\'#c6c7ef\'" onmouseout="style.backgroundcolor=\'white\'" ';
strframe+=' title="�������ѡ�����"><span  id=nickyearhead></span></td>';
strframe+='<td width=48 align=center   onmouseover="style.backgroundcolor=\'#c6c7ef\'" ';
strframe+=' onmouseout="style.backgroundcolor=\'white\'" ';
strframe+='        title="�������ѡ���·�"><span id=nickmonthhead ></span></td>';
strframe+='        <td width=16 bgcolor=#9496e1 align=center ';
strframe+='         title="��� 1 ��" ><b >&gt;</b></td></tr>';
strframe+='    </table></td></tr>';
strframe+='  <tr ><td width=142 height=18 >';
strframe+='<table border=1 cellspacing=0 cellpadding=0 bgcolor=#9496e1 ' + (bmoveable? 'onmousedown="dragstart()" onmouseup="dragend()"':'');
strframe+=' bordercolorlight=#9496e1 bordercolordark=#ffffff width=140 height=20  >';
strframe+='<tr  align=center valign=bottom><td >��</td>';
strframe+='<td >һ</td><td >��</td>';
strframe+='<td >��</td><td >��</td>';
strframe+='<td >��</td><td >��</td></tr>';
strframe+='</table></td></tr>';
strframe+='  <tr ><td width=142 height=120 >';
strframe+='    <table border=1 cellspacing=2 cellpadding=0 bordercolorlight=#9496e1 bordercolordark=#ffffff bgcolor=#fff8ec width=140 height=120 >';
var n=0; for (j=0;j<5;j++){ strframe+= ' <tr align=center >'; for (i=0;i<7;i++){
strframe+='<td width=20 height=20 id=nickday'+n+'   onclick=parent.nickdayclick(this.innertext,0)></td>';n++;}
strframe+='</tr>';}
strframe+='      <tr align=center >';
for (i=35;i<39;i++)strframe+='<td width=20 height=20 id=nickday'+i+'   ></td>';
strframe+='        <td colspan=3 align=right ><span onclick=parent.closelayer() ';
strframe+='          title="' + _versioninfo + '"><u>�ر�</u></span>&nbsp;</td></tr>';
strframe+='    </table></td></tr><tr ><td >';
strframe+='        <table border=0 cellspacing=1 cellpadding=0 width=100%  bgcolor=#ffffff>';
strframe+='          <tr ><td  align=left><input  type=button class=button value="<<" title="��ǰ�� 1 ��" ';
strframe+='             onfocus="this.blur()" ><input  class=button title="��ǰ�� 1 ��" type=button ';
strframe+='             value="< " onfocus="this.blur()" ></td><td ';
strframe+='              align=center><input  type=button class=button value=���� ';
strframe+='             onfocus="this.blur()" title="��ǰ����" ></td><td ';
strframe+='              align=right><input  type=button class=button value=" >" ';
strframe+='             onfocus="this.blur()" title="��� 1 ��" class=button ><input ';
strframe+='              type=button class=button value=">>" title="��� 1 ��" ';
strframe+='             onfocus="this.blur()" ></td>';
strframe+='</tr></table></td></tr></table></div>';

window.frames.nickdatelayer.document.writeln(strframe);
window.frames.nickdatelayer.document.close();  //���ie������������������

//==================================================== web ҳ����ʾ���� ======================================================
var outobject;
var outbutton;  //����İ�ť
var outdate="";  //��Ŷ��������
var odatelayer=window.frames.nickdatelayer.document.all;  //�����������
function setday(tt,obj) //��������
{
 if (arguments.length >  2){alert("�Բ��𣡴��뱾�ؼ��Ĳ���̫�࣡");return;}
 if (arguments.length == 0){alert("�Բ�����û�д��ر��ؼ��κβ�����");return;}
 var dads  = document.all.nickdatelayer.style;
 var th = tt;
 var ttop  = tt.offsettop;     //tt�ؼ��Ķ�λ���
 var thei  = tt.clientheight;  //tt�ؼ�����ĸ�
 var tleft = tt.offsetleft;    //tt�ؼ��Ķ�λ���
 var ttyp  = tt.type;          //tt�ؼ�������
 while (tt = tt.offsetparent){ttop+=tt.offsettop; tleft+=tt.offsetleft;}
 dads.top  = (ttyp=="image")? ttop+thei : ttop+thei+6;
 dads.left = tleft;
 outobject = (arguments.length == 1) ? th : obj;
 outbutton = (arguments.length == 1) ? null : th; //�趨�ⲿ����İ�ť
 //���ݵ�ǰ������������ʾ����������
 var reg = /^(\d+)-(\d{1,2})-(\d{1,2})$/;
 var r = outobject.value.match(reg);
 if(r!=null){
  r[2]=r[2]-1;
  var d= new date(r[1], r[2],r[3]);
  if(d.getfullyear()==r[1] && d.getmonth()==r[2] && d.getdate()==r[3]){
   outdate=d;  //�����ⲿ���������
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

var monhead = new array(12);         //����������ÿ���µ��������
    monhead[0] = 31; monhead[1] = 28; monhead[2] = 31; monhead[3] = 30; monhead[4]  = 31; monhead[5]  = 30;
    monhead[6] = 31; monhead[7] = 31; monhead[8] = 30; monhead[9] = 31; monhead[10] = 30; monhead[11] = 31;

var nicktheyear=new date().getfullyear(); //������ı����ĳ�ʼֵ
var nickthemonth=new date().getmonth()+1; //�����µı����ĳ�ʼֵ
var nickwday=new array(39);               //����д���ڵ�����

function document.onclick() //������ʱ�رոÿؼ� //ie6�����������������л����㴦�����
{
  with(window.event)
  { if (srcelement.getattribute("author")==null && srcelement != outobject && srcelement != outbutton)
    closelayer();
  }
}

function document.onkeyup()  //��esc���رգ��л�����ر�
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

function nickwritehead(yy,mm)  //�� head ��д�뵱ǰ��������
  {
 odatelayer.nickyearhead.innertext  = yy + " ��";
    odatelayer.nickmonthhead.innertext = mm + " ��";
  }

function tmpselectyearinnerhtml(stryear) //��ݵ�������
{
  if (stryear.match(/\d/)!=null){alert("�����������������֣�");return;}
  var m = (stryear) ? stryear : new date().getfullyear();
  if (m < 1000 || m > 9999) {alert("���ֵ���� 1000 �� 9999 ֮�䣡");return;}
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
       {selectinnerhtml += "<option  value='" + i + "' selected>" + i + "��" + "</option>\r\n";}
    else {selectinnerhtml += "<option  value='" + i + "'>" + i + "��" + "</option>\r\n";}
  }
  selectinnerhtml += "</select>";
  odatelayer.tmpselectyearlayer.style.display="";
  odatelayer.tmpselectyearlayer.innerhtml = selectinnerhtml;
  odatelayer.tmpselectyear.focus();
}

function tmpselectmonthinnerhtml(strmonth) //�·ݵ�������
{
  if (strmonth.match(/\d/)!=null){alert("�·���������������֣�");return;}
  var m = (strmonth) ? strmonth : new date().getmonth() + 1;
  var s = "<select  name=tmpselectmonth style='font-size: 12px' "
     s += "onblur='document.all.tmpselectmonthlayer.style.display=\"none\"' "
     s += "onchange='document.all.tmpselectmonthlayer.style.display=\"none\";"
     s += "parent.nickthemonth = this.value; parent.nicksetday(parent.nicktheyear,parent.nickthemonth)'>\r\n";
  var selectinnerhtml = s;
  for (var i = 1; i < 13; i++)
  {
    if (i == m)
       {selectinnerhtml += "<option  value='"+i+"' selected>"+i+"��"+"</option>\r\n";}
    else {selectinnerhtml += "<option  value='"+i+"'>"+i+"��"+"</option>\r\n";}
  }
  selectinnerhtml += "</select>";
  odatelayer.tmpselectmonthlayer.style.display="";
  odatelayer.tmpselectmonthlayer.innerhtml = selectinnerhtml;
  odatelayer.tmpselectmonth.focus();
}

function closelayer()               //�����Ĺر�
  {
    document.all.nickdatelayer.style.display="none";
  }

function ispinyear(year)            //�ж��Ƿ���ƽ��
  {
    if (0==year%4&&((year%100!=0)||(year%400==0))) return true;else return false;
  }

function getmonthcount(year,month)  //�������Ϊ29��
  {
    var c=monhead[month-1];if((month==2)&&ispinyear(year)) c++;return c;
  }
function getdow(day,month,year)     //��ĳ������ڼ�
  {
    var dt=new date(year,month-1,day).getday()/7; return dt;
  }

function nickprevy()  //��ǰ�� year
  {
    if(nicktheyear > 999 && nicktheyear <10000){nicktheyear--;}
    else{alert("��ݳ�����Χ��1000-9999����");}
    nicksetday(nicktheyear,nickthemonth);
  }
function nicknexty()  //���� year
  {
    if(nicktheyear > 999 && nicktheyear <10000){nicktheyear++;}
    else{alert("��ݳ�����Χ��1000-9999����");}
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
function nickprevm()  //��ǰ���·�
  {
    if(nickthemonth>1){nickthemonth--}else{nicktheyear--;nickthemonth=12;}
    nicksetday(nicktheyear,nickthemonth);
  }
function nicknextm()  //�����·�
  {
    if(nickthemonth==12){nicktheyear++;nickthemonth=1}else{nickthemonth++}
    nicksetday(nicktheyear,nickthemonth);
  }

function nicksetday(yy,mm)   //��Ҫ��д����**********
{
  nickwritehead(yy,mm);
  //���õ�ǰ���µĹ�������Ϊ����ֵ
  nicktheyear=yy;
  nickthemonth=mm;

  for (var i = 0; i < 39; i++){nickwday[i]=""};  //����ʾ�������ȫ�����
  var day1 = 1,day2=1,firstday = new date(yy,mm-1,1).getday();  //ĳ�µ�һ������ڼ�
  for (i=0;i<firstday;i++)nickwday[i]=getmonthcount(mm==1?yy-1:yy,mm==1?12:mm-1)-firstday+i+1 //�ϸ��µ������
  for (i = firstday; day1 < getmonthcount(yy,mm)+1; i++){nickwday[i]=day1;day1++;}
  for (i=firstday+getmonthcount(yy,mm);i<39;i++){nickwday[i]=day2;day2++}
  for (i = 0; i < 39; i++)
  { var da = eval("odatelayer.nickday"+i)     //��д�µ�һ���µ�������������
    if (nickwday[i]!="")
      {
  //��ʼ���߿�
  da.bordercolorlight="#9496e1";
  da.bordercolordark="#ffffff";
  if(i<firstday)  //�ϸ��µĲ���
  {
   da.innerhtml="<b><font color=gray>" + nickwday[i] + "</font></b>";
   da.title=(mm==1?12:mm-1) +"��" + nickwday[i] + "��";
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
    //��ѡ�е�������ʾΪ����ȥ
    if((mm==1?yy-1:yy)==outdate.getfullyear() && (mm==1?12:mm-1)== outdate.getmonth() + 1 &&
    nickwday[i]==outdate.getdate())
    {
     da.bordercolorlight="#ffffff";
     da.bordercolordark="#9496e1";
    }
   }
  }
  else if (i>=firstday+getmonthcount(yy,mm))  //�¸��µĲ���
  {
   da.innerhtml="<b><font color=gray>" + nickwday[i] + "</font></b>";
   da.title=(mm==12?1:mm+1) +"��" + nickwday[i] + "��";
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
    //��ѡ�е�������ʾΪ����ȥ
    if((mm==12?yy+1:yy)==outdate.getfullyear() && (mm==12?1:mm+1)== outdate.getmonth() + 1 &&
    nickwday[i]==outdate.getdate())
    {
     da.bordercolorlight="#ffffff";
     da.bordercolordark="#9496e1";
    }
   }
  }
  else  //���µĲ���
  {
   da.innerhtml="<b>" + nickwday[i] + "</b>";
   da.title=mm +"��" + nickwday[i] + "��";
   da.onclick=function("nickdayclick(this.innertext,0)");  //��td����onclick�¼��Ĵ���
   //����ǵ�ǰѡ������ڣ�����ʾ����ɫ�ı���������ǵ�ǰ���ڣ�����ʾ����ɫ�ı���
   if(!outdate)
    da.style.backgroundcolor = (yy == new date().getfullyear() && mm == new date().getmonth()+1 && nickwday[i] == new date().getdate())?
     "#c6c7ef":"#e0e0e0";
   else
   {
    da.style.backgroundcolor =(yy==outdate.getfullyear() && mm== outdate.getmonth() + 1 && nickwday[i]==outdate.getdate())?
     "#ffd700":((yy == new date().getfullyear() && mm == new date().getmonth()+1 && nickwday[i] == new date().getdate())?
     "#c6c7ef":"#e0e0e0");
    //��ѡ�е�������ʾΪ����ȥ
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

function nickdayclick(n,ex)  //�����ʾ��ѡȡ���ڣ������뺯��*************
{
  var yy=nicktheyear;
  var mm = parseint(nickthemonth)+ex; //ex��ʾƫ����������ѡ���ϸ��·ݺ��¸��·ݵ�����
 //�ж��·ݣ������ж�Ӧ�Ĵ���
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
    outobject.value= yy + "-" + mm + "-" + n ; //ע�����������������ĳ�����Ҫ�ĸ�ʽ
    closelayer();
  }
  else {closelayer(); alert("����Ҫ����Ŀؼ����󲢲����ڣ�");}
}

