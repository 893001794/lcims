<%@page import="com.lccert.oa.searchFactory.SearchFactory"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
    <%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.system.Forum"%>
<%@page import="com.lccert.crm.system.ForumAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("GBK");
	String status=request.getParameter("status");
	System.out.println(status);
	String nameshort = request.getParameter("nameshort");
	String keyman = request.getParameter("keyman");
	String cId = request.getParameter("contactId");
	int conId=0;
	if(cId !=null){
	  conId =Integer.parseInt(cId);
	}
	String nowman =request.getParameter("nowman");
	String contatdate =request.getParameter("contatdate");
	String saywords =request.getParameter("saywords");
	//客户id
	String custId =request.getParameter("custId");
	//System.out.println(contatdate+"-----------------");
	//登记人
	String xsdb =request.getParameter("xsdb");
	//获取现在时间
	String add1=new SimpleDateFormat("HH:mm").format(new Date());
	List temp =new ArrayList();
	//contactID,custID,nameshort,contactman,contactdate
	temp.add(custId);
	temp.add(nameshort);
	temp.add(keyman);
	//temp.add("2011-12-8 00:00:00");
	temp.add(contatdate);
	temp.add(saywords);
	temp.add(nowman);
	temp.add(xsdb);
	temp.add(add1);
	//temp.add(custId);
	int count =0;
	if(status.equals("add")){
		//获取联系记录的id
		List row=new SearchFactory().getVOLClient().getContactId();
		List coulumn =(List)row.get(0);
		int contactId=0;
		if(coulumn.get(0)!=null){
			contactId=Integer.parseInt(coulumn.get(0).toString())+1;
		}
		temp.add(contactId);
		count =new SearchFactory().getVOLClient().addContact(temp);
	}
	else if(status.equals("del")){
		count=new SearchFactory().getVOLClient().delContact(conId);
	}
	else if(status.equals("modify")){
		temp.add("conId");
		count=new SearchFactory().getVOLClient().updContact(temp);
	}
	if(count>0) {
		out.println("<script language=javascript>");
		out.println("alert('操作成功')");
		out.println("parent.location.reload();");
		out.println("</script>");
	} else {
		out.println("<script language=javascript>");
		out.println("alert('操作失败')");
		out.println("parent.location.reload();");
		out.println("</script>");
		return;
	}
%>