<%@page import="com.lccert.crm.vo.Fincome"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page errorPage="../error.jsp"%>
<%@include file="../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	String pid = request.getParameter("pid");
	String idStr = request.getParameter("id");
	String vpYear="2015";
	String vpMonth="01";
	Fincome fincome=null;
	Integer id=0;
	if(idStr==null || "".equals(idStr)){
		if(pid !=null || !"".equals(pid)){
			//根据报价单号查询收入申请表
			fincome=DaoFactory.getInstance().getFincome().getFincomeByVpid(pid);
			if(fincome !=null){
				id=fincome.getId();
			}
		}
	}else{
		id=Integer.parseInt(idStr);
	}
	fincome=DaoFactory.getInstance().getFincome().getFincomeById(id);
	if(fincome==null){
		fincome=new Fincome();
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
		<script src="../js/cashcount/fincome.js"></script>
	</head>
	<body class="body1">
		<form method="post" name="quotationform" id="quotationform" action="editfincome_post.jsp" >
			<input name="command" type="hidden" value="edit" />
			<input name ="id" id ="id" type ="hidden" value="<%=fincome.getId()%>">
			<table width="95%" border="0" cellspacing="0" cellpadding="0"
				height="25">
				<tr>
					<td width="522" class="p1" height="25" nowrap>
						<img src="../images/mark_arrow_02.gif" width="14" height="14">
							&nbsp;
							<b>财务管理&gt;&gt;修改收入申请表</b>
					</td>
				</tr>
			</table>
			<div class="outborder">
				<table width="100%" cellpadding="5" cellspacing="5">
					<tr>
						<td align="right">
							 收款日期：
						</td>
						<td >
							<input type="text" id ="dpaytime"  name ="dpaytime" size="31" value="<%=fincome.getDpaytime()%>">
							<img
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd',el:'dpaytime'})"
								src="../javascript/date/skin/datePicker.gif" width="16"
								height="22" align="middle">
						</td>
						<td align="right">
							所属年份：
						</td>
						<td >
							<input type="text" id ="vpyear"  name ="vpyear" size="35" value="<%=fincome.getVpyear()%>">
						</td>
						<td align="right">
							所属月份：
						</td>
						<td >
							<input type="text" id ="vpmonth"  name ="vpmonth" size="35" value="<%=fincome.getVpmonth()%>">
						</td>
					</tr>
					<tr>
						<td align="right" width="14%">
							客户名称 ：
						</td>
						<td >
							<input type="text" id ="client"  name ="client" size="35" value="<%=fincome.getClient()%>">
							<script>   
						        $("#client").autocomplete("../client_ajax.jsp",{
						            delay:10,
						            max:5,
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
						<td width="14%" align="right">
							所属部门：
						</td>
						<td >
							<input type="text" id ="dept"  name ="dept" size="35" value="<%=fincome.getDept()%>">
						</td>
						<td width="14%" align="right">
							销售人员：
						</td>
						<td >
							<input type="text" id ="sales"  name ="sales" size="35" value="<%=fincome.getSales()%>">
						</td>
					</tr>
					<tr>
						<td width="14%" align="right">
							报价单号：
						</td>
						<td >
							<input type="text" id ="vpid"  name ="vpid" size="35" value="<%=fincome.getVpid()%>">
						</td>
						<td align="right">
							所在省份：
						</td>
						<td >
							<input type="text" id ="province"  name ="province" size="35" value="<%=fincome.getProvince()%>">
						</td>
						<td align="right">
							所在城市：
						</td>
						<td >
							<input type="text" id ="city"  name ="city" size="35" value="<%=fincome.getCity()%>">
						</td>
					</tr>
					<tr>
						<td align="right">
							化学：
						</td>
						<td >
							<input type="text" id ="chem"  name ="chem" size="35" value="<%=fincome.getChem() %>" onblur="sumTotal();">
						</td>
						<td align="right">
							安全：
						</td>
						<td >
							<input type="text" id ="safe"  name ="safe" size="35" value="<%=fincome.getSafe() %>" onblur="sumTotal();">
						</td>
						<td align="right">
							光性能：
						</td>
						<td >
							<input type="text" id ="op"  name ="op" size="35" value="<%=fincome.getOp()%>" onblur="sumTotal();">
						</td>
					</tr>
					<tr>
						<td align="right">
							EMC联营：
						</td>
						<td >
							<input type="text" id ="emc"  name ="emc" size="35" value="<%=fincome.getEmc()%>" onblur="sumTotal();">
						</td>
						<td align="right">
							EMC暗室：
						</td>
						<td >
							<input type="text" id ="dr"  name ="dr" size="35" value="<%=fincome.getDr()%>" onblur="sumTotal();">
						</td>
						<td align="right">
							大客户部：
						</td>
						<td >
							<input type="text" id ="vip"  name ="vip" size="35" value="<%=fincome.getVip()%>" onblur="sumTotal();">
						</td>
					</tr>
					<tr>
						<td align="right">
							环境部：
						</td>
						<td >
							<input type="text" id ="eq"  name ="eq" size="35" value="<%=fincome.getEq()%>" onblur="sumTotal();">
						</td align="right">
						<td align="right">
							财务部：
						</td>
						<td >
							<input type="text" id ="finance"  name ="finance" size="35" value="<%=fincome.getFinance()%>" onblur="sumTotal();">
						</td>
						<td align="right">
							广州公司：
						</td>
						<td >
							<input type="text" id ="gz"  name ="gz" size="35" value="<%=fincome.getGz()%>" onblur="sumTotal();">
						</td>
					</tr>
					<tr>
						<td align="right">
							小计：
						</td>
						<td >
							<input type="text" id ="total"  name ="total" size="35" value="<%=fincome.getTotal()%>">
						</td>
						<td align="right">
							账号名称：
						</td>
						<td >
							<input type="text" id ="account"  name ="account" size="35" value="<%=fincome.getAccount()%>">
						</td>
						<td align="right">
							 票据类型：
						</td>
						<td >
							<select  id="einvtype" name="einvtype" style="width: 250px;">
								<option value="">请选择票据类型</option>
								<option value="专用发票" <%=fincome.getEinvtype()!=null && fincome.getEinvtype().equals("专用发票")?"selected":"" %>>专用发票</option>
								<option value="普通发票" <%=fincome.getEinvtype()!=null && fincome.getEinvtype().equals("普通发票")?"selected":"" %>>普通发票</option>
								<option value="收据" <%=fincome.getEinvtype()!=null && fincome.getEinvtype().equals("收据")?"selected":"" %>>收据</option>
							</select>
						</td>
						</td>
					</tr>
					<tr>
						<td align="right">
							票据编号：
						</td>
						<td >
							<input type="text" id ="einvno"  name ="einvno" size="35" value="<%=fincome.getEinvno()%>">
						</td>
						<td align="right">
							备注：
						</td>
						<td >
							<textarea rows="6" cols="33" id ="remarks"  name ="remarks" ><%=fincome.getRemarks()%></textarea>
						</td>
						<td align="right">
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
