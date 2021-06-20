<%@ page import="java.io.*"%>
<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<%@ page import="com.darkoaksoftware.darkmarks.*"%>
<jsp:useBean id="mcat" class="com.darkoaksoftware.utils.dataset.WriteBackDataCursor" scope="page" />
<jsp:useBean id="mcat2" class="com.darkoaksoftware.utils.dataset.WriteBackDataCursor" scope="page" />
<%
	boolean bTop = (request.getParameter("TOP")!=null);
	String sSetVal = (bTop)?"PARENT_ID":"CAT_ID";
	String sPCatId = request.getParameter("CID");
%>
<SELECT NAME="<%=sSetVal%>">
<%
	mcat.init("CAT.tdb",Constants.getDbPath(application));	
	
	mcat2.init("CAT.tdb",Constants.getDbPath(application));	
	
	mcat.selectEquals("PARENT_ID","0");	
	if(bTop) mcat.selectEquals("CAT_ID",sPCatId,false);	
	mcat.sortBy("NAME",ArrayComparator.ASC);
	String sCatSelected=""+request.getParameter(sSetVal);
	if (bTop){
	%>
		<OPTION VALUE=0>
		Root
		</OPTION>
	<%
	}
	if (mcat.gotoFirst())do	{
		String sCatId=(String)mcat.getProperty("CAT_ID");
		%>
		<OPTION VALUE=<%=sCatId+((sCatSelected.equals(sCatId))?" SELECTED":"")%>>
		<%=mcat.getProperty("NAME")%>
		</OPTION>
		<%
		mcat2.refreshRows();
		mcat2.selectEquals("PARENT_ID",""+mcat.getProperty("CAT_ID"));
		if (!bTop&&mcat2.gotoFirst()){		
			do{ 
			String sCatId2=(String)mcat2.getProperty("CAT_ID");
			%>
			<OPTION VALUE=<%=sCatId2+((sCatSelected.equals(sCatId2))?" SELECTED":"")%>>
			&nbsp;&nbsp;&nbsp;<%=mcat2.getProperty("NAME")%>
			</OPTION>
			<%
			}while(mcat2.gotoNext());
		}
	}while (mcat.gotoNext());		
%>
</SELECT>
