package com.lccert.crm.chemistry.util;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
/***
 * ��ȡelx�Ĺ���
 * @author Administrator
 *
 */
public class ReadExl {
	public List<String[]> parse(File file) {   
	    List<String[]> excelValueList = new ArrayList<String[]>();   
	    if (file.exists() && file.canRead()&& (file.getName().lastIndexOf(".xls") >= 1)) {   //�ж��Ƿ���ڸ��ı�
	        Workbook workbook = null;   
	        try {   
	            workbook = Workbook.getWorkbook(file);  //�õ�����������
	            Sheet sheet = workbook.getSheet(0);   //��ȡ������
	            int row = sheet.getRows();    //��ȡ������������� 
	            int col = sheet.getColumns();    //��ȡ�������������
	            for (int r = 0; r < row; r++) {   
	                String[] rowValue = new String[col];   //����һ������
	                for (int c = 0; c < col; c++) {  
	                	// rowValue[c]�˱�������װȡÿ����Ԫ���ֵ�������жϸõ�Ԫ���Ƿ�Ϊ�ն������Ϊ�վ�ȥ""ֵ
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
   
