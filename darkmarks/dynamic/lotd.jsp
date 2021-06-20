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
%>
<jsp:useBean id="edcur" class="com.darkoaksoftware.utils.dataset.WriteBackDataCursor" scope="request" />
<jsp:useBean id="comcur" class="com.darkoaksoftware.utils.dataset.WriteBackDataCursor" scope="request" />
<%
	String sDesc="";
	String sUrl="";
	String sTitle="";
	String sLotd=request.getParameter("lotdid");
	System.out.println("Del:"+request.getParameter("DELETE"));
	if(request.getMethod().equals("POST")){
    edcur.init("LOTD.tdb",Constants.getDbPath(application));	
		if(null!=request.getParameter("UPDATE")){			
			if(sLotd!=null&&!"".equals(sLotd)){
  	    edcur.selectEquals("MARK_ID",sLotd);	    
	      edcur.gotoFirst();			 
			}else{ 
			  edcur.insertRow();
			}
			edcur.setProperty("TITLE",request.getParameter("TITLE"));
			edcur.setProperty("URL",request.getParameter("URL"));
			edcur.setProperty("DESCRIPTION",request.getParameter("DESCRIPTION"));			
			edcur.commit();
		}else if (null!=request.getParameter("DELETE")){
		  System.out.println("Immediate Delete id:"+sLotd);
  	    edcur.selectEquals("MARK_ID",sLotd);	    
	      if(edcur.gotoFirst()){
	        edcur.delete();
	        edcur.commit();
          comcur.init("LOTD_COMM.tdb",Constants.getDbPath(application));		      	 
          comcur.selectEquals("MARK_ID",sLotd); 
          if (comcur.gotoFirst()){
            do{
              comcur.delete();
            }while (comcur.gotoFirst());
		      comcur.commit();
		    }
		    
		  }
		
		}
		%><jsp:forward page="home.jsp"/><%		
	}else{
	  
	  if (!StringUtils.isNill(sLotd)){
	    edcur.init("LOTD.tdb",Constants.getDbPath(application));	
	    edcur.selectEquals("MARK_ID",sLotd);	    
	    if (edcur.gotoFirst()){
	      sTitle=(String)edcur.getProperty("TITLE");
	      sUrl=(String)edcur.getProperty("URL");
	      sDesc=(String)edcur.getProperty("DESCRIPTION");
	    }
	  }else{
	    sTitle=request.getParameter("TITLE");
	    sUrl=request.getParameter("URL");
	  }
	}if(sLotd==null)sLotd="";
	%>
			<FORM METHOD=POST ACTION=<%=request.getRequestURI()%>>
				<TABLE BORDER=1 cellpadding=3 cellspacing=0 bordercolor=#333333><TR ALIGN=CENTER CLASS="FORMTITLE"><TD>Link of the day</TD></TR><TR><TD>
				<TABLE BORDER=0 cellspacing=0 cellpadding=3><TR><TD align="right" class='HDRITEM'>Title:</TD><TD>
				<INPUT NAME="TITLE" TYPE=TEXT VALUE="<%=sTitle%>" SIZE=60>
				<INPUT NAME="lotdid" TYPE=HIDDEN VALUE="<%=sLotd%>" SIZE=60>
				</TD></TR>
				<TR><TD align="right" class='HDRITEM'>URL:</TD><TD>
				<INPUT NAME="URL" TYPE=TEXT VALUE="<%=sUrl%>" SIZE=60><BR>
				</TD></TR>
				<TR><TD align="right" class='HDRITEM'>Description:</TD><TD>
				<INPUT NAME="DESCRIPTION" TYPE=TEXT VALUE="<%=sDesc%>" SIZE=60>
				</TD></TR>
				</TABLE>
				</TD></TR><TR><TD align=center>
				<INPUT TYPE="SUBMIT" NAME="UPDATE" VALUE="Update">&nbsp;&nbsp;
				<% if(!StringUtils.isNill(sLotd)){%>
				<INPUT TYPE="SUBMIT" NAME="DELETE" VALUE="Delete">&nbsp;&nbsp;
				<%}%>
				<INPUT TYPE="SUBMIT" NAME="CANCEL" VALUE="Cancel">
				</TD></TR></TABLE>
			</FORM>
