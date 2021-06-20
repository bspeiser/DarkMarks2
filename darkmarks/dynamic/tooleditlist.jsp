<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<%@ page import="com.darkoaksoftware.darkmarks.*"%>
<%@ page import="com.darkoaksoftware.utils.*"%>
<%@ page import="java.util.*"%>
<%
HashMap hm = ToolBar.getAvailableTools(application);
Iterator it = hm.keySet().iterator();
%><TABLE BORDER=1 cellpadding=3 cellspacing=0 bordercolor=#333333><TR><TD ALIGN=CENTER CLASS="FORMTITLE">Choose Tool To Edit
</TD></TR><%

if (it.hasNext())do{
	String sTool= (String)it.next();
	%><TR><TD><A href='hometooledit.jsp?TOOL_NAME=<%=sTool%>'><%=sTool%></A></TD></TR><%
}while (it.hasNext());
%></TABLE>
