package com.lccert.crm.quotation;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DecimalFormat;
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
import com.lccert.crm.vo.Fincome;

/**
 * ������������뵼������
 *
 */
public class FinComeExport extends HttpServlet {
	
	
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
		String flowfile = path + "export" + fs + "fincomeExport.xls";
		//��ȡҳ�洫������ֵ
		Fincome fincome = (Fincome)request.getSession().getAttribute("fincome");
		List <Fincome> list=DaoFactory.getInstance().getFincome().searchFincomeList(fincome);
		try {
			// ��ȡ�ļ�����
			wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet();
			HSSFRow row = sheet.createRow((short) 0);
			HSSFCell cell = row.createCell(0);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("�յ�����");
			row.createCell(1).setCellValue("�ͻ�����");
			row.createCell(2).setCellValue("���");
			row.createCell(3).setCellValue("�·�");
			row.createCell(4).setCellValue("���۵���");
			row.createCell(5).setCellValue("��������");
			row.createCell(6).setCellValue("������Ա");
			row.createCell(7).setCellValue("��ѧ");
			row.createCell(8).setCellValue("��ȫ");
			row.createCell(9).setCellValue("������");
			row.createCell(10).setCellValue("EMC��Ӫ");
			row.createCell(11).setCellValue("EMC����");
			row.createCell(12).setCellValue("��ͻ�");
			row.createCell(13).setCellValue("������");
			row.createCell(14).setCellValue("����");
			row.createCell(15).setCellValue("���ݹ�˾");
			row.createCell(16).setCellValue("С��");
			row.createCell(17).setCellValue("�˺�����");
			row.createCell(18).setCellValue("Ʊ������");
			row.createCell(19).setCellValue("��Ʊ����");
			row.createCell(20).setCellValue("��ע");
			row.createCell(21).setCellValue("ƾ֤��");
			row.createCell(22).setCellValue("ʡ��");
			row.createCell(23).setCellValue("����");
			for(int i=0;i<list.size();i++) {
				sheet.autoSizeColumn(( short ) i+1);
				fincome = list.get(i);
				row = sheet.createRow((short) i+1);
				cell = row.createCell(0);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(fincome.getDpaytime()==null?"":fincome.getDpaytime());
				row.createCell(1).setCellValue(fincome.getClient() ==null?"":fincome.getClient());
				row.createCell(2).setCellValue(fincome.getVpyear() ==null?"":fincome.getVpyear());
				row.createCell(3).setCellValue(fincome.getVpmonth()==null?"":fincome.getVpmonth());
				row.createCell(4).setCellValue(fincome.getVpid()==null?"":fincome.getVpid());
				row.createCell(5).setCellValue(fincome.getDept()==" "?"":fincome.getDept());
				row.createCell(6).setCellValue(fincome.getSales()==null?"":fincome.getSales());
				row.createCell(7).setCellValue(fincome.getChem()!=null && fincome.getChem()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getChem()):"");
				row.createCell(8).setCellValue(fincome.getSafe()!=null && fincome.getSafe()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getSafe()):"");
				row.createCell(9).setCellValue(fincome.getOp()!=null && fincome.getOp()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getOp()):"");
				row.createCell(10).setCellValue(fincome.getEmc()!=null && fincome.getEmc()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getEmc()):"");
				row.createCell(11).setCellValue(fincome.getDr()!=null && fincome.getDr()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getDr()):"");
				row.createCell(12).setCellValue(fincome.getVip()!=null && fincome.getVip()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getVip()):"");
				row.createCell(13).setCellValue(fincome.getEq()!=null && fincome.getEq()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getEq()):"");
				row.createCell(14).setCellValue(fincome.getFinance()!=null && fincome.getFinance()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getFinance()):"");
				row.createCell(15).setCellValue(fincome.getGz()!=null && fincome.getGz()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getGz()):"");
				row.createCell(16).setCellValue(fincome.getTotal()!=null && fincome.getTotal()!=0?new DecimalFormat("##,###,###,###.00").format(fincome.getTotal()):"");
				row.createCell(17).setCellValue(fincome.getAccount()==null?"":fincome.getAccount());
				row.createCell(18).setCellValue(fincome.getEinvtype()==null?"": fincome.getEinvtype());
				row.createCell(19).setCellValue(fincome.getEinvno()==null?"":fincome.getEinvno());
				row.createCell(20).setCellValue(fincome.getRemarks()==null?"":fincome.getRemarks());
				row.createCell(21).setCellValue("");
				row.createCell(22).setCellValue(fincome.getProvince()==null?"":fincome.getProvince());
				row.createCell(23).setCellValue(fincome.getCity()==null?"":fincome.getCity());
			}
			row = sheet.getRow(1);
			
      
			fOut = new FileOutputStream(new File(flowfile));
			wb.write(fOut);
			response.sendRedirect("export/fincomeExport.xls");
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
