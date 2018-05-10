package com.lccert.crm.project;

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
import com.lccert.crm.quotation.QuotationAction;

/**
 * ��Ŀ����������
 * ���ڵ�����ز�����Ŀ��Excel�ļ�
 * @author Eason
 *
 */
public class ProjectExport extends HttpServlet {
	
	
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
	 * ������Ŀ��Excel
	 * @param request
	 * @param response
	 */
	public synchronized void exportProject(HttpServletRequest request,HttpServletResponse response) {
		HSSFWorkbook wb = null;
		FileOutputStream fOut = null;
		String   fs   =   System.getProperties().getProperty("file.separator");
		String path = request.getSession().getServletContext().getRealPath(fs);
		String flowfile = path + "export" + fs + "export.xls";
		List<Project> list = (List<Project>)request.getSession().getAttribute("projects");
		try {
			// ��ȡ�ļ�����
			wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet();
			//sheet.autoSizeColumn(( short ) 0);

			HSSFRow row = sheet.createRow((short) 0);
			HSSFCell cell = row.createCell(0);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("���۵���");
			row.createCell(1).setCellValue("��Ŀ��");
			row.createCell(2).setCellValue("������");
			row.createCell(3).setCellValue("��Ŀ����");
			row.createCell(4).setCellValue("��������");
			row.createCell(5).setCellValue("Ӧ������ʱ��");
			row.createCell(6).setCellValue("��Ŀ�ȼ�");
			row.createCell(7).setCellValue("������Ա");
			row.createCell(8).setCellValue("�ͷ���Ա");
			row.createCell(9).setCellValue("�ͻ�����");
			row.createCell(10).setCellValue("��ĿԤ��");
			row.createCell(11).setCellValue("������Ŀ");
			row.createCell(12).setCellValue("�ֹ�˾");
			row.createCell(13).setCellValue("������Ա");
			row.createCell(14).setCellValue("����ʱ��");
			row.createCell(15).setCellValue("��Ʒ����");
			row.createCell(16).setCellValue("��Ʒ��");
			row.createCell(17).setCellValue("��Ʒ����");
			row.createCell(18).setCellValue("�Ƿ��տ�");
			
			for(int i=0;i<list.size();i++) {
				sheet.autoSizeColumn(( short ) i);
				Project p = list.get(i);
				String rptype = "";
				String rptime = "";
				String servname = "";
				String warning = "";
				String samplename = "";
				String samplecount = "";
				String sampledesc = "";
				if("��ѧ����".equals(p.getPtype())||"��ױƷ".equals(p.getPtype())||"����".equals(p.getPtype())) {
					ChemProject cp = (ChemProject)p.getObj();
					rptype = cp.getRptype();
					rptime = cp.getRptime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getRptime());
					servname = cp.getServname();
					warning = cp.getWarning();
					samplename = cp.getSamplename();
					samplecount = cp.getSamplecount();
					sampledesc = cp.getSampledesc();
				} else {
					//PhyProject pp = (PhyProject)p.getObj();
				}
				Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
				row = sheet.createRow((short) i+1);
				cell = row.createCell(0);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(p.getPid());
				row.createCell(1).setCellValue(p.getSid());
				row.createCell(2).setCellValue(p.getRid());
				row.createCell(3).setCellValue(p.getPtype());
				row.createCell(4).setCellValue(rptype);
				row.createCell(5).setCellValue(rptime);
				row.createCell(6).setCellValue(p.getLevel());
				row.createCell(7).setCellValue(qt.getSales());
				row.createCell(8).setCellValue(servname);
				row.createCell(9).setCellValue(qt.getClient());
				row.createCell(10).setCellValue(warning);
				row.createCell(11).setCellValue(p.getTestcontent());
				row.createCell(12).setCellValue(qt.getCompany());
				row.createCell(13).setCellValue(p.getBuildname());
				row.createCell(14).setCellValue(p.getBuildtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(p.getBuildtime()));
				row.createCell(15).setCellValue(samplename);
				row.createCell(16).setCellValue(samplecount);
				row.createCell(17).setCellValue(sampledesc);
				row.createCell(18).setCellValue(qt.getPreadvance()/qt.getTotalprice()*100 + "%");
			}

      
			fOut = new FileOutputStream(new File(flowfile));
			wb.write(fOut);
			
			response.sendRedirect("export/export.xls");
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
