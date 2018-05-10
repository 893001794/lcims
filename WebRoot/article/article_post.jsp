<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.TimerTask.MyTimerTask"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="com.lccert.crm.vo.Depot"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@ include file="../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%
	request.setCharacterEncoding("GBK");
	int id =0;
	String statusStr="";
	String depotid="";
	String hrefStr="";
	//��ȡ������״̬
	String status=request.getParameter("status");
	if(status.equals("del")){
	 depotid =request.getParameter("id");
	id =DaoFactory.getInstance().getDepotDao().delDeport(Integer.parseInt(depotid));
	statusStr="ɾ��";
	hrefStr="article_manage.jsp";
	}else{
	//��ȡ��Ʒ����
	String article = request.getParameter("article");
	//��ȡƷ��
	String c1 = request.getParameter("c1");
	//��ȡ����ͺ�
	String  specification= request.getParameter("specification");
	//��ȡ����
	String  number= request.getParameter("number");
	//��ȡ���
	String  price= request.getParameter("price");
	//��ȡ��Ӧ��
	String  client= request.getParameter("client");
	//��ȡ������λ
	String c2 = request.getParameter("c2");
	//��ȡʹ��״̬
	String  c3= request.getParameter("c3");
	//��ȡʹ�ò���
	String  dept= request.getParameter("dept");
	//��ȡ���λ��
	String c4 = request.getParameter("c4");
	//��ȡʹ������
	String usedateStr = request.getParameter("usedate");
	Date usedate = null;
	if(usedateStr != null && !"".equals(usedateStr)) {
		usedate = new SimpleDateFormat("yyy-MM-dd").parse(usedateStr);
	}
	
	//��ȡ��ͬ���
	String contract=request.getParameter("contract");
	//��ȡ���λ��
	String c5 = request.getParameter("c5");
	//��ȡ������
	String  keeper= request.getParameter("keeper");
	//�����û���������ѯ�û���id
	int userid =UserAction.getInstance().getIdByName(keeper);
	//��ȡ��У׼����
	String nextcalStr = request.getParameter("nextcal");
	Date nextcal = null;
	if(nextcalStr != null && !"".equals(nextcalStr)) {
		nextcal = new SimpleDateFormat("yyy-MM-dd").parse(nextcalStr);
		
	}else{
	nextcal = new SimpleDateFormat("yyy-MM-dd").parse(new Date().toLocaleString());
	}
	//��ȡУ׼����
	String calibrationStr = request.getParameter("calibration");
	Date calibration = null;
	if(calibrationStr != null && !"".equals(calibrationStr)) {
		calibration = new SimpleDateFormat("yyy-MM-dd").parse(calibrationStr);
	}else{
	calibration = new SimpleDateFormat("yyy-MM-dd").parse(new Date().toLocaleString());
	}
	//��ȡ��Ʊ����
	String  invoicecode= request.getParameter("invoicecode");
	//��ȡ��Ʊ����
	String  invoiceno= request.getParameter("invoiceno");
	//��ȡ��ע
	String  notes= request.getParameter("notes");
	String company ="";
	String str =user.getCompany();
	if(str.equals("��ɽ")){
	str="Z";
	}
	if(str.equals("��ݸ")){
	str="D";
	}
	if(str.equals("����")){
	str="G";
	}
	
	Depot depot=new Depot();

	depot.setAid(Integer.parseInt(article));
	depot.setBrand(c1);
	depot.setSpecification(specification);
	depot.setPrice(Float.parseFloat(price));
	depot.setNumber(Integer.parseInt(number));
	depot.setUnitofaccount(c2);
	depot.setClient(client);
	depot.setDeptid(Integer.parseInt(dept));
	depot.setUsestatus(c3);
	depot.setUserdate(usedate);
	depot.setAperture(c4);
	depot.setKeepid(userid);
	depot.setFundstype(c5);
	depot.setCalibration(calibration); 
	depot.setNextcal(nextcal); 
	depot.setInvoicecode(invoicecode);
	depot.setInvoiceno(invoiceno);
	depot.setRemarks(notes);
	depot.setContract(contract);
	
	if(status.equals("ad")){
	id =DaoFactory.getInstance().getDepotDao().addDepot(depot,str);
	statusStr="���";
	}if(status.equals("up")){
	 depotid =request.getParameter("id");
	depot.setId(Integer.parseInt(depotid));
	id =DaoFactory.getInstance().getDepotDao().updateDepot(depot);
	statusStr="����";
	}
	hrefStr="printarticle.jsp?id=" + id ;
	 }
	if(id !=0) {
		out.println("<div alight=center>");
		out.println(statusStr+"�ɹ�");
		out.println("<a href='"+hrefStr+"'>����</a>");
		out.println("</div>");
		return;
	} else {
		out.println("<div alight=center>");
		out.println(statusStr+"ʧ�ܣ��뷵���������룡");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
	out.println("</div>");
	return;
	}
%>