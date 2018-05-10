package com.lccert.crm.chemistry.lab;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.CellStyle;

import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.Project;

import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.quotation.QuotationAction;
import com.lccert.crm.vo.Synthesis;

/**
 * 迟单项目导出工具类
 * 用于导出迟单项目到Excel文件
 * @author Eason
 *
 */
public class LateProjectExport extends HttpServlet {
	
	
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
	 * 导出迟单项目到Excel
	 * @param request
	 * @param response
	 */
	public synchronized void exportProject(HttpServletRequest request,HttpServletResponse response) {
		HSSFWorkbook wb = null;
		FileOutputStream fOut = null;
		String   fs   =   System.getProperties().getProperty("file.separator");
		String path = request.getSession().getServletContext().getRealPath(fs);
		String flowfile = path + "export" + fs + "lateproject.xls";
		List list = (List)request.getSession().getAttribute("lateprojects");
		int[] family = (int[])request.getSession().getAttribute("family");
		try {
			// 读取文件内容
			wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet();
			//sheet.autoSizeColumn(( short ) 0);

			HSSFRow row = sheet.createRow((short) 0);
			HSSFCell cell = row.createCell(0);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("项目等级");
			row.createCell(1).setCellValue("报告编号");
			row.createCell(2).setCellValue("项目内容");
			row.createCell(3).setCellValue("排单时间");
			row.createCell(4).setCellValue("应出报告时间");
			row.createCell(5).setCellValue("实际完成时间");
			row.createCell(6).setCellValue("销售人员");
			row.createCell(7).setCellValue("客服人员");
			row.createCell(8).setCellValue("工程师");
			row.createCell(9).setCellValue("项目状态");
			row.createCell(10).setCellValue("迟单数/项目总数：");
			row.createCell(11).setCellValue(family[0] + "/" + family[1]);
			row.createCell(12).setCellValue("迟单率：");
			row.createCell(13).setCellValue(family[0]*100/family[1] + "%");
			row.createCell(14).setCellValue("应出报告总数："+family[2]);
			row.createCell(15).setCellValue("应出中山报告总数："+family[3]);
			row.createCell(16).setCellValue("应出东莞报告总数："+family[4]);
			for(int i=0;i<list.size();i++) {
				sheet.autoSizeColumn(( short ) i);
				Synthesis sy= (Synthesis)list.get(i);
		    	Quotation qt = QuotationAction.getInstance().getQuotationByPid(sy.getPid());
				row = sheet.createRow((short)i+1);
				cell = row.createCell(0);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(sy.getLevel()==null?"":sy.getLevel());
				row.createCell(1).setCellValue(sy.getRid());
				row.createCell(2).setCellValue(sy.getTestcontent());
				row.createCell(3).setCellValue(sy.getCreatetime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(sy.getCreatetime()));
				row.createCell(4).setCellValue(sy.getRptime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(sy.getRptime()));
				row.createCell(5).setCellValue(sy.getSendtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(sy.getSendtime()));
				row.createCell(6).setCellValue(qt.getSales());
				row.createCell(7).setCellValue(sy.getServname());
				row.createCell(8).setCellValue(sy.getEngineer());
				row.createCell(9).setCellValue(sy.getStatus());
			}
			fOut = new FileOutputStream(new File(flowfile));
			wb.write(fOut);
			
			response.sendRedirect("export/lateproject.xls");
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
