<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.flow.FlowAction"%>

<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="java.util.List"%>

<%
	request.setCharacterEncoding("GBK");
	String command = request.getParameter("command");
	Quotation qt = null;
	String pid = null;
	String rid = null;
	float totalprice = 0;
	Flow f=null;
	if (command != null && "search".equals(command)) {
		rid=request.getParameter("rid");
		if(!(pid == null || "".equals(pid))) {
			pid = pid.trim();
			qt = QuotationAction.getInstance().getQuotationByPid(pid);
			f = FlowAction.getInstance().getFlowByPid(pid);
		}
		if(!(rid == null || "".equals(rid))){
		//根据rid来查询pid
		rid =rid.trim();
		pid =FlowAction.getInstance().getPidByRid(rid);
		qt = QuotationAction.getInstance().getQuotationByPid(pid);
		//f = FlowAction.getInstance().getFlowByPid(pid);
		List list= FlowAction.getInstance().getFlowByRid(rid);
		for(int i=0;i<list.size();i++){
		f= (Flow)list.get(i);
		}
		}
	}
	if(qt == null) {
		qt = new Quotation();
	}
	if(f == null){
	f =new Flow();
	}
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>销售管理</title>
		<link rel="stylesheet" href="../css/drp.css">
				<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />   
<script src="../javascript/jquery.js"></script>
<script src="../javascript/jquery.autocomplete.min.js"></script>
    <script src="../javascript/jquery.autocomplete.js"></script> 
</script>

	</head>

	<body >
			<hr width="100%" align="center" size=0>


			<table width=100% border=0 cellspacing=5 cellpadding=5
				style="margin-left: 13em">
				<tr>
					<td valign=middle width=50%>
						<form  method=post action=b.jsp autocomplete="off">
							<input type="hidden" name="command" value="search" />
							<font color="red">请输入报告编号：</font>
							<input id="rid" type="text" name="rid" size="40" />
							<input type=submit name=Submit value=打印>
							 <script>   
						        $("#rid").autocomplete("../vrid_ajax.jsp",{
						            delay:10,
						            minChars:4,
						            matchSubset:1,
						            matchContains:1,
						            cacheLength:5,
						            matchContains: true,   
						            scrollHeight: 250, 
						            width:250,
						            autoFill:false
						        });    
						     </script>   
						</form>
						
					</td>
					
				</tr>

			</table>

	</body>
</html>
