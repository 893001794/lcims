package com.lccert.crm.chemistry.lab;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.ChemProjectAction;
import com.lccert.crm.project.Project;
import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.quotation.QuotationAction;

/**
 * 月结客户项目内容导出工具类
 * 用户导出月结客户的项目详细内容到Excel表中
 * @author Eason
 *
 */
public class WeekStatisticsExport extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		exportProject(request,response);
	}

	/**
	 * 导出项目到Excel表
	 * @param request
	 * @param response
	 */
	public synchronized void exportProject(HttpServletRequest request,HttpServletResponse response) {
		HSSFWorkbook wb = null;
		FileOutputStream fOut = null;
		String   fs   =   System.getProperties().getProperty("file.separator");
		String path = request.getSession().getServletContext().getRealPath(fs);
		String status =request.getParameter("status");
		List list =QuotationAction.getInstance().getWeekStatistics(status);
		try {
			// 读取文件内容
			wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet();
			//sheet.autoSizeColumn(( short ) 0);

			HSSFRow row = sheet.createRow((short) 0);
			HSSFCell cell = row.createCell(0);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			
			if(status.equals("report")){
				cell.setCellValue("报告号");
				row.createCell(1).setCellValue("报告客户");
				row.createCell(2).setCellValue("客服人员");
				row.createCell(3).setCellValue("报告建立时间");
				for(int i=0;i<list.size();i++) {
				 	sheet.autoSizeColumn(( short ) i);
			    	List columns = (List)list.get(i);
			    	for(int j=0;j<columns.size();j++) {
						row = sheet.createRow((short) i+1);
						cell = row.createCell(0);
						cell.setCellType(HSSFCell.CELL_TYPE_STRING);
						cell.setCellValue(columns.get(0).toString());
						row.createCell(1).setCellValue(columns.get(1)+"");
						row.createCell(2).setCellValue(columns.get(2)+"");
						row.createCell(3).setCellValue(columns.get(3)+"");
			    	}
				}
				String flowfile = path + "export"+ fs + "weekreport.xls";
				fOut = new FileOutputStream(new File(flowfile));
				wb.write(fOut);
				response.sendRedirect("export/weekreport.xls");

			}else if(status.equals("late")){
				cell.setCellValue("报告号");
				row.createCell(1).setCellValue("报告客户");
				row.createCell(2).setCellValue("客服人员");
				row.createCell(3).setCellValue("报告建立时间");
				row.createCell(4).setCellValue("应出报告时间");
				row.createCell(5).setCellValue("报告完成时间");
				for(int i=0;i<list.size();i++) {
				 	sheet.autoSizeColumn(( short ) i);
			    	List columns = (List)list.get(i);
			    	for(int j=0;j<columns.size();j++) {
						row = sheet.createRow((short) i+1);
						cell = row.createCell(0);
						cell.setCellType(HSSFCell.CELL_TYPE_STRING);
						cell.setCellValue(columns.get(0).toString());
						row.createCell(1).setCellValue(columns.get(1)+"");
						row.createCell(2).setCellValue(columns.get(2)+"");
						row.createCell(3).setCellValue(columns.get(3)+"");
						row.createCell(4).setCellValue(columns.get(4)+"");
						row.createCell(5).setCellValue(columns.get(5)+"");
			    	}
				}
				String flowfile = path + "export"+ fs + "weeklate.xls";
				fOut = new FileOutputStream(new File(flowfile));
				wb.write(fOut);
				response.sendRedirect("export/weeklate.xls");
			}else if(status.equals("client")){
						cell.setCellValue("报告客户");
						for(int i=0;i<list.size();i++) {
						 	sheet.autoSizeColumn(( short ) i);
					    	List columns = (List)list.get(i);
					    	for(int j=0;j<columns.size();j++) {
								row = sheet.createRow((short) i+1);
								cell = row.createCell(0);
								cell.setCellType(HSSFCell.CELL_TYPE_STRING);
								cell.setCellValue(columns.get(0)+"");
					    	}
						}
				String flowfile = path + "export"+ fs + "weekclient.xls";
				fOut = new FileOutputStream(new File(flowfile));
				wb.write(fOut);
				response.sendRedirect("export/weekclient.xls");
			}else if (status.equals("createname")){
				cell.setCellValue("报告号");
				row.createCell(1).setCellValue("报价单号");
				row.createCell(2).setCellValue("排单人");
				row.createCell(3).setCellValue("排单时间");
				row.createCell(4).setCellValue("预估分包费");
				row.createCell(5).setCellValue("机构费");
				row.createCell(6).setCellValue("报价金额");
				row.createCell(7).setCellValue("已收金额");
				for(int i=0;i<list.size();i++) {
				 	sheet.autoSizeColumn(( short ) i);
			    	List columns = (List)list.get(i);
			    	for(int j=0;j<columns.size();j++) {
						row = sheet.createRow((short) i+1);
						cell = row.createCell(0);
						cell.setCellType(HSSFCell.CELL_TYPE_STRING);
						cell.setCellValue(columns.get(0).toString());
						row.createCell(1).setCellValue(columns.get(1)+"");
						row.createCell(2).setCellValue(columns.get(2)+"");
						row.createCell(3).setCellValue(columns.get(3)+"");
						row.createCell(4).setCellValue(columns.get(4)+"");
						row.createCell(5).setCellValue(columns.get(5)+"");
						row.createCell(6).setCellValue(columns.get(6)+"");
						row.createCell(7).setCellValue(columns.get(7)+"");
			    	}
				}
				String flowfile = path + "export\\servStatistics.xls";
				fOut = new FileOutputStream(new File(flowfile));
				wb.write(fOut);
				response.sendRedirect("export/servStatistics.xls");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(fOut != null) {
				// 操作结束，关闭文件
				try {
					fOut.flush();
					fOut.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

}
