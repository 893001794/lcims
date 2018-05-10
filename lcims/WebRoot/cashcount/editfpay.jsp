<%@page import="com.lccert.crm.vo.Fpay"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page errorPage="../error.jsp"%>
<%@include file="../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	String idStr = request.getParameter("id");
	Fpay fpay=null;
	Integer id=Integer.parseInt(idStr);
	fpay=DaoFactory.getInstance().getFpay().getFpayById(id);
	if(fpay==null){
		fpay=new Fpay();
	}
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>添加报价单</title>
		<script language="javascript" type="text/javascript" src="../javascript/date/WdatePicker.js"></script>
		<link rel="stylesheet" type="text/css" href="../css/jquery.autocomplete.css" />
		<script src="../javascript/jquery.js"></script>
		<script language="javascript" type="text/javascript" src="../javascript/date/WdatePicker.js"></script>
		<script src="../javascript/jquery.autocomplete.min.js"></script>
		<script src="../javascript/Calendar.js"></script>
		<script src="../js/cashcount/fpay.js"></script>
		
		
	</head>
	<body class="body1">
		<form method="post" name="quotationform" id="quotationform" action="editfpay_post.jsp" >
			<input name="command" type="hidden" value="edit" />
			<input name ="fpayId" id ="fpayId" type ="hidden" value="<%=id%>">
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
						<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>财务管理&gt;&gt;修改支出申请表</b>
					</td>
				</tr>
			</table>
			<div class="outborder">
				<table width="100%" cellpadding="5" cellspacing="5">
					<tr>
						<td align="right">
							 支出日期：
						</td>
						<td >
							<input type="text" id ="dpaytime"  name ="dpaytime" size="31" value="<%=fpay.getDpaytime()%>">
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'dpaytime'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
						<td align="right" width="14%">
							供应商 ：
						</td>
						<td >
							<input type="text" id ="supplier"  name ="supplier" size="35" value="<%=fpay.getSupplier()%>">
						</td>
						<td align="right">
							摘要：
						</td>
						<td >
							<input type="text" id ="summay"  name ="summay" size="35" value="<%=fpay.getSummay()%>">
						</td>
					</tr>
					<tr>
						<td width="14%" align="right">
							所属部门：
						</td>
						<td >
							<select id="dept" name="dept" style="width: 280px;">
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("销售一部")?"selected":"" %>>销售一部</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("销售二部")?"selected":"" %>>销售二部</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("销售三部")?"selected":"" %>>销售三部</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("大客户部")?"selected":"" %>>大客户部</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("销售五部")?"selected":"" %>>销售五部</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("EMC部")||fpay.getDept().equals("EMC组")?"selected":"" %>>EMC组</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("JIM团队")?"selected":"" %>>JIM团队</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("销售客服")?"selected":"" %>>销售客服</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("环境部")?"selected":"" %>>环境部</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("财务部")?"selected":"" %>>财务部</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("行政部")?"selected":"" %>>行政部</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("质控部")?"selected":"" %>>质控部</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("总经办")?"selected":"" %>>总经办</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("化学实验室")?"selected":"" %>>化学实验室</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("安全实验室")?"selected":"" %>>安全实验室</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("光性能实验室")?"selected":"" %>>光性能实验室</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("EMC实验室")?"selected":"" %>>EMC实验室</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("培训学院")?"selected":"" %>>培训学院</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("广州公司")?"selected":"" %>>广州公司</option>
								<option <%=fpay.getDept()!=null && fpay.getDept().equals("工程部")?"selected":"" %>>工程部</option>
							</select>
						</td>
						<td width="14%" align="right">
							人员：
						</td>
						<td >
							<input type="text" id ="person"  name ="person" size="35" value="<%=fpay.getPerson() %>">
						</td>
						<td width="14%" align="right">
							总经办：
						</td>
						<td >
							<input type="text" id ="gmo"  name ="gmo" size="35" value="<%=fpay.getGmo()%>" onblur="sumTotal();">
						</td>
					</tr>
					<tr>
						<td align="right">
							化学：
						</td>
						<td >
							<input type="text" id ="chem"  name ="chem" size="35" value="<%=fpay.getChem()%>" onblur="sumTotal();">
						</td>
						<td align="right">
							安全：
						</td>
						<td >
							<input type="text" id ="safe"  name ="safe" size="35" value="<%=fpay.getSafe() %>" onblur="sumTotal();">
						</td>
						<td align="right">
							光性能：
						</td>
						<td >
							<input type="text" id ="op"  name ="op" size="35" value="<%=fpay.getOp() %>" onblur="sumTotal();">
						</td>
					</tr>
					<tr>
						<td align="right">
							EMC联营：
						</td>
						<td >
							<input type="text" id ="emc"  name ="emc" size="35" value="<%=fpay.getEmc() %>" onblur="sumTotal();">
						</td>
						<td align="right">
							EMC暗室：
						</td>
						<td >
							<input type="text" id ="dr"  name ="dr" size="35" value="<%=fpay.getDr() %>" onblur="sumTotal();">
						</td>
						<td align="right">
							大客户部：
						</td>
						<td >
							<input type="text" id ="vip"  name ="vip" size="35" value="<%=fpay.getVip() %>" onblur="sumTotal();">
						</td>
					</tr>
					<tr>
						<td align="right">
							环境部：
						</td>
						<td >
							<input type="text" id ="eq"  name ="eq" size="35" value="<%=fpay.getEq()%>" onblur="sumTotal();">
						</td align="right">
						<td align="right">
							财务部：
						</td>
						<td >
							<input type="text" id ="finance"  name ="finance" size="35" value="<%=fpay.getFinance() %>" onblur="sumTotal();">
						</td>
						<td align="right">
							行政部：
						</td>
						<td >
							<input type="text" id ="administration"  name ="administration" size="35" value="<%=fpay.getAdministration() %>" onblur="sumTotal();">
						</td>
					</tr>
					<tr>
						<td align="right">
							工程部：
						</td>
						<td >
							<input type="text" id ="engineering"  name ="engineering" size="35" value="<%=fpay.getEngineering() %>" onblur="sumTotal();">
						</td>
						<td align="right">
							小计：
						</td>
						<td >
							<input type="text" id ="total"  name ="total" size="35" value="<%=fpay.getTotal() %>">
						</td>
						<td align="right">
							账号名称：
						</td>
						<td >
							<select id="account" name ="account"; style="width: 280px;">
								<option value="1769" <%=fpay.getAccount()!=null && fpay.getAccount().equals("1769")?"selected":"" %>>1769</option>
								<option value="1769-0002" <%=fpay.getAccount()!=null && fpay.getAccount().equals("1769-0002")?"selected":"" %>>1769-0002</option>
								<option value="1769-0003" <%=fpay.getAccount()!=null && fpay.getAccount().equals("1769-0003")?"selected":"" %>>1769-0003</option>
								<option value="1769-0004" <%=fpay.getAccount()!=null && fpay.getAccount().equals("1769-0004")?"selected":"" %>>1769-0004</option>
								<option value="5963" <%=fpay.getAccount()!=null && fpay.getAccount().equals("5963")?"selected":"" %>>5963</option>
								<option value="3232" <%=fpay.getAccount()!=null && fpay.getAccount().equals("3232")?"selected":"" %>>3232</option>
								<option value="8833" <%=fpay.getAccount()!=null && fpay.getAccount().equals("8833")?"selected":"" %>>8833</option>
								<option value="5016" <%=fpay.getAccount()!=null && fpay.getAccount().equals("5016")?"selected":"" %>>5016</option>
								<option value="4193" <%=fpay.getAccount()!=null && fpay.getAccount().equals("4193")?"selected":"" %>>4193</option>
								<option value="7084" <%=fpay.getAccount()!=null && fpay.getAccount().equals("7084")?"selected":"" %>>7084</option>
								<option value="1050" <%=fpay.getAccount()!=null && fpay.getAccount().equals("1050")?"selected":"" %>>1050</option>
								<option value="现金" <%=fpay.getAccount()!=null && fpay.getAccount().equals("现金")?"selected":"" %>>现金</option>
								<option value="HK-现金" <%=fpay.getAccount()!=null && fpay.getAccount().equals("HK-现金")?"selected":"" %>>HK-现金</option>
							</select>
						</td>
						
					</tr>
					<tr>
						<td align="right">
							 票据类型：
						</td>
						<td >
							<select id="einvtype" name ="einvtype"; style="width: 280px;" >
								<option value="发票" <%=fpay.getEinvtype()!=null && fpay.getEinvtype().equals("发票")?"selected":"" %>>发票</option>
								<option value="收据" <%=fpay.getEinvtype()!=null && fpay.getEinvtype().equals("收据")?"selected":"" %>>收据</option>
							</select>
						</td>
						<td align="right">
							 发票号码：
						</td>
						<td >
							<input type="text" id ="invoiceno"  name ="invoiceno" size="35" value="<%=fpay.getInvoiceno() %>">
						</td>
						<td align="right">
							备注：
						</td>
						<td >
							<textarea rows="6" cols="33" id ="remarks"  name ="remarks"> <%=fpay.getRemarks() %></textarea>
						</td>
						
					</tr>
					<tr>
						<td align="right">
							一级科目：
						</td>
						<td >
							<input type="text" id ="onelevelsub"  name ="onelevelsub" size="35" value="<%=fpay.getOnelevelsub() %>">
						</td>
						
						<td align="right">
							二级科目
						</td>
						<td >
							<input type="text" id ="twolevelsub"  name ="twolevelsub" size="35" value="<%=fpay.getTwolevelsub() %>">
						</td>
						<td >
							三级科目
						</td>
						<td >
							<input type="text" id ="threelevelsub"  name ="threelevelsub" size="35" value="<%=fpay.getThreelevelsub() %>" onblur="findSubsByThreeLevelSub(this.value);">
						</td>
					</tr>
					<tr>
						<td align="right">
							出差地区：
						</td>
						<td >
							<input type="text" id ="travel"  name ="travel" size="35" value="<%=fpay.getTravel() %>">
						</td>
						
						<td align="right">
							招待客户
						</td>
						<td >
							<input type="text" id ="entertain"  name ="entertain" size="35" value="<%=fpay.getEntertain() %>">
						</td>
						<td >
							&nbsp;
						</td>
						<td >
							&nbsp;
						</td>
					</tr>
				</table>
			</div>
			<hr width="97%" align="center" size=0>
			<div align="center">
				<input name="btnAdd" class="button1" type="submit"" id="btnAdd" value="修改" > &nbsp;&nbsp;&nbsp;&nbsp;
				<input name="btnBack" class="button1" type="button" id="btnBack" value="返回" onClick="javascript:window.history.back();" />
			</div>
		</form>
		<p>&nbsp;</p>
	</body>
</html>
