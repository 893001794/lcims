<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.dao.impl.ProjectDaoImplMySql"%>
<%@page import="com.lccert.oa.searchFactory.SearchFactory"%>
<%@page import="java.util.List"%>
<%@ include file="../comman.jsp"  %>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page errorPage="../error.jsp" %>
<%
	request.setCharacterEncoding("GBK");
	String pid = request.getParameter("pid");
	List temp = SearchFactory.getInstance().getQuotation(pid);
	if(pid == null || "".equals(pid)) {
		response.sendRedirect("myquotation.jsp");
		return;
	}
	Quotation qt = QuotationAction.getInstance().getQuotationByPid(pid);
	System.out.println(pid);
	List<Project> projectList=ProjectAction.getInstance().getAllProjectByPid(pid);
	//所有分项目的实际机构费
	float agcost=0f;
	if(projectList !=null && projectList.size()>0){
		for(int i=0;i<projectList.size();i++){
			agcost=agcost+projectList.get(i).getAgcost();
		}
	}
	if(qt == null) {
		response.sendRedirect("myquotation.jsp");
		return;
	}
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>订单详细信息</title>
		<style type="text/css">
/*工作区的背景色*/
.body1 {
	background-color: #fffff5;
}

.outborder {
	border: solid 1px;
}
</style>


		<script language="javascript">
		
		function confirmaccept() {
			window.self.location = "../finance/quotation/confirm.jsp?pid=<%=qt.getPid()%>";
		}
		
		function goBack() {
		window.history.back();
		}
</script>
	</head>

	<body class="body1">
		<form name="form1">
			<table width="95%" border="0" cellspacing="2" cellpadding="2">
				<tr>
					<td>&nbsp;
						
					</td>
				</tr>
			</table>
			<table width="95%" border="0" cellspacing="0" cellpadding="0"
				height="25">
				<tr>
					<td width="522" class="p1" height="25" nowrap>
						<img src="../images/mark_arrow_03.gif" width="14" height="14">
						&nbsp;
						<b>&gt;&gt;销售管理&gt;&gt;订单详细信息</b>
					</td>
				</tr>
			</table>
			<hr width="97%" align="center" size=0>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							报价单编号：
						</td>
						<td width="33%">
							<input name="pid" type="text" style="background-color: #F2F2F2"
								readonly="readonly" value="<%=qt.getPid() %>" size="40" />
						</td>

						<td width="17%">
							分公司：						</td>
						<td width="33%">

							<input type="text" style="background-color: #F2F2F2"
								readonly="readonly" value="<%=qt.getCompany() %>" size="40" />
					  </td>

					</tr>
					<tr>
						
						<td>
							销售人员：
						</td>
						<td>
							<input name="rid" type="text" style="background-color: #F2F2F2"
								size="40" readonly="readonly" value="<%=qt.getSales() %>" />
						</td>
					
						<td>
							立项时间：
						</td>
						<td>
							<input type="text" style="background-color: #F2F2F2" size="40"
								readonly="readonly" value="<%=qt.getCreatetime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getCreatetime()) %>" />
						</td>
					</tr>
					<tr>
						
						<td>
							客户名称：
						</td>
						<td>
							<input style="background-color: #F2F2F2" size="40"
								readonly="readonly" value="<%=qt.getClient() %>" />
						</td>
						<td width="100">
								客户要求时间：
							</td>
							<td width="17%">
								<input style="background-color: #F2F2F2" size="40"
									readonly="readonly" value="<%=qt.getCompletetime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getCompletetime()) %>" />
						  </td>
						
					</tr>
					<tr>
						<td>
							项目名称：
						</td>
						<td>
							<input type="text" size="40" style="background-color: #F2F2F2"
								readonly="readonly" value="<%=qt.getProjectcontent() %>" />
						</td>
						<td>
							&nbsp;
						</td>
						<td>
							&nbsp;
						</td>
					</tr>
				</table>
			</div>
			<div class="outborder">
			<table width="95%" cellpadding="5" cellspacing="5" >
			<%
						for(int j=0;j<temp.size();j++){
						Quotation qu =(Quotation)temp.get(j);
						String oldPid =qu.getOldPid();
						if(oldPid !=null && ! "".equals(oldPid)){
							String str="";
							String str1="";
							//统计应收金额
						float totalpay =qt.getInvcount();
						String quotype =qu.getQuotype();
						if(quotype.equals("flu") ){
						str="冲红";
						str1="-";
						totalpay=totalpay-qu.getInvcount();
						}
						if(quotype.equals("add") ){
						str="补充重测";
						totalpay=totalpay+qu.getInvcount();
						}if(quotype.equals("mod") ){
						str="修改报告";
						totalpay=totalpay+qu.getInvcount();
						}
						%>	
			 <tr>
				 	
						<td>关联<%=str %>报价单</td>
						<td>
						 <input name="totalprice" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=oldPid %>"/>
						 </td>
						<td>应收金额</td>
						<td><input name="totalprice" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=totalpay==0?"0":new DecimalFormat("##,###,###,###.00").format(totalpay) %>"/></td>
						
					
				 </tr>	
				  <tr>
				 	
						<td><%=str %>金额</td>
						<td><input name="totalprice" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=str1%><%=qu.getInvcount()==0?"0":new DecimalFormat("##,###,###,###.00").format(qu.getInvcount()) %>"/></td>
						
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						
					
				 </tr>	
				 <%
						}
						
						}
						 %>		
				<tr>
					<td width="17%">
						报价金额：					</td>
					<td width="33%">
				  <input name="totalprice" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=qt.getTotalprice()==0?"0":new DecimalFormat("##,###,###,###.00").format(qt.getTotalprice()) %>"/>				  
				  </td>
				  <td width="17%">
						已收金额：					</td>
					<td width="33%">
					<%
						float totalpay = qt.getPreadvance() + qt.getSepay() + qt.getBalance();
					 %>
				  <input name="payprice" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=totalpay==0?"0":new DecimalFormat("##,###,###,###.00").format(totalpay) %>"/>				  
				  </td>
				 </tr>
				
				 <tr>
					<td width="17%">
						预估分包费：					
					</td>
					<td width="33%">
				  <input name="totalprice" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=qt.getPresubcost()==0?"0":new DecimalFormat("##,###,###,###.00").format(qt.getPresubcost()) %>"/>				  
				  </td>
				  <td width="17%">
						（预估/实际）机构费：					</td>
					<td width="33%">
				  <input name="payprice" type="text" size="19" style="background-color: #F2F2F2" readonly="readonly" value="<%=qt.getPreagcost()==0?"0":new DecimalFormat("##,###,###,###.00").format(qt.getPreagcost()) %>" title="<%=qt.getPreagcost()%>"/>				  
				  <input name="payprice" type="text" size="18" style="background-color: #F2F2F2" readonly="readonly" value="<%=agcost==0.0 ?"0":new DecimalFormat("##,###,###,###.00").format(agcost) %>" title="<%=agcost%> "/>
				  </td>
				</tr>
				
				<tr>
					<td>开票总金额：					</td>
					<td>
						<input name="preadvance" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=qt.getInvcount()==0?"0":new DecimalFormat("##,###,###,###.00").format(qt.getInvcount()) %>"/>
					</td>
					<td width="17%">
						项目收款方式：					</td>
					<td width="33%">
				  		<input name="paytime" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=qt.getAdvancetype() %>"/>				  
				  	</td>
					
				</tr>
				<tr>
					<td width="17%">
						票据编号：					
					</td>
					<td width="33%">
					  <input name="invcode" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=qt.getInvcode()==null?"":qt.getInvcode() %>"/>
				  	</td>
				  <td>
						开发票方式：
					</td>
					<td>
						<input name="preadvance" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=qt.getInvtype() %>"/>
					</td>
				</tr>
				<tr>
					<td width="17%">
						开票题头：					</td>
					<td width="33%">
					  <input name="preadvance" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=qt.getInvhead() %>"/>
				  </td>
					<td width="17%">
						备注：					</td>
					<td width="33%">
					  <input name="preadvance" type="text" size="40" style="background-color: #F2F2F2" readonly="readonly" value="<%=qt.getTag() %>"/>
				  </td>
				</tr>
			</table>
			
				</div>

			<hr width="97%" align="center" size=0>
			<div align="center">
			<%
			if(user.getTicketid().matches("\\d\\d\\d1\\d\\d\\d\\d") && "未收到".equals(qt.getEconfrim())) {
			 %>
				<input name="btnAdd" class="button1" type="button" id="btnAdd"
					value="确认收到" onClick="confirmaccept()">
				&nbsp;&nbsp;&nbsp;
			<%} %>
				<input name="btnBack" class="button1" type="button" id="btnBack"
					value="返回" onClick="goBack()" />
			</div>
		</form>
	</body>
</html>
