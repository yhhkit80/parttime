<!--
function Gi_LocOpenSub(strUrl,strSub) { //��ת����
	var winname = window.open('', '_self', 'left=0');
	winname.document.open('text/html', 'replace');
	winname.document.writeln('<form action="'+strUrl+'" method="post" name="OnSucsSubGoNext">'+strSub+'</form><script language="javascript">document.OnSucsSubGoNext.submit(OnSucsSubGoNext.form);<\/script>');
	winname.document.close();
}
function Gi_winOpen(strUrl) { //�¿�����
	var winname = window.open('Gi_newWin', "_blank", 'left=0,top=0,width=50,height=50,toolbar=no, menubar=yes, scrollbars=no, location=no, statusbar=yes, copyhistory=no ,directories=no');
	winname.document.open('text/html', 'replace');
	winname.document.writeln('<meta http-equiv="refresh" content="0;URL='+ strUrl +'">');
	winname.document.close();
}
function Gi_winOpenScroll(strUrl) { //�¿�����
	var winname = window.open('Gi_newWin', "_blank", 'left=0,top=0,width=50,height=50,toolbar=no, menubar=yes, scrollbars=yes, location=no, status=yes, copyhistory=no ,directories=no');
	winname.document.open('text/html', 'replace');
	winname.document.writeln('<meta http-equiv="refresh" content="0;URL='+ strUrl +'">');
	winname.document.close();
}
function Gi_winOpenFree(strUrl) { //�¿�����
	var winname = window.open('Gi_newWin', "_blank", 'left=0,top=0,toolbar=no, menubar=yes, resizable=yes, scrollbars=yes, location=no, status=yes, copyhistory=no ,directories=no');
	winname.document.open('text/html', 'replace');
	winname.document.writeln('<meta http-equiv="refresh" content="0;URL='+ strUrl +'">');
	winname.document.close();
}
function Gi_winOpenRegular(strUrl,Height,Width) { //�¿����ڣ�ָ�����ڴ�С��
	var winname = window.open('Gi_newWin', "_blank", 'left=0,top=0,width='+ Width +',height='+ Height +',toolbar=no, menubar=yes, resizable=yes, scrollbars=yes, location=no, status=yes, copyhistory=no ,directories=no');
	winname.document.open('text/html', 'replace');
	winname.document.writeln('<meta http-equiv="refresh" content="0;URL='+ strUrl +'">');
	winname.document.close();
}
function Gi_winOpenSub(strUrl,strSub) { //�¿�����
	var winname = window.open('', '_blank', 'left=0,top=0,toolbar=no, menubar=yes, resizable=yes, scrollbars=yes, location=no, status=yes, copyhistory=no ,directories=no');
	winname.document.open('text/html', 'replace');
	winname.document.writeln('<form action="'+strUrl+'" method="post" name="OnSucsSubGoNext">'+strSub+'</form><script language="javascript">document.OnSucsSubGoNext.submit(OnSucsSubGoNext.form);<\/script>');
	winname.document.close();
}

function Gi_ceSub(formName){//ctrl + enter �ύ��
	document.forms(formName).submit();
	Gi_disAllButton();
}

function Gi_getOptDate(formName,objName){//ѡ������
	dRes = showModalDialog('../htmledit/calendar.htm', null, 'dialogWidth: 200px; dialogHeight: 220px; center: yes; resizable: no; scroll: yes; status: no;')

	if(dRes){
		document.forms(formName).elements(objName).value=dRes;
	}
}

function Gi_getOptDateLinkage(formName,objName,linkageObjName){//�Զ����µ�������
	dRes = showModalDialog('../htmledit/calendar.htm', null, 'dialogWidth: 200px; dialogHeight: 220px; center: yes; resizable: no; scroll: yes; status: no;')
	if(dRes){
		document.forms(formName).elements(objName).value=dRes;
		res0=res.split("-")[0];
		res1=res.split("-")[1];
		res2=res.split("-")[2];

		res1=eval(res1-"-1");
		if (res1>12){
			res1=eval(res1-12);
			res0=eval(res0-"-1");
		}
			dRes=res0+"-"+res1+"-"+res2;
		
		document.forms(formName).elements(linkageObjName).value=dRes;
	}
}

function Gi_getSelectID(formName,selectName,objName){//�õ�select�µ�valueֵ
	if (document.forms(formName).elements(selectName).value!=''){
		document.forms(formName).elements(objName).value=document.forms(formName).elements(selectName).value;
	}
}

function Gi_disAllButton(){//Gi_disAllButton�����ύ��ťdisablend
	var TypeNo=new  Array("INPUT");
	for(i=0;i<TypeNo.length;i++){
		var AList=document.all.tags(TypeNo[i]);
		for(j=0;j<AList.length;j++){
			AList[j].disabled=true;
		}
	}
}

function Gi_delConfirm(tAdd,fAdd,strConfirm){//ȷ��confirm�¼�
	var delQus;
	delQus=confirm("ȷ��Ҫɾ�� {( "+strConfirm+" )} ô?");
	if (delQus==true){
		window.self.location= tAdd ;
	}else{
		fAdd
	}
}	

//ȷ��confirmSub�¼�
var delCheck=false;
function Gi_delConfirm(strConfirm){
	var delQus;
	delQus=confirm('ȷ��Ҫɾ�� {( '+strConfirm+' )} ô?');
	if (delQus==true){
		delCheck = true;
	}else{
		delCheck = false;
	}
}
function Gi_validForm(formName,elementsName,strAlert){
	var eNum=new Array();
	eNum=elementsName.split("|");
	var aNum=new Array();
	aNum=strAlert.split("|");

	for (var i=0; i<eNum.length; i++){
		if (document.forms(formName).elements(eNum[i]).value==''){
			alert(aNum[i]);
			document.forms(formName).elements(eNum[i]).focus();
			return false;
		}
	}
	return true;
}

//�˵�չ��
var lastObj 
function Gi_expandObj(obj){
	if(lastObj != null){
		if(obj == lastObj){
			if(obj.style.display=="none"){
				obj.style.display="block";
			}else{
				obj.style.display="none"				
			}
		}else{
			lastObj.style.display="none"
			obj.style.display="block";
		}
	}else{
		obj.style.display="block";
	}	
	lastObj=obj
}


//other
//ˢ�¸����ڣ�Ҳ����ָ��ǰ���ڵ�����һ�����ڣ�
//��ҳ����Body�� onunload����Ӹú������磺<body onunload="reflash()">
function reflash(){
	if(!window.opener.window.closed){
		window.opener.window.location.reload()
	}
}


// ����������Ƿ��Ǵ����������(�����Կյļ���) by rj
function fCheckNumber(s){
	if (!isNaN(s)&&!checkBlank(s)){
		if(s>0){
			return true;
		}else	{
			return false;
		}
	}else{
		return false;
	}
}


// ����������Ƿ��Ǵ����������(�����Կյļ���) by rj
function fCheckInteger(s){
	var re=/^[\d]+$/
	if(re.exec(s) || s==""){	
		if(s>0){
			return true;
		}else{
			return false;
		}
	}else{
		return false;
	}	
}


function fAddOption(sel,text,value){
//��������б��һ��option
//sel: ��������������; text: Ҫ��ӵ�option����ʾ�ı�; value: Ҫ��ӵ�option��ֵ
//By neat
	
	var newOption;
	for(i=0;i<sel.options.length;i++)
	{
		if(sel.options(i).value == value)
		{
			//�����Ѿ����ڣ�����False
			return false;
		}
	}
	newOption=document.createElement("option");
	newOption.text=text;
	newOption.value=value;
	sel.add(newOption);
	return true;
}

function fDelOption(sel){
//ɾ�������б�ѡ�е�option,�ɶ�ѡ
//sel: ����������б����
//����ֵ: true--�����ɹ�; false--δ����,������ʾ���
//By Neat

	if(sel.value=="")
	{
	alert("��ѡ��Ҫɾ������Ŀ!")
	return false;
	}
	for(i=0;i<sel.options.length;i++)
	{
		if(sel.options(i).selected)
		{
			sel.options.remove(i);
			i--;
		}
	}
	return true;
}


function fDelOptionSort(sel){
//ɾ�������б�ѡ�е�option,�ɶ�ѡ��ͬʱ��option��������
//sel: ����������б����
//����ֵ: true--�����ɹ�; false--δ����,������ʾ���
//By Neat

	if(sel.value=="")
	{
	alert("��ѡ��Ҫɾ������Ŀ!")
	return false;
	}
	for(i=0;i<sel.options.length;i++)
	{
		if(sel.options(i).selected)
		{
			sel.options.remove(i);
			i--;
		}
	}
	var x = 1;
	var strTmp
	for(i=0;i<sel.options.length;i++)
	{
		strTmp = sel.options(i).text;
		strTmp = strTmp.substring(0,strTmp.indexOf("-")+1);
		sel.options(i).text = fReplace(sel.options(i).text,strTmp, x + "-");

		strTmp = sel.options(i).value;
		strTmp = strTmp.substring(0,strTmp.indexOf("-")+1);
		sel.options(i).value = fReplace(sel.options(i).value,strTmp, x + "-");
		x += 1;
	}

	return true;
}


//ȥ���ַ�����ǰ��ո�
function ftrimStr(str)
{
	var pos;
	pos = str.indexOf(" ");
	while (str.charAt(0) == " ")
		str = str.substr(1);
	while (str.charAt(str.length - 1) == " ")
		str = str.substr(0,str.length - 1);
	return str;
}


//�ύ�б�ҳ�Ĳ�ѯ
function fsubmitForm(){
	var d=document.forms(0);
	if(d.pageNo){
		d.pageNo.value=1
	};
	d.submit()
}


//����󻯴���
function fOpenMaxWin(url){
	var x=window.screen.width - 10;
	var y=window.screen.height ;
	window.open(url,"","width=" + x + ",height=" + y + ",resizable=yes,srollbars=yes,left=0,top=0")
}


function fShowHidByElt(hidElt,onElt){
//����ָ�������λ����ʾ���صĶ���
//hidElt: Ҫ��ʾ�Ķ���; onElt:��ʾ��λ�õ����ݶ���

	selElt=onElt  //���蹫�ñ���
	hidElt.style.left=onElt.offsetLeft;
	hidElt.style.top=parseInt(onElt.offsetTop) + 20;
	hidElt.style.display="";
	hidElt.focus();
}


function fSwapSelectOption(sel1,sel2){
//���������������option,�ɶ�ѡ  **��sel1��sel2
//sel1: ��������������1; sel2: ��������������2
//����ֵ: true--�����ɹ�; false--δ����,������ʾ���
//Code By Neat

	if(sel1.value=="")
	{
		alert("��ѡ��Ҫ�ı����Ŀ!");
		return false;
	}else

	{
		for(i=0;i<sel2.options.length;i++)
		{
			if(sel2.options(i).value==sel1.value)
			{
				return true;
			}
		}
		var newOption;
		for(i=0;i<sel1.options.length;i++)
		{
			if(sel1.options(i).selected)
			{
				newOption=document.createElement("option");
				newOption.value=sel1.options(i).value;
				newOption.text=sel1.options(i).text;
				sel2.add(newOption);
				sel1.options.remove(i);
				i--;
			};
		};
		return true;
	}
	return false;
}



function fSwapSelectOption2(sel1,sel2){
//���������������option,�ɶ�ѡ  **��sel1��sel2
//sel1: ��������������1; sel2: ��������������2
//�ظ�ֵ��Value��Text���ж�
//����ֵ: true--�����ɹ�; false--δ����,������ʾ���
//Code Chang By Xuxm

	if(sel1.value=="" && sel1.text=="")
	{
		alert("��ѡ��Ҫ�ı����Ŀ!");
		return false;
	}else

	{
		var newOption;
		for(i=0;i<sel1.options.length;i++)
		{
			if(sel1.options(i).selected)
			{
				for(j=0;j<sel2.options.length;j++)
						if(sel2.options(j).value==sel1.options(i).value&&sel2.options(j).text==sel1.options(i).text)break;
				  
				if(j==sel2.options.length){
						newOption=document.createElement("option");
						newOption.value=sel1.options(i).value;
						newOption.text=sel1.options(i).text;
						sel2.add(newOption);
				}		
				sel1.options.remove(i);
				i--;
				
			};
		};
		return true;
	}
	return false;
}




function fChgOptionsSq(elt,dir){
//�ı�������option��˳��
//elt:���������dir������("up","down")
	var i
	var tmpText,tmpValue
	
	if(dir=="up"){
		for(i=0;i<elt.options.length;i++){
			if(elt.options(i).selected && i>0){
				tmpText=elt.options(i).text;
				tmpValue=elt.options(i).value;
				elt.options(i).text=elt.options(i-1).text;
				elt.options(i).value=elt.options(i-1).value;
				elt.options(i-1).text=tmpText;
				elt.options(i-1).value=tmpValue;
				elt.options(i).selected=false;
				elt.options(i-1).selected=true;
			}
		}
	}else{
		for(i=elt.options.length-1;i>=0;i--){
			if(elt.options(i).selected && i<elt.options.length-1){
				tmpText=elt.options(i).text;
				tmpValue=elt.options(i).value;
				elt.options(i).text=elt.options(i+1).text;
				elt.options(i).value=elt.options(i+1).value;
				elt.options(i+1).text=tmpText;
				elt.options(i+1).value=tmpValue;
				elt.options(i).selected=false;
				elt.options(i+1).selected=true;
			}
		}
	}
}


//�ַ����滻(����ͬVB��replace����)  By Neat
function fReplace(str1,str2,str3){
	var str="";
	var pos;
	var con=true;
	while(con)
	{
		pos=str1.indexOf(str2);
		if(pos != -1)
		{
			str=str + str1.substring(0,pos);
			str=str + str3;
			str1=str1.substring(pos+str2.length,str1.length)
		}else
		{
			con=false;
		}
	}
	if(str.length>0)
	{
		return str+str1;
	}else
	{
		return str1;
	}
}



function fPicLimit(IncludeName,sLength)
//��������ͼƬ��ʾ�ߴ�
//����: IncludeName--�ַ���,����ͼƬ����������
//	sLength: ���ƵĿ�Ȼ򳤶�,ȡ����������,�ȱ���СͼƬ


{
	var imgs=document.images;
	for(i=0;i<imgs.length;i++)
	{
		if(imgs(i).name.indexOf(IncludeName)!=-1)
		{
			if(imgs(i).height>imgs(i).width)
			{
				if(imgs(i).height>sLength){imgs(i).height=sLength}
			}else
			{
				if(imgs(i).width>sLength){imgs(i).width=sLength}
			}
		}
	}
}


function fChgOptionsSq(elt,dir){
//�ı�������option��˳��,���ı��ı��ĵ�һ���ַ���˳��ţ�
//elt:���������dir������("up","down")
	var i
	var tmpText,tmpValue
	
	if(dir=="up"){
		for(i=0;i<elt.options.length;i++){
			if(elt.options(i).selected && i>0){
				tmpText=elt.options(i).text;
				tmpText=i + tmpText.substring(1,tmpText.length)
				tmpValue=elt.options(i).value;
				elt.options(i).text=(i+1) + elt.options(i-1).text.substring(1,elt.options(i-1).text.length)
				elt.options(i).value=elt.options(i-1).value;
				elt.options(i-1).text=tmpText;
				elt.options(i-1).value=tmpValue;
				elt.options(i).selected=false;
				elt.options(i-1).selected=true;
			}
		}
	}else{
		for(i=elt.options.length-1;i>=0;i--){
			if(elt.options(i).selected && i<elt.options.length-1){
				tmpText=elt.options(i).text;
				tmpText=(i+2) + tmpText.substring(1,tmpText.length)
				tmpValue=elt.options(i).value;
				elt.options(i).text=(i+1) + elt.options(i+1).text.substring(1,elt.options(i+1).text.length)
				elt.options(i).value=elt.options(i+1).value;
				elt.options(i+1).text=tmpText;
				elt.options(i+1).value=tmpValue;
				elt.options(i).selected=false;
				elt.options(i+1).selected=true;
			}
		}
	}
}



//����һ���ַ��������в��ܰ�����һ���ַ����е�����һ���ַ�
function fNoIncludeChar(searchTxt,noChars)
{
	for(i=0;i<(noChars.length);i++)
	{
		if(searchTxt.indexOf(noChars.substring(i,i+1)) != -1)
		{
			return false;
		}
	}
	return true;
}
//���Email ǰ̨ҳ�����ʵ����if(!checkMail(form1.Email.value)){alert("����ȷ����Email");form1.Email.focus();return false;};	
function checkMail(strEmail){ 
	var myReg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/; 
	if(myReg.test(strEmail)) return true; 
	return false; 
} 
//-->