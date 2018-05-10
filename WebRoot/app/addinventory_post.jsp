<%@page import="com.lccert.lcim.app.ApplicationAction"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.vo.Inventory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>

<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="com.lccert.crm.kis.QuoItem"%>
<%@page import="com.lccert.crm.kis.Item"%>
<%@page import="com.lccert.crm.kis.ItemAction"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="com.lccert.crm.kis.Company"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.kis.Bank"%>
<%@page import="com.lccert.crm.kis.AdvanceType"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@ include file="../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%
	request.setCharacterEncoding("GBK");
	//产品名称
	String productId = request.getParameter("id");
	String status = request.getParameter("status");
	String type = request.getParameter("type");
	String inventoryId = request.getParameter("inventoryId");
	
	//区域
	String earea = request.getParameter("earea");
	//规格
	String standard = request.getParameter("standard");
	String strPrice = request.getParameter("price");
	List list =new ArrayList();
	int count=0;
	if(type.equals("del")){
		list.add(inventoryId);
		count=DaoFactory.getInstance().getInventoryDao().delInventory("inventory",list);
	}else{
		float price = 0;
		if(!("".equals(strPrice) || strPrice == null)) {
			price = Float.parseFloat(strPrice);
		}
		//单位
		String unit=request.getParameter("unit");
		//供应商
		//数量
		String number = request.getParameter("number");
		if(!("".equals(number) || number == null)) {
			count = Integer.parseInt(number);
		}
		//验收备注
		String remark = request.getParameter("remark");
		//供应商
		String client = request.getParameter("suppliername");
		int clientCount = ApplicationAction.getInstance().getSupplierByName(client);
		if(!status.equals("出库")){
			if(clientCount==0) {
				out.println("客户不存在，请重新输入！");
				out.println("<br><a href='javascript:window.history.back();'>返回</a>");
				return;
			}
		}
		
		list.add(productId);
		list.add(earea);
		list.add(count);
		list.add(status);
		list.add(price);
		list.add(client);
		list.add(remark);
		if(type.equals("add")){
			count=DaoFactory.getInstance().getInventoryDao().addInventory("inventory",list);
		}else if (type.equals("modi")){
			list.add(inventoryId);
			count=DaoFactory.getInstance().getInventoryDao().updInventory("inventory",list);
		}
			if(count>0) {
				out.println("<script type='text/javascript'>");
				out.println("alert('操作成功');");
				out.println("window.close();");
				out.println("</script>");
			return;
			}
		}
		if(count>0&&type.equals("del")) {
				out.println("<div alight=center>");
			out.println("操作成功");
			out.println("<a href='in_statistics.jsp'>返回</a>");
			out.println("</div>");
			return;
			}
		out.println("<div alight=center>");
		out.println("操作失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		out.println("</div>");
		return;
		
%>