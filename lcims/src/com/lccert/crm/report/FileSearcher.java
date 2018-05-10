package com.lccert.crm.report;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

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
	 */
//    public static void findFiles(String baseDirName, String targetFileName, List<File> fileList) {
//        /**
//         * 算法简述：
//         * 从某个给定的需查找的文件夹出发，搜索该文件夹的所有子文件夹及文件，
//         * 若为文件，则进行匹配，匹配成功则加入结果集，若为子文件夹，则进队列。
//         * 队列不空，重复上述操作，队列为空，程序结束，返回结果。
//         */
//        String tempName = null;
//        String fs = System.getProperties().getProperty("file.separator");
//        //判断目录是否存在
//        //System.out.println("判断文件夹是否存在的:"+baseDirName);
//        File baseDir = new File(baseDirName);
//        if (!baseDir.exists() || !baseDir.isDirectory()){
//            System.out.println("文件查找失败：" + baseDirName + "不是一个目录！");
//        } else {
//        	
//        	String[] filelist = baseDir.list();
//        
//    	    for (int i = 0; i < filelist.length; i++) {
//   
//    	    	File readfile = new File(baseDirName + fs + filelist[i]);
//    	    	
//    	        int a =1;
//    	        if(!readfile.isDirectory()) {
//    	        	tempName =readfile.getName(); 
//                        if (FileSearcher.wildcardMatch(targetFileName,tempName)) {
//                        	
//                            //匹配成功，将文件名添加到结果集
//                            fileList.add(readfile.getAbsoluteFile()); 
//                            a++;
//                        }	
////                        System.out.println("我被调用了多少次了"+a);
//    	        }
//    	        else if(readfile.isDirectory()){
//    	        	findFiles(baseDirName + fs + filelist[i],targetFileName,fileList);
//    	        }
//    	    }
//        }
//
//    }
    public static void findFiles(String baseDirName, String targetFileName, List<File> fileList) {
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
    				if (FileSearcher.wildcardMatch(targetFileName, tempName)) {
    					//匹配成功，将文件名添加到结果集
    					fileList.add(readfile.getAbsoluteFile()); 
    				}
    			} else if(readfile.isDirectory()){
    				findFiles(baseDirName + fs + filelist[i],targetFileName,fileList);
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
    private static boolean wildcardMatch(String pattern, String str) {
    	boolean flag =false;
    	String p=pattern.substring(0, pattern.indexOf("*"));
    	String s=str.substring(0, str.indexOf("."));
    	int patternLength = pattern.length();
	    int strLength = str.length();
	    int strIndex = 0;
    	if(p.equals(s.substring(0, 12))){
    	     return flag =true;
    	}
		return flag;
    }

    public static void main(String[] paramert) {
    	
        //    在此目录中找文件
        String baseDIR = "f:/file"; 
        //    找扩展名为txt的文件
        String fileName = "LCZC10100023*.JPG"; 
        List<File> resultList = new ArrayList<File>();
        FileSearcher.findFiles(baseDIR, fileName, resultList); 
        if (resultList.size() == 0) {
            System.out.println("No File Fount.");
        } else {
            for (int i = 0; i < resultList.size(); i++) {
                System.out.println("显示查找结果:"+resultList.get(i));//显示查找结果。 
            }
        }
    }


}
