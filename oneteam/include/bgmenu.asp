<!-- #include file="consts.asp" -->
<script language="JavaScript">
<!--
<%
RF = Session("flag")
mName = ""
If InStr(RF,"|1|") > 0 Then mName = mName & "###{վ���ۺ�}����"
If InStr(RF,"|2|") > 0 Then mName = mName & "###{��̨�ʺ�}����"
If InStr(RF,"|3|") > 0 Then mName = mName & "###{ABOUT US}����"
If InStr(RF,"|4|") > 0 Then mName = mName & "###{PRODUCTS LIST}����"
If InStr(RF,"|5|") > 0 Then mName = mName & "###{QUALIFICATION}����"
If InStr(RF,"|6|") > 0 Then mName = mName & "###{QUOTE}����"
If InStr(RF,"|7|") > 0 Then mName = mName & "###{CONTACT US}����"


smName = ""
If InStr(RF,"|1|") > 0 Then smName = smName & "### + վ������ + �� �� վ"
If InStr(RF,"|2|") > 0 Then smName = smName & "### + �ʺ��б����"
If InStr(RF,"|3|") > 0 Then smName = smName & "### + ABOUT US"
If InStr(RF,"|4|") > 0 Then smName = smName & "### + PRODUCTS LIST"
If InStr(RF,"|5|") > 0 Then smName = smName & "### + QUALIFICATION"
If InStr(RF,"|6|") > 0 Then smName = smName & "### + QUOTE"
If InStr(RF,"|7|") > 0 Then smName = smName & "### + CONTACT US"



smLinks = ""
If InStr(RF,"|1|") > 0 Then smLinks = smLinks & "###Module@Type/typeList.asp��Module@Recy/info_list.asp"
If InStr(RF,"|2|") > 0 Then smLinks = smLinks & "###Admin/AdminList.asp"
If InStr(RF,"|3|") > 0 Then smLinks = smLinks & "###Module@about/info_list.asp"
If InStr(RF,"|4|") > 0 Then smLinks = smLinks & "###Module@prod/info_list.asp"
If InStr(RF,"|5|") > 0 Then smLinks = smLinks & "###Module@pic/info_list.asp"
If InStr(RF,"|6|") > 0 Then smLinks = smLinks & "###Module@feedback/info_list.asp"
If InStr(RF,"|7|") > 0 Then smLinks = smLinks & "###Module@contact/info_list.asp"

Session("mName") = mName
Arr_mName   = Split(mName,"###")
Cot_mName   = Ubound(Arr_mName)
Arr_smName  = Split(smName,"###")
Cot_smName  = Ubound(Arr_smName)
Arr_smLinks = Split(smLinks,"###")
Cot_smLinks = Ubound(Arr_smLinks)
%>
var mNameArray = new Array();
<%For I = 1 To Cot_mName%>mNameArray[<%=I-1%>] = "<%=Arr_mName(I)%>";
<%Next%>

var smNameArray = new Array();
<%For I = 1 To Cot_mName%>smNameArray[<%=I-1%>] = "<%=Arr_smName(I)%>";
<%Next%>

var smLinksArray = new Array();
<%For I = 1 To Cot_mName%>smLinksArray[<%=I-1%>] = "<%=Arr_smLinks(I)%>";
<%Next%>

//�������
var KeyWords = new Array();
//һ����Ŀ��
var mName = new Array();
//������Ŀ�� 2 ά����
var smName = new Array();
//������Ŀ����
var smLinks = new Array();
//ѭ��
for (var j=0;j<mNameArray.length;j++){	
	KeyWords[j]	= ""+mNameArray[j].split("<% = cSeparator %>")[1]+"";	
	mName[j] = ""+mNameArray[j].split("<% = cSeparator %>")[0]+"";	
	smName[j]=[];	
	smLinks[j]=[];
	for (var z=0;z<smNameArray[j].split("<% = cSeparator %>").length;z++){
		smName[j][z]=""+smNameArray[j].split("<% = cSeparator %>")[z]+"";
		smLinks[j][z]=""+smLinksArray[j].split("<% = cSeparator %>")[z]+"";
	}	
}


//�̶���Ŀ
var iKeyWords = new Array();
iKeyWords[0] = "chgPass";
iKeyWords[1] = "logOUt";

var imName = new Array();
imName[0] = "�޸�����";
imName[1] = "�˳�ϵͳ";

var imLinks = new Array();
imLinks[0] = "changepassword.asp";
imLinks[1] = "logout.asp";


var lastObj , lastObj_pic , lastObj_class , lastObj_2_class
function Gi_expandObj(obj){
			if(obj.style.display=="none"){
				obj.style.display="block";
			} else {
				obj.style.display="none"
			}
}
function Gi_getFMClassName(obj_class) {
	if (lastObj_class != null) {
		if (obj_class == lastObj_class) {
			obj_class.className="sys-toppane-selection sys-link-normal";
		} else {
			obj_class.className="sys-toppane-selection sys-link-normal";
			lastObj_class.className="sys-link-normal";	
			if (lastObj != null) {
				lastObj.style.display="none"
				lastObj_pic.src="images/collapsed.gif";
				if (lastObj_2_class != null){
					lastObj_2_class.className="sys-link-normal";
				}
			} 
		}
	} else {
		obj_class.className="sys-toppane-selection sys-link-normal";
	}
	lastObj_class=obj_class;
	lastObj = null
}

function Gi_getSMClassName(obj_2_class) {
	if (lastObj_2_class != null) {
		if (obj_2_class == lastObj_2_class) {
			obj_2_class.className="sys-toppane-selection-s sys-link-normal";
		} else {
			lastObj_2_class.className="sys-link-normal";
			obj_2_class.className="sys-toppane-selection-s sys-link-normal";
		}
	} else {
		obj_2_class.className="sys-toppane-selection-s sys-link-normal";
	}
	lastObj_2_class=obj_2_class;
}
//-->
</script>