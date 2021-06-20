<%if(!com.darkoaksoftware.darkmarks.User.checkUser(request,response,application,session)){%><jsp:forward page="homelogin.jsp"/><%}%>
<%@ page autoFlush = "false" %>
<%@ page buffer = "1028kb"%>
<HTML>
<TITLE>Add DarkMark</TITLE>
<LINK REL=STYLESHEET HREF="../images/s.css" media="screen" TYPE="text/css">
<BODY BGCOLOR="#000000" leftmargin=0 rightmargin=0 marginwidth=0 marginheight=0 topmargin=0 >
<TABLE border=0 cellspacing=0 cellpadding=0 width="100%">
<TR>
	<TD width=129 valign=center>
		<jsp:include page="logo.jsp"/>		
	</TD><TD>&nbsp</TD>
	<TD width="*" valign=top><jsp:include page="toplinks.jsp"/>
	</TD>
	</TR>
	<TR><TD BGCOLOR=#FFCC66 colspan=3><IMG SRC="../images/clear.gif" align=left></td></tr>
	<TR><TD BGCOLOR=#CC9933 colspan=3><IMG SRC="../images/clear.gif" align=left></td></tr>
	<TR>
	<TD valign=top ><jsp:include page="leftnav.jsp">
	<jsp:param name="home" value="home.jsp"/>
	</jsp:include>
	</TD><TD>&nbsp</TD>
	<TD width="*" height="*" valign=top align=left><BR>
		<jsp:include page="edit.jsp" flush="false"/>		
	</TD></TR></TABLE>
	</TD>
	</TR>
</TABLE>
</BODY>
</HTML><%response.flushBuffer();%>

