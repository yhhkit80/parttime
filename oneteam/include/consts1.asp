<%
'��ֹע��
Dim qs,errc,iii
qs=Request.Servervariables("query_string")
Dim deStr(18)
deStr(0)="net user"
deStr(1)="xp_cmdshell"
deStr(2)="/add"
deStr(3)="exec%20master.dbo.xp_cmdshell"
deStr(4)="net localgroup administrators"
deStr(5)="select"
deStr(6)="count"
deStr(7)="asc"
deStr(8)="char"
deStr(9)="mid"
deStr(10)="'"
deStr(11)=":"
deStr(12)=""""
deStr(13)="insert"
deStr(14)="delete"
deStr(15)="drop"
deStr(16)="truncate"
deStr(17)="from"
deStr(18)=";"
errc=False
For iii= 0 To Ubound(deStr)
   If Instr(qs,deStr(iii))<>0 Then
      errc=True
   End if
Next
If errc Then
    Response.Write("�Բ��𣬷Ƿ�URL��ַ����!")
    Response.End
End If
Session.CodePage = 936
Response.charset = "gb2312" 

'��˾��
Const cCompanyName = ""
Const SiteRoot = "\dep_b"

'���ݿ����
StrDBPrefix = "HS_"



StrConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&server.MapPath("include/#asdasdfasdxlklk0.mdb")

'�ָ�����(1)

Const cSeparator = "��"
Const cLinkSign = " --} "

'��������
Const cOptiLang = 1
Const cConfiLangType_01 = "����"
Const cConfiLangType_02 = "����"

'���������
Const MaxLevel = 2
'����Ƿ���leaf

'�õ���ֵǰ̨
Dim BGSecSon,FGSecSon,RndNum
Randomize
RndNum = Int(90000*Rnd)+10000
FGSecSon = Session.Contents("FGSecSon")
If FGSecSon = "" Then
Session.Contents("FGSecSon") = Server.URLEncode ( StrReverse( Request.Servervariables("HTTP_USER_AGENT") & Year(Now) & Month(Now) & Day(Now) & Hour(Now) & Minute(Now) & Second(Now) & RndNum ) )
End If

'��̨
BGSecSon = Session.Contents("BGSecSon")
If BGSecSon = "" Then
Session.Contents("BGSecSon") = Server.URLEncode ( StrReverse( Request.Servervariables("HTTP_USER_AGENT") & Year(Now) & Month(Now) & Day(Now) & Hour(Now) & Minute(Now) & Second(Now) & RndNum ) )
End If
%>
