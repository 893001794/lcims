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
	
/******************���ɱ���Ŀ¼*******************/
	String third = "";
	if ("��������".equals(p.getType())) {
		third = "8000";
	} else if ("y".equals(p.getIsout())) {
		third = "9000";
	} else if ("�Բ�".equals(p.getType())) {
		Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
		String company = qt.getCompany();
		if ("��ɽ".equals(company)) {
			third = "LCZC";
		} else if ("����".equals(company)) {
			third = "LCGC";
		} else if ("��ݸ".equals(company)) {
			third = "LCDC";
		}
	}
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd ");//�������ڸ�ʽ 
	String date =sdf.format(new Date());
	String year=date.substring(0, 4);
	String month=date.substring(5, 7);
	String head = new Config()._PATH;
	String filepath =fs+fs+"file"+ fs+"13 ������Ƭ" + fs + year + fs + month + fs + third;
	System.out.println("�ϴ�ͼƬ��·��:"+ filepath);
	
/*************************************************/
	
	
	String filename = p.getRid();

System.out.println("��ʼ����");
	SmartUpload up = new SmartUpload();
	up.initialize(pageContext);
	up.setAllowedFilesList("jpg,bmp,gif,tif,png");
	up.setDeniedFilesList("ext,bat,jsp,htm,html");
	up.upload();
	java.io.File savedir = new java.io.File(filepath);
	// ���Ŀ¼�����ھʹ���
	if (!savedir.exists()) {
		savedir.mkdirs();
	}
	int count = up.getFiles().getCount();
	for(int i=0;i<count;i++) {
System.out.println("���յ��ļ�");
		com.jspsmart.upload.File file = up.getFiles().getFile(i);
		if(count > 2) {
			filename = p.getRid() + "(" + (i+1) + ")";
		}
		if(file.isMissing()) continue;
		
		String savepath = filepath + fs + filename + "." + file.getFileExt();
		//����ͼƬ��������
		file.saveAs(head + fs + savepath,SmartUpload.SAVE_PHYSICAL);
		//����ͼƬ�����ݿ�
		ReportImg rimg = new ReportImg();
		rimg.setRid(p.getRid());
		rimg.setSid(p.getSid());
		rimg.setImgurl(savepath);
		rimg.setName(filename);
		ChemProjectAction.getInstance().addImg(rimg);
	}
System.out.println("��ʼ����");
out.println("<script>window.parent.Finish('�ϴ����');</script>");
%>
