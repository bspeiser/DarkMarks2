<%if(!com.darkoaksoftware.darkmarks.User.checkUser(request,response,application,session)){%><SCRIPT>self.close();
</SCRIPT><%}%>
<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<%@ page import="com.darkoaksoftware.darkmarks.*"%>
<%@ page import="com.darkoaksoftware.utils.*"%>
<%@ page import="java.util.*"%>
<%@ page autoFlush = "false" %>
<%@ page buffer = "1028kb"%>
<HTML>
<TITLE>Edit Daily Paper</TITLE>
<LINK REL=STYLESHEET HREF="../images/s.css" media="screen" TYPE="text/css">
<BODY BGCOLOR="#000000" leftmargin=0 rightmargin=0 marginwidth=0 marginheight=0 topmargin=0 >
<%

User u = (User)session.getAttribute(User.USER);
WriteBackDataCursor mdp = new WriteBackDataCursor();
mdp.init("DAILY_PAPER.tdb",Constants.getDbPath(application));	
System.out.println("test:"+u);
mdp.selectEquals("USER_ID",""+u.getUserId());

String sFormBox=StringUtils.defaultNill(request.getParameter("DAILY_PAPER"),"").trim();
StringBuffer sb = new StringBuffer();
if(request.getMethod().equals("GET")){
	if (mdp.gotoFirst())do	{
		sb.append(mdp.getProperty("SITE_LOC")+"\n");
	}while (mdp.gotoNext());
}else  {
  if(null!=request.getParameter("Update")){
	while(mdp.gotoFirst()){
		mdp.delete();
	}
	String [] sa = StringUtils.splitA(sFormBox,'\n');
	for(int ii=0;ii<sa.length;ii++){
		mdp.insertRow();
		mdp.setProperty("USER_ID",""+u.getUserId());
		String sUrl=sa[ii];
		sUrl=sUrl.trim();
		if (!sUrl.toLowerCase().startsWith("http://")) {
			sUrl="http://"+sUrl;
		}
		mdp.setProperty("SITE_LOC",sUrl);			
	}	
	mdp.commit();}
	%><SCRIPT>self.close();
	</SCRIPT><%
}%>
<FORM METHOD=POST ACTION=<%=request.getRequestURI()%>>
	<TABLE><TR><TD>Enter one url per line.
	</TD></TR>	
	<TR><TD>	
	<TEXTAREA name="DAILY_PAPER" cols=60 rows=20><%=sb.toString()%></TEXTAREA><BR>
	</TD></TR><TR><TD align=center>
	<INPUT TYPE="SUBMIT" Name="Update" VALUE="Update">&nbsp;&nbsp;&nbsp;
	<INPUT TYPE="BUTTON" Name="Cancel" VALUE="Cancel" onclick='self.close()'>
	</TD></TR>
	</TABLE>	
</FORM>
</BODY>
</HTML><%response.flushBuffer();%>	
	