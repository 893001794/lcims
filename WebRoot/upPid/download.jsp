<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.net.URLEncoder"%>

<%
	request.setCharacterEncoding("GBK");
	String fs = System.getProperties().getProperty("file.separator");
	String icode = request.getParameter("id");
	System.out.println(icode+"-----------------");
	if (icode == null || "".equals(icode)) {
		out.println("<script type='text/javascript'>");
		out.println("alert('����������');");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	//String ctime = request.getParameter("ctime");
	//���ͼƬ��·��
	//String path=fs+"opt"+fs+"invoice";
	//String path=fs+fs+"192.168.0.7"+fs+"imtest";
	String path=fs+fs+"file"+fs+"10 ��Ѷ��"+fs+"attachmot";
	String filedownload = path+ fs + icode+".pdf";
	String filedisplay = icode+".pdf";
	filedisplay = URLEncoder.encode(filedisplay, "UTF-8");
	

	java.io.OutputStream outp = null;
	java.io.FileInputStream in = null;
	try {
		in = new FileInputStream(filedownload);
		
		//�����ļ�����ʱ�����ļ�������ķ�ʽ����   
		//����response.reset()���������еģ�>���治Ҫ���У��������һ����   
		
		response.reset();//���Լ�Ҳ���Բ���   
		response.setContentType("application/x-download");
		response.addHeader("Content-Disposition", "attachment;filename=" + filedisplay);
		outp = response.getOutputStream();
		byte[] b = new byte[1024];
		int i = 0;

		while ((i = in.read(b)) > 0) {
			outp.write(b, 0, i);
		}
		//     
		outp.flush();
		//Ҫ���������仰������ᱨ��   
		//java.lang.IllegalStateException: getOutputStream() has already been called for //this response
		out.clear();
		out = pageContext.pushBody();
	} catch (FileNotFoundException e1) {
		out.println("<script type='text/javascript'>");
		out.println("alert('ͼƬ������');");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
	} catch (IOException e) {
		out.println("<script type='text/javascript'>");
		out.println("alert('���ͼƬ���ݳ���');");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
	} finally {
		if (in != null) {
			in.close();
			in = null;
		}
		if(outp != null) {
			outp.close();
			outp = null;
		}
	}
%>