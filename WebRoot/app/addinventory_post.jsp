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
	//��Ʒ����
	String productId = request.getParameter("id");
	String status = request.getParameter("status");
	String type = request.getParameter("type");
	String inventoryId = request.getParameter("inventoryId");
	
	//����
	String earea = request.getParameter("earea");
	//���
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
		//��λ
		String unit=request.getParameter("unit");
		//��Ӧ��
		//����
		String number = request.getParameter("number");
		if(!("".equals(number) || number == null)) {
			count = Integer.parseInt(number);
		}
		//���ձ�ע
		String remark = request.getParameter("remark");
		//��Ӧ��
		String client = request.getParameter("suppliername");
		int clientCount = ApplicationAction.getInstance().getSupplierByName(client);
		if(!status.equals("����")){
			if(clientCount==0) {
				out.println("�ͻ������ڣ����������룡");
				out.println("<br><a href='javascript:window.history.back();'>����</a>");
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
				out.println("alert('�����ɹ�');");
				out.println("window.close();");
				out.println("</script>");
			return;
			}
		}
		if(count>0&&type.equals("del")) {
				out.println("<div alight=center>");
			out.println("�����ɹ�");
			out.println("<a href='in_statistics.jsp'>����</a>");
			out.println("</div>");
			return;
			}
		out.println("<div alight=center>");
		out.println("����ʧ�ܣ��뷵���������룡");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		out.println("</div>");
		return;
		
%>