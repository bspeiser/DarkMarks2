<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<%@ page import="com.darkoaksoftware.darkmarks.*"%>
<%@ page import="com.darkoaksoftware.utils.*"%>
<jsp:include page="checkuser.jsp"/>
<%
	WriteBackDataCursor notedb = new WriteBackDataCursor();
	String sError="";
	String sNoteId="-1";	
	String sNoteContent="";
	String sNoteFileName="";
	String sNoteType="";
	String sMarkId = request.getParameter("MID");
	notedb.init("NOTES.tdb",Constants.getDbPath(application));	
	User u = (User)session.getAttribute(User.USER);
	if(request.getMethod().equals("GET")){		
		notedb.selectEquals("MARK_ID",sMarkId);
		if (notedb.gotoFirst()){
			notedb.selectEquals("USER_ID",""+u.getUserId());
			if (notedb.gotoFirst()){
				sNoteId=(String)notedb.getProperty("NOTE_ID");	
				sNoteFileName=(String)notedb.getProperty("FILE_NAME");
				sNoteType=(String)notedb.getProperty("TYPE");
				sNoteContent=Note.getNote(
					u.getUserId(),
					Integer.parseInt(sNoteId), 
					sNoteFileName,
					u.getCKey(),
					null,
					Constants.getNotesPath(application));				
			}
		}
	}else{
		sNoteId=request.getParameter("NOTE_ID");
		sNoteContent=request.getParameter("NOTE_CONTENTS");		
		if ("-1".equals(sNoteId)&&!StringUtils.isNill(sNoteContent)){
			notedb.insertRow();						
			notedb.setProperty("MARK_ID",sMarkId);
			notedb.setProperty("USER_ID",""+u.getUserId());
		}else{
			notedb.selectEquals("NOTE_ID",sNoteId);			
			if (StringUtils.isNill(sNoteContent)){
				notedb.delete();			
				notedb.commit();
				Note.removeNote(
					u.getUserId(), 
					Integer.parseInt(notedb.getProperty("NOTE_ID").toString()), 
					notedb.getProperty("FILE_NAME").toString(), 
					Constants.getNotesPath(application));
			}
		}
		if(!StringUtils.isNill(sNoteContent)){
			sNoteId=(String)notedb.getProperty("NOTE_ID");	
			sNoteFileName=(String)notedb.getProperty("FILE_NAME");
			Note.putNote(sNoteContent, 
				u.getUserId(), 
				Integer.parseInt(sNoteId), 
				sNoteFileName, 
				u.getCKey(),
				null,
				Constants.getNotesPath(application));
				notedb.commit();
		}
		%><jsp:forward page="home.jsp"/><%
	}
%>
<FORM METHOD=POST ACTION=<%=request.getRequestURI()%>>
<INPUT TYPE=TEXT NAME="NOTE_ID" VALUE="<%=sNoteId%>">
<INPUT TYPE=TEXT NAME="MID" VALUE="<%=sMarkId%>">
<TABLE BORDER=1 cellpadding=3 cellspacing=0 bordercolor=#333333><TR><TD ALIGN=CENTER CLASS="FORMTITLE">Sign In
</TD></TR><TR><TD>
<TABLE BORDER=0 cellspacing=0 cellpadding=3>
	<tr>	
	<td align=right class="HDRITEM">
		Type: 
	</td>
	<td>
		<INPUT TYPE=TEXT NAME="NAME" VALUE="">
	</td>
	</tr><tr>
	<td align=right class="HDRITEM">
		Note: 
	</td>
	<td>		
		<TEXTAREA WIDTH=60 HEIGHT=10 NAME="NOTE_CONTENTS" ><%=sNoteContent%></TEXTAREA>
	</td>
	</tr><tr><td align=center class="DESCLINE" colspan=2>Notes are for your eyes only and will not be visible to other users.</td></tr>
	<tr><td align=center class="ERRORTXT" colspan=2><%=sError%></td></tr>
	</TABLE>
	</TD></TR><TR colspan=2><TD align=center>
		<INPUT TYPE="SUBMIT" Name="LOGIN" VALUE="Sign In">&nbsp;&nbsp;
	</TD></TR></TABLE>

</FORM>
