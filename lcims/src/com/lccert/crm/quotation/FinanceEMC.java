package com.lccert.crm.quotation;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.lccert.crm.chemistry.util.TimeTest;
import com.lccert.crm.kis.Order;
import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.user.UserAction;
import com.lccert.crm.user.UserForm;
import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

/**
 * ���񶩵�����������
 * ���ڵ�������Ŀ���������ص���Ϣ��Excel�ļ�
 * @author Eason
 *
 */
public class FinanceEMC extends HttpServlet {
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
	 * �������񶩵���Excel
	 * @param request
	 * @param response
	 */
	public synchronized void exportProject(HttpServletRequest request,HttpServletResponse response) {
		HSSFWorkbook wb = null;
		FileOutputStream fOut = null;
		String   fs   =   System.getProperties().getProperty("file.separator");
		String path = request.getSession().getServletContext().getRealPath(fs);
		String flowfile = path + "export" + fs + "financeEMC.xls";
		List<Order> list = (List<Order>)request.getSession().getAttribute("financeEMC");
		UserForm user = (UserForm)request.getSession().getAttribute("user");
		try {
			// ��ȡ�ļ�����
			wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet();
			//sheet.autoSizeColumn(( short ) 0);
			HSSFRow row = sheet.createRow((short) 0);
			HSSFCell cell = row.createCell(0);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("�������۵���");
			row.createCell(1).setCellValue("EMC���۵���");
			row.createCell(2).setCellValue("�ͻ���");
			row.createCell(3).setCellValue("��Ʒ");
			row.createCell(4).setCellValue("������Ŀ");
			row.createCell(5).setCellValue("�ռ�ʱ��");
			row.createCell(6).setCellValue("��������");
			row.createCell(7).setCellValue("�յ�ʱ��");
			//row.createCell(8).setCellValue("���翪ʼʱ��");
			//row.createCell(9).setCellValue("�������ʱ��");
			//row.createCell(10).setCellValue("���翪ʼʱ��");
			//row.createCell(11).setCellValue("�������ʱ��");
			//row.createCell(8).setCellValue("����(Сʱ)");
			row.createCell(8).setCellValue("���");
			if(user.getTicketid().matches("\\d\\d\\d1\\d\\d\\d\\d")||user.getId()==103){
				row.createCell(9).setCellValue("���ս��");
				row.createCell(10).setCellValue("��ˮ��");
			}else{
				row.createCell(9).setCellValue("��ˮ��");
			}
			for(int i=0;i<list.size();i++) {
				sheet.autoSizeColumn(( short ) i+1);
				Order order = list.get(i);
				row = sheet.createRow((short) i+1);
				cell = row.createCell(0);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(order.getOldPid());
				row.createCell(1).setCellValue(order.getPid());
				row.createCell(2).setCellValue(order.getClient().getName());
				row.createCell(3).setCellValue(order.getProduct());
				row.createCell(4).setCellValue(order.getProjectcontent());
				row.createCell(5).setCellValue(order.getCollection()!=null?new SimpleDateFormat("yyyy.MM.dd").format(order.getCollection()):"");
				row.createCell(6).setCellValue(order.getTest()!=null?new SimpleDateFormat("yyyy.MM.dd").format(order.getTest()):"");
				row.createCell(7).setCellValue(order.getReceipt()!=null?new SimpleDateFormat("yyyy.MM.dd").format(order.getReceipt()):"");
				//row.createCell(8).setCellValue(order.getAmstart());
				//row.createCell(9).setCellValue(order.getAmend());
				//row.createCell(10).setCellValue(order.getPmstart());
				//row.createCell(11).setCellValue(order.getPmend());
				//String timeStr=new TimeTest().TimeSerial(order.getAmstart(), order.getPmstart(),order.getAmend(), order.getPmend());
				//row.createCell(8).setCellValue(timeStr);
				float total=order.getTotalprice();
				row.createCell(8).setCellValue(total);
				if(user.getTicketid().matches("\\d\\d\\d1\\d\\d\\d\\d")||user.getId()==103){
					float preprice=0.0f;
					if(order.getStatus().equals("y")){//��ȡ��˺�Ķ���
						Quotation qt=QuotationAction.getInstance().getQuotationByPid(order.getPid());
						//��ȡ���ս��
						preprice= qt.getPreadvance() + qt.getSepay() + qt.getBalance();
						}
					row.createCell(9).setCellValue(preprice);
					row.createCell(10).setCellValue(order.getUI());
				}else{
					row.createCell(9).setCellValue(order.getUI());
				}
				
			}
      
			fOut = new FileOutputStream(new File(flowfile));
			wb.write(fOut);
			response.sendRedirect("export/financeEMC.xls");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(fOut != null) {
				// �����������ر��ļ�
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
