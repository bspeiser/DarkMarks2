<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<%@ page import="com.darkoaksoftware.darkmarks.*"%>
<%@ page import="com.darkoaksoftware.utils.*"%>
<%
String sToolName=request.getParameter("TOOL_NAME");
String sTool="";
if (request.getMethod().equals("GET")){	
	sTool=ToolBar.readTool(sToolName,application);
}else{
	sTool=request.getParameter("TOOL");
	if(null==request.getParameter("Cancel")){	
		ToolBar.writeTool(sToolName,sTool,application);
	} 
	%><jsp:forward page="hometoollist.jsp"/><%
}
%>
<FORM METHOD=POST ACTION=<%=request.getRequestURI()%>>
<TABLE BORDER=1 cellpadding=3 cellspacing=0 bordercolor=#333333><TR><TD ALIGN=CENTER CLASS="FORMTITLE">Edit Tool
</TD></TR><TR><TD>
<TABLE BORDER=0 cellspacing=0 cellpadding=3>
	<tr>	
	<td align=right class="HDRITEM">
		Name: 
	</td>
	<td>
		<INPUT TYPE=TEXT NAME="TOOL_NAME" VALUE="<%=sToolName%>">
	</td>
	</tr><tr>
	<td align=right class="HDRITEM" colspan=2>
		<TEXTAREA name="TOOL" cols=60 rows=20><%=sTool%>
		</TEXTAREA>
	</td>
	</tr>
	</TABLE>
	</TD></TR><TR><TD align=center>
		<INPUT TYPE="SUBMIT" Name="Update" VALUE="Update">&nbsp;&nbsp;
		<INPUT TYPE="SUBMIT" Name="Cancel" VALUE="Cancel">&nbsp;&nbsp;
	</TD></TR></TABLE>

</FORM>
