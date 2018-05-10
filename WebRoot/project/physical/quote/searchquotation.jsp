<%@page import="com.lccert.crm.dao.QuoteDao"%>
<%@page import="com.lccert.crm.dao.impl.QuoteDaoImple"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page errorPage="../../error.jsp" %>
<%@page import="java.util.ArrayList"%>

<%
	request.setCharacterEncoding("GBK");
	String command = request.getParameter("command");
	String serviceLab = request.getParameter("parttype");
	String product = request.getParameter("product");
	
	if(serviceLab ==null){
		serviceLab="";
	}
	if(product ==null){
		product="";
	}
	List list = new ArrayList ();
	if (command != null && "search".equals(command)) {
		
		if(product != null && !"".equals(product)) {
			list =DaoFactory.getInstance().getQuoteDao().getProduct(product);
			}
	}

%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>电子电器服务项目信息</title>
		<link rel="stylesheet" href="../../css/drp.css">
		<link rel="stylesheet" href="../../css/style.css">
		<script type="text/javascript" src="../../javascript/suggest.js"></script>
				<link rel="stylesheet" type="text/css" href="../../css/jquery.autocomplete.css" />   
<script src="../../javascript/jquery.js"></script>
<script src="../../javascript/jquery.autocomplete.min.js"></script>
    <script src="../../javascript/jquery.autocomplete.js"></script> 
		<script type="text/javascript">
	
	function showdialog(id,phonoPath) {
		window.showModalDialog("phy_quote.jsp?id="+id+"&phonoPath="+phonoPath,"","dialogWidth:900px;dialogHeight:400px");
	}
</script>
	</head>

	<body class="body1">
		
			<div align="center">
				<table width="95%" border="0" cellspacing="0" cellpadding="0"
					height="35">
					<tr>
						<td class="p1" height="18" nowrap>
							&nbsp;
						</td>
					</tr>
					<tr>
						<td width="522" class="p1" height="17" nowrap>
							<img src="../../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>电子电器&gt;&gt;服务项目</b>
						</td>
					</tr>
				</table>
				
				<hr width="100%" align="center" size=0>
				
				<form name=search method=post action=searchquotation.jsp?command=search >
				<table width=100% border=0 cellspacing=5 cellpadding=5  style="margin-left: 5em">
					<tr>
						<td width="50%">
						
							<font color="red">请输入产品名称：</font>
							<input type=text name=product size="40" value="<%=product%>" />
							<input type=submit name=Submit value=搜索>
						</td>
					</tr>
				<tr>
					<td >
						<div id="mydiv">
						全部
							<input type="checkbox" name="parttype" value="" onClick="chooseOne(this);"  <%=serviceLab.equals("")?"checked":"" %>/>
						<%
						QuoteDao q=DaoFactory.getInstance().getQuoteDao();
						List rows =q.getServiceLab();
						for(int i =0;i<rows.size();i++){
							List column=(List)rows.get(i);
							%>
							|&nbsp; <%=column.get(1) %>
							<input type="checkbox" name="parttype" value="<%=column.get(0)%>" onClick="chooseOne(this);" <%=serviceLab.equals(column.get(0))?"checked":"" %> />
							<%
						}
						 %>
						</div>
						 <script>   
						     function chooseOne(cb) {   
						         var obj = document.getElementById("mydiv");   
						         for (i=0; i<obj.children.length; i++){   
						             if (obj.children[i]!=cb)    obj.children[i].checked = false;   
						             //else    obj.children[i].checked = cb.checked;   
						             //若要至少勾選一個的話，則把上面那行else拿掉，換用下面那行   
						             else obj.children[i].checked = true;   
						         }   
						         var search=document.getElementById("search");
						         //search.action ="searchquotation.jsp?command=search";
						         search.submit();
						     }   
						 </script>
						</td>
				</tr>
				</table>
				</form>
				<hr width="100%" align="center" size=0>
			</div>
			<form name="userform" id="userform">
			<table width="95%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">查询列表</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right"><a href="myproject.jsp">增加报价信息</a></div>
					</td>
				</tr>
			</table>
			<table width="95%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<tr>
					<td class="rd6" >
						产品名称
					</td>
					<td class="rd6" >
						产品类别名
					</td>
					<td class="rd6" >
						服务项目
					</td>
					<td class="rd6" >
						标准号
					</td>
					<td class="rd6" >
						市场
					</td>
					<td class="rd6" >
						价格
					</td>
				</tr>
				<%
				if(list != null) {
					for(int i=0;i<list.size();i++) {
						List column1 =(List)list.get(i);
						//获取id查询服务表
						String [] serviceitem=column1.get(2).toString().split(",");
						for(int j =0;j<serviceitem.length;j++){
						//查询服务表
						int id =Integer.parseInt(serviceitem[j].toString());
							List itemRows=DaoFactory.getInstance().getQuoteDao().getServiceitem(id,serviceLab);
							for(int k=0;k<itemRows.size();k++){
								String  str="";
								List itemColumn =(List)itemRows.get(k);
								 System.out.println(itemColumn.get(2).toString());
								String [] standardId=itemColumn.get(2).toString().split(",");
								//获取标准号
								 for(int s=0;s<standardId.length;s++){
								 int sid =Integer.parseInt(serviceitem[s].toString());
									String code=DaoFactory.getInstance().getQuoteDao().getCodeById(sid);
									str+=code+"<br>";
								 }
				 %>
				<tr>
					<td class="rd8">
						<%=column1.get(0) %>
					</td>
					<td class="rd8">
						<%=column1.get(1) %>
					</td>
					<td class="rd8">
						<%=itemColumn.get(1) %>
					</td>
					<td class="rd8">
						<%=str%>
					</td>
					<td class="rd8">
						<%=itemColumn.get(3) %>
					</td>
						
					<td class="rd8">
						<a href="javascript:showdialog('<%=itemColumn.get(0) %>','<%=column1.get(3)%>');">市场价格</a>
					</td>
				</tr>
				<%
						}
						}
				}
				}
				 %>
			</table>
		</form>
	</body>
</html>
