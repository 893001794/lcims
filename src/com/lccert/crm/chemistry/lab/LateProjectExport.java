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
 * �ٵ���Ŀ����������
 * ���ڵ����ٵ���Ŀ��Excel�ļ�
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
	 * �����ٵ���Ŀ��Excel
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
			// ��ȡ�ļ�����
			wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet();
			//sheet.autoSizeColumn(( short ) 0);

			HSSFRow row = sheet.createRow((short) 0);
			HSSFCell cell = row.createCell(0);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("��Ŀ�ȼ�");
			row.createCell(1).setCellValue("������");
			row.createCell(2).setCellValue("��Ŀ����");
			row.createCell(3).setCellValue("�ŵ�ʱ��");
			row.createCell(4).setCellValue("Ӧ������ʱ��");
			row.createCell(5).setCellValue("ʵ�����ʱ��");
			row.createCell(6).setCellValue("������Ա");
			row.createCell(7).setCellValue("�ͷ���Ա");
			row.createCell(8).setCellValue("����ʦ");
			row.createCell(9).setCellValue("��Ŀ״̬");
			row.createCell(10).setCellValue("�ٵ���/��Ŀ������");
			row.createCell(11).setCellValue(family[0] + "/" + family[1]);
			row.createCell(12).setCellValue("�ٵ��ʣ�");
			row.createCell(13).setCellValue(family[0]*100/family[1] + "%");
			row.createCell(14).setCellValue("Ӧ������������"+family[2]);
			row.createCell(15).setCellValue("Ӧ����ɽ����������"+family[3]);
			row.createCell(16).setCellValue("Ӧ����ݸ����������"+family[4]);
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
