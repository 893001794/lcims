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
 * ���񶩵�����������
 * ���ڵ�������Ŀ���������ص���Ϣ��Excel�ļ�
 * @author Eason
 *
 */
public class PayFinanceExport extends HttpServlet {
	
	
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
		String flowfile = path + "export" + fs + "payFinance.xls";
		List<Quotation> list = (List<Quotation>)request.getSession().getAttribute("financeQ");
		//System.out.println(list.size());
		try {
			// ��ȡ�ļ�����
			wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet();
			HSSFRow row = sheet.createRow((short) 0);
			HSSFCell cell = row.createCell(0);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("����ʱ��(���յ�����)");
			row.createCell(1).setCellValue("���۵���");
			row.createCell(2).setCellValue("����");
			row.createCell(3).setCellValue("�ͻ�����");
			row.createCell(4).setCellValue("���۽��");
			row.createCell(5).setCellValue("Ԥ�տ�");
			row.createCell(6).setCellValue("Ԥ�տ�ʱ��");
			row.createCell(7).setCellValue("�����տ�");
			row.createCell(8).setCellValue("����Ԥ�տ�ʱ��");
			row.createCell(9).setCellValue("β���տ�");
			row.createCell(10).setCellValue("β���տ�ʱ��");
			row.createCell(11).setCellValue("Ƿ����");
			
			for(int i=0;i<list.size();i++) {
				sheet.autoSizeColumn(( short ) i+1);
				Quotation qt = list.get(i);
				row = sheet.createRow((short) i+1);
				cell = row.createCell(0);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(qt.getConfirmtime()==null?"":new SimpleDateFormat("yyyy.MM").format(qt.getConfirmtime()));
				row.createCell(1).setCellValue(qt.getPid());
				row.createCell(2).setCellValue(qt.getSales());
				row.createCell(3).setCellValue(qt.getClient());
				row.createCell(4).setCellValue(qt.getTotalprice());
				row.createCell(5).setCellValue(qt.getPreadvance());
				row.createCell(6).setCellValue(qt.getPaytime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getPaytime()));
				
				row.createCell(7).setCellValue(qt.getSepay());
				row.createCell(8).setCellValue(qt.getSepaytime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getSepaytime()));
				row.createCell(9).setCellValue(qt.getBalance());
				row.createCell(10).setCellValue(qt.getBalancetime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(qt.getBalancetime()));
				row.createCell(11).setCellValue(qt.getTotalprice() - (qt.getPreadvance() + qt.getSepay() + qt.getBalance()));
			}
			row = sheet.getRow(1);
			
      
			fOut = new FileOutputStream(new File(flowfile));
			wb.write(fOut);
			response.sendRedirect("export/payFinance.xls");
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
