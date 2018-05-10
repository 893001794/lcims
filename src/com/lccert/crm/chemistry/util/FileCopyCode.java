package com.lccert.crm.chemistry.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;

public class FileCopyCode {
	public static void main(String[] args) {
		FileCopyCode fc =new FileCopyCode();
		fc.copyFile("E:\\LCZC11050266-C(CNAS).doc", "D:\\LCZC11050266-C(CNAS).doc");
	}
	
	public void assign(){
		String fs = System.getProperties().getProperty("file.separator");
		///oa/14#报告处理/待审核的报告/temp.doc
		///oa/14#报告处理/待打印的报告/

		copyFile(fs+"oa"+fs+"14#报告处理"+fs+"待审核的报告"+fs+"temp.doc",fs+"oa"+fs+"14#报告处理"+fs+"待打印的报告"+fs+"temp.doc");
	}
	/** 
     * 复制单个文件 
     * @param oldPath String 原文件路径 如：c:/fqf.txt 
     * @param newPath String 复制后路径 如：f:/fqf.txt 
     * @return boolean 
     */ 
   public void copyFile(String oldPath, String newPath) { 
       try { 
           int bytesum = 0; 
           int byteread = 0; 
           File oldfile = new File(oldPath); 
           if (oldfile.exists()) { //文件存在时 
               InputStream inStream = new FileInputStream(oldPath); //读入原文件 
               FileOutputStream fs = new FileOutputStream(newPath); 
               byte[] buffer = new byte[1444]; 
               int length; 
               while ( (byteread = inStream.read(buffer)) != -1) { 
                   bytesum += byteread; //字节数 文件大小 
                  // System.out.println(bytesum); 
                   fs.write(buffer, 0, byteread); 
               } 
               inStream.close(); 
           } 
       } 
       catch (Exception e) { 
           System.out.println("复制单个文件操作出错"); 
           e.printStackTrace(); 

       } 

   } 


}
