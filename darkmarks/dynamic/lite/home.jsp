<%@ page buffer = "1028kb"%> 
<%if(!com.darkoaksoftware.darkmarks.User.checkUser(request,response,application,session)){%><jsp:forward page="homelogin.jsp"/><%}%>
<HTML><TITLE>DarkMarks2 Lite</TITLE>
<LINK REL=STYLESHEET HREF="s.css" media="screen" TYPE="text/css">
<BODY BGCOLOR="#000000" leftmargin=0 rightmargin=0 marginwidth=0 marginheight=0 topmargin=0 >
<%--<IMG SRC="..\..\images\200.gif" border=0 align=left hspace=0 vspace=0>--%><%@ include file="top.jsp"%>
<jsp:include page="search.jsp"/> 
</BODY>
</HTML><%response.flushBuffer();%>
 