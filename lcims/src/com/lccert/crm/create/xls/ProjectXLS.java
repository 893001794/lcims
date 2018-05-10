package com.lccert.crm.create.xls;

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
import com.lccert.crm.vo.ProjectChem;

/**
 * ���񶩵�����������
 * ���ڵ�������Ŀ���������ص���Ϣ��Excel�ļ�
 * @author Eason
 *
 */
public class ProjectXLS extends HttpServlet {
	
	
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
		String flowfile = path + "export" + fs + "project.xls";
		List list =(List)request.getSession().getAttribute("projectxls");
		try {
			// ��ȡ�ļ�����
			wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet();
			//sheet.autoSizeColumn(( short ) 0);

			HSSFRow row = sheet.createRow((short) 0);
			HSSFCell cell = row.createCell(0);
		
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("���Ա����");
			row.createCell(1).setCellValue("��Ʒ����");
			row.createCell(2).setCellValue("������Ŀ");
			row.createCell(3).setCellValue("�ŵ�ʱ��");
			row.createCell(4).setCellValue("Ӧ�����������");
			row.createCell(5).setCellValue("���Ƶ���");
			row.createCell(6).setCellValue("ʵ�ʵ���");
			row.createCell(7).setCellValue("��Ŀ������");
			row.createCell(8).setCellValue("��Ŀǩ����");
			row.createCell(9).setCellValue("����");
		
			for(int i=0;i<list.size();i++) {
				sheet.autoSizeColumn(( short ) i+1);
				ProjectChem p = (ProjectChem) list.get(i);
				row = sheet.createRow((short) i+1);
				cell = row.createCell(0);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(p.getRid());
				row.createCell(1).setCellValue(p.getSamplename());
				row.createCell(2).setCellValue(p.getProjectcontent());
				row.createCell(3).setCellValue(p.getCreatetime()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(p.getCreatetime()));
				row.createCell(4).setCellValue(p.getCompletetime()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(p.getCompletetime()));
				row.createCell(5).setCellValue(p.getEstimate());
				row.createCell(6).setCellValue(p.getItestcount());
				
				row.createCell(7).setCellValue(p.getProjectleader()==null?"":p.getProjectleader());
				row.createCell(8).setCellValue(p.getProjectissuer()==null?"":p.getProjectissuer());
			
				row.createCell(9).setCellValue(p.getObject());
				
			}
			row = sheet.getRow(1);
			fOut = new FileOutputStream(new File(flowfile));
			wb.write(fOut);
			
			response.sendRedirect("export/project.xls");
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
