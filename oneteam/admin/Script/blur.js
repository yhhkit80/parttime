<!--
function Gi_blurObj(){//���ض���ǩ�Ķ��󲻿��Ծ۽�  �������ӵ����߿�
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