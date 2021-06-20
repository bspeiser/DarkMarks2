<%@include file="../code/login.jsp"%>
<HTML><TITLE>DarkMarks2 Lite</TITLE><FORM METHOD=POST ACTION=<%=request.getRequestURI()%>><H3>Sign In</H3>&nbsp;Name: <INPUT TYPE=TEXT NAME="NAME" VALUE=""><BR>&nbsp;Password:<INPUT TYPE=PASSWORD NAME="PASSWORD" VALUE=""><BR><font class="ERRORTXT"><%=sError%></font><INPUT TYPE="SUBMIT" Name="LOGIN" VALUE="Sign In"></FORM></html>
