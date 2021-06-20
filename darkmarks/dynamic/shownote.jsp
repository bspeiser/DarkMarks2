<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<%@ page import="com.darkoaksoftware.darkmarks.*"%>
<%@ page import="com.darkoaksoftware.utils.*"%>
<jsp:include page="checkuser.jsp"/>
<LINK REL=STYLESHEET HREF="../images/s.css" media="screen" TYPE="text/css">
<HTML>
<TITLE>Note</TITLE>
<BODY BGCOLOR="#000000" leftmargin=0 rightmargin=0 marginwidth=0 marginheight=0 topmargin=0 >
<SPAN CLASS="NOTES">
<%
	String sNoteContent=Note.getNote(request,application,session);
	if (!StringUtils.isNill(sNoteContent)){
		%><%=sNoteContent=StringUtils.replace(sNoteContent,"\n","<BR/>")%><%
	}else{%>
		{No note}
	<%
	}	
%></SPAN></BODY></HTML><%response.flushBuffer();%>

