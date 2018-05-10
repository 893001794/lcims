<%@ page language="java" import="java.util.*,java.io.*" pageEncoding="gb2312"%>
<%@ page import="org.apache.poi.hssf.usermodel.*" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.poi.poifs.filesystem.POIFSFileSystem"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%@page import="com.lccert.crm.project.Project"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>POI将数据导入Excel，上传到服务器，并从客户端保存</title>
 <meta http-equiv="pragma" content="no-cache">
 <meta http-equiv="cache-control" content="no-cache">
 <meta http-equiv="expires" content="0">    
 <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
 <meta http-equiv="description" content="This is my page">
 
  </head>
  
  <body>
    <%
    	java.io.OutputStream outp = null;   
		java.io.FileInputStream in = null; 
		POIFSFileSystem fs = null;
		HSSFWorkbook wb = null;
		FileOutputStream fileOut = null;
		boolean isok = false;
		String path = request.getRealPath("/");
		String flowfile = path + "/export/project.xls";
		List<Project> list = (List<Project>)session.getAttribute("projects");
		try {
			// 读取文件内容
			fs = new POIFSFileSystem(new FileInputStream(flowfile));
			wb = new HSSFWorkbook(fs);
			HSSFSheet sheet = wb.getSheetAt(0);
			
			for(int i=0;i<list.size();i++) {
				Project p = list.get(i);
				ChemProject cp = (ChemProject)p.getObj();
				Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
				HSSFRow row = sheet.createRow(i+1);
				HSSFCell cell = row.createCell(0);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(p.getPid());
				row.createCell(1).setCellValue(p.getSid());
				row.createCell(2).setCellValue(p.getRid());
				row.createCell(3).setCellValue(p.getPtype());
				row.createCell(4).setCellValue(cp.getRptype());
				row.createCell(5).setCellValue(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cp.getRptime()));
				row.createCell(6).setCellValue(p.getLevel());
				row.createCell(7).setCellValue(cp.getServname());
				row.createCell(8).setCellValue(qt.getClient());
				row.createCell(9).setCellValue(cp.getWarning());
				row.createCell(10).setCellValue(p.getTestcontent());
				row.createCell(11).setCellValue(qt.getCompany());
				row.createCell(12).setCellValue(p.getBuildname());
				row.createCell(13).setCellValue(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(p.getBuildtime()));
				row.createCell(14).setCellValue(cp.getSamplename());
				row.createCell(15).setCellValue(cp.getSamplecount());
				row.createCell(16).setCellValue(cp.getSampledesc());
			}

       // 文件存放位置 保存于服务器
       String filePath = application.getRealPath("\\export")+"\\project.xls";
       // 新建一输出流
       		// 新建一输出文件流
			FileOutputStream fOut = new FileOutputStream(new File(filePath));
			// 把相应的Excel 工作簿存盘
			wb.write(fOut);
			fOut.flush();
			// 操作结束，关闭文件
			fOut.close();
			//System.out.println("文件生成...");
			response.sendRedirect("../../export/project.xls");
			return;
		} catch (Exception e) {
			System.out.println("已运行   xlCreate()   :   " + e);
		}
       
		%>  
		<h1 align="center">导出成功</h1>
		<br>
		<h2 align="center"><a href="../../export/project.xls">点击下载</a>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="projectexport.jsp">返回</a>
		</h2>

     
  </body>
</html>