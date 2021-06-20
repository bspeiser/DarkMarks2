<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<%@ page import="com.darkoaksoftware.darkmarks.*"%>
<%
	WriteBackDataCursor mcat = new WriteBackDataCursor();
	mcat.init("CAT.tdb",Constants.getDbPath(application));	
	String sCatId = request.getParameter("CID");
	String sCatDesc="New Category";
	String sParentId="0";
	if(request.getMethod().equals("GET")){
		if (sCatId!=null){
			mcat.selectEquals("CAT_ID",sCatId);
			if (mcat.gotoFirst()){
				sCatDesc=(String)mcat.getProperty("NAME");
				sParentId=(String)mcat.getProperty("PARENT_ID");
				
			}
		}else{
			sCatId="-1";
		}
	}else{
		if(null!=request.getParameter("Update")){
			sCatDesc=request.getParameter("NAME");
			sParentId=request.getParameter("PARENT_ID");
			if(sCatId==null||sCatId.equals("-1")){
				mcat.insertRow();			
			}else{
				mcat.selectEquals("CAT_ID",sCatId);
			}
			mcat.setProperty("NAME",sCatDesc);
			mcat.setProperty("PARENT_ID",sParentId);
			mcat.commit();		
			if (!"0".equals(sParentId)){
				mcat.refreshRows();
				mcat.selectEquals("PARENT_ID",sCatId);
				if (mcat.gotoFirst())do{
					mcat.setProperty("PARENT_ID",sParentId);
				}while(mcat.gotoNext());
				mcat.commit();		
				
			}
			%><jsp:forward page="home.jsp"/><%
		}else if(null!=request.getParameter("Done")){
			%><jsp:forward page="home.jsp"/><%
		}else {
			sCatId="-1";
			sParentId="-1";
		}
	}
%>
<FORM METHOD=POST ACTION=<%=request.getRequestURI()%>>
<INPUT TYPE=HIDDEN NAME="CID" VALUE="<%=sCatId%>">
<TABLE BORDER=1 cellpadding=3 cellspacing=0 bordercolor=#333333><TR><TD ALIGN=CENTER CLASS="FORMTITLE">Edit Category
</TD></TR><TR><TD>
<TABLE BORDER=0 cellspacing=0 cellpadding=3>
	<tr>	
	<td align=right class="HDRITEM">
		Name: 
	</td>
	<td>
		<INPUT TYPE=TEXT NAME="NAME" VALUE="<%=sCatDesc%>">
	</td>
	</tr><tr>
	<td align=right class="HDRITEM">
		Child Of: 
	</td>
	<td>		
		<jsp:include page="catlist.jsp" >
		<jsp:param name="PARENT_ID" value="<%=sParentId%>" />
		<jsp:param name="TOP" value="1" />
		</jsp:include>
	</td>
	</tr>
	</TABLE>
	</TD></TR><TR><TD align=center>
		<INPUT TYPE="SUBMIT" Name="Update" VALUE="Update">&nbsp;&nbsp;
		<INPUT TYPE="SUBMIT" Name="New" VALUE="New">&nbsp;&nbsp;
		<INPUT TYPE="SUBMIT" Name="Done" VALUE="Done">
	</TD></TR></TABLE>

</FORM>
