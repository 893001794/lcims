<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ include file="../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	List quoitemlist = new ArrayList();
	int number = 0;
	boolean flag =true;
	String sno=request.getParameter("sno");
	String sname=request.getParameter("sname");
	String smodel=request.getParameter("smodel");
	String sid=request.getParameter("sid");
	String speichorot=request.getParameter("speichorot");
	//String strId=request.getParameter("id");
	String strId=request.getParameter("strId");
//	System.out.println(strId+"-----");
	flag =true;
	if(strId !=null){
	
		String [] ids=strId.split(";");
			//System.out.println(ids+"----");
			for(int i =0;i<ids.length;i++){
			List list =new ArrayList();
			//System.out.println(ids[i]+"----------------");
				int id=Integer.parseInt(ids[i]);
			//	list.add(sno);
				list.add(sname);
				list.add(smodel);
				list.add(sid);
				list.add(speichorot);
				list.add(id);
				//System.out.println(sno+"---"+sname+"---"+smodel+"--"+sid+"---"+speichorot+"----"+id);
				int count =DaoFactory.getInstance().getSimpleDao().upSample(list);
				if(count==0){
				flag=false;
				}
				}
				
		if(flag !=false) {
			out.println("修改成功!<br>");
			return;
		}else{
			out.println("修改失败！<br>");
			out.println("<a href='javascript:window.history.back();'>返回</a>");
		}
		
		
	}
	
%>
