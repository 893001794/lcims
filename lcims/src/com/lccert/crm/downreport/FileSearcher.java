package com.lccert.crm.downreport;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * 文件搜索工具类
 * @author Eason 
 * 
 */
public class FileSearcher {

	/**
	 * 递归查找文件
	 * @param baseDirName  查找的文件夹路径
	 * @param targetFileName  需要查找的文件名
	 * @param fileList  查找到的文件集合
	 *  @param filetype  查找文件的类型(.doc或.pdf)
	 */
    public static void findFiles(String baseDirName, String targetFileName, List<File> fileList,String filetype,int a) {
//    	System.out.println(baseDirName+":baseDirName");
//    	System.out.println(targetFileName+":targetFileName");
//    	System.out.println(filetype+":filetype");
//    	System.out.println(a+":a");
    	/**
    	 * 算法简述：
    	 * 从某个给定的需查找的文件夹出发，搜索该文件夹的所有子文件夹及文件，
    	 * 若为文件，则进行匹配，匹配成功则加入结果集，若为子文件夹，则进队列。
    	 * 队列不空，重复上述操作，队列为空，程序结束，返回结果。
    	 */
    	String tempName = null;
    	String fs = System.getProperties().getProperty("file.separator");
    	//判断目录是否存在
    	File baseDir = new File(baseDirName);
    	if (!baseDir.exists() || !baseDir.isDirectory()){
    		System.out.println("文件查找失败：" + baseDirName + "不是一个目录！");
    	} else {
    		String[] filelist = baseDir.list();
    	
    		for (int i = 0; i < filelist.length; i++) {
    			File readfile = new File(baseDirName + fs + filelist[i]);
    			if(!readfile.isDirectory()) {
    				tempName =  readfile.getName();
    				System.out.println("tempName:"+tempName.substring(tempName.lastIndexOf(".")+1,tempName.length())+"*********"+filetype);
    				if(tempName.substring(tempName.lastIndexOf(".")+1,tempName.length()).equals(filetype)){//如果类型匹配就调用wildcardMatch方法
    					System.out.println("************----------");
    				if (FileSearcher.wildcardMatch(targetFileName, tempName,a)) {
    					//匹配成功，将文件名添加到结果集
    					fileList.add(readfile.getAbsoluteFile()); 
    				}
    				}
    			} else if(readfile.isDirectory()){
    				findFiles(baseDirName + fs + filelist[i],targetFileName,fileList,filetype,a);
    			}
    		}
    	}
    }
    
    /**
     * 通配符匹配
     * @param pattern    通配符模式
     * @param str    待匹配的字符串
     * @return    匹配成功则返回true，否则返回false
     */
    private static boolean wildcardMatch(String pattern, String str,int a) {
    	boolean flag =false;
//    	System.out.println(str+":str");
//    	System.out.println(pattern.substring(0, pattern.indexOf("E"))+"*******");
    	String p=pattern.substring(0, pattern.indexOf("*"));
    	String s=str.substring(0, str.indexOf("."));
    	int patternLength = pattern.length();
	    int strLength = str.length();
	    int strIndex = 0;
	    System.out.println(p+"******p---"+s+"-----==="+a);
	    if(s.lastIndexOf("-")>-1){
	    	if(p.equals(s.substring(0,s.lastIndexOf("-")+a))){
	    	     return flag =true;
	    	}
	    }else{
	    	if(p.equals(s)){
	    	     return flag =true;
	    	}
	    }
    	
		return flag;
    }
    public static void main(String[] paramert) {
    	String fs = System.getProperties().getProperty("file.separator");
//        //    在此目录中找文件
//        //String baseDIR = fs+fs+"file"+fs+"22 化学报告"+fs+"已完成的报告存档"+fs+"LCZC"+fs+"1011"+fs; 
//    	 String baseDIR = "D:\\temp"; 
//        //    找扩展名为txt的文件
//        String fileName = "LCZa10110271-E*.doc"; 
//        List<File> resultList = new ArrayList<File>();
//        FileSearcher.findFiles(baseDIR, fileName, resultList,"doc"); 
//        if (resultList.size() == 0) {
//            System.out.println("No File Fount.");
//        } else {
//            for (int i = 0; i < resultList.size(); i++) {
//                System.out.println("显示查找结果:"+resultList.get(i));//显示查找结果。 
//            }
//        }
//    	/oa/opt/bak/verify/LCZC11050266-C(CNAS).doc
//    	String filePath="D:"+fs+"Temp"+fs+"lczc11050266-c(cnas).doc";
//    	 String filePath = "D:"+fs+"oa"+fs+"opt"+fs+"chemrep"+fs+"LCZC"+fs+"1506"+fs+"LCZC15061010-E.pdf"; 
    	 String filePath = "D:"+fs+"oa"+fs+"opt"+fs+"chemrep"+fs+"GDGF"+fs+"2016"+fs+"GDGF044201600048.pdf";
    	 String baseDIR=filePath.substring(0,filePath.lastIndexOf(fs));
    	 String fileName="";
    	 if(filePath.lastIndexOf("-")>-1){
    		 fileName=filePath.substring(filePath.lastIndexOf(fs)+1,filePath.lastIndexOf("-"))+"*"+filePath.substring(filePath.lastIndexOf("."),filePath.length());
    	 }else{
    		 fileName=filePath.substring(filePath.lastIndexOf(fs)+1,filePath.lastIndexOf("."))+"*"+filePath.substring(filePath.lastIndexOf("."),filePath.length());
    	 }
         System.out.println(baseDIR+":baseDIR");
         System.out.println(fileName+":fileName");
         String filetyp=filePath.substring(filePath.lastIndexOf(".")+1,filePath.length());
         System.out.println(filetyp+":filetyp");
         List<File> resultList = new ArrayList<File>();
	      FileSearcher.findFiles(baseDIR, fileName, resultList,filetyp,0); 
	      if (resultList.size() == 0) {
	          System.out.println("No File Fount.");
	      } else {
	          for (int i = 0; i < resultList.size(); i++) {
	              System.out.println("显示查找结果:"+resultList.get(i));//显示查找结果。 
	          }
	      }
    	
//    	
//
    }


   
    
    
    
}
