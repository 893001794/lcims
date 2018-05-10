<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ChemLabTime"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lccert.crm.project.Warnning"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.chemistry.barcode.BarCodeAction"%>
<%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.project.DynamicProjectTime"%>
<%@page import="com.lccert.crm.project.ProjectTimeAction"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@page import="com.lccert.crm.chemistry.util.Config"%>
<%@ include file="../../comman.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
 %>
<%
	request.setCharacterEncoding("GBK");
	SmartUpload up = new SmartUpload();
	up.initialize(this.getServletConfig(),request,response);
	up.setMaxFileSize(500 * 1024*1024);
	//up.setAllowedFilesList("doc,txt,xls,tif");
	//up.setDeniedFilesList("ext,bat,jsp,htm,html");
	up.upload();
	String command = up.getRequest().getParameter("command");
	if(command == null || "".equals(command)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	if(command != null && "add".equals(command)) {
		String savepath = "";
		String sid = up.getRequest().getParameter("sid");
		if(sid == null || "".equals(sid)) {
			out.println("<script type='text/javascript'>");
			out.println("window.self.location='javascript:window.history.back();';");
			out.println("</script>");
			return;
		}
	
		String rid = up.getRequest().getParameter("rid");
		String event = up.getRequest().getParameter("event");
		String count = request.getParameter("count");
		String type = request.getParameter("type");
		String u = user.getName();
		String str = "";
		if("send".equals(event)) {
			str = count + "发出" + type + "通知";
		} else if("accept".equals(event)){
			str = count + "收到" + type + "样品";
		} else {
			str = event;
		}
		
		String fs = System.getProperties().getProperty("file.separator");
		String head = new Config()._PATH;
		String filepath = "buyangfujian";
		String filename = rid;
		
		java.io.File savedir = new java.io.File(head + fs + filepath);
		// 如果目录不存在就创建
		if (!savedir.exists()) {
			savedir.mkdirs();
		}
		
		for(int i=0;i<up.getFiles().getCount();i++) {
		com.jspsmart.upload.File file = up.getFiles().getFile(i);
		
		if(file.isMissing()) continue;
		
		savepath = filepath + fs + filename + "buyang." + file.getFileExt();
		//保存图片到服务器
		file.saveAs(head + fs + savepath,SmartUpload.SAVE_PHYSICAL);
		//保存图片到数据库
		}
		
		DynamicProjectTime dpt = new DynamicProjectTime();
		dpt.setSid(sid);
		dpt.setRid(rid);
		dpt.setUser(u);
		dpt.setEvent(str);
		dpt.setFilepath(savepath);
		
		if(ProjectTimeAction.getInstance().addProjectTime(dpt)) {
		String url = basePath + "sampleannex?sid=" + sid;
		ProjectTimeAction.getInstance().sendAnnexEmail(sid,url);
		out.println("<div alight=center>");
		out.println("项目动态添加成功");
		out.println("<a href='javascript:window.close();window.opener.document.location.reload();'>关闭</a>");
		out.println("</div>");
		return;
		} else {
			out.println("<div alight=center>");
			out.println("项目动态添加失败！");
			out.println("<br><a href='javascript:window.history.back();'>返回</a>");
			out.println("</div>");
			return;
		}
		
	}
		
%>