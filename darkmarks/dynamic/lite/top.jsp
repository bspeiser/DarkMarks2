<%
String s=request.getParameter("SEARCH");
if (s==null) s="";
String sParam=request.getParameter("smain");
String sCatPath="../catlist.jsp";
String sToolPath=sParam;
if (sParam==null) {
  sParam="."; 
  sToolPath="..";
}else{
 sToolPath=".";
}
  
%><table border=0 cellspacing=0 cellpadding=0><tr class=TOOLLINK><td ><A HREF="<%=sParam%>/home.jsp"><SPAN  style="color:#000000;background-color:#FFCF63;border-style:outset;border-width:2px">DM2&nbsp;</span></A>&nbsp;</td><td><FORM METHOD="GET"  style="margin-bottom:0;margin-top:0" valign=top action="<%=sParam%>/home.jsp"><SPAN class='HDRITEM'><INPUT TYPE=TEXT SIZE=6 NAME="SEARCH" VALUE="<%=s%>" class=TOOLTEXT><INPUT TYPE="SUBMIT"  VALUE="Search" class=TOOLTEXT></SPAN></FORM></td><td>&nbsp;</td><td>&nbsp<A HREF="<%=sToolPath%>/litetoolbar.jsp">Tools</A></td></tr> 
<TR><TD colspan=3><FORM METHOD="GET"  style="margin-bottom:0;margin-top:0" valign=top action="<%=sParam%>/home.jsp"><jsp:include page="<%=sCatPath%>"/><INPUT TYPE="SUBMIT"  VALUE="go" class=TOOLTEXT> 
</TD></TR></table>
