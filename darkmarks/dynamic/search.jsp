<%@ page import="java.io.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<%@ page import="com.darkoaksoftware.darkmarks.*"%>
<%
  boolean found = false;
  if(request.getProtocol().equals("HTTP/1.1")){
    response.setHeader ("cache-control", "no-cache");
  }
  response.setHeader ("pragma","no-cache");
  response.setHeader ("expires","0");
%>
<jsp:useBean id="mcur" class="com.darkoaksoftware.utils.dataset.WriteBackDataCursor" scope="request" />
<jsp:useBean id="catcur" class="com.darkoaksoftware.utils.dataset.WriteBackDataCursor" scope="request" />
<%
	mcur.init("MARKS.tdb",Constants.getDbPath(application));	
	catcur.init("CAT.tdb",Constants.getDbPath(application));	
	String sCatId = request.getParameter("CID");
	String sFldSearch = request.getParameter("SEARCH");
	if (sCatId !=null){
		mcur.selectEquals("CAT_ID",sCatId);
		catcur.selectEquals("CAT_ID",sCatId);	
		mcur.sortBy("TITLE",ArrayComparator.ASC);	
		found|=	mcur.gotoFirst();
	}else if (sFldSearch!=null&&sFldSearch.trim().length()>0){
		mcur.selectLike("TITLE",sFldSearch.trim());		
		mcur.addOR();		
		mcur.selectLike("DESCRIPTION",sFldSearch.trim());
		mcur.mergeQuery();		
		found|=	mcur.gotoFirst();
		mcur.sortBy("TITLE",ArrayComparator.ASC);		
	}else{
		found|=	mcur.gotoFirst();
		mcur.sortBy("DATE_ADDED",new SimpleDateFormat("MM/dd/yy hh:mm a"),ArrayComparator.DESC);
		mcur.limitRows(7);				
	}
	String sLotd = 	request.getParameter("lotdmax");
	if (sLotd==null) sLotd="7";
	if (mcur.gotoFirst()){		
		if(sCatId!=null){
			%><jsp:include page="catline.jsp"><jsp:param name='catname' value='<%=catcur.getProperty("NAME")%>'/> </jsp:include><%
			}else if (sFldSearch!=null){
				String sSearchStr="Search results for: "+sFldSearch;
			%><jsp:include page="catline.jsp"><jsp:param name='catname' value='<%=sSearchStr%>'/> </jsp:include><%
			}else {
			%><jsp:include page="lotdlist.jsp"><jsp:param name='lotdmax' value='<%=sLotd%>'/></jsp:include><%
			%><jsp:include page="catline.jsp"><jsp:param name='catname' value='New Links'/> </jsp:include><%
		}
		%><jsp:include page="reslist.jsp"/><%
	}		
	if (sCatId!=null){
		catcur.refreshRows();
		catcur.selectEquals("PARENT_ID",sCatId);			
		if (catcur.gotoFirst()) do{		
			mcur.refreshRows();
			mcur.selectEquals("CAT_ID",(String)catcur.getProperty("CAT_ID"));
			mcur.sortBy("TITLE",ArrayComparator.ASC);		
			if (mcur.gotoFirst()){
				found=true;
				%><jsp:include page="catline.jsp"><jsp:param name='catname' value='<%=catcur.getProperty("NAME")%>'/></jsp:include><%
				%><jsp:include page="reslist.jsp"/><%
			}		
		}while (catcur.gotoNext());
	}
	if(!found){%><SPAN class="TITLELINE">No results found</SPAN><%
	}
%>