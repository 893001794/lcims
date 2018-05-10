package com.lccert.crm.chemistry.util;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
/***
 * 读取elx的工具
 * @author Administrator
 *
 */
public class ReadExl {
	public List<String[]> parse(File file) {   
	    List<String[]> excelValueList = new ArrayList<String[]>();   
	    if (file.exists() && file.canRead()&& (file.getName().lastIndexOf(".xls") >= 1)) {   //判断是否存在该文本
	        Workbook workbook = null;   
	        try {   
	            workbook = Workbook.getWorkbook(file);  //得到工作部对象
	            Sheet sheet = workbook.getSheet(0);   //获取工作表
	            int row = sheet.getRows();    //获取工作表的所有行 
	            int col = sheet.getColumns();    //获取工作表的所有列
	            for (int r = 0; r < row; r++) {   
	                String[] rowValue = new String[col];   //声明一个数组
	                for (int c = 0; c < col; c++) {  
	                	// rowValue[c]此变量用来装取每个单元格的值，并且判断该单元格是否为空对象，如果为空就去""值
	                    rowValue[c] = sheet.getCell(c, r).getContents() != null ? sheet.getCell(c, r).getContents():"";   
	                }   
	                excelValueList.add(rowValue);   
	            }   
	        } catch (BiffException e) {   
	            // TODO Auto-generated catch block   
	            e.printStackTrace();   
	        } catch (IOException e) {   
	            // TODO Auto-generated catch block   
	            e.printStackTrace();   
	        } finally {   
	            if (workbook != null) {   
	                workbook.close();   
	            }   
	        }   
	    }   
	    return excelValueList;   
	}
}
   
