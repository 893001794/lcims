package com.lccert.crm.project;

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

import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.quotation.QuotationAction;
/***
 * 外包项目的servlet类
 * @author tangzp
 *
 */
public class OutProject extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest requst, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(requst, response);
	}

	@Override
	protected void doPost(HttpServletRequest requst, HttpServletResponse response)
			throws ServletException, IOException {
		exOutProject(requst, response);
	}
	
	/**
	 * 导出当天接单项目到Excel
	 * @param request
	 * @param response
	 */
	public synchronized void exOutProject(HttpServletRequest request,HttpServletResponse response) {
		HSSFWorkbook wb = null;
		FileOutputStream fOut = null;
		String   fs   =   System.getProperties().getProperty("file.separator");
		String path = request.getSession().getServletContext().getRealPath(fs);
		String type ="";
		//获取外包类型
		if(request.getSession().getAttribute("outype")!=null && request.getSession().getAttribute("outype").equals("tuv")){
			type ="TUV";
		}else{
			type ="POUT";
		}
		
		String flowfile = path + "export" + fs + type+"project.xls";
		List<Project> list = (List<Project>)request.getSession().getAttribute("outproject");
		try {
			// 读取文件内容
			wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet();
			//sheet.autoSizeColumn(( short ) 0);
			HSSFRow row = sheet.createRow((short) 0);
			HSSFCell cell = row.createCell(0);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			//根据外包的类型来选择不同的字段名称
			if(type.equals("TUV")){
				cell.setCellValue("报价单编号");
				row.createCell(1).setCellValue("项目报告号");
				row.createCell(2).setCellValue("TUV编号");
				row.createCell(3).setCellValue("客户名称");
				row.createCell(4).setCellValue("销售名称");
				row.createCell(5).setCellValue("样品名称");
				row.createCell(6).setCellValue("测试项目");
				row.createCell(7).setCellValue("立创对客户报价(对内)");
				row.createCell(8).setCellValue("工程师");
				row.createCell(9).setCellValue("第三方分包费");
				row.createCell(10).setCellValue("TUV测试费用");
				row.createCell(11).setCellValue("To TUV(40%)");
				row.createCell(12).setCellValue("TUV(TUV测试费+40%)");
				row.createCell(13).setCellValue("To 立创");
				for(int i=0;i<list.size();i++) {
					sheet.autoSizeColumn(( short ) i);
					Project p =list.get(i);
					//TUV检测项目费用
					float tuvPrice=0.0f;
					//第三方
					float presubcost=Float.parseFloat(p.getPresubcost());
					//TO TUV(40%)=（TUV对立创报价-第三方包费-TUV测试费用）*40%
					 tuvPrice=(p.getPrice()-p.getSubcost2()-presubcost)*0.4f;
					row = sheet.createRow((short) i+1);
					cell = row.createCell(0);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(p.getPid());
					row.createCell(1).setCellValue(p.getRid());
					row.createCell(2).setCellValue(p.getTuvno());
					row.createCell(3).setCellValue(p.getClient());
					row.createCell(4).setCellValue(p.getSales());
					row.createCell(5).setCellValue(p.getSamplename());
					row.createCell(6).setCellValue(p.getTuvpshort());
					row.createCell(7).setCellValue(p.getLcrealprice());
					row.createCell(8).setCellValue(p.getPrice());
					row.createCell(9).setCellValue(p.getSubcost2());
					row.createCell(10).setCellValue(p.getPresubcost());
					row.createCell(11).setCellValue(tuvPrice);
					row.createCell(12).setCellValue(tuvPrice+presubcost);
					row.createCell(13).setCellValue(p.getPrice()-tuvPrice-presubcost);
				}
			}else{
			cell.setCellValue("报价单编号");
			row.createCell(1).setCellValue("项目报告号");
			row.createCell(2).setCellValue("项目内容");
			row.createCell(3).setCellValue("应回数据时间");
			row.createCell(4).setCellValue("请款时间");
			row.createCell(5).setCellValue("实际外包金额");
			row.createCell(6).setCellValue("发出外包登记");
			row.createCell(7).setCellValue("样品名称");
			row.createCell(8).setCellValue("销售名称)");
			row.createCell(9).setCellValue("分包机构");
			row.createCell(10).setCellValue("回数据时间");	
			for(int i=0;i<list.size();i++) {
				sheet.autoSizeColumn(( short ) i);
				Project p =list.get(i);
				row = sheet.createRow((short) i+1);
				cell = row.createCell(0);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(p.getPid());
				row.createCell(1).setCellValue(p.getRid());
				row.createCell(2).setCellValue(p.getTestcontent()==null ?"":p.getTestcontent() );
				row.createCell(3).setCellValue(p.getOrtime() ==null ?"":new SimpleDateFormat("yyyy.MM").format(p.getOrtime()));
				row.createCell(4).setCellValue(p.getBqtime() ==null ?"":new SimpleDateFormat("yyyy.MM").format(p.getBqtime()));
				row.createCell(5).setCellValue(p.getOeprice());
				row.createCell(6).setCellValue(p.getOstime() ==null ?"":new SimpleDateFormat("yyyy.MM").format(p.getOstime()));
				row.createCell(7).setCellValue(p.getSamplename()==null?"":p.getSamplename());
				row.createCell(8).setCellValue(p.getSales() ==null ?"":p.getSales());
				row.createCell(9).setCellValue(p.getSubname() ==null ?"":p.getSubname());
				row.createCell(10).setCellValue(p.getOetime() ==null ?"":new SimpleDateFormat("yyyy.MM").format(p.getOstime()));
			}

			}
			fOut = new FileOutputStream(new File(flowfile));
			wb.write(fOut);
			
			response.sendRedirect("export/"+type+"project.xls");
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
