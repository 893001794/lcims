<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.*" %> 
<%@page import="java.io.*" %>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@page import="com.jspsmart.upload.File"%>
<%@page import="com.lccert.crm.chemistry.util.Config"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.report.ReportImg"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>

<%
	request.setCharacterEncoding("GBK"); 
	String sid = request.getParameter("sid");
	if(sid == null || "".equals(sid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	Project p = ProjectAction.getInstance().getProjectBySid(sid);
	if(p == null) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	String fs = System.getProperties().getProperty("file.separator");
	
/******************生成保存目录*******************/
	String third = "";
	if ("机构合作".equals(p.getType())) {
		third = "8000";
	} else if ("y".equals(p.getIsout())) {
		third = "9000";
	} else if ("自测".equals(p.getType())) {
		Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
		String company = qt.getCompany();
		if ("中山".equals(company)) {
			third = "LCZC";
		} else if ("广州".equals(company)) {
			third = "LCGC";
		} else if ("东莞".equals(company)) {
			third = "LCDC";
		}
	}
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd ");//设置日期格式 
	String date =sdf.format(new Date());
	String year=date.substring(0, 4);
	String month=date.substring(5, 7);
	String head = new Config()._PATH;
	String filepath =fs+fs+"file"+ fs+"13 报告照片" + fs + year + fs + month + fs + third;
	System.out.println("上传图片的路径:"+ filepath);
	
/*************************************************/
	
	
	String filename = p.getRid();

System.out.println("开始接收");
	SmartUpload up = new SmartUpload();
	up.initialize(pageContext);
	up.setAllowedFilesList("jpg,bmp,gif,tif,png");
	up.setDeniedFilesList("ext,bat,jsp,htm,html");
	up.upload();
	java.io.File savedir = new java.io.File(filepath);
	// 如果目录不存在就创建
	if (!savedir.exists()) {
		savedir.mkdirs();
	}
	int count = up.getFiles().getCount();
	for(int i=0;i<count;i++) {
System.out.println("接收到文件");
		com.jspsmart.upload.File file = up.getFiles().getFile(i);
		if(count > 2) {
			filename = p.getRid() + "(" + (i+1) + ")";
		}
		if(file.isMissing()) continue;
		
		String savepath = filepath + fs + filename + "." + file.getFileExt();
		//保存图片到服务器
		file.saveAs(head + fs + savepath,SmartUpload.SAVE_PHYSICAL);
		//保存图片到数据库
		ReportImg rimg = new ReportImg();
		rimg.setRid(p.getRid());
		rimg.setSid(p.getSid());
		rimg.setImgurl(savepath);
		rimg.setName(filename);
		ChemProjectAction.getInstance().addImg(rimg);
	}
System.out.println("开始结束");
out.println("<script>window.parent.Finish('上传完毕');</script>");
%>
