package com.lccert.crm.flow;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import jp.ne.so_net.ga2.no_ji.jcom.IDispatch;
import jp.ne.so_net.ga2.no_ji.jcom.JComException;
import jp.ne.so_net.ga2.no_ji.jcom.ReleaseManager;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFooter;
import org.apache.poi.hssf.usermodel.HSSFHeader;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.ChemProjectAction;
import com.lccert.crm.project.Project;

/**
 * 打印流转单工具类
 * 用于打印流转单，网页打印方式
 * @author eason
 * 
 */
public class PrintFlowAction {

	private static PrintFlowAction instance = null;

	private PrintFlowAction() {

	}

	public synchronized static PrintFlowAction getInstance() {
		if (instance == null) {
			instance = new PrintFlowAction();
		}
		return instance;
	}

	/**
	 * 打印流转单
	 * 
	 * @param flowfile
	 * @param flow
	 * @return
	 */
	public synchronized boolean Printflow(String flowfile, Flow flow) {
		POIFSFileSystem fs = null;
		HSSFWorkbook wb = null;
		FileOutputStream fileOut = null;
		boolean isok = false;
		Project p = ChemProjectAction.getInstance().getChemProjectBySid(flow.getSid(),"");
		ChemProject cp = (ChemProject)p.getObj();
		try {
			// 读取文件内容
			fs = new POIFSFileSystem(new FileInputStream(flowfile));
			wb = new HSSFWorkbook(fs);
			HSSFSheet sheet = wb.getSheetAt(0);

			HSSFRow row = sheet.getRow(1);
			HSSFCellStyle style = wb.createCellStyle();// 创建一个样式
			style.setWrapText(true);// 自动换行

			HSSFCell cell = row.getCell(1);
			cell.setCellStyle(style);
			if (cell == null)
				cell = row.createCell(1);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(flow.getRid());
			cell = row.getCell(5);
			if (cell == null)
				cell = row.createCell(5);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(flow.getPid());

			row = sheet.getRow(3);
			cell = row.getCell(1);
			if (cell == null)
				cell = row.createCell(1);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(flow.getPdtime());
			cell = row.getCell(5);
			if (cell == null)
				cell = row.createCell(5);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(cp.getRptime());

			row = sheet.getRow(5);
			cell = row.getCell(1);
			if (cell == null)
				cell = row.createCell(1);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(p.getLevel());
			cell = row.getCell(5);
			if (cell == null)
				cell = row.createCell(5);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(cp.getRptype());

			row = sheet.getRow(7);
			cell = row.getCell(0);
			if (cell == null)
				cell = row.createCell(0);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(flow.getTestparent());

			row = sheet.getRow(12);
			cell = row.getCell(0);
			if (cell == null)
				cell = row.createCell(0);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(flow.getTestchild());

			row = sheet.getRow(21);
			cell = row.getCell(0);
			if (cell == null)
				cell = row.createCell(0);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(cp.getSampledesc());

			row = sheet.getRow(31);
			cell = row.getCell(0);
			if (cell == null)
				cell = row.createCell(0);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(cp.getAppform());

			row = sheet.getRow(45);
			cell = row.getCell(4);
			if (cell == null)
				cell = row.createCell(4);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(new SimpleDateFormat("yyyy-MM-dd").format(flow
					.getPdtime()));

			String icode = "*" + flow.getFid().substring(3, 13) + "*";
			HSSFHeader header = sheet.getHeader();
			header.setRight(HSSFHeader.fontSize((short) 30)
					+ HSSFHeader.font("C39HrP24DmTt", "Normal") + icode);
			header.setLeft(HSSFHeader.fontSize((short) 24)
					+ HSSFHeader.font("宋体", "常规") + "LC-WS-003"
					+ flow.getFlowtype().substring(0, 2));
			HSSFFooter footer = sheet.getFooter();
			footer.setLeft(new SimpleDateFormat("yyyy-MM-dd")
					.format(new Date()));
			footer.setRight("共1页，第1页");

			// 把内容写入文件

			fileOut = new FileOutputStream(flowfile);
			wb.write(fileOut);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (fileOut != null) {
					fileOut.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		// String path="D:\\test.doc";
		// print("Word.Application", "Documents", path);
		if (print("Excel.Application", "Workbooks", flowfile)) {
			isok = true;
		}

		return isok;
	}

	/***
	 * 打印
	 * @param docApplication
	 *            Application类型
	 * @param docProperty
	 *            文档的属性
	 * @param filePath
	 *            文件的绝对路径
	 */
	private synchronized boolean print(String docApplication,
			String docProperty, String filePath) {
		ReleaseManager rm = new ReleaseManager();
		boolean isok = false;
		try {
			IDispatch docApp = new IDispatch(rm, docApplication);
			docApp.put("Visible", new Boolean(false));

			IDispatch wdDocuments = (IDispatch) docApp.get(docProperty);
			Object[] arglist1 = new Object[1];

			arglist1[0] = (Object) filePath;
			IDispatch docDocument = (IDispatch) wdDocuments.method("Open",
					arglist1);

			docDocument.method("PrintOut", null);
			docApp.method("Quit", null);
			isok = true;
		} catch (JComException e) {
			e.printStackTrace();
		} finally {
			rm.release();
			rm = null;
		}
		return isok;
	}

}
