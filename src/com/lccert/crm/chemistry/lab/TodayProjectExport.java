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

/**
 * ����ӵ���Ŀ����������
 * ��������ӵ���Ŀ��Excel�ļ�
 * @author Eason
 *
 */
public class TodayProjectExport extends HttpServlet {
	
	
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
	 * ��������ӵ���Ŀ��Excel
	 * @param request
	 * @param response
	 */
	public synchronized void exportProject(HttpServletRequest request,HttpServletResponse response) {
		HSSFWorkbook wb = null;
		FileOutputStream fOut = null;
		String   fs   =   System.getProperties().getProperty("file.separator");
		String path = request.getSession().getServletContext().getRealPath(fs);
		String flowfile = path + "export" + fs + "todayproject.xls";
		List<Project> list = (List<Project>)request.getSession().getAttribute("todayprojects");
		try {
			// ��ȡ�ļ�����
			wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet();
			//sheet.autoSizeColumn(( short ) 0);

			HSSFRow row = sheet.createRow((short) 0);
			HSSFCell cell = row.createCell(0);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("��Ŀ�ȼ�");
			row.createCell(1).setCellValue("������");
			row.createCell(2).setCellValue("���۱��");
			row.createCell(3).setCellValue("����ͻ�");
			row.createCell(4).setCellValue("��Ŀ����");
			row.createCell(5).setCellValue("�ŵ�ʱ��");
			row.createCell(6).setCellValue("Ӧ������ʱ��");
			row.createCell(7).setCellValue("ʵ�����ʱ��");
			row.createCell(8).setCellValue("������Ա");
			row.createCell(9).setCellValue("�ͷ���Ա");
			row.createCell(10).setCellValue("����ʦ");
			row.createCell(11).setCellValue("��������ʱ��");
			row.createCell(12).setCellValue("����������");
			row.createCell(13).setCellValue("�������ʱ��");
			row.createCell(14).setCellValue("���������");
			row.createCell(15).setCellValue("��Ŀ״̬");
			
			for(int i=0;i<list.size();i++) {
				sheet.autoSizeColumn(( short ) i);
				Project p = list.get(i);
				ChemProject cp = (ChemProject)p.getObj();
				Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
				row = sheet.createRow((short) i+1);
				cell = row.createCell(0);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(p.getLevel());
				row.createCell(1).setCellValue(p.getRid());
				row.createCell(2).setCellValue(p.getPid());
				row.createCell(3).setCellValue(cp.getClient());
				row.createCell(4).setCellValue(p.getTestcontent());
				row.createCell(5).setCellValue(cp.getCreatetime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cp.getCreatetime()));
				row.createCell(6).setCellValue(cp.getRptime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cp.getRptime()));
				row.createCell(7).setCellValue(cp.getEndtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cp.getEndtime()));
				row.createCell(8).setCellValue(qt.getSales());
				row.createCell(9).setCellValue(cp.getServname());
				row.createCell(10).setCellValue(cp.getEngineer());
//				System.out.println(cp.getNucopletintime()+":cp.getNucopletintime()");
//				System.out.println(cp.getRpconfirmtime()+":cp.getRpconfirmtime()");
				row.createCell(11).setCellValue(cp.getNucopletintime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getNucopletintime()));
				row.createCell(12).setCellValue(cp.getNucopletinuser()==null?"":cp.getNucopletinuser());
				row.createCell(13).setCellValue(cp.getRpconfirmtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getRpconfirmtime()));
				row.createCell(14).setCellValue(cp.getRpconfirmuser()==null?"":cp.getRpconfirmuser());
				row.createCell(15).setCellValue(cp.getStatus());
			}
			fOut = new FileOutputStream(new File(flowfile));
			wb.write(fOut);
			
			response.sendRedirect("export/todayproject.xls");
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
