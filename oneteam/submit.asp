<%
dim server_v1,server_v2
server_v1=Cstr(Request.ServerVariables("HTTP_REFERER"))
server_v2=Cstr(Request.ServerVariables("SERVER_NAME"))
if server_v1="" or  mid(server_v1,8,len(server_v2))<>server_v2 then
response.write "<SCRIPT language=JavaScript>alert('来源非法，禁止外部提交！');"
response.write "location.href='index.asp';</SCRIPT>"
response.end
end if


%>
<!--#include file="include/consts1.asp"-->
<!--#include file="include/func.asp"-->
<%
company=htmlstr(request.form("company"))
address=htmlstr(request.form("address1"))
guojia=htmlstr(request.form("guojia"))
username=htmlstr(request.form("username"))
tel=htmlstr(request.form("telphone"))
email=htmlstr(request.form("email"))
market=htmlstr(request.form("market"))
content=htmlstr(request.form("content"))
iLanguage=1
idtree=".0.4."

if username<>"" and tel<>"" then

str="insert into feedback([company],[address],guojia,username,tel,[email],market,content,[iLanguage],idtree) values('"&company&"','"&address&"','"&guojia&"','"&username&"','"&tel&"','"&email&"','"&market&"','"&content&"',"&iLanguage&",'"&idtree&"')"
fInUpData(str)

	response.Write("<script language=javascript>alert('Successful !');location.href='quote.asp';</script>")

else
response.Write("<script language=javascript>alert('Erroe');history.back();</script>")
end if

	
%>