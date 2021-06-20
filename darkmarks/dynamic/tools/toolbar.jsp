<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<%@ page import="com.darkoaksoftware.darkmarks.*"%>
<%@ page import="com.darkoaksoftware.utils.*"%>
<%
User u = (User)session.getAttribute(User.USER);
String sUserName = u.getUserName();
String sTool=sUserName+"toolbar.jsp";
%>
<jsp:include page="<%=sTool%>"/>