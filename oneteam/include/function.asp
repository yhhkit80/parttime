<%
function redate(date1)
	time0=year(date1)
	times1=month(date1)
	times2=day(date1)
	if len(times1)=1 then times1="0"&times1
	if len(times2)=1 then times2="0"&times2
	redate=time0&"."&times1&"."&times2
end function

function imgurl(url)
	if url<>"" then
		url=replace(url,"../","")
	end if
	imgurl=url
end function

'''''类别名称
function tp_name(idtree)
	set rs_type=fGetRsList("select * from hs_infoType where tptree='"&idtree&"'")
	if rs_type.recordcount>=1 then
		tp_name=rs_type("tpname")
	end if
	rs_type.close
	set rs_type=nothing
end function

''''''''''图片
function tp_img(idtree)
	set rs_type=fGetRsList("select * from hs_infoType where tptree='"&idtree&"'")
	if rs_type.recordcount>=1 then
		tp_img=rs_type("tpimage")
	end if
	rs_type.close
	set rs_type=nothing
end function


'''''上级类别名称
function tpparent_name(idtree)
	set rs_type=fGetRsList("select tpname from hs_infoType where tpid in (select tpparent from hs_infotype where tptree='"&idtree&"')")
	if rs_type.recordcount>=1 then
		tpparent_name=rs_type("tpname")
	end if
	rs_type.close
	set rs_type=nothing
end function

''''''''''显示网页内容
function show_content(idtree)
	set rs=fGetRsList("select top 1 content from hs_info where idtree='"&idtree&"' order by pxid desc, releasedate desc,id desc")
	if rs.recordcount>=1 then show_content=rs("content")
	rs.close
	set rs=nothing
end function

%>