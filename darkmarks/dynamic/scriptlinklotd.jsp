<%@ page import="java.net.*"%><%
String sUrl = request.getRequestURL().toString();
sUrl=sUrl.substring(0,sUrl.lastIndexOf("/"));
String sLink="a=escape(location.href);b=escape(document.title);c='"+
sUrl+"/homelotd.jsp?URL='+a+'&TITLE='+b+'&t=add';location.href=c";
%><A HREF="javascript:<%=sLink%>" class="EDITACTION">Add LOTD</A>