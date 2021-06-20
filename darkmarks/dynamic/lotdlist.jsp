<%@ page import="java.io.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<%@ page import="com.darkoaksoftware.darkmarks.*"%>
<jsp:useBean id="lotdcur" class="com.darkoaksoftware.utils.dataset.WriteBackDataCursor" scope="request" />
<%
	int max=999999;
	boolean odd=false;
	String lotdmax=request.getParameter("lotdmax"); 
	if (lotdmax!=null){
		max = Integer.parseInt(lotdmax);
		lotdcur.init("LOTD.tdb",Constants.getDbPath(application));			
		if(lotdcur.gotoFirst()){
		lotdcur.sortBy("MARK_ID",NumberFormat.getInstance(),ArrayComparator.DESC);
		String sLotdTitle ="Recent LOTD";
		session.putValue(sLotdTitle,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF='"+request.getRequestURI()+"?lotdmax=99999' style='font-size:smaller'>[all]</A>");
		%>
		<jsp:include page="catline.jsp"><jsp:param name='catname' value='<%=sLotdTitle%>'/> </jsp:include>
		<table width="98%" cellpadding="2"><%
		do	{
			if (--max<0) break;
			String sStyle=odd ? "ROWODD" : "ROWEVEN";
			odd=!odd;
			String sCommentCount = (String)lotdcur.getProperty("COMMENT_COUNT");		
			%>
			<tr class="<%=sStyle%>"></td><IMG SRC="../images/clear.gif" height=5><BR>&nbsp;<A TARGET="_blank" HREF='<%=lotdcur.getProperty("URL")%>'><SPAN class="TITLELINE"><%=lotdcur.getProperty("TITLE")%></SPAN></A>
			&nbsp;<FONT class="DATELINE"><%=lotdcur.getProperty("DATE_ADDED")%></FONT><SPAN class="DESCLINE"><BR/>&nbsp;&nbsp;&nbsp;
				<%=lotdcur.getProperty("DESCRIPTION")%>&nbsp;<A HREF="homelotdcomm.jsp?lotdid=<%=lotdcur.getProperty("MARK_ID")%>" class="COMLINK">(<%=lotdcur.getProperty("COMMENT_COUNT")%>)</A><BR/><IMG SRC="../images/clear.gif" height=5></SPAN></td></tr>
			<%						
		}while (lotdcur.gotoNext());		
		%></table>
	<%}}%>