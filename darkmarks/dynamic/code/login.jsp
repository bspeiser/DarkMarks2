<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<%@ page import="com.darkoaksoftware.darkmarks.*"%>
<%@ page import="com.darkoaksoftware.utils.*"%>
<%	WriteBackDataCursor userdb = new WriteBackDataCursor();
	String sError="";
	userdb.init("USERS.tdb",Constants.getDbPath(application));	
	if(request.getMethod().equals("GET")){
	}else{
		User u = User.getUserByName(request.getParameter("NAME"),userdb);
		if (u==null){
			sError = "User Not Found!";
		}else{
			if(!u.checkPass(request.getParameter("PASSWORD"))){
				sError = "Password does not match!";
			}else{
				session.setAttribute(User.USER,u);
				Cookie c = new Cookie("mc",u.getCookie());
				c.setMaxAge(CookieJar.AGE_YEAR);
				response.addCookie(c);
				%><jsp:forward page="home.jsp"/><%
			}			
		}	
	}
%>
