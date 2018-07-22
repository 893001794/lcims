<%@page import="java.text.DecimalFormat"%>
<%@page import="com.lccert.crm.chemistry.util.TimeTest"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.ParseException"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@ include file="../comman.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.chemistry.util.PageModel"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%
	request.setCharacterEncoding("GBK");
	int pageNo = 1;
	int pageSize = 20;
	String pageNoStr = request.getParameter("pageNo");
	if (pageNoStr != null && !"".equals(pageNoStr)) {
		pageNo = Integer.parseInt(pageNoStr);
	}
	PageModel pm = new PageModel();
	int salesid = user.getId();
	List<Order> list = null;
	String command = request.getParameter("command");
	String status=request.getParameter("status");
	String client = request.getParameter("client");
	String pid = request.getParameter("pid");
	String uid = request.getParameter("uid");
	String parttype = request.getParameter("parttype");
	String month=request.getParameter("month");
	//���
	String year =request.getParameter("year");
	if(year ==null ){
	SimpleDateFormat sdf =new SimpleDateFormat("yyyy");
	year=sdf.format(new Date());
	}
	if(month ==null){
	SimpleDateFormat sdf =new SimpleDateFormat("MM");
	month=sdf.format(new Date());

}
	int clientid = 0;
//System.out.println(status);
	if(status !=null && !"".equals(status)){
	//��t_quotation���н�authorization��Ϊy�ͽ���ʱ��¼����ӵ�acthorizer�ֶ���
	if(QuotationAction.getInstance().updateAuthorizationPid(user.getName(),pid) == true){
	response.sendRedirect("order_manage.jsp?command=search&pid="+pid+"&uid="+uid+"&client="+client+"&parttype="+parttype+"");
	return ;
	}
	}else if(command !=null){
		if(client != null && !"".equals(client)) {
			ClientForm cf = ClientAction.getInstance().getClientByName(client);
			if(cf != null) {
				clientid = cf.getId();
			}
		}
		pm = OrderAction.getInstance().getAllOrders(pageNo,pageSize,"",pid,uid,clientid,year,month);
	}
	else{
	pm = OrderAction.getInstance().getAllOrders(pageNo,pageSize,"EMC",pid,uid,clientid,year,month);
	session.setAttribute("financeEMC",pm.getList());
	}
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>���۱��۵�</title>
		<link rel="stylesheet" href="../css/drp.css">
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />   
		<script src="../javascript/jquery.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		<script src="../javascript/jquery.autocomplete.js"></script>
		<script type="text/javascript">
	function printorder() {
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("��ѡ����Ҫ��ӡ�Ķ�����");
			return;
		}
		if (count > 1) {
			alert("һ��ֻ�ܴ�ӡһ�ݶ�����");
			return;
		}
		window.showModelessDialog("printorder.jsp?id=" + document.getElementsByName("selectFlag")[j].value,"","dialogWidth:900px;dialogHeight:700px");
	}
	
	
	function showdialog(pid) {
		window.open("../project/project_manage.jsp?command=search&pid=" + pid);
	}
	
	function addOrder() {
		
		window.self.location = "addorder.jsp";	
	}
	
	function modifyOrder() {
		var count = 0;
		var j = 0;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				j = i;
				count ++;
			}
		}
		if (count == 0) {
			alert("��ѡ����Ҫ�޸ĵ��û����ݣ�");
			return;
		}
		if (count > 1) {
			alert("һ��ֻ���޸�һ���û����ݣ�");
			return;
		}
	
		window.self.location = "modiorder.jsp?id=" + document.getElementsByName("selectFlag")[j].value;
	}
	
	function deleteUser() {
		var flag = false;
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			if (document.getElementsByName("selectFlag")[i].checked) {
				flag = true;
				break;
			}
		}
		if (!flag) {
			alert("��ѡ����Ҫɾ�����û����ݣ�");
			return;
		}
		if (window.confirm("�Ƿ�ȷ��ɾ��ѡ�е����ݣ�")) {
			//ִ��ɾ��
			with (document.getElementById("userForm")) {
				method = "post";
				action = "quotationlist.jsp?command=delete"
				submit();
			}
		}
	}
		
	function checkAll() {
		for (var i = 0; i < document.getElementsByName("selectFlag").length; i++) {
			document.getElementsByName("selectFlag")[i].checked = document.getElementById("ifAll").checked;
		}
	}

	function topPage() {
		window.self.location = "order_manage.jsp?pageNo=1";
	}
	
	function previousPage() {
		window.self.location = "order_manage.jsp?pageNo=<%=pm.getPreviousPageNo()%>&year=<%=year%>&month=<%=month%>";
	}	
	
	function nextPage() {
		window.self.location = "order_manage.jsp?pageNo=<%=pm.getNextPageNo()%>&year=<%=year%>&month=<%=month%>";
	}
	
	function bottomPage() {
		window.self.location = "order_manage.jsp?pageNo=<%=pm.getBottomPageNo()%>&year=<%=year%>&month=<%=month%>";
	}
	
<%---------------------������ݵ�EXCEL�ĵ�start---------------------%>
	
	<%---���ȫ��δ�����Ŀ��EXCEL�ĵ�---%>
	function nofinishex() {
		if (window.confirm("�Ƿ�ȷ��������ݣ�")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---������սӵ���ϸ��EXCEL�ĵ�---%>
	function todayex() {
		if (window.confirm("�Ƿ�ȷ��������ݣ�")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---���ȫ��δ��ɷְ���TUV��Ŀ��EXCEL�ĵ�---%>
	function notuvex() {
		if (window.confirm("�Ƿ�ȷ��������ݣ�")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---�����ݸδ�����Ŀ��EXCEL�ĵ�---%>
	function dgnoex() {
		if (window.confirm("�Ƿ�ȷ��������ݣ�")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---����ٵ����ٵ�Ԥ����EXCEL�ĵ�---%>
	function warnex() {
		if (window.confirm("�Ƿ�ȷ��������ݣ�")) {
				window.self.location = "modifyproject.jsp";
		}
	}
	
	<%---����Ѿ���ɵ�����δ������EXCEL�ĵ�---%>
	function nosendex() {
		if (window.confirm("�Ƿ�ȷ��������ݣ�")) {
				window.self.location = "modifyproject.jsp";
		}
	}	
	
function exportEMC() {
	if(confirm("ȷ������EMC?")) {
		window.self.location = "../financeEMC";
	}
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
							<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>���۹���&gt;&gt;�����۵�</b>
						</td>
					</tr>
				</table>
				<hr width="100%" align="center" size=0>
				
				<form name=search id ="search" method=post action=order_manage.jsp?command=search >
				<table width=100% border=0 cellspacing=5 cellpadding=5  style="margin-left: 5em">
					<tr>
						<td width="50%">
							<font color="red">�����뱨�۵��ţ�&nbsp;&nbsp;</font>
							<input type=text name=pid size="40" value="" />
							<input type=submit name=Submit value=����>
						</td>
					</tr>
					<tr>
						<td width="50%">
							<font color="red">��������ˮ�˺ţ�&nbsp;&nbsp;</font>
							<input type=text name=uid size="40" value="" />
							<input type=submit name=Submit value=����>
						</td>
					</tr>
					<tr>
						<td width="50%">
							<font color="red">������ͻ����ƣ�&nbsp;&nbsp;</font>
							<input id="client" type="text" name="client" size="40" />
							<input type=submit name=Submit value=����>
							<script>
								$("#client").autocomplete("../client_ajax.jsp",{
									delay:10,
									minChars:1,
									matchSubset:1,
									matchContains:1,
									cacheLength:10,
									matchContains: true,
									scrollHeight: 250,
									width:250,
									autoFill:false
								});
							</script>
						</td>
					</tr>
				<tr>
					<td >
					��ݣ�<select name ="year" id ="year" onchange="searchsales();">
							<option value="2010" <%=("2010").equals(year)?"selected":"" %>>2010</option>
							<option value="2011" <%=("2011").equals(year)?"selected":"" %>>2011</option>
							<option value="2012" <%=("2012").equals(year)?"selected":"" %>>2012</option>
							<option value="2013" <%=("2013").equals(year)?"selected":"" %>>2013</option>
							<option value="2014" <%=("2014").equals(year)?"selected":"" %>>2014</option>
							<option value="2015" <%=("2015").equals(year)?"selected":"" %>>2015</option>
							<option value="2016" <%=("2016").equals(year)?"selected":"" %>>2016</option>
							<option value="2017" <%=("2017").equals(year)?"selected":"" %>>2017</option>
							<option value="2018" <%=("2018").equals(year)?"selected":"" %>>2018</option>
							<option value="2019" <%=("2019").equals(year)?"selected":"" %>>2019</option>
							<option value="2020" <%=("2020").equals(year)?"selected":"" %>>2020</option>
						</select>
						�·ݣ�<select name ="month" id ="month" onchange="searchsales();">
							<option value="01" <%="01".equals(month)?"selected":""%>>1</option>
							<option value="02" <%="02".equals(month)?"selected":""%>>2</option>
							<option value="03" <%="03".equals(month)?"selected":""%>>3</option>
							<option value="04" <%="04".equals(month)?"selected":""%>>4</option>
							<option value="05" <%="05".equals(month)?"selected":""%>>5</option>
							<option value="06" <%="06".equals(month)?"selected":""%>>6</option>
							<option value="07" <%="07".equals(month)?"selected":""%>>7</option>
							<option value="08" <%="08".equals(month)?"selected":""%>>8</option>
							<option value="09" <%="09".equals(month)?"selected":""%>>9</option>
							<option value="10" <%="10".equals(month)?"selected":""%>>10</option>
							<option value="11" <%="11".equals(month)?"selected":""%>>11</option>
							<option value="12" <%="12".equals(month)?"selected":""%>>12</option>
						</select>
						<script type="text/javascript">
							function searchsales(){
							   var myform =document.getElementById("search");
								myform.action ="order_manage.jsp";
								myform.submit();
							}
						</script>
						&nbsp;&nbsp;
						<input name="export" value="����EMC" type="button" onclick="exportEMC();" />
					</td>
				</tr>
					
				</table>
				</form>
				<hr width="130%" align="center" size=0>
			</div>

			<table width="130%" height="20" border="0" align="center"
				cellspacing="0" class="rd1" id="toolbar">
				<tr>
					<%
					if(user.getName().equals("ŷ����")||user.getId()==103){
					%>
					<td width="27%" nowrap  class="r19" align="left" height="33px;">
						
						<font color="#FFFFFF" size="2pt"><a href="addorder.jsp" style="font-size: 15pt;text-align: left;">���EMC���۵�</a></font>
					</td>
					<%} %>
					<td width="49%" class="rd19">
						<font color="#FFFFFF" size="2pt">&nbsp;</font>
					</td>
					
					
				</tr>
			</table>
			<table width="130%" border="1" cellspacing="0" cellpadding="0"
				align="center" class="table1">
				<tr style="text-align: center;" >
					<td class="rd6" >
						<input type="checkbox" name="ifAll" id="ifAll" onClick="checkAll()">
					</td>
					<td  class ="rd6">
						EMC���۵����
					</td>
					<td class="rd6" >
						�������۵����
					</td>
					<td class="rd6" width="15%" style="text-align: center;" >
						�ͻ�����
					</td>
					<td class="rd6" >
						��Ʒ
					</td>
					<td class="rd6" >
						������Ŀ
					</td>
					<%--<td class="rd6" >
						�յ�ʱ��
					</td>--%>
					<td class="rd6" >
						��������
					</td>
					<td class="rd6" >
						�յ�ʱ��
					</td>
					<!-- 
					<td class="rd6" >
						���翪ʼʱ��
					</td>
					<td class="rd6" >
						�������ʱ��
					</td>
					<td class="rd6" >
						���翪ʼʱ��
					</td>
					<td class="rd6" >
						�������ʱ��
					</td>
					 
					<td class="rd6">
						����(Сʱ)
					</td>
					<td class="rd6">
						��׼��
					</td>-->
					<td class="rd6">
						���
					</td>
					<%if(user.getTicketid().matches("\\d\\d\\d1\\d\\d\\d\\d")||user.getId()==103||user.getId()==254){ %>
					<td class="rd6">
						���ս��
					</td>
					<td class="rd6">
						δ�ս��
					</td>
					<%} %>
					<td class="rd6">
						״̬
					</td>
					<td class="rd6">
						����
					</td>
				</tr>
				
				<%
				list = pm.getList();
				for(int i=0;i<list.size();i++) {
					Order order = list.get(i);
					String authoriz=QuotationAction.getInstance().getAuthorizationPid(order.getPid());
					float preprice=0.0f;//���ս��
					if(order.getStatus().equals("y")){
					Quotation qt=QuotationAction.getInstance().getQuotationByPid(order.getPid());
					preprice= qt.getPreadvance() + qt.getSepay() + qt.getBalance();
					}
				 %>
				
				<tr>
					<td class="rd8">
						<input type="checkbox" name="selectFlag" class="checkbox1"
							value="<%=order.getId()%>">
					</td>
					<td class="rd8">
						<a href="orderdetail.jsp?id=<%=order.getId() %>"><%=order.getPid() %></a>
					</td>
					<td class="rd8">
						<a href="orderdetail.jsp?id=<%=order.getId()%>"><%=order.getOldPid()==null?"":order.getOldPid()%></a>
					</td>
					<td class="rd8" width="10%" style="width: 10%">
						<%=order.getClient().getName()%>
					</td>
					<td class="rd8">
						<%=order.getProduct()%>
					</td>
					<td class="rd8" width="30%" style="width: 30%">
						<%=order.getProjectcontent() %>
					</td>
				<%--	<td class="rd8">
						<%=order.getCollection()!=null?new SimpleDateFormat("yyyy.MM.dd").format(order.getCollection()):""%>
					</td>--%>
					<td class="rd8">
						<%=order.getTest()!=null?new SimpleDateFormat("yyyy.MM.dd").format(order.getTest()):""%>
					</td>
					<td class="rd8"  >
						<%=order.getReceipt()!=null?new SimpleDateFormat("yyyy.MM.dd").format(order.getReceipt()):""%>
					</td>
					<!-- 
					<td class="rd8"  >
						<%=order.getAmstart()%>
					</td>
					<td class="rd8"  >
						<%=order.getAmend()%>
					</td>
					<td class="rd8"  >
						<%=order.getPmstart()%>
					</td>
					<td class="rd8"  >
						<%=order.getPmend()%>
					</td>
					
					<td class="rd8" width="60" >
					<%
					//String timeStr=new TimeTest().TimeSerial(order.getAmstart(), order.getPmstart(),order.getAmend(), order.getPmend());
					
					 %>
						
					</td>
					<td class="rd8"  >
						<%=order.getStandprice()%>
					</td>-->
					<td class="rd8" width="1%">
					<%
						//float total=0f;
						//float f=Float.parseFloat(timeStr);
						//float standPrice =400;
						//if(order.getStandprice()>0){
						//	standPrice=order.getStandprice();
					//	}
					//		total=f*standPrice;
					 %>
					 <%=order.getTotalprice()%>
					 </td>
					<%if(user.getTicketid().matches("\\d\\d\\d1\\d\\d\\d\\d")||user.getId()==103||user.getId()==254){
					%>
					 <td class="rd8" width="1%">
					 	<%=preprice == 0 ? "0.00": new DecimalFormat("##,###,###,###.00").format(preprice)%>
					 </td>
					<td class="rd8" width="1%">
						<%=order.getTotalprice()-preprice%>
					</td>
					 <%}%>
					 <td class="rd8" width="5%">
						<font color="<%="n".equals(order.getStatus())?"red":"green" %>"><%="n".equals(order.getStatus())?"δ���":"�����" %></font>
						<font color="<%="y".equals(authoriz)?"#7B68EE":"" %>"><%="y".equals(authoriz)?"����Ȩ":"" %></font>
					</td>
					<td class="rd8" width="4%">
					<%
						if("n".equals(order.getStatus()) && (user.getId()==103||user.getId()==188||user.getId()==138)) {
			 		%>
						<a href="orderdetail.jsp?id=<%=order.getId()%>">���</a>
					<%
						}
					  %>
					 
					</td>
				</tr>
				
				<%
				}
				 %>
			</table>
			<table width="130%" height="30" border="0" align="center"
				cellpadding="0" cellspacing="0" class="rd1">
				<tr>
					<td nowrap class="rd19" height="2">
						<div align="left">
							<font color="#FFFFFF" size="2pt">&nbsp;��&nbsp; <%=pm.getTotalPages() %> &nbsp;ҳ</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<font color="#FFFFFF" size="2pt">��ǰ��</font>&nbsp;
							<font color="#FF0000" size="2pt"><%=pm.getPageNo() %></font>&nbsp;
							<font color="#FFFFFF" size="2pt">ҳ</font>
						</div>
					</td>
					<td nowrap class="rd19">
						<div align="right">
							<input name="btnTopPage" class="button1" type="button"
								id="btnTopPage" value="|&lt;&lt; " title="��ҳ"
								onClick="topPage()">
							<input name="btnPreviousPage" class="button1" type="button"
								id="btnPreviousPage" value=" &lt;  " title="��ҳ"
								onClick="previousPage()">
							<input name="btnNextPage" class="button1" type="button"
								id="btnNextPage" value="  &gt; " title="��ҳ" onClick="nextPage()">
							<input name="btnBottomPage" class="button1" type="button"
								id="btnBottomPage" value=" &gt;&gt;|" title="βҳ"
								onClick="bottomPage()">
							&nbsp;
						<input name="btnModify" class="button1" type="button"
								id="btnModify" value="�޸�" onClick="modifyOrder()">
						</div>
					</td>
				</tr>
			</table>
			
			<br>
	<div align="center">
		<input name="btnModify" class="button1" type="button"
				id="btnModify" value="��ӡ����" onClick="printorder()">
						
					</div>
		
	</body>
</html>
