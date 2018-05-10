<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.FinanceQuotationAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
 <%@ page errorPage="../../error.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("GBK");
	String pid = request.getParameter("pid");
	if(pid == null || "".equals(pid)) {
		response.sendRedirect("quotation_manage.jsp");
		return;
	}
	Quotation qt = QuotationAction.getInstance().getQuotationByPid(pid);
	List<Project> list = ChemProjectAction.getInstance().getChemProjectByPid(pid,"");
 %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>报价单管理</title>

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
		function child(str) {
			window.open("../project/projectdetail.jsp?sid=" + str);
		}
		
		function goBack() {
		window.self.location="quotation_manage.jsp";
		}
		
</script>

		<script type="text/javascript">
		function addAppform(temp) {
			document.getElementById("addappform").value += temp;
			document.getElementById("addappform").value += "\n";
		}
		function addInorganic(temp0) {
			document.getElementById("inorganic").value += temp;
			document.getElementById("inorganic").value += "\n";
		}
		function addInorganicDetail(temp1) {
			document.getElementById("inorganicdetail").value += temp1;
			document.getElementById("inorganicdetail").value += "\n";
		}
		function addOrganic(temp2) {
			document.getElementById("organic").value += temp2;
			document.getElementById("organic").value += "\n";
		}
		function addOrganicDetail(temp3) {
			document.getElementById("organicdetail").value += temp3;
			document.getElementById("organicdetail").value += "\n";
		}
		function addfood(temp4) {
			document.getElementById("food").value += temp4;
			document.getElementById("food").value += "\n";
		}
	</script>

	</head>

	<body class="body1">
		<table width="95%" border="0" cellspacing="2" cellpadding="2">

		</table>
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			height="25">
			<tr>
				<td width="522" class="p1" height="25" nowrap>
					<img src="../../images/mark_arrow_03.gif" width="14" height="14">
					&nbsp;
					<b>&gt;&gt;财务管理&gt;&gt;报价单详细信息</b>
				</td>
			</tr>
		</table>
		<hr width="97%" align="center" size=0>
		<form name="form1">
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							报价单编号：
						</td>
						<td width="33%">
							<input name="pid" size="40" type="text"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getPid() %>" />
						</td>

						<td width="17%">
							分公司：
						</td>
						<td width="33%">

							<input type="text" size="40" style="background-color: #F2F2F2"
								readonly="readonly" value="<%=qt.getCompany() %>" />
						</td>

					</tr>
					<tr>
						<td>
							立项时间：
						</td>
						<td>
							<input type="text" size="40" style="background-color: #F2F2F2"
								readonly="readonly" value="<%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getCreatetime()) %>" />
						</td>
						<td>
							销售人员：
						</td>
						<td>
							<input name="sales" size="40" type="text"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getSales() %>" />
						</td>
					
						
					</tr>

					<tr>
						<td width="100">
							应完成时间：
						</td>
						<td width="611">
							<input style="background-color: #F2F2F2" readonly="readonly"
								size="40" value="<%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getCompletetime()) %>" />
						</td>
						<td>
							客户名称：
						</td>
						<td>
							<input style="background-color: #F2F2F2" readonly="readonly"
								size="40" value="<%=qt.getClient() %>" />
						</td>

					</tr>

					<tr>
						<td width="116">
							报价金额：
						</td>
						<td width="168">
							<input name="totalprice" type="text" readonly="readonly"
								size="40" style="background-color: #F2F2F2"
								value="<%=new DecimalFormat("##,###,###,###.00").format(qt.getTotalprice()) %>" />
						</td>
						<td>
							项目名称：
						</td>
						<td>
							<input type="text" style="background-color: #F2F2F2" size="40"
								readonly="readonly" value="<%=qt.getProjectcontent() %>" />
						</td>
						
					</tr>
					<tr>
						
						<td>
							收款方式：
						</td>
						<td>
							<input name="advancetype" value="<%=qt.getAdvancetype() %>"
								type="text" size="40" readonly="readonly"
								style="background-color: #F2F2F2" />
						</td>
						<td>
					</tr>
				</table>
			</div>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">

					<tr>
						<td width="17%">
							已收预付款：
						</td>
						<td width="33%">
							<input name="preadvance" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getPreadvance()==0?"":new DecimalFormat("##,###,###,###.00").format(qt.getPreadvance()) %>" />
						</td>
						<td>
							预付款收款日期：
						</td>
						<td>
							<input name="paytime" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getPaytime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getPaytime()) %>" />
						</td>
					</tr>
					<tr>
						<td>
							预付款收款票据：
						</td>
						<td>
							<input name="paynotes" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getPaynotes()==null?"":qt.getPaynotes() %>" />
						</td>
						<td width="132">
							收款账号：
						</td>
						<td width="263">
							<input name="creditcard" value="<%=qt.getCreditcard()==null?"":qt.getCreditcard() %>"
								type="text" size="40" readonly="readonly"
								style="background-color: #F2F2F2" />
						</td>
					</tr>
				</table>
			</div>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							二次收款金额：
						</td>
						<td width="33%">
							<input name="sepay" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getSepay()==0?"":new DecimalFormat("##,###,###,###.00").format(qt.getSepay()) %>" />
						</td>
						<td>
							二次收款日期：
						</td>
						<td>
							<input name="sepaytime" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getSepaytime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getSepaytime()) %>" />
						</td>
						
					</tr>
					<tr>
						<td width="17%">
							二次收款账号：
						</td>
						<td width="33%">
							<input name="sepayacount" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getSepayacount()==null?"":qt.getSepayacount() %>" />
						</td>
						<td>
							二次收款票据：
						</td>
						<td>
							<input name="sepaynotes" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getSepaynotes()==null?"":qt.getSepaynotes() %>" />
						</td>
					</tr>
				</table>
			</div>
			<div class="outborder">
				<table width="95%" cellpadding="5" cellspacing="5">
					<tr>
						<td width="17%">
							应收尾款金额：
						</td>
						<td width="33%">
							<input name="prebalance" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getPrebalance()==0?"":new DecimalFormat("##,###,###,###.00").format(qt.getPrebalance()) %>" />
						</td>
						<td width="17%">
							实收尾款金额：
						</td>
						<td width="33%">
							<input name="balance" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getBalance()==0?"":new DecimalFormat("##,###,###,###.00").format(qt.getBalance()) %>" />
						</td>
					</tr>
					<tr>
						<td>
							尾款收款账号：
						</td>
						<td>
							<input name="balanceacount" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getBalanceacount()==null?"":qt.getBalanceacount() %>" />
						</td>
						<td>
							尾款收款日期：
						</td>
						<td>
							<input name="balancetime" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getBalancetime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getBalancetime()) %>" />
						</td>
					</tr>
					<tr>
						<td>
							项目退款金额：
						</td>
						<td>
							<input name="refund" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getRefund()==0?"":new DecimalFormat("##,###,###,###.00").format(qt.getRefund()) %>" />
						</td>
						<td>
							尾款收款票据：
						</td>
						<td>
							<input name="balancenotes" type="text" size="40"
								style="background-color: #F2F2F2" readonly="readonly"
								value="<%=qt.getBalancenotes()==null?"":qt.getBalancenotes() %>" />
						</td>
						
					</tr>

					<table width="100%" cellpadding="5" cellspacing="5">
						<tr>
							<td width="116">
								项目退款说明：
							</td>
							<td width="593">
								<input name="refunddesc" type="text" size="80" size="40"
									style="background-color: #F2F2F2" readonly="readonly"
									value="<%=qt.getRefunddesc()==null?"":qt.getRefunddesc() %>" />
							</td>
						</tr>
					</table>
			
					<div class="outborder">
						<table width="95%" cellpadding="5" cellspacing="5">
							<tr>
								<td width="17%">
									特殊接待费预算：
								</td>
								<td width="33%">
									<input name="prespefund" type="text" size="40"
										style="background-color: #F2F2F2" readonly="readonly"
										value="<%=qt.getPrespefund()==0?"":new DecimalFormat("##,###,###,###.00").format(qt.getPrespefund()) %>" />
								</td>
								<td width="17%">
									实际特殊接待费：
								</td>
								<td width="33%">
									<input name="spefund" type="text" size="40"
										style="background-color: #F2F2F2" readonly="readonly"
										value="<%=qt.getSpefund()==0?"":new DecimalFormat("##,###,###,###.00").format(qt.getSpefund()) %>" />
								</td>
							</tr>
							<tr>
								<td>
									特殊接待费支付方式：
								</td>
								<td>
									<input name="spefundtype" type="text" size="40"
										style="background-color: #F2F2F2" readonly="readonly"
										value="<%=qt.getSpefundtype()==null?"":qt.getSpefundtype() %>" />
								</td>
								<td>
									特殊接待费支付日期：
								</td>
								<td>
									<input name="spefundtime" type="text" size="40"
										style="background-color: #F2F2F2" readonly="readonly"
										value="<%=qt.getSpefundtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getSpefundtime()) %>" />
								</td>
							</tr>
						</table>

						<table width="95%" cellpadding="5" cellspacing="5">
							<tr>
								<td width="164">
									特殊接待费支付备注：
								</td>
								<td width="546">
									<input name="spefunddesc" type="text" size="70" size="40"
										style="background-color: #F2F2F2" readonly="readonly"
										value="<%=qt.getSpefunddesc()==null?"":qt.getSpefunddesc() %>" />
								</td>
							</tr>
						</table>
					</div>
					<div class="outborder">
						<table width="95%" cellpadding="5" cellspacing="5">
							<tr>
								<td width="17%">
									开票方式：
								</td>
								<td width="33%">
									<input name="invtype" type="text" size="40"
										style="background-color: #F2F2F2" readonly="readonly"
										value="<%=qt.getInvtype() %>" />
								</td>
								<td width="17%">
									票据编号：
								</td>
								<td width="33%">
									<input name="invcode" type="text" size="40"
										style="background-color: #F2F2F2" readonly="readonly"
										value="<%=qt.getInvcode()==null?"":qt.getInvcode() %>" />
								</td>
								
							</tr>
							<tr>
								
								<td width="17%">
									开票总金额：
								</td>
								<td width="33%">
									<input name="invcount" type="text" size="40"
										style="background-color: #F2F2F2" readonly="readonly"
										value="<%=qt.getInvcount()==0?"":new DecimalFormat("##,###,###,###.00").format(qt.getInvcount()) %>" />
								</td>
								<td width="17%">
									实际开票金额222：
								</td>
								<td width="33%">
									<input name="invprice" type="text" size="40"
										style="background-color: #F2F2F2" readonly="readonly"
										value="<%=qt.getInvprice()==0?"":new DecimalFormat("##,###,###,###.00").format(qt.getInvprice()) %>" />
								</td>
							</tr>
							<tr>
								<td width="17%">
									票据抬头：
								</td>
								<td width="33%">
									<input name="invhead" type="text" size="40"
										style="background-color: #F2F2F2" readonly="readonly"
										value="<%=qt.getInvhead()==null?"":qt.getInvhead() %>" />
								</td>
								<td width="17%">
									票据内容：
								</td>
								<td width="33%">
									<input name="invcontent" type="text" size="40"
										style="background-color: #F2F2F2" readonly="readonly"
										value="<%=qt.getInvcontent()==null?"":qt.getInvcontent() %>" />
								</td>
							</tr>
							<tr>
								<td>
									票据日期：
								</td>
								<td>
									<input name="invtime" size="40" type="text"
										style="background-color: #F2F2F2" readonly="readonly"
										value="<%=qt.getInvtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getInvtime()) %>" />
								</td>
								<td>
									税金:
								</td>
								<td>
									<input name="tax" size="40" type="text"
										style="background-color: #F2F2F2" readonly="readonly"
										value="<%=qt.getTax()==0?"":new DecimalFormat("##,###,###,###.00").format(qt.getTax()) %>" />
								</td>
							</tr>
							<tr>
								<td>
									备注：
								</td>
								<td>
									<input name="tag" type="text" size="40"
										style="background-color: #F2F2F2" readonly="readonly"
										value="<%=qt.getTag()==null?"":qt.getTag() %>" />
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
						<table width="95%" cellpadding="5" cellspacing="5">
							<tr>
								<td width="17%">
									业绩核算基数：
								</td>
								<td width="33%">
									<input name="preacount" type="text" size="40"
										style="background-color: #F2F2F2" readonly="readonly"
										value="<%=qt.getPreacount()==0?"":new DecimalFormat("##,###,###,###.00").format(qt.getPreacount()) %>" />
								</td>
								<td width="17%">
									业绩结算基数：
								</td>
								<td width="33%">
									<input name="acount" type="text" size="40"
										style="background-color: #F2F2F2" readonly="readonly"
										value="<%=qt.getAcount()==0?"":new DecimalFormat("##,###,###,###.00").format(qt.getAcount()) %>" />
								</td>
							</tr>
						</table>
					</div>
					<p>
						<div class="outborder">
				<table width="100%" cellpadding="5" cellspacing="5" border="1">
					<tr bgcolor="#A9F5F2">
					 <td>报告编号</td>
					 <td>报告应出时间</td>
					 <td>分项目金额</td>
					 <td>业绩核算基数</td>
					 <td>业绩结算基数</td>
					 <td>操作</td>
					</tr>
				<%
				for(int i=0;i<list.size();i++) {
					Project p = list.get(i);
					ChemProject cp = (ChemProject)p.getObj();
				 %>
					<tr>
						<td><%=p.getRid() %></td>
						<td><%=cp.getRptime() %></td>
						<td><%=p.getPrice() %></td>
						<td><%=p.getPpreacount() %></td>
						<td><%=p.getPacount() %></td>
						<td><a href="../project/projectlog.jsp?sid=<%=p.getSid() %>&ptype=<%=URLEncoder.encode(p.getPtype()) %>" style="color: blue">分项目款项</a></td>
					</tr>
				<%
				}
				 %>
				</table>
			</div>
				
					<hr width="97%" align="center" size=0>
					<div align="center">

						&nbsp;&nbsp;&nbsp;
						<input name="btnBack" class="button1" type="button" id="btnBack"
							value="返回" onClick="goBack()" />
					</div>
					
	</body>
</html>
