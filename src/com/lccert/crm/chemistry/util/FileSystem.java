package com.lccert.crm.chemistry.util;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.lccert.crm.dao.impl.RecordDaoImpl;


public class FileSystem{
	String fs = System.getProperties().getProperty("file.separator");
	static int fileCount =0;
	String folderName ="";
	String lastPath="";
	int indexOfC=0; //用来记录不相同文件个数的
    private static ArrayList filelist = new ArrayList(); 
  //获取今天的日期
	SimpleDateFormat sdf =new SimpleDateFormat("yyyyMMdd");
	String dateStr=sdf.format(new Date());
    public static void main(String[] args) {
//        long a = System.currentTimeMillis();
        new FileSystem().getFilePath("E:\\42#Record");
    }
    
    public void getFilePath(String filePath){
    	List temp =new ArrayList ();
		temp.add("filepate");
		List a=new RecordDaoImpl().getFilePath(temp, dateStr);
    	List list =new ArrayList();
    	list.add("C");
    	list.add("E");
    	list.add("G");
    	list.add("D");
    	for(int i=0;i<list.size();i++){
    		lastPath=filePath+fs+list.get(i)+fs+dateStr;
    		System.out.println(lastPath);
    		//先重新获取数据里面的值
    		getFolderName(lastPath,a);
    	}
    }
    
    public void getFolderName(String folderPath,List a){
    	 File dir = new File(folderPath); 
         File[] files = dir.listFiles(); 
         if (files == null) {
        	 return ;
         }
       
	         for (int i = 0; i < files.length;i++) { 
	             if (files[i].isDirectory()) { 
	            	 folderName=files[i].getAbsolutePath();
	            	 getFolderName(files[i].getAbsolutePath(),a); 
	                 //添加数据库的方法
	                 fileCount=0;
	             } else { 
	                 String strFileName = files[i].getAbsolutePath().toLowerCase();
	            	 fileCount++;
//	                 System.out.println(folderName);
//	                 System.out.println(strFileName+"----wen jian ming wei -----------------");
//	                 System.out.println(fileCount);
	            	 File ff = new File(strFileName);
	            	 long l = getFileSizes(ff);
 					//获取文件大小
//	            	 if(strFileName.indexOf("-o-")>-1&&l/1024>200){
//	            		 System.out.println(l/1024+"----------------wen jian de da xiao zhuang hua wei K");
//	            	 }
// 					
 					if(l/1024>200){
		                 if(a.size()==0){
		                	 addRecordPlan(strFileName,fileCount);
		                 }else{
	//	                	 System.out.println(a.size());
		                	 indexOfC=0;
		                	 for(int j =0;j<a.size();j++){
		                 		List filePath =(List)a.get(j);
	//	                 		System.out.println(strFileName.indexOf(filePath.get(0).toString()));
		                     		if(strFileName.indexOf(filePath.get(0).toString())==-1){
//		                     			System.out.println("------进来---------------");
		                     			indexOfC++;
		                     		}
		                 		}
			                	 if(indexOfC == a.size()){
			                		 System.out.println(strFileName);
			 	                	//调用方法
			           				addRecordPlan(strFileName,fileCount);
			 	                 }
		                 }
		                
 					}
	  	             filelist.add(files[i].getAbsolutePath());
	               } 
	           
		}
	        
	        
    }
    //添加record表
    public int addRecordPlan(String strFileName,int fileCount){
    	int count=0;
    	File ff = new File(strFileName);
        try {
        	List spList =refreshFileList(folderName);
//        	System.out.println(spList.size()+"---------------------spList.size()");
//            System.out.println(spList.get(1)+"----"+spList.get(2)+"-------------"+folderName.substring(folderName.lastIndexOf("\\")+1,folderName.lastIndexOf("\\")+4));
			long l = getFileSizes(ff);
			//获取文件大小
//			System.out.println(l/1024);
			//添加数据库的方法
			List recordList =new ArrayList();
//			varea,drecordate,vecordname,count,filepate
			recordList.add(spList.get(1));
			recordList.add(spList.get(2));
//			recordList.add(folderName.substring(folderName.lastIndexOf(fs)+1,folderName.lastIndexOf(fs)+4));
			recordList.add(folderName);
			recordList.add(1);
			recordList.add(strFileName);
			count =new RecordDaoImpl().addRecord(recordList);
			if(count>0){
				System.out.println("添加成功");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return count;
         
    }
    /***
     * 取得文件大小
     * @param f 文件路径
     * @return
     * @throws Exception
     */
    public long getFileSizes(File f){
        long s=0;
        try {
        if (f.exists()) {
            FileInputStream fis = null;
				fis = new FileInputStream(f);
			
           s= fis.available();
        } else {
            f.createNewFile();
            System.out.println("文件不存在");
        }
        } catch (Exception e) {
			e.printStackTrace();
		}
        return s;
    }
    /***
     * //转换文件大小
     * @param fileS
     * @return
     */
    public String FormetFileSize(long fileS) {
        DecimalFormat df = new DecimalFormat("#.00");
        String fileSizeString = "";
        if (fileS < 1024) {
            fileSizeString = df.format((double) fileS) + "B";
        } else if (fileS < 1048576) {
            fileSizeString = df.format((double) fileS / 1024) + "K";
        } else if (fileS < 1073741824) {
            fileSizeString = df.format((double) fileS / 1048576) + "M";
        } else {
            fileSizeString = df.format((double) fileS / 1073741824) + "G";
        }
        return fileSizeString;
    }
    
    /***
     *递归 获取每一个\\的值
     * @param str
     */
    public List   refreshFileList(String str) { 
    	String s2 = str;
		  int pos = 0;
		  //int cnt2 = 0;
		  int start=0;
		  String strSub="";
		 List strList =new ArrayList();
		  while (pos < s2.length()) {
		   pos = s2.indexOf(fs, pos);
		   if (pos == -1) {
		    break;
		   } else {
		   // cnt2++;
		   // System.out.println(pos);
			   strSub=str.substring(start,pos);
			   strList.add(strSub);
//			   System.out.println(strSub+"-----");
		    pos++;
		    start=pos;
		   }
		  }
		  return strList;
    }
}
