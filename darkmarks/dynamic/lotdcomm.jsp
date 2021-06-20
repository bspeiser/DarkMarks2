<%@ page import="java.io.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<%@ page import="com.darkoaksoftware.utils.*"%>
<%@ page import="com.darkoaksoftware.darkmarks.*"%>
<%if(!com.darkoaksoftware.darkmarks.User.checkUser(request,response,application,session)){%><jsp:forward page="homelogin.jsp"/><%}%>
<jsp:useBean id="lotdcur" class="com.darkoaksoftware.utils.dataset.WriteBackDataCursor" scope="request" />
<jsp:useBean id="lotdcomm" class="com.darkoaksoftware.utils.dataset.WriteBackDataCursor" scope="request" />
<%
  User u = (User)session.getValue(User.USER);
	boolean odd=false;
	String lotdid=request.getParameter("lotdid");
	String lotd_com_req=request.getParameter("lotdcom");
	lotd_com_req=StringUtils.defaultNill(lotd_com_req,"");
	String lotd_com_post=request.getParameter("lotdcomp");
	String sCommentReq="";
	if (lotdid!=null){
		lotdcur.init("LOTD.tdb",Constants.getDbPath(application));			
		lotdcomm.init("LOTD_COMM.tdb",Constants.getDbPath(application));					
		lotdcur.selectEquals("MARK_ID",lotdid);

		if(request.getMethod().equals("POST")){
		  if(StringUtils.isNill(lotd_com_post)){
		    lotdcomm.insertRow();
		   }else{
		    lotdcomm.selectEquals("COMM_ID",lotd_com_post);
		   }
		  String sComment = request.getParameter("COMMENT");
		  sComment=StringUtils.escapeForHtml(sComment);
		  sComment=StringUtils.replace(sComment,"\n","<BR>");
      sComment=StringUtils.replace(sComment,"\r","");
		  lotdcomm.setProperty("COMMENT",sComment);
		  lotdcomm.setProperty("MARK_ID",lotdid);
		  
		  lotdcomm.setProperty("USER",u.getUserName());
		  lotdcomm.commit();
		  if(lotdcur.gotoFirst()&&StringUtils.isNill(lotd_com_post)){
		    String sCount=(String)lotdcur.getProperty("COMMENT_COUNT");
		    int iCount = StringUtils.parseInt(sCount,0);
		    iCount++;
		    lotdcur.setProperty("COMMENT_COUNT",""+iCount);
		    lotdcur.commit();
		  }		  
		}else if(!"".equals(lotd_com_req)){
	    lotdcomm.selectEquals("COMM_ID",lotd_com_req);
	    if(lotdcomm.gotoFirst()){	    
	      sCommentReq=(String)lotdcomm.getProperty("COMMENT");
	      sCommentReq=StringUtils.replace(sCommentReq,"<BR>","\n");
      }	       
		}
		lotdcomm.refreshRows(); 
		lotdcomm.selectEquals("MARK_ID",lotdid);
		
		
		if(lotdcur.gotoFirst()){
		String sLotdTitle ="LOTD Comments";
		session.putValue(sLotdTitle,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
		%>
		<jsp:include page="catline.jsp"><jsp:param name='catname' value='<%=sLotdTitle%>'/> </jsp:include>
		<table width="98%" cellpadding="2">
		<tr class="ROWEVEN"></td><IMG SRC="../images/clear.gif" height=5><BR>&nbsp;<A TARGET="_blank" HREF='<%=lotdcur.getProperty("URL")%>'><SPAN class="TITLELINE"><%=lotdcur.getProperty("TITLE")%></SPAN></A>
		&nbsp;<FONT class="DATELINE"><%=lotdcur.getProperty("DATE_ADDED")%></FONT>&nbsp;<A HREF='homelotd.jsp?lotdid=<%=lotdid%>'><SPAN class="EDITLINK">[Edit]</SPAN></A><SPAN class="DESCLINE"><BR/>&nbsp;&nbsp;&nbsp;
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
		    <TR CLASS=COMLINE><TD>(<%		    
		    boolean bThisUser=u.getUserName().equals(lotdcomm.getProperty("USER"));
		    if(bThisUser){
		      out.print("<A HREF='"+
		        request.getRequestURI()+
		        "?lotdid="+
		        lotdid+
		        "&lotdcom="+
		        lotdcomm.getProperty("COMM_ID")+
		        "'>");
		    }
		    out.print(lotdcomm.getProperty("COMM_ID"));
		    if(bThisUser){out.print("</A>");}
		    %>) <%=lotdcomm.getProperty("USER")%> wrote on <%=lotdcomm.getProperty("DATE_ADDED")%>
		    </TD></TR>
		    <TR><TD class=DESCLINE><%=HtmlConverter.convTags((String)lotdcomm.getProperty("COMMENT"))%> 
		    </TD></TR>
		  <%}while(lotdcomm.gotoNext());%>
		  </table>

	<%}%>
		<FORM METHOD=POST ACTION=<%=request.getRequestURI()%>>
    <INPUT TYPE=HIDDEN NAME="lotdid" VALUE="<%=lotdid%>">
    <INPUT TYPE=HIDDEN NAME="lotdcomp" VALUE="<%=lotd_com_req%>">
    <TEXTAREA NAME="COMMENT" COLS=60 rows=3><%=sCommentReq%></TEXTAREA><BR>
    <INPUT TYPE=SUBMIT NAME="btn" VALUE="Add Comment">
    </FORM>
	
	<%}%>
	<%}%>
	<SPAN style="font-size:10px">To embed an Image: <span style="font-size:10px;font-family:monospace;color:#CCCC99">||IMG=http://www.domain.com/myimg.gif||</span>
	<BR>To embed an link: <SPAN style="font-size:10px;font-family:monospace;color:#CCCC99">||LINK=http://www.domain.com/mylink.html||</SPAN><BR>
  No spaces allowed.
	</SPAN>