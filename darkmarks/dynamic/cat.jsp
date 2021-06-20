<%@ page import="java.io.*"%>
<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<jsp:useBean id="mcur" class="com.darkoaksoftware.utils.dataset.WriteBackDataCursor" scope="page" />
<jsp:useBean id="mcur2" class="com.darkoaksoftware.utils.dataset.WriteBackDataCursor" scope="page" />
<%
	
	mcur.init("CAT.tdb",Constants.getDbPath(application));	
	mcur2.init("CAT.tdb",Constants.getDbPath(application));	
	mcur.sortBy("NAME",ArrayComparator.ASC);
	mcur.selectEquals("PARENT_ID","0");	
	if (mcur.gotoFirst())do	{
		%><A HREF='<%=request.getRequestURI()%>?CID=<%=mcur.getProperty("CAT_ID")%>' CLASS='TOPCAT'><%="&amp;"StringUtils.escapeNbsForHtml(""+mcur.getProperty("NAME"))%></A><BR/><% 
		mcur2.refreshRows();
		mcur2.selectEquals("PARENT_ID",""+mcur.getProperty("CAT_ID"));
		if (mcur2.gotoFirst()){
			do{ 			
			%>&nbsp;&nbsp;&nbsp;<A HREF='<%=request.getRequestURI()%>?CID=<%=mcur2.getProperty("CAT_ID")%>' CLASS='SUBCAT'><%=StringUtils.escapeNbsForHtml(""+mcur2.getProperty("NAME"))%></A><BR/><%
			}while(mcur2.gotoNext());
		}
	}while (mcur.gotoNext());		
%>
