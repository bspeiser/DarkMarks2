<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<%@ page import="com.darkoaksoftware.utils.*"%>
<%@ page import="com.darkoaksoftware.darkmarks.*"%>

<%
	User u = (User)session.getValue(User.USER);
	String sError = "";
	if(request.getMethod().equals("POST")){
		String sPW1=request.getParameter("PW1");
		String sPW2=request.getParameter("PW2");
		String sOPW=request.getParameter("OPW");
		if (!u.checkPass(sOPW)){
			sError="Old Password Incorrect.";
		}else if (null==(sError=u.validPW(sPW1,sPW2))){			
			u.changePassword(sPW1,application);
			%><jsp:forward page="home.jsp"/><%
		}
	}
%>
<FORM METHOD=POST ACTION=<%=request.getRequestURI()%>>
<TABLE BORDER=1 cellpadding=3 cellspacing=0 bordercolor=#333333><TR><TD ALIGN=CENTER CLASS="FORMTITLE">Change Password
</TD></TR><TR><TD>
<TABLE BORDER=0 cellspacing=0 cellpadding=3>
	<tr>	
	<td align=right class="HDRITEM">
		Old Password: 
	</td>
	<td>
		<INPUT TYPE=PASSWORD NAME="OPW" VALUE="">
	</td>
	</tr>
	<tr>	
	<td align=right class="HDRITEM">
		New Password: 
	</td>
	<td>
		<INPUT TYPE=PASSWORD NAME="PW1" VALUE="">
	</td>
	</tr>
	<tr>	
	<td align=right class="HDRITEM">
		Confirm: 
	</td>
	<td>
		<INPUT TYPE=PASSWORD NAME="PW2" VALUE="">
	</td>
	</tr><tr><td align=center class="ERRORTXT" colspan=2><%=sError%></td></tr>
	</TABLE>
	</TD></TR><TR><TD align=center>
		<INPUT TYPE="SUBMIT" Name="Update" VALUE="Update">&nbsp;&nbsp;
	</TD></TR></TABLE>

</FORM>
