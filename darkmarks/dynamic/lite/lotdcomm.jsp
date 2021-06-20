<%@ include file="../code/lotdcomm.jsp"%>
<HTML><TITLE>DarkMarks2 Lite</TITLE>
<LINK REL=STYLESHEET HREF="s.css" media="screen" TYPE="text/css">
<BODY BGCOLOR="#000000" leftmargin=0 rightmargin=0 marginwidth=0 marginheight=0 topmargin=0 >		
<%@ include file="top.jsp"%>
		<jsp:include page="catline.jsp"><jsp:param name='catname' value='<%=sLotdTitle%>'/> </jsp:include>
		<table width="98%" cellpadding="2">
		<tr class="ROWEVEN"></td><IMG SRC="../images/clear.gif" height=5><BR>&nbsp;<A TARGET="_blank" HREF='<%=lotdcur.getProperty("URL")%>'><SPAN class="TITLELINE"><%=lotdcur.getProperty("TITLE")%></SPAN></A>
		&nbsp;<FONT class="DATELINE"><%=lotdcur.getProperty("DATE_ADDED")%></FONT><SPAN class="DESCLINE"><BR/>&nbsp;&nbsp;&nbsp;
			<%=lotdcur.getProperty("DESCRIPTION")%><BR/><IMG SRC="../images/clear.gif" height=5></SPAN></td></tr>		
		</table>
		<%
		  if(lotdcomm.gotoFirst()){
		  %> 
		  <table width="98%" cellpadding="2">
		  <%do{
   			String sStyle=odd ? "ROWODD" : "ROWEVEN";
	  		odd=!odd;
		  %>		  
		    <TR CLASS=COMLINE><TD><%=lotdcomm.getProperty("USER")%> wrote on <%=lotdcomm.getProperty("DATE_ADDED")%>
		    </TD></TR>
		    <TR><TD class=COMLINK><%=lotdcomm.getProperty("COMMENT")%> 
		    </TD></TR>
		  <%}while(lotdcomm.gotoNext());%>
		  </table>

	<%}%>
		<FORM METHOD=POST ACTION=<%=request.getRequestURI()%>>
    <INPUT TYPE=HIDDEN NAME="lotd" VALUE="<%=lotdid%>">
    <TEXTAREA NAME="COMMENT"  rows=2 style="width:190"></TEXTAREA><BR>
    <INPUT TYPE=SUBMIT NAME="btn" VALUE="Add Comment" CLASS=TOOLTEXT>
    </FORM>
	
	<%}%>
	<%}%>