<%@ page import="com.darkoaksoftware.darkmarks.*"%>
<%
session.removeAttribute(User.USER);
session.invalidate();
Cookie mc= new Cookie("mc","-1");
mc.setMaxAge(0);
response.addCookie(mc);
	%><jsp:forward page="homelogin.jsp"/>
