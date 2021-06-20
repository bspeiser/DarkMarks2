<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<%
	WriteBackDataCursor mcat = new WriteBackDataCursor();
	mcat.init("USERS.tdb",Constants.getDbPath(application));	
	String sUserId = request.getParameter("UID");
	String sUserName = "New User";
	if(request.getMethod().equals("GET")){
		if (sCatId!=null){
			mcat.selectEquals("USER_ID",sCatId);
			if (mcat.gotoFirst()){
				sUserName=(String)mcat.getProperty("USER_NAME");				
				
			}
		}else{
			sUserName=null;
		}
	}else{
		String sUserName=request.getParameter("NAME");
		String sUserPass1=request.getParameter("PASS_1");
		String sUserPass2=request.getParameter("PASS_2");
		if(null!=request.getParameter("Create")){
			if (StringUtils.isNill(sUserName)){
				sError="User Name Required";				
			}else if (sUserPass1.equals(sUserPass2)){
				sError="Passwords do not match";				
			}else {
				mcat.selectEquals("USER_NAME",sUserName);
				if(mcat.gotoFirst()){
					sError="User name in use";				
				}else{
					mcat.insertRow();			
					mcat.setProperty("USER_NAME",sCatDesc);
					mcat.setProperty("USER_PASS",CCipher.encrypt(sUserPass1));
					mcat.commit();		
					%><jsp:forward page="home.jsp"/><%
				}
			}
		}else if (null!=request.getParameter("Update")){
			String sUserName=request.getParameter("NAME");
			String sUserPass1=request.getParameter("PASS_1");
			String sUserPass2=request.getParameter("PASS_2");
			mcat.selectEquals("USER_NAME",sUserName);
			if(!mcat.gotoFirst()){
				sError = "User does not exist";				
			}else if (!CCipher.encrypt(sUserPass0).equals(mcat.getProperty("USER_PASS")){
				sError = "Password incorrect";				
			}else {
				mcat.setProperty("USER_PASS",CCipher.encrypt(sUserPass1));
				mcat.commit();						
			}			
		}
			if (sUserPass1.equals(sUserPass2)){
				if(sUserId==null||sUserId.equals("-1")){
					mcat.insertRow();			
					mcat.setProperty("USER_NAME",sCatDesc);
				}else{
					mcat.selectEquals("USER_ID",sUserId);
				}
				mcat.setProperty("USER_PASS",CCipher.encrypt(sUserPass1));
				
			}else{ 
				sError = "Passwords do not match";
			}				
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
