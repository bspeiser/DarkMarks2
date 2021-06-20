<%
String sText=request.getParameter("catname");
if (sText==null) sText="";
String sExtra=(String)session.getValue(sText);
if (sExtra!=null){session.removeValue(sText);
}else {sExtra="";}
%><table CLASS="CATMIDDLE" width="98%" cellpadding=0><tr><td class="CATTITLE"><img src="../images/clear.gif"/></td></tr><tr><td ><%=sText+sExtra%></td></tr><tr><td class="CATTITLE"><img src="../images/clear.gif"/></td></tr></table>