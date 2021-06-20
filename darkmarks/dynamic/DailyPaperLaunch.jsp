<%if(!com.darkoaksoftware.darkmarks.User.checkUser(request,response,application,session)){%><jsp:forward page="homelogin.jsp"/><%}%>
<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<%@ page import="com.darkoaksoftware.darkmarks.*"%>
<%@ page import="com.darkoaksoftware.utils.*"%>
<%@ page import="java.util.*"%>
<HTML>
<SCRIPT language='javascript'>

<%
User u = (User)session.getAttribute(User.USER);
WriteBackDataCursor mdp = new WriteBackDataCursor();
mdp.init("DAILY_PAPER.tdb",Constants.getDbPath(application));	
mdp.selectEquals("USER_ID",""+u.getUserId());
if (mdp.gotoFirst())do	{
	%>
	window.open('<%=mdp.getProperty("SITE_LOC")%>');
	<%
}while (mdp.gotoNext());
%>
//alert("launched");
history.go(-1);
</SCRIPT>
</HTML><%response.flushBuffer();%>