<%@ page import="java.io.*"%>
<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<%@ page import="com.darkoaksoftware.utils.*"%>
<%@ page import="com.darkoaksoftware.darkmarks.*"%>
<jsp:useBean id="mcur" class="com.darkoaksoftware.utils.dataset.WriteBackDataCursor" scope="page" />
<jsp:useBean id="mcur2" class="com.darkoaksoftware.utils.dataset.WriteBackDataCursor" scope="page" />
<TABLE cellspacing=1 cellpadding=0 border=0 BGCOLOR=#333333><%	
	mcur.init("CAT.tdb",Constants.getDbPath(application));	
	mcur2.init("CAT.tdb",Constants.getDbPath(application));	
	mcur.sortBy("NAME",ArrayComparator.ASC);
	mcur.selectEquals("PARENT_ID","0");	
	String sHome=request.getParameter("home");
	if (sHome==null) sHome=request.getRequestURI();
	if (mcur.gotoFirst())do	{
		%><TR><TD BGCOLOR=#000000><IMG SRC="../images/goldarrow.gif" align="middle"/><IMG src="../images/clear.gif" width=5><A HREF='<%=sHome%>?CID=<%=mcur.getProperty("CAT_ID")%>' CLASS='TOPCAT'><%= StringUtils.escapeNbsForHtml(""+mcur.getProperty("NAME"))%></A></TD></TR><%
		mcur2.refreshRows();
		mcur2.selectEquals("PARENT_ID",""+mcur.getProperty("CAT_ID"));
		if (mcur2.gotoFirst()){
			do{ 
			%><TR><TD BGCOLOR=#000000><IMG SRC="../images/clear.gif" width=10><IMG SRC="../images/golddot.gif" align="middle"/><A HREF='<%=sHome%>?CID=<%=mcur2.getProperty("CAT_ID")%>' CLASS='SUBCAT'><%=StringUtils.escapeNbsForHtml(""+mcur2.getProperty("NAME"))%></A></TD></TR><%
			}while(mcur2.gotoNext());
		}
	}while (mcur.gotoNext());		
	
%></TABLE>
