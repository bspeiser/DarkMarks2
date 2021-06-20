<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<%@ page import="com.darkoaksoftware.darkmarks.*"%>
<jsp:useBean id="mcur" class="com.darkoaksoftware.utils.dataset.WriteBackDataCursor" scope="request" />
<%
	int max=999999;
	boolean odd=false;
	HashMap hmNotes = Note.getUserNoteMap(request,application,session);
	%><table width="98%" cellpadding="2"><%
	do	{
		if (--max<0) break;
		String sStyle=odd ? "ROWODD" : "ROWEVEN";
		odd=!odd;
		%><tr class="<%=sStyle%>"></td><%
		%><IMG SRC="../images/clear.gif" height=2><BR><%
		%>&nbsp;<A TARGET="_blank" HREF='<%=mcur.getProperty("URL")%>'><%
			%><SPAN class="TITLELINE"><%=mcur.getProperty("TITLE")%></SPAN><%
			 if (null!=hmNotes.get(mcur.getProperty("MARK_ID"))){
			%><A HREF='javascript:openNote(<%=mcur.getProperty("MARK_ID")%>)'><IMG SRC='../images/noteicon.gif' BORDER=0></A><%				
			}			
		%></A>&nbsp;<%
		%><A HREF='homeedit.jsp?MID=<%=mcur.getProperty("MARK_ID")%>'><%
			%><SPAN class="EDITLINK">[Edit]</SPAN><%
		%></A><%
		
		%>&nbsp;<FONT class="DATELINE"><%=mcur.getProperty("DATE_ADDED")%><%
		%></FONT><SPAN class="DESCLINE"><BR/>&nbsp;&nbsp;&nbsp;<%
			%><%=mcur.getProperty("DESCRIPTION")%><BR/><IMG SRC="../images/clear.gif" height=2></SPAN></td></tr><%							
	}while (mcur.gotoNext());		
	%></table>