<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<%@ page import="com.darkoaksoftware.darkmarks.*"%>
<%@ page import="com.darkoaksoftware.utils.*"%>
<%
WriteBackDataCursor ec = new WriteBackDataCursor();
ec.init("USERS.tdb",Constants.getDbPath(application));	
CookieJar cj = new CookieJar(request);
Cookie c = (Cookie)cj.get("mc");
System.out.println(cj);
User u = (User)session.getAttribute(User.USER);
if (c!=null){	
	System.out.println("Cookie:"+c);
	u = User.getUserByCookie(c.getValue(),ec);
	System.out.println("User:"+u);
	if (u!=null) {
		session.setAttribute(User.USER,u);
	}
}
if (u==null) {
	%><jsp:forward page="homelogin.jsp"/><%
}else {
	Cookie c2 = new Cookie("mc",u.getCookie());
	c2.setMaxAge(CookieJar.AGE_YEAR);
	c2.setPath("/darkmarks");
	response.addCookie(c2);
	System.out.println(u);
}
%>