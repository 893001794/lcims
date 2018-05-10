package com.lccert.crm.quotation;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DecimalFormat;
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
public class FinanceQuotationExport2 extends HttpServlet {
	
	
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
		String flowfile = path + "export" + fs + "financequotation2.xls";
		List<Quotation> list = (List<Quotation>)request.getSession().getAttribute("financequotation2");
		float[] f = (float[])request.getSession().getAttribute("total");
		try {
			// 读取文件内容
			wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet();
			//sheet.autoSizeColumn(( short ) 0);

			HSSFRow row = sheet.createRow((short) 0);
			HSSFCell cell = row.createCell(0);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("所属年份");
			row.createCell(1).setCellValue("所属月份");
			row.createCell(2).setCellValue("销售");
			row.createCell(3).setCellValue("排单人员");
			row.createCell(4).setCellValue("客户名称");
			row.createCell(5).setCellValue("报价单号");
			row.createCell(6).setCellValue("被冲红报价号");
			row.createCell(7).setCellValue("项目类型");
			row.createCell(8).setCellValue("项目名称");
			row.createCell(9).setCellValue("收款日期");
			row.createCell(10).setCellValue("收款方式");
			row.createCell(11).setCellValue("票据形式");
			row.createCell(12).setCellValue("报价金额");
			row.createCell(13).setCellValue("已收金额");
			row.createCell(14).setCellValue("未收金额");
			row.createCell(15).setCellValue("备注");
			row.createCell(16).setCellValue("预估分包费+机构费");
			row.createCell(17).setCellValue("预估接待费");
			row.createCell(18).setCellValue("税金");
			row.createCell(19).setCellValue("其他费用");
			row.createCell(20).setCellValue("本月收款比例");
			row.createCell(21).setCellValue("本月收款金额");
			row.createCell(22).setCellValue("本月扣机构费+分包费");
			row.createCell(23).setCellValue("本月扣特殊接待费");
			row.createCell(24).setCellValue("本月扣税金");
			row.createCell(25).setCellValue("本月扣其他费用");
			row.createCell(26).setCellValue("坏账扣款");
			row.createCell(27).setCellValue("业绩小计");
			row.createCell(28).setCellValue("是否结案");
			row.createCell(29).setCellValue("结案日期");
			DecimalFormat df=new DecimalFormat("#.00"); 
			for(int j=0;j<list.size();j++){
	    		List<Quotation> listQuotation=(List)list.get(0);
	    		List listFloat =(List)list.get(1);
				for(int i=0;i<listQuotation.size();i++) {
					sheet.autoSizeColumn(( short ) i+1);
					Quotation qt = listQuotation.get(i);
					List cloums=(List)listFloat.get(i);
					UserForm user = UserAction.getInstance().getUserByName(qt.getSales());
					String dept = "";
					String str="";
			    	if(qt.getQuotype()!=null&&qt.getQuotype().equals("flu")){
			    	str="-";
			    	}
					if("中山".equals(user.getCompany())) {
						dept = user.getDept();
					} else {
						dept = user.getCompany();
					}
					row = sheet.createRow((short) i+1);
					cell = row.createCell(0);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(qt.getConfirmtime()==null?"":new SimpleDateFormat("yyyy").format(qt.getConfirmtime()));
					row.createCell(1).setCellValue(qt.getConfirmtime()==null?"":new SimpleDateFormat("MM").format(qt.getConfirmtime()));
					row.createCell(2).setCellValue(qt.getSales());
					row.createCell(3).setCellValue(qt.getCreatename());
					row.createCell(4).setCellValue(qt.getClient());
					row.createCell(5).setCellValue(qt.getPid());
					row.createCell(6).setCellValue(qt.getOldPid());
					row.createCell(7).setCellValue("");
					row.createCell(8).setCellValue(qt.getProjectcontent()==null?"":qt.getProjectcontent());
					row.createCell(9).setCellValue(qt.getPaytime()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(qt.getPaytime()));
					row.createCell(10).setCellValue(qt.getCreditcard());
					row.createCell(11).setCellValue(qt.getInvtype());
					//如果是冲红就为负数
					if(qt.getQuotype().equals("flu")){
						str="";
					}
					row.createCell(12).setCellValue(str+qt.getTotalprice());
					row.createCell(13).setCellValue(qt.getPreadvance() + qt.getSepay() + qt.getBalance());
					row.createCell(14).setCellValue(qt.getTotalprice() - (qt.getPreadvance() + qt.getSepay() + qt.getBalance()));
					row.createCell(15).setCellValue(qt.getObject());
					row.createCell(16).setCellValue(qt.getPresubcost()+qt.getPreagcost());
					row.createCell(17).setCellValue(qt.getPrespefund());
					row.createCell(18).setCellValue(qt.getTotalprice()*0.08);
					row.createCell(19).setCellValue(qt.getOthercost());
					float scale=(qt.getPreadvance() + qt.getSepay() + qt.getBalance())/qt.getTotalprice();//比例
					if(qt.getTotalprice()==0){
				      	scale=0.0f;
				      }
					row.createCell(20).setCellValue(scale*100+"%");
					row.createCell(21).setCellValue(qt.getPreadvance() + qt.getSepay() + qt.getBalance());
					row.createCell(22).setCellValue((qt.getPresubcost()+qt.getPreagcost())*scale);
					row.createCell(23).setCellValue(qt.getPrespefund()*scale);
					row.createCell(24).setCellValue(qt.getTotalprice()*0.08*scale);
					row.createCell(25).setCellValue(qt.getOthercost());
					row.createCell(26).setCellValue(qt.getBadDebt()==null?"":qt.getBadDebt());
					/*
					 * 统计业绩的方法
					 */
					Float sun =0.0f;
			   		Float taxes=qt.getTotalprice()*0.08f*scale;
			   		Float amountRece=qt.getPreadvance()+qt.getSepay()+qt.getBalance();//已收金额
			   		//杂费金额比例=(预计分包费+机构费)*收款比例-特殊接待费*收款比例*其他费用
					Float othercost=(qt.getPresubcost()+qt.getPreagcost())*scale+qt.getPrespefund()*scale+qt.getOthercost();//已收款金额
					//坏账额
					Float badDebt=Float.parseFloat(qt.getBadDebt()==null||qt.getBadDebt().equals("")?"0.0":qt.getBadDebt());
					//业绩小计=已收金额-税金比例-杂费金额比例-坏账
					sun=amountRece-taxes-othercost-badDebt;
					row.createCell(27).setCellValue(df.format(sun));
					row.createCell(28).setCellValue(qt.getStatus());
					row.createCell(29).setCellValue(qt.getFinish()==null?"":qt.getFinish()+"");
				}
			}
			//row = sheet.getRow(1);
			//row.createCell(22).setCellValue(f[1]);
			//row.createCell(23).setCellValue(f[0]);
			fOut = new FileOutputStream(new File(flowfile));
			wb.write(fOut);
			response.sendRedirect("export/financequotation2.xls");
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
