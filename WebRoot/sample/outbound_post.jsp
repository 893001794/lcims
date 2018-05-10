<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ include file="../../comman.jsp"  %>
<%
	request.setCharacterEncoding("GBK");
	boolean flag =true;
	String outdatetime=request.getParameter("outdatetime");
	String tpplication=request.getParameter("tpplication");
	//System.out.println(tpplication+"--------");
	String strId =request.getParameter("strId");
	String status =request.getParameter("status");
	status=new String(status.getBytes("ISO-8859-1"),"GBK");
	//System.out.println(status+"-----status---");
int id=0;
if(strId==null){
strId="";
}
if(strId !=null&&!strId.equals("")){
	String [] ids=strId.split(";");
			//System.out.println(ids+"----");
			for(int i =0;i<ids.length;i++){
			id=Integer.parseInt(ids[i]);
			List list =new ArrayList();
			list.add("vsno");
			List row=DaoFactory.getInstance().getSimpleDao().getSampleById(list,id);
			List column =(List)row.get(0);
			String sno =column.get(0).toString();
			List outBundList = new ArrayList();
			outBundList.add(sno);
			outBundList.add(outdatetime);
			outBundList.add(tpplication);
			outBundList.add(status);
			int count=DaoFactory.getInstance().getSimpleDao().addSamplePackage1(outBundList);
			if(count ==0){
			flag=false;
			}
			}
}
	if(flag ==true){
			out.println("<script type='text/javascript'>");
			out.println("alert('操作成功')");
		//	out.println("window.close();");
			out.println("</script>");
			return;
	}else{
		out.println("<script type='text/javascript'>");
			out.println("alert('操作失败')");
			out.println("window.close();");
			out.println("</script>");
			out.println("<a href='javascript:window.history.back();'>返回</a>");
		}
%>
