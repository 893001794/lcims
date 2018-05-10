<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>


<%
	request.setCharacterEncoding("GBK");
	String[] codes = request.getParameterValues("code");
	//String[] contents = request.getParameterValues("content");
	for(int i=0;i<codes.length;i++) {
		System.out.println("codes:" + codes[i]);
		//System.out.println(contents[i]);
	}
%>