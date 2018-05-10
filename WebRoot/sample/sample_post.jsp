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
	String pno=request.getParameter("pno");
	//String [] pnos =request.getParameterValues("packageNo");
	String [] snos =request.getParameterValues("sno");
	//System.out.println(snos+"-------------");
	String [] snames =request.getParameterValues("sname");
	String [] smodels =request.getParameterValues("smodel");
	String [] sids =request.getParameterValues("sid");
	String [] speichorots =request.getParameterValues("speichorot");
	for(int i=0;i<snos.length;i++) {
				List pursue=new ArrayList();
				pursue.add(snos[i]);
				pursue.add(pno);
				pursue.add(user.getName());
				int pCount=DaoFactory.getInstance().getSimpleDao().addSamplePursue(pursue);
				if(pCount == 0){
					flag =false;
				}
				if(flag !=false){
				List list =new ArrayList();
				//System.out.println("pno:"+pno+"--sno:"+snos[i]+"--sname:"+snames[i]+"--smodel:"+smodels[i]+"--sid"+sids[i]+"--speichorots-"+speichorots[i]);
				list.add(snos[i]);
				list.add(sids[i]);
				list.add(snames[i]);
				list.add(smodels[i]);
				//list.add(pno);
				list.add(speichorots[i]);
				list.add(user.getName());
				int count=DaoFactory.getInstance().getSimpleDao().addSample(list);
					if(count==0){
					flag =false;
					}
			
			}
		}	
	if(flag !=false) {
			out.println("添加成功!<br>");
			return;
	}else{
			out.println("添加失败！<br>");
			out.println("<a href='javascript:window.history.back();'>返回</a>");
		}
%>
