<!--
function Gi_onLoadBlurObj(){//让特定标签的对象不可以聚焦  消除链接的虚线框
tagNum=new  Array("IMG","A","BUTTON","TD","TR","INPUT","TABLE");
for(i=0;i<tagNum.length;i++){
	var  tagList=document.all.tags(tagNum[i]);
		for(j=0;j<tagList.length;j++){
			if (tagList[j].tagName=="INPUT"){		
				if (tagList[j].type=="text"||tagList[j].type=="password"){
				}else{
					tagList[j].attachEvent("onfocus",tagList[j].blur);
				}
			}else{
				tagList[j].attachEvent("onfocus",tagList[j].blur);
			}
		}
	}
}

function Gi_disAllButton(){////disAllSub所有提交后按钮disablend
	var tagList=document.all.tags("input");
	var typeList = new Array("submit","button");
	for(var i=0;i<typeList.length;i++){
		typeList[i].disabled=true;
	}
}

function Addpic(mPicPath){//Function to add pic
	 parent.sSendURL(mPicPath);
}
function Gi_getLibAddpic(mPicPath){//lib add pic
	parent.parent.sSendURL(mPicPath)
}

function Gi_onUnloadSubForm(formName){//当窗口关闭时提交表单
	document.forms(formName).submit(formName.form);
}


function Gi_winOpen(strUrl) { //新开窗口
	var winname = window.open('Gi_newWin', "_blank", 'left=0,top=0,width=50,height=50,toolbar=no, menubar=yes, scrollbars=no, location=no, statusbar=yes, copyhistory=no ,directories=no');
	winname.document.open('text/html', 'replace');
	winname.document.writeln('<meta http-equiv="refresh" content="0;URL='+ strUrl +'">');
	winname.document.close();
}
function Gi_winOpenScroll(strUrl) { //新开窗口
	var winname = window.open('Gi_newWin', "_blank", 'left=0,top=0,width=50,height=50,toolbar=no, menubar=yes, scrollbars=yes, location=no, status=yes, copyhistory=no ,directories=no');
	winname.document.open('text/html', 'replace');
	winname.document.writeln('<meta http-equiv="refresh" content="0;URL='+ strUrl +'">');
	winname.document.close();
}

var delCheck=false;
function Gi_delSubConfirm(strConfirm){//表单提交确认
	var delQus;
	delQus=confirm('确认要删除 ( '+strConfirm+' ) 么?');
	if (delQus==true){
		delCheck = true;
	}else{
		delCheck = false;
	}
}

//得到select下的value值
function Gi_getSelectID(formName,selectName,objName){
		if (document.forms(formName).elements(selectName).value!=''){
			document.forms(formName).elements(objName).value=document.forms(formName).elements(selectName).value;
		}
}

//层显示
function Gi_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=Gi_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}
function Gi_showHideLayers() { //v6.0
  var i,p,v,obj,args=Gi_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=Gi_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}
//-->