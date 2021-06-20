<%
String s=request.getParameter("SEARCH");
if (s==null) s="";
%><FORM METHOD="GET"  style="margin-bottom:0;margin-top:0" valign=top action="home.jsp"><SPAN class='HDRITEM'>Seach:<INPUT TYPE=TEXT SIZE=12 NAME="SEARCH" VALUE="<%=s%>" class=TOOLTEXT><INPUT TYPE="SUBMIT"  VALUE="Go" class=TOOLTEXT></SPAN></FORM>