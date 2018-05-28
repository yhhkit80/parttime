<script language="javascript">

<!--
/****************************************************
Author:Chrothra.Chen@Globeidea.Group
E-Mail:Globeidea@msn.com
Date:2004.02
****************************************************/
function Gi_getFileUpLoad(formName,objName,getPath,getTName,delFileTag,delFile,resetFile,prevFile){//文件上传调用函数
	var nRes='enterUpLoad';
	var upLoadType='文件';
	rRes = Gi_getFileOpt(nRes,upLoadType,getPath,getTName);
	if(rRes){
		document.getElementById(delFileTag).style.display='block';
		document.forms(formName).elements(delFile).disabled='';
		document.forms(formName).elements(resetFile).disabled='';
		document.forms(formName).elements(prevFile).disabled='';
		document.forms(formName).elements(objName).value=rRes;
	}
}

function Gi_getImageUpLoad(formName,objName,getPath,getTName,delImageTag,delImage,resetImage,prevImage){//文件上传调用函数
	var nRes='enterUpLoad';
	var upLoadType='图片';
	rRes = Gi_getFileOpt(nRes,upLoadType,getPath,getTName);
	if(rRes){
		document.getElementById(delImageTag).style.display='block';
		document.forms(formName).elements(delImage).disabled='';
		document.forms(formName).elements(resetImage).disabled='';
		document.forms(formName).elements(prevImage).disabled='';
		document.forms(formName).elements(objName).value=rRes;
	}
}

function Gi_getIMGUpLoad(formName,objName,objShowName,getPath,getTName,delIMGTag,delIMG,resetIMG,prevIMG){//图片上传调用函数
	var nRes='enterUpLoad';
	var upLoadType='图片';
	rRes = Gi_getFileOpt(nRes,upLoadType,getPath,getTName);
	if(rRes){
		document.images(objShowName).src=rRes;
		document.images(objShowName).className='hand';	
		document.images(objShowName).outerHTML=document.images(objShowName).outerHTML.replace('>',' onClick="'+ prevIMG + rRes +'\');">');
		document.getElementById(delIMGTag).style.display='block';
		document.forms(formName).elements(delIMG).disabled='';
		document.forms(formName).elements(resetIMG).disabled='';
		document.forms(formName).elements(objName).value=rRes;
	}
}

function Gi_getFileOpt(nRes,upLoadType,getPath,getTName){//选择上传和库
	 if(nRes=='enterUpLoad'){
		rRes = showModalDialog(''+getPath+'OptIframeUpLoad.asp?UPTName='+getTName+'&UPType=<%=server.URLEncode("图片")%>', null, 'dialogWidth: 305px; dialogHeight: 220px; center: yes; resizable: no; scroll: no; status: no;');
		if (rRes=='enterUpLib'){
			Gi_getFileOpt(rRes,upLoadType,getPath,getTName);
		}
	}
	else if(nRes=='enterUpLib'){
		rRes = showModalDialog(''+getPath+'OptIframeUpLib.asp?UPTName='+getTName+'&UPType=<%=server.URLEncode("图片")%>', null, 'dialogWidth: 800px; dialogHeight: 455px; center: yes; resizable: no; scroll: no; status: no;');
		if (rRes=='enterUpLoad'){
			Gi_getFileOpt(rRes,upLoadType,getPath,getTName);
		}
	}
return rRes;
}

function Gi_openHtmlEditor(formName,objName,filePath,iframeH,getTName){//打开Html编辑器
	strHTML=document.forms(formName).elements(objName).value;  
	var wHead;
		wHead='<iframe ID="editor" NAME="editor" src = "'+filePath+'edit.html#'+getTName+'" style="width: 100%;height:'+iframeH+';display:none"></iframe>'
		+'<div id="switchDiv" style="padding: 0;margin: 0;width: 100%"><table border="0" cellspacing="0" cellpadding="0" width="100%" style="background-color:buttonface">'
		+'<tr><td id="status1" height="20"><map name="switch1">'
		+'<area onclick="Gi_switchStatus(2)" shape="polygon" coords="50, 1, 46, 7, 50, 14, 90, 14, 95, 2">'
		+'<area onclick="Gi_switchStatus(3)" shape="polygon" coords="128, 13, 134, 0, 96, 0, 93, 10, 96, 14">'
		+'</map><img src="'+filePath+'images/normal.gif" height="15" width="135" usemap="#switch1" border="0">'
		+'</td><td id="status2" height="20" style="display:none"><map name="switch2">'
		+'<area onclick="Gi_switchStatus(1)" shape="polygon" coords="5, 3, 12, 14, 43, 14, 49, 6, 43, 0">'
		+'<area onclick="Gi_switchStatus(3)" shape="polygon" coords="97, 0, 94, 7, 98, 14, 127, 14, 134, 0">'
		+'</map><img src="'+filePath+'images/html.gif" height="15" width="135" usemap="#switch2" border="0">'
		+'</td><td id="status3" height="20" style="display:none"><map name="switch3">'
		+'<area onclick="Gi_switchStatus(1)" shape="polygon" coords="3, 2, 10, 14, 41, 14, 50, 0">'
		+'<area onclick="Gi_switchStatus(2)" shape="polygon" coords="87, 14, 91, 5, 87, 0, 50, 0, 46, 9, 49, 14">'
		+'</map><img src="'+filePath+'images/preview.gif" height="15" width="135" usemap="#switch3" border="0"></td>'
		+'<td><img src="'+filePath+'images/scrolll.gif" height=15 width=24></td><td width="100%" style="background-color:white;filter:Alpha(opacity=50);">&nbsp; </td><td><img src="'+filePath+'images/scrollr.gif" height=15 width=24></td></tr></table></div>';
	document.write(wHead);
 }
function Gi_getHtmlContent(formName,objName){//提交时得到Html编辑中的内容
	document.forms(formName).elements(objName).value=editor.myEditor.textEdit.document.body.innerHTML;
}

function Gi_switchStatus(flag){
	document.frames.editor.frames.editStatus.swapModes(flag);
	for(var i=1;i<4;i++){
		document.all['status' + i].style.display='none';
	}
	document.all['status' + flag].style.display='block';
}
 //-->
 </script>