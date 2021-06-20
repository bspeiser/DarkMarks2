<%@ page import="java.io.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<%@ page import="com.darkoaksoftware.utils.*"%>
<%@ page import="com.darkoaksoftware.darkmarks.*"%>
<%if(!com.darkoaksoftware.darkmarks.User.checkUser(request,response,application,session)){%><jsp:forward page="homelogin.jsp"/><%}%>
<jsp:useBean id="lotdcur" class="com.darkoaksoftware.utils.dataset.WriteBackDataCursor" scope="request" />
<jsp:useBean id="lotdcomm" class="com.darkoaksoftware.utils.dataset.WriteBackDataCursor" scope="request" />

<%
	boolean odd=false;
	String lotdid=request.getParameter("lotd");
	if (lotdid!=null){
		lotdcur.init("LOTD.tdb",Constants.getDbPath(application));			
		lotdcomm.init("LOTD_COMM.tdb",Constants.getDbPath(application));					
		lotdcur.selectEquals("MARK_ID",lotdid);
		if(request.getMethod().equals("POST")){
		  lotdcomm.insertRow();
		  String sComment = request.getParameter("COMMENT");
		  sComment=StringUtils.escapeForHtml(sComment);
		  sComment=StringUtils.replace(sComment,"\n","<BR>");
      sComment=StringUtils.replace(sComment,"\r","");
		  lotdcomm.setProperty("COMMENT",sComment);
		  lotdcomm.setProperty("MARK_ID",lotdid);
		  User u = (User)session.getValue(User.USER);
		  lotdcomm.setProperty("USER",u.getUserName());
		  lotdcomm.commit();
		  if(lotdcur.gotoFirst()){
		    String sCount=(String)lotdcur.getProperty("COMMENT_COUNT");
		    int iCount = StringUtils.parseInt(sCount,0);
		    iCount++;
		    lotdcur.setProperty("COMMENT_COUNT",""+iCount);
		    lotdcur.commit();
		  }		  
		}
		lotdcomm.selectEquals("MARK_ID",lotdid);
		
		
		if(lotdcur.gotoFirst()){
		String sLotdTitle ="LOTD Comments";
		session.putValue(sLotdTitle,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
		%>