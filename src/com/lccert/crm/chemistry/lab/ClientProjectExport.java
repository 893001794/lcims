package com.lccert.crm.chemistry.lab;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.ChemProjectAction;
import com.lccert.crm.project.Project;
import com.lccert.crm.quotation.Quotation;

/**
 * �½�ͻ���Ŀ���ݵ���������
 * �û������½�ͻ�����Ŀ��ϸ���ݵ�Excel����
 * @author Eason
 *
 */
public class ClientProjectExport extends HttpServlet {
	
	
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
	 * ������Ŀ��Excel��
	 * @param request
	 * @param response
	 */
	public synchronized void exportProject(HttpServletRequest request,HttpServletResponse response) {
		HSSFWorkbook wb = null;
		FileOutputStream fOut = null;
		String path = request.getSession().getServletContext().getRealPath("/");
		String flowfile = path + "export\\clientproject.xls";
		List<Quotation> list = (List<Quotation>)request.getSession().getAttribute("clientprojects");
		try {
			// ��ȡ�ļ�����
			wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet();
			//sheet.autoSizeColumn(( short ) 0);

			HSSFRow row = sheet.createRow((short) 0);
			HSSFCell cell = row.createCell(0);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("�ͻ�����");
			row.createCell(1).setCellValue("���۵���");
			row.createCell(2).setCellValue("�����");
			row.createCell(3).setCellValue("����Ŀ�۸�");
			row.createCell(4).setCellValue("��Ŀ����");
			row.createCell(5).setCellValue("��Ʒ����");
			row.createCell(6).setCellValue("����ʱ��");
			
			for(int i=0;i<list.size();i++) {
			 	sheet.autoSizeColumn(( short ) i);
		    	Quotation qt = list.get(i);
//		    	List<Project> lps = ChemProjectAction.getInstance().getChemProjectByPid(qt.getPid(),"");
		    	List<Project> lps =ChemProjectAction.getInstance().getChemProjectByPid(qt.getPid(), "");
		    	for(int j=0;j<lps.size();j++) {
		    		Project p = lps.get(j);
		    		ChemProject cp =(ChemProject)p.getObj();
					row = sheet.createRow((short) i+1);
					cell = row.createCell(0);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(qt.getClient());
					row.createCell(1).setCellValue(p.getPid());
					row.createCell(2).setCellValue(p.getRid());
					row.createCell(3).setCellValue(p.getPrice());
					row.createCell(4).setCellValue(p.getTestcontent());
					row.createCell(5).setCellValue(cp.getSamplename());
					row.createCell(6).setCellValue(p.getBuildtime());
		    	}
			}

      
			fOut = new FileOutputStream(new File(flowfile));
			wb.write(fOut);
			
			response.sendRedirect("export/clientproject.xls");
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
