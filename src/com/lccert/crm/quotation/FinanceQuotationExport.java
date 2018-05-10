package com.lccert.crm.quotation;

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
import com.lccert.crm.user.UserAction;
import com.lccert.crm.user.UserForm;

/**
 * 财务订单导出工具类
 * 用于导出于项目中与财务相关的信息到Excel文件
 * @author Eason
 *
 */
public class FinanceQuotationExport extends HttpServlet {
	
	
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
	 * 导出财务订单到Excel
	 * @param request
	 * @param response
	 */
	public synchronized void exportProject(HttpServletRequest request,HttpServletResponse response) {
		HSSFWorkbook wb = null;
		FileOutputStream fOut = null;
		String   fs   =   System.getProperties().getProperty("file.separator");
		String path = request.getSession().getServletContext().getRealPath(fs);
		String flowfile = path + "export" + fs + "financequotation.xls";
		List<Quotation> list = (List<Quotation>)request.getSession().getAttribute("financequotation");
		float[] f = (float[])request.getSession().getAttribute("total");
		try {
			// 读取文件内容
			wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet();
			//sheet.autoSizeColumn(( short ) 0);

			HSSFRow row = sheet.createRow((short) 0);
			HSSFCell cell = row.createCell(0);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("所属时期(即收单日期)");
			row.createCell(1).setCellValue("报价单号");
			row.createCell(2).setCellValue("被冲红报价号");
			row.createCell(3).setCellValue("销售");
			row.createCell(4).setCellValue("部门");
			row.createCell(5).setCellValue("客户名称");
			row.createCell(6).setCellValue("项目名称");
			row.createCell(7).setCellValue("报价金额");
			row.createCell(8).setCellValue("票据形式");
			row.createCell(9).setCellValue("是否收款");
			row.createCell(10).setCellValue("收款方式");
			row.createCell(11).setCellValue("收款日期");
			row.createCell(12).setCellValue("已收金额");
			row.createCell(13).setCellValue("未收金额");
			row.createCell(14).setCellValue("预计分包费");
			row.createCell(15).setCellValue("实际分包费");
			row.createCell(16).setCellValue("预计机构费");
			row.createCell(17).setCellValue("实际机构费");
			row.createCell(18).setCellValue("预计特殊接待费");
			row.createCell(19).setCellValue("特殊接待费");
			row.createCell(20).setCellValue("税金");
			row.createCell(21).setCellValue("其他费用");
			row.createCell(22).setCellValue("机构支付费用备注");
			row.createCell(23).setCellValue("收款备注");
			row.createCell(24).setCellValue("业绩小计");
			row.createCell(25).setCellValue("业绩系数");
		
			
			row.createCell(26).setCellValue("签单总额");
			row.createCell(27).setCellValue("业绩总额");
			
			
			for(int i=0;i<list.size();i++) {
				sheet.autoSizeColumn(( short ) i+1);
				Quotation qt = list.get(i);
				UserForm user = UserAction.getInstance().getUserByName(qt.getSales());
				String dept = "";
				if("中山".equals(user.getCompany())) {
					dept = user.getDept();
				} else {
					dept = user.getCompany();
				}
				row = sheet.createRow((short) i+1);
				cell = row.createCell(0);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(qt.getConfirmtime()==null?"":new SimpleDateFormat("yyyy.MM").format(qt.getConfirmtime()));
				row.createCell(1).setCellValue(qt.getPid());
				row.createCell(2).setCellValue(qt.getOldPid());
				row.createCell(3).setCellValue(qt.getSales());
				row.createCell(4).setCellValue(dept);
				row.createCell(5).setCellValue(qt.getClient());
				row.createCell(6).setCellValue(qt.getProjectcontent());
				//如果是冲红就为负数
				String str  ="";
				
				if(qt.getQuotype().equals("flu")){
					str="-";
				}
				row.createCell(7).setCellValue(str+qt.getTotalprice());
				row.createCell(8).setCellValue(qt.getInvtype());
			
				row.createCell(9).setCellValue(qt.getPreadvance()==0?"n":"y");
				row.createCell(10).setCellValue(qt.getCreditcard());
				row.createCell(11).setCellValue(qt.getPaytime()==null?"":new SimpleDateFormat("MM-dd").format(qt.getPaytime()));
				row.createCell(12).setCellValue(qt.getPreadvance() + qt.getSepay() + qt.getBalance());
				row.createCell(13).setCellValue(qt.getTotalprice() - (qt.getPreadvance() + qt.getSepay() + qt.getBalance()));
				row.createCell(14).setCellValue(qt.getPresubcost());
				row.createCell(15).setCellValue(qt.getSubcost());
				row.createCell(16).setCellValue(qt.getPreagcost());
				row.createCell(17).setCellValue(qt.getAgcost());
				row.createCell(18).setCellValue(qt.getPrespefund());
				row.createCell(19).setCellValue(qt.getSpefund());
				row.createCell(20).setCellValue(qt.getTax());
				row.createCell(21).setCellValue(qt.getOthercost());
				row.createCell(22).setCellValue(qt.getObject());
				row.createCell(23).setCellValue(qt.getCollRemarks());
				/*
				 * 统计业绩的方法
				 */
				//amountRece 为已收金额
			      Float amountRece=qt.getPreadvance()+qt.getSepay()+qt.getBalance();
			      Float sun =0.0f;
			      if(qt.getSubcost() ==0 && qt.getAgcost()==0){
			      sun =amountRece-qt.getPresubcost()-qt.getPreagcost()-qt.getSpefund()-qt.getTax();
			      }else if(qt.getSubcost() !=0 && qt.getAgcost()==0){
			      sun =amountRece-qt.getSubcost()-qt.getPreagcost()-qt.getSpefund()-qt.getTax();
			      }else if(qt.getSubcost() ==0 && qt.getAgcost()!=0){
			      sun =amountRece-qt.getPresubcost()-qt.getAgcost()-qt.getSpefund()-qt.getTax();
			      }else if(qt.getSubcost() !=0 && qt.getAgcost()!=0){
			      sun =amountRece-qt.getSubcost()-qt.getAgcost()-qt.getSpefund()-qt.getTax();
			      }
				
				
				row.createCell(24).setCellValue(sun);
				row.createCell(25).setCellValue(qt.getAdvarceFactor()+","+qt.getSepayFactor()+","+qt.getBalanceFactor());
			}
			row = sheet.getRow(1);
			row.createCell(26).setCellValue(f[1]);
			row.createCell(27).setCellValue(f[0]);
      
			fOut = new FileOutputStream(new File(flowfile));
			wb.write(fOut);
			
			response.sendRedirect("export/financequotation.xls");
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
