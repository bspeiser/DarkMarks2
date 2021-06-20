<%@ page buffer = "1028kb"%> 
<%if(!com.darkoaksoftware.darkmarks.User.checkUser(request,response,application,session)){%><jsp:forward page="homelogin.jsp"/><%}%>
<HTML>
<HEAD><jsp:include page="opennotescript.jsp"/></HEAD>
<TITLE>DarkMarks2</TITLE>
<LINK REL=STYLESHEET HREF="../images/s.css" media="screen" TYPE="text/css">
<BODY BGCOLOR="#000000" leftmargin=0 rightmargin=0 marginwidth=0 marginheight=0 topmargin=0 >
<TABLE border=0 cellspacing=0 cellpadding=0 width="100%">
<TR>
	<TD width=129 valign=center>
		<jsp:include page="logo.jsp"/>		
	</TD><TD width=3><IMG SRC="../images/clear.gif" align=left width=3></TD>
	<TD width="*" valign=top colspan=2><jsp:include page="toplinks.jsp"/>
	</TD>
	</TR> 
	<TR><TD BGCOLOR=#FFCC66 colspan=4><IMG SRC="../images/clear.gif" align=left></td></tr>
	<TR><TD BGCOLOR=#CC9933 colspan=4><IMG SRC="../images/clear.gif" align=left></td></tr>
	</TABLE><TABLE>
	<TR>
	<TD valign=top ><jsp:include page="leftnav.jsp"/>
	</TD><TD>&nbsp</TD>
	<TD width="100%" height="*" valign=top><TABLE CELLSPACING=0 CELLPADDING=0><TR><TD><IMG SRC="../images/clear.gif" align=left width=3></TD></TR></TABLE>
		<jsp:include page="search.jsp"/>
	</TD><TD width=70 align=right valign=top><jsp:include page="tools/toolbar.jsp"/></TD>
	</TR>
</TABLE>
</BODY>
</HTML><%response.flushBuffer();%>
