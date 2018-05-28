 <%
Response.Buffer = True
With Response
.Expires = -1
.AddHeader "Pragma","no-cache"
.AddHeader "cache-ctrol","no-cache"
End With
Dim a(10,10)
a(0,1) = "0x3c" '数字0
a(0,2) = "0x66"
a(0,3) = "0xc3"
a(0,4) = "0xc3"
a(0,5) = "0xc3"
a(0,6) = "0xc3"
a(0,7) = "0xc3"
a(0,8) = "0xc3"
a(0,9) = "0x66"
a(0,10)= "0x3c"

a(1,1) = "0x18" '数字1
a(1,2) = "0x1c"
a(1,3) = "0x18"
a(1,4) = "0x18"
a(1,5) = "0x18"
a(1,6) = "0x18"
a(1,7) = "0x18"
a(1,8) = "0x18"
a(1,9) = "0x18"
a(0,10)= "0x7e"

a(2,1) = "0x3c" '数字2
a(2,2) = "0x66"
a(2,3) = "0x60"
a(2,4) = "0x60"
a(2,5) = "0x30"
a(2,6) = "0x18"
a(2,7) = "0x0c"
a(2,8) = "0x06"
a(2,9) = "0x06"
a(2,10)= "0x7e"

a(3,1) = "0x3c" '数字3
a(3,2) = "0x66"
a(3,3) = "0xc0"
a(3,4) = "0x60"
a(3,5) = "0x1c"
a(3,6) = "0x60"
a(3,7) = "0xc0"
a(3,8) = "0xc0"
a(3,9) = "0x66"
a(3,10)= "0x38"

a(4,1) = "0x38" '数字4
a(4,2) = "0x3c"
a(4,3) = "0x36"
a(4,4) = "0x33"
a(4,5) = "0x33"
a(4,6) = "0x33"
a(4,7) = "0xff"
a(4,8) = "0x30"
a(4,9) = "0x30"
a(4,10)= "0xfe"

a(5,1) = "0xfe" '数字5
a(5,2) = "0xfe"
a(5,3) = "0x06"
a(5,4) = "0x06"
a(5,5) = "0x3e"
a(5,6) = "0x60"
a(5,7) = "0xc0"
a(5,8) = "0xc3"
a(5,9) = "0x66"
a(5,10)= "0x3c"

a(6,1) = "0x60" '数字6
a(6,2) = "0x30"
a(6,3) = "0x18"
a(6,4) = "0x0c"
a(6,5) = "0x3e"
a(6,6) = "0x63"
a(6,7) = "0xc3"
a(6,8) = "0xc3"
a(6,9) = "0x66"
a(6,10) ="0x3c"

a(7,1) = "0xff" '数字7
a(7,2) = "0xc0"
a(7,3) = "0x60"
a(7,4) = "0x30"
a(7,5) = "0x18"
a(7,6) = "0x18"
a(7,7) = "0x18"
a(7,8) = "0x18"
a(7,9) = "0x18"
a(7,10)= "0x18"

a(8,1) = "0x3c" '数字8
a(8,2) = "0x66"
a(8,3) = "0xc3"
a(8,4) = "0x66"
a(8,5) = "0x3c"
a(8,6) = "0x66"
a(8,7) = "0xc3"
a(8,8) = "0xc3"
a(8,9) = "0x66"
a(8,10)= "0x3c"

a(9,1) = "0x3c" '数字9
a(9,2) = "0x66"
a(9,3) = "0xc3"
a(9,4) = "0xc3"
a(9,5) = "0x66"
a(9,6) = "0x3c"
a(9,7) = "0x18"
a(9,8) = "0x0c"
a(9,9) = "0x06"
a(9,10)= "0x03"
Dim num
Randomize
num = Int(7999 * Rnd + 2000)
Session("adminid") = cint(num)
Dim Image
Dim Width, Height
Dim digtal
Dim Length
Dim sort
Dim hc
Length = 4 
hc = chr(13) & chr(10)
Redim sort(Length)
digital = ""
For I = 1 To Length - Len(num)
digital = digital & "0"
Next
For I = 1 To Len(num)
digital = digital & Mid(num, I, 1)
Next
For I = 1 To Len(digital)
sort(I) = Mid(digital, I, 1)
Next
Width = 8 * Len(digital)
Height = 10
Response.ContentType = "image/x-xbitmap"
Image = "#define counter_width " & Width & hc
Image = Image & "#define counter_height " & Height & hc
Image = Image & "static unsigned char counter_bits[] = {" & hc
For I = 1 To Height
For J = 1 To Length
Image = Image & a(sort(J),I) & ","
Next
Next
Image = Left(Image, Len(Image) - 1)
Image = Image & "};" & hc
Response.Write Image
%>
