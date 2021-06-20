<%@ page import="java.io.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.darkoaksoftware.utils.dataset.*"%>
<%@ page import="com.darkoaksoftware.darkmarks.*"%>
<jsp:useBean id="lotdcur" class="com.darkoaksoftware.utils.dataset.WriteBackDataCursor" scope="request" />
<%
  FlatFile f = new FlatFile("LOTD.tdb",Constants.getDbPath(application));
  f.load();
  f.addColumn("COMMENT_COUNT","'0'");
%>