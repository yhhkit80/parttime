<!--
function Gi_blurObj(){//让特定标签的对象不可以聚焦  消除链接的虚线框
TypeNo=new  Array("IMG","A","BUTTON","TD","TR","INPUT");
for(i=0;i<TypeNo.length;i++){
	var  AList=document.all.tags(TypeNo[i]);
		for(j=0;j<AList.length;j++){
			if (AList[j].tagName=="INPUT"){		
				if (AList[j].type=="text"||AList[j].type=="password"){
					//alert("d");
					//AList[j].attachEvent("onfocus",AList[j].blur);
				}else{
					AList[j].attachEvent("onfocus",AList[j].blur);
				}
			}else{
				AList[j].attachEvent("onfocus",AList[j].blur);
			}
		}
	}
}
window.onload=Gi_blurObj;
//-->