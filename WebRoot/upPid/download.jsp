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
		out.println("alert('附件不存在');");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	//String ctime = request.getParameter("ctime");
	//存放图片的路径
	//String path=fs+"opt"+fs+"invoice";
	//String path=fs+fs+"192.168.0.7"+fs+"imtest";
	String path=fs+fs+"file"+fs+"10 资讯部"+fs+"attachmot";
	String filedownload = path+ fs + icode+".pdf";
	String filedisplay = icode+".pdf";
	filedisplay = URLEncoder.encode(filedisplay, "UTF-8");
	

	java.io.OutputStream outp = null;
	java.io.FileInputStream in = null;
	try {
		in = new FileInputStream(filedownload);
		
		//关于文件下载时采用文件流输出的方式处理：   
		//加上response.reset()，并且所有的％>后面不要换行，包括最后一个；   
		
		response.reset();//可以加也可以不加   
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
		//要加以下两句话，否则会报错   
		//java.lang.IllegalStateException: getOutputStream() has already been called for //this response
		out.clear();
		out = pageContext.pushBody();
	} catch (FileNotFoundException e1) {
		out.println("<script type='text/javascript'>");
		out.println("alert('图片不存在');");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
	} catch (IOException e) {
		out.println("<script type='text/javascript'>");
		out.println("alert('输出图片数据出错');");
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