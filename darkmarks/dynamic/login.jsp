<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<%@ page import="com.darkoaksoftware.darkmarks.*"%>
<%@ page import="com.darkoaksoftware.utils.*"%>
<%
	WriteBackDataCursor userdb = new WriteBackDataCursor();
	String sError="";
	userdb.init("USERS.tdb",Constants.getDbPath(application));	
	if(request.getMethod().equals("GET")){
	}else{
		User u = User.getUserByName(request.getParameter("NAME"),userdb);
		if (u==null)
		{
			sError = "User Not Found!";
		}
		else
		{

			if(!u.checkPass(request.getParameter("PASSWORD")))
			{
				sError = "Password does not match!";
			}
			else
			{
				session.setAttribute(User.USER,u);
				Cookie c = new Cookie("mc",u.getCookie());
				c.setMaxAge(CookieJar.AGE_YEAR);
				response.addCookie(c);
				%><jsp:forward page="home.jsp"/><%
			}			
		}	
	}

%>
<FORM METHOD=POST ACTION=<%=request.getRequestURI()%>>
<TABLE BORDER=1 cellpadding=3 cellspacing=0 bordercolor=#333333><TR><TD ALIGN=CENTER CLASS="FORMTITLE">Sign In
</TD></TR><TR><TD>
<TABLE BORDER=0 cellspacing=0 cellpadding=3>
	<tr>	
	<td align=right class="HDRITEM">
		Name: 
	</td>
	<td>
		<INPUT TYPE=TEXT NAME="NAME" VALUE="">
	</td>
	</tr><tr>
	<td align=right class="HDRITEM">
		Password: 
	</td>
	<td>		
		<INPUT TYPE=PASSWORD NAME="PASSWORD" VALUE="">
	</td>
	</tr><tr><td align=center class="ERRORTXT" colspan=2><%=sError%></td></tr>
	</TABLE>
	</TD></TR><TR colspan=2><TD align=center>
		<INPUT TYPE="SUBMIT" Name="LOGIN" VALUE="Sign In">&nbsp;&nbsp;
	</TD></TR></TABLE>

</FORM>
