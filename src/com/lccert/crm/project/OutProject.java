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
/***
 * �����Ŀ��servlet��
 * @author tangzp
 *
 */
public class OutProject extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest requst, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(requst, response);
	}

	@Override
	protected void doPost(HttpServletRequest requst, HttpServletResponse response)
			throws ServletException, IOException {
		exOutProject(requst, response);
	}
	
	/**
	 * ��������ӵ���Ŀ��Excel
	 * @param request
	 * @param response
	 */
	public synchronized void exOutProject(HttpServletRequest request,HttpServletResponse response) {
		HSSFWorkbook wb = null;
		FileOutputStream fOut = null;
		String   fs   =   System.getProperties().getProperty("file.separator");
		String path = request.getSession().getServletContext().getRealPath(fs);
		String type ="";
		//��ȡ�������
		if(request.getSession().getAttribute("outype")!=null && request.getSession().getAttribute("outype").equals("tuv")){
			type ="TUV";
		}else{
			type ="POUT";
		}
		
		String flowfile = path + "export" + fs + type+"project.xls";
		List<Project> list = (List<Project>)request.getSession().getAttribute("outproject");
		try {
			// ��ȡ�ļ�����
			wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet();
			//sheet.autoSizeColumn(( short ) 0);
			HSSFRow row = sheet.createRow((short) 0);
			HSSFCell cell = row.createCell(0);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			//���������������ѡ��ͬ���ֶ�����
			if(type.equals("TUV")){
				cell.setCellValue("���۵����");
				row.createCell(1).setCellValue("��Ŀ�����");
				row.createCell(2).setCellValue("TUV���");
				row.createCell(3).setCellValue("�ͻ�����");
				row.createCell(4).setCellValue("��������");
				row.createCell(5).setCellValue("��Ʒ����");
				row.createCell(6).setCellValue("������Ŀ");
				row.createCell(7).setCellValue("�����Կͻ�����(����)");
				row.createCell(8).setCellValue("����ʦ");
				row.createCell(9).setCellValue("�������ְ���");
				row.createCell(10).setCellValue("TUV���Է���");
				row.createCell(11).setCellValue("To TUV(40%)");
				row.createCell(12).setCellValue("TUV(TUV���Է�+40%)");
				row.createCell(13).setCellValue("To ����");
				for(int i=0;i<list.size();i++) {
					sheet.autoSizeColumn(( short ) i);
					Project p =list.get(i);
					//TUV�����Ŀ����
					float tuvPrice=0.0f;
					//������
					float presubcost=Float.parseFloat(p.getPresubcost());
					//TO TUV(40%)=��TUV����������-����������-TUV���Է��ã�*40%
					 tuvPrice=(p.getPrice()-p.getSubcost2()-presubcost)*0.4f;
					row = sheet.createRow((short) i+1);
					cell = row.createCell(0);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(p.getPid());
					row.createCell(1).setCellValue(p.getRid());
					row.createCell(2).setCellValue(p.getTuvno());
					row.createCell(3).setCellValue(p.getClient());
					row.createCell(4).setCellValue(p.getSales());
					row.createCell(5).setCellValue(p.getSamplename());
					row.createCell(6).setCellValue(p.getTuvpshort());
					row.createCell(7).setCellValue(p.getLcrealprice());
					row.createCell(8).setCellValue(p.getPrice());
					row.createCell(9).setCellValue(p.getSubcost2());
					row.createCell(10).setCellValue(p.getPresubcost());
					row.createCell(11).setCellValue(tuvPrice);
					row.createCell(12).setCellValue(tuvPrice+presubcost);
					row.createCell(13).setCellValue(p.getPrice()-tuvPrice-presubcost);
				}
			}else{
			cell.setCellValue("���۵����");
			row.createCell(1).setCellValue("��Ŀ�����");
			row.createCell(2).setCellValue("��Ŀ����");
			row.createCell(3).setCellValue("Ӧ������ʱ��");
			row.createCell(4).setCellValue("���ʱ��");
			row.createCell(5).setCellValue("ʵ��������");
			row.createCell(6).setCellValue("��������Ǽ�");
			row.createCell(7).setCellValue("��Ʒ����");
			row.createCell(8).setCellValue("��������)");
			row.createCell(9).setCellValue("�ְ�����");
			row.createCell(10).setCellValue("������ʱ��");	
			for(int i=0;i<list.size();i++) {
				sheet.autoSizeColumn(( short ) i);
				Project p =list.get(i);
				row = sheet.createRow((short) i+1);
				cell = row.createCell(0);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(p.getPid());
				row.createCell(1).setCellValue(p.getRid());
				row.createCell(2).setCellValue(p.getTestcontent()==null ?"":p.getTestcontent() );
				row.createCell(3).setCellValue(p.getOrtime() ==null ?"":new SimpleDateFormat("yyyy.MM").format(p.getOrtime()));
				row.createCell(4).setCellValue(p.getBqtime() ==null ?"":new SimpleDateFormat("yyyy.MM").format(p.getBqtime()));
				row.createCell(5).setCellValue(p.getOeprice());
				row.createCell(6).setCellValue(p.getOstime() ==null ?"":new SimpleDateFormat("yyyy.MM").format(p.getOstime()));
				row.createCell(7).setCellValue(p.getSamplename()==null?"":p.getSamplename());
				row.createCell(8).setCellValue(p.getSales() ==null ?"":p.getSales());
				row.createCell(9).setCellValue(p.getSubname() ==null ?"":p.getSubname());
				row.createCell(10).setCellValue(p.getOetime() ==null ?"":new SimpleDateFormat("yyyy.MM").format(p.getOstime()));
			}

			}
			fOut = new FileOutputStream(new File(flowfile));
			wb.write(fOut);
			
			response.sendRedirect("export/"+type+"project.xls");
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
