<%@ page import="java.io.*"%>
<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<%@ page import="com.darkoaksoftware.utils.*"%>
<%@ page import="com.darkoaksoftware.darkmarks.*"%>
<%
  if(request.getProtocol().equals("HTTP/1.1")){
    response.setHeader ("cache-control", "no-cache");
  }
  response.setHeader ("pragma","no-cache");
  response.setHeader ("expires","0");
%><jsp:include page="checkuser.jsp"/>
<jsp:useBean id="edcur" class="com.darkoaksoftware.utils.dataset.WriteBackDataCursor" scope="request" />
<%
	edcur.init("MARKS.tdb",Constants.getDbPath(application));	
	String sMarkId = request.getParameter("MID");
	String sNote = "";
	if (sMarkId!=null) edcur.selectEquals("MARK_ID",sMarkId);
	if(request.getMethod().equals("POST")){
		if(null!=request.getParameter("UPDATE")){
			if(sMarkId.equals("-1")){
				edcur.insertRow();
			}else{
				edcur.gotoFirst();
				
			}
			edcur.setProperty("TITLE",StringUtils.escapeForHtml(request.getParameter("TITLE")));
			edcur.setProperty("URL",request.getParameter("URL"));
			edcur.setProperty("DESCRIPTION",StringUtils.escapeForHtml(request.getParameter("DESCRIPTION")));			
			edcur.setProperty("CAT_ID",request.getParameter("CAT_ID"));									
			edcur.commit();
			Note.updateNote(request,application,session,(String)edcur.getProperty("MARK_ID"));
		}else if (null!=request.getParameter("DELETE")){
				edcur.selectEquals("MARK_ID",sMarkId);
				Note.removeNote(sMarkId,application,session);
				edcur.gotoFirst();
				edcur.delete();
				edcur.commit();							
		}
		%><jsp:forward page="home.jsp"/><%		
	}else{
		String sTitle = "";
		String sUrl = "";
		String sDesc = "";
		String sMid = "-1";
		String sCid = "0";
		if (sMarkId!=null){
			sTitle = (String)edcur.getProperty("TITLE");
			sUrl = (String)edcur.getProperty("URL");
			sDesc = (String)edcur.getProperty("DESCRIPTION");
			sCid = (String)edcur.getProperty("CAT_ID");
			sMid=sMarkId;
			sNote = Note.getNote(request,application,session);
		}else{
			sUrl=request.getParameter("URL");
			sTitle=request.getParameter("TITLE");
		}
		%>
<HTML><TITLE>DarkMarks2 Lite</TITLE>
<LINK REL=STYLESHEET HREF="s.css" media="screen" TYPE="text/css">
<BODY BGCOLOR="#000000" leftmargin=0 rightmargin=0 marginwidth=0 marginheight=0 topmargin=0 >		
			<FORM METHOD=POST ACTION=<%=request.getRequestURI()%>>
<INPUT NAME="MID" TYPE=HIDDEN VALUE="<%=sMid%>" SIZE=1>
<TABLE BORDER=1 cellpadding=0 cellspacing=0 bordercolor=#333333><TR ALIGN=CENTER CLASS="FORMTITLE"><TD>Edit DarkMark</TD></TR>
<TR><TD class='HDRITEM' >Title:</TD></TR>
<TR><TD><INPUT NAME="TITLE" class=TOOLTEXT VALUE="<%=sTitle%>" SIZE=40 style="width:190px"></TD></TR>
<TR><TD  class='HDRITEM'>URL</TD></TR>
<TR><TD><INPUT NAME="URL" class=TOOLTEXT VALUE="<%=sUrl%>" SIZE=40 style="width:190px"></TD></TR>
<TR><TD class='HDRITEM'>Description</TD></TR>
<TR><TD><INPUT NAME="DESCRIPTION" class=TOOLTEXT VALUE="<%=sDesc%>" SIZE=40 style="width:190px"></TD></TR>
<TR><TD  class='HDRITEM'>Category</TD></TR>
<TR><TD><jsp:include page="../catlist.jsp" >
				<jsp:param name="CAT_ID" value="<%=sCid%>" />
</jsp:include></TD></TR>
<TR><TD class='HDRITEM'>Notes</TD></TR>
<TR><TD><TEXTAREA NAME="NOTE_CONTENTS" class=TOOLTEXT><%=sNote%></TEXTAREA></TD></TR>
<tr><td align=center class="DESCLINE">Notes are for your eyes only and will not be visible to other users.</td></tr>
<TR><TD  class='HDRITEM'>
<INPUT TYPE="SUBMIT" NAME="UPDATE" VALUE="Update" class=TOOLTEXT>&nbsp;&nbsp;
<INPUT TYPE="SUBMIT" NAME="DELETE" VALUE="Delete" class=TOOLTEXT>&nbsp;&nbsp;
<INPUT TYPE="SUBMIT" NAME="CANCEL" VALUE="Cancel" class=TOOLTEXT>
</TD></TR>
</TABLE>
</FORM>
		<%
	}
%></BODY></HTML>
