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

import com.lccert.crm.dao.DaoFactory;
import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.user.UserAction;
import com.lccert.crm.user.UserForm;
import com.lccert.crm.vo.Fpay;

/**
 * ���������֧����������
 *
 */
public class FpayExport extends HttpServlet {
	
	
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
	 * ������������ʵ�����Excel
	 * @param request
	 * @param response
	 */
	public synchronized void exportProject(HttpServletRequest request,HttpServletResponse response) {
		HSSFWorkbook wb = null;
		FileOutputStream fOut = null;
		String   fs   =   System.getProperties().getProperty("file.separator");
		String path = request.getSession().getServletContext().getRealPath(fs);
		String flowfile = path + "export" + fs + "fPayExport.xls";
		//��ȡҳ�洫������ֵ
		Fpay fpay = (Fpay)request.getSession().getAttribute("fPay");
		List <Fpay> list=DaoFactory.getInstance().getFpay().searchFpayList(fpay);
		try {
			// ��ȡ�ļ�����
			wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet();
			HSSFRow row = sheet.createRow((short) 0);
			HSSFCell cell = row.createCell(0);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("֧������");
			row.createCell(1).setCellValue("��Ӧ��");
			row.createCell(2).setCellValue("ժҪ");
			row.createCell(3).setCellValue("����");
			row.createCell(4).setCellValue("��Ա");
			row.createCell(5).setCellValue("��ѧ");
			row.createCell(6).setCellValue("��ȫ");
			row.createCell(7).setCellValue("������");
			row.createCell(8).setCellValue("EMC��Ӫ");
			row.createCell(9).setCellValue("EMC����");
			row.createCell(10).setCellValue("��ͻ���");
			row.createCell(11).setCellValue("������");
			row.createCell(12).setCellValue("�ܾ���");
			row.createCell(13).setCellValue("����");
			row.createCell(14).setCellValue("������");
			row.createCell(15).setCellValue("���̲�");
			row.createCell(16).setCellValue("С��");
			row.createCell(17).setCellValue("�˺�����");
			row.createCell(18).setCellValue("Ʊ������");
			row.createCell(19).setCellValue("��Ʊ����");
			row.createCell(20).setCellValue("ƾ֤��");
			row.createCell(21).setCellValue("��ע");
			row.createCell(22).setCellValue("һ����Ŀ");
			row.createCell(23).setCellValue("������Ŀ");
			row.createCell(24).setCellValue("������Ŀ");
			row.createCell(25).setCellValue("��������");
			row.createCell(26).setCellValue("�д��ͻ�");
			for(int i=0;i<list.size();i++) {
				sheet.autoSizeColumn(( short ) i+1);
				fpay = list.get(i);
				row = sheet.createRow((short) i+1);
				cell = row.createCell(0);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(fpay.getDpaytime()==null?"":fpay.getDpaytime());
				row.createCell(1).setCellValue(fpay.getSupplier());
				row.createCell(2).setCellValue(fpay.getSummay());
				row.createCell(3).setCellValue(fpay.getDept());
				row.createCell(4).setCellValue(fpay.getPerson());
				row.createCell(5).setCellValue(fpay.getChem()!=null && fpay.getChem()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getChem()):"");
				row.createCell(6).setCellValue(fpay.getSafe()!=null && fpay.getSafe()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getSafe()):"");
				row.createCell(7).setCellValue(fpay.getOp()!=null && fpay.getOp()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getOp()):"");
				row.createCell(8).setCellValue(fpay.getEmc()!=null && fpay.getEmc()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getEmc()):"");
				row.createCell(9).setCellValue(fpay.getDr()!=null && fpay.getDr()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getDr()):"");
				row.createCell(10).setCellValue(fpay.getVip()!=null && fpay.getVip()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getVip()):"");
				row.createCell(11).setCellValue(fpay.getEq()!=null && fpay.getEq()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getEq()):"");
				row.createCell(12).setCellValue(fpay.getGmo()!=null && fpay.getGmo()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getGmo()):"");
				row.createCell(13).setCellValue(fpay.getFinance()!=null && fpay.getFinance()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getFinance()):"");
				row.createCell(14).setCellValue(fpay.getAdministration()!=null && fpay.getAdministration()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getAdministration()):"");
				row.createCell(15).setCellValue(fpay.getEngineering()!=null && fpay.getEngineering()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getEngineering()):"");
				row.createCell(16).setCellValue(fpay.getTotal()!=null && fpay.getTotal()!=0?new DecimalFormat("##,###,###,###.00").format(fpay.getTotal()):"");
				row.createCell(17).setCellValue(fpay.getAccount());
				row.createCell(18).setCellValue(fpay.getEinvtype());
				row.createCell(19).setCellValue(fpay.getInvoiceno());
				row.createCell(20).setCellValue("");
				row.createCell(21).setCellValue(fpay.getRemarks());
				row.createCell(22).setCellValue(fpay.getOnelevelsub());
				row.createCell(23).setCellValue(fpay.getTwolevelsub());
				row.createCell(24).setCellValue(fpay.getThreelevelsub());
				row.createCell(25).setCellValue(fpay.getTravel());
				row.createCell(26).setCellValue(fpay.getEntertain());
			}
			row = sheet.getRow(1);
			
      
			fOut = new FileOutputStream(new File(flowfile));
			wb.write(fOut);
			response.sendRedirect("export/fPayExport.xls");
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
