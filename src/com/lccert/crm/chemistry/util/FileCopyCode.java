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
		///oa/14#���洦��/����˵ı���/temp.doc
		///oa/14#���洦��/����ӡ�ı���/

		copyFile(fs+"oa"+fs+"14#���洦��"+fs+"����˵ı���"+fs+"temp.doc",fs+"oa"+fs+"14#���洦��"+fs+"����ӡ�ı���"+fs+"temp.doc");
	}
	/** 
     * ���Ƶ����ļ� 
     * @param oldPath String ԭ�ļ�·�� �磺c:/fqf.txt 
     * @param newPath String ���ƺ�·�� �磺f:/fqf.txt 
     * @return boolean 
     */ 
   public void copyFile(String oldPath, String newPath) { 
       try { 
           int bytesum = 0; 
           int byteread = 0; 
           File oldfile = new File(oldPath); 
           if (oldfile.exists()) { //�ļ�����ʱ 
               InputStream inStream = new FileInputStream(oldPath); //����ԭ�ļ� 
               FileOutputStream fs = new FileOutputStream(newPath); 
               byte[] buffer = new byte[1444]; 
               int length; 
               while ( (byteread = inStream.read(buffer)) != -1) { 
                   bytesum += byteread; //�ֽ��� �ļ���С 
                  // System.out.println(bytesum); 
                   fs.write(buffer, 0, byteread); 
               } 
               inStream.close(); 
           } 
       } 
       catch (Exception e) { 
           System.out.println("���Ƶ����ļ���������"); 
           e.printStackTrace(); 

       } 

   } 


}
