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
		<title>���ӵ���������Ŀ��Ϣ</title>
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
							<b>���ӵ���&gt;&gt;������Ŀ</b>
						</td>
					</tr>
				</table>
				
				<hr width="100%" align="center" size=0>
				
				<form name=search method=post action=searchquotation.jsp?command=search >
				<table width=100% border=0 cellspacing=5 cellpadding=5  style="margin-left: 5em">
					<tr>
						<td width="50%">
						
							<font color="red">�������Ʒ���ƣ�</font>
							<input type=text name=product size="40" value="<%=product%>" />
							<input type=submit name=Submit value=����>
						</td>
					</tr>
				<tr>
					<td >
						<div id="mydiv">
						ȫ��
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
						             //��Ҫ���ٹ��xһ����Ԓ���t����������else�õ����Q����������   
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
						<font color="#FFFFFF" size="2pt">��ѯ�б�</font>
					</td>
					<td width="27%" nowrap class="rd16">
						<div align="right"><a href="myproject.jsp">���ӱ�����Ϣ</a></div>
					</td>
				</tr>
			</table>
			<table width="95%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<tr>
					<td class="rd6" >
						��Ʒ����
					</td>
					<td class="rd6" >
						��Ʒ�����
					</td>
					<td class="rd6" >
						������Ŀ
					</td>
					<td class="rd6" >
						��׼��
					</td>
					<td class="rd6" >
						�г�
					</td>
					<td class="rd6" >
						�۸�
					</td>
				</tr>
				<%
				if(list != null) {
					for(int i=0;i<list.size();i++) {
						List column1 =(List)list.get(i);
						//��ȡid��ѯ�����
						String [] serviceitem=column1.get(2).toString().split(",");
						for(int j =0;j<serviceitem.length;j++){
						//��ѯ�����
						int id =Integer.parseInt(serviceitem[j].toString());
							List itemRows=DaoFactory.getInstance().getQuoteDao().getServiceitem(id,serviceLab);
							for(int k=0;k<itemRows.size();k++){
								String  str="";
								List itemColumn =(List)itemRows.get(k);
								 System.out.println(itemColumn.get(2).toString());
								String [] standardId=itemColumn.get(2).toString().split(",");
								//��ȡ��׼��
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
						<a href="javascript:showdialog('<%=itemColumn.get(0) %>','<%=column1.get(3)%>');">�г��۸�</a>
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
