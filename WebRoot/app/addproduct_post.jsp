<%@page import="com.lccert.lcim.app.ApplicationAction"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
     <%@ page errorPage="../../error.jsp" %>
<%
	request.setCharacterEncoding("GBK");
	String product=request.getParameter("product");
	String status =request.getParameter("status");
	int count =0;
	String proudctId =request.getParameter("proudctId");
	List list =new ArrayList ();
	if(status.equals("del")){
		list.add(proudctId);
		count=DaoFactory.getInstance().getInventoryDao().delInventory("product",list);
	}else{
		String genera =request.getParameter("genera");
		String warning =request.getParameter("warning");
		String assets =request.getParameter("assets");
		int warningCount=0;
		if(warning !=null){
			warningCount=Integer.parseInt(warning);
		}
		int generaId =0;
		if(!("".equals(genera) || genera == null)){
			//List row =DaoFactory.getInstance().getInventoryDao().getCategory(genera,"product");
			//if(row.size()>0){
			//List column =(List)row.get(0);
				generaId=Integer.parseInt(genera);
			//}
		}
		String group =request.getParameter("group");
		
		int groupId =Integer.parseInt(group);
		String standard = request.getParameter("standard");
		if(proudctId !=null&&!status.equals("modify")){
			List isProduct=DaoFactory.getInstance().getInventoryDao().getIsProduct(product,standard,"product");
			if(isProduct.size()>0) {
				out.println("��ƷӦ�����ڻ��������ظ���");
				out.println("<br><a href='javascript:window.history.back();'>����</a>");
				return;
			}
		}
		//��Ӧ��
		String client = request.getParameter("suppliername");
		//int clientCount = ApplicationAction.getInstance().getSupplierByName(client);
		//if(!status.equals("modify")){
		//	if(clientCount==0) {
		//		out.println("�ͻ������ڣ����������룡");
		//		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		//		return;
		//	}
		//}
		String unit = request.getParameter("unit");
		String priceStr = request.getParameter("price");
			float price = 0;
		if(!("".equals(priceStr) || priceStr == null)) {
			price = Float.parseFloat(priceStr);
		}
		list.add(product);
		list.add(standard);
		list.add(generaId);
		list.add(groupId);
		list.add(unit);
		list.add(price);
		list.add(client);
		list.add(warningCount);
		list.add(assets);
		if(status.equals("modify")){
		list.add(proudctId);
		count=DaoFactory.getInstance().getInventoryDao().updInventory("product",list);
		}else{
		count=DaoFactory.getInstance().getInventoryDao().addInventory("product",list);
		}
	}
	//---------------------2010-12-29--------------------
	if(count>0) {
		if(status.equals("1")){
			out.print("<SCRIPT language=javascript>");
			out.print("function go(){alert('��ӳɹ�������');window.history.go(-1);}");
			out.print("setTimeout('go()',0)");
			out.print("</SCRIPT>");
			}else{
			out.println("<div alight=center>");
			out.println("�����ɹ�");
			out.println("<a href='product.jsp'>����</a>");
			out.println("</div>");
		}
	return;
	} else {
		out.println("<div alight=center>");
		out.println("����ʧ�ܣ��뷵���������룡");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		out.println("</div>");
		return;
	}
%>