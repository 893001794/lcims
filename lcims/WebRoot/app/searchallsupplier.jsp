<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.lcim.app.ApplicationAction"%>
<%@page import="com.lccert.lcim.app.ApplicationForm"%>
<%@page import="com.lccert.lcim.app.Supplier"%> 
<SCRIPT language=javascript>
function get_data()
        {
            var terms = new Array();
            
            <%
            	List<Supplier> suppliers = ApplicationAction.getInstance().getAllSuppliers();
            	for(int i=0;i<suppliers.size();i++) {
            		Supplier sup = (Supplier)suppliers.get(i);
            %>
            		terms.push({val:1,activity:"[<%=sup.getName()%>]&nbsp;&nbsp;<%=sup.getName()%>",val2:"<%=sup.getName()%>"});
            <%
            	}
            %>
            return terms;    
        }		
</SCRIPT>