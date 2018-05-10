package com.lccert.crm.downreport;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * �ļ�����������
 * @author Eason 
 * 
 */
public class FileSearcher {

	/**
	 * �ݹ�����ļ�
	 * @param baseDirName  ���ҵ��ļ���·��
	 * @param targetFileName  ��Ҫ���ҵ��ļ���
	 * @param fileList  ���ҵ����ļ�����
	 *  @param filetype  �����ļ�������(.doc��.pdf)
	 */
    public static void findFiles(String baseDirName, String targetFileName, List<File> fileList,String filetype,int a) {
//    	System.out.println(baseDirName+":baseDirName");
//    	System.out.println(targetFileName+":targetFileName");
//    	System.out.println(filetype+":filetype");
//    	System.out.println(a+":a");
    	/**
    	 * �㷨������
    	 * ��ĳ������������ҵ��ļ��г������������ļ��е��������ļ��м��ļ���
    	 * ��Ϊ�ļ��������ƥ�䣬ƥ��ɹ��������������Ϊ���ļ��У�������С�
    	 * ���в��գ��ظ���������������Ϊ�գ�������������ؽ����
    	 */
    	String tempName = null;
    	String fs = System.getProperties().getProperty("file.separator");
    	//�ж�Ŀ¼�Ƿ����
    	File baseDir = new File(baseDirName);
    	if (!baseDir.exists() || !baseDir.isDirectory()){
    		System.out.println("�ļ�����ʧ�ܣ�" + baseDirName + "����һ��Ŀ¼��");
    	} else {
    		String[] filelist = baseDir.list();
    	
    		for (int i = 0; i < filelist.length; i++) {
    			File readfile = new File(baseDirName + fs + filelist[i]);
    			if(!readfile.isDirectory()) {
    				tempName =  readfile.getName();
    				System.out.println("tempName:"+tempName.substring(tempName.lastIndexOf(".")+1,tempName.length())+"*********"+filetype);
    				if(tempName.substring(tempName.lastIndexOf(".")+1,tempName.length()).equals(filetype)){//�������ƥ��͵���wildcardMatch����
    					System.out.println("************----------");
    				if (FileSearcher.wildcardMatch(targetFileName, tempName,a)) {
    					//ƥ��ɹ������ļ�����ӵ������
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
     * ͨ���ƥ��
     * @param pattern    ͨ���ģʽ
     * @param str    ��ƥ����ַ���
     * @return    ƥ��ɹ��򷵻�true�����򷵻�false
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
//        //    �ڴ�Ŀ¼�����ļ�
//        //String baseDIR = fs+fs+"file"+fs+"22 ��ѧ����"+fs+"����ɵı���浵"+fs+"LCZC"+fs+"1011"+fs; 
//    	 String baseDIR = "D:\\temp"; 
//        //    ����չ��Ϊtxt���ļ�
//        String fileName = "LCZa10110271-E*.doc"; 
//        List<File> resultList = new ArrayList<File>();
//        FileSearcher.findFiles(baseDIR, fileName, resultList,"doc"); 
//        if (resultList.size() == 0) {
//            System.out.println("No File Fount.");
//        } else {
//            for (int i = 0; i < resultList.size(); i++) {
//                System.out.println("��ʾ���ҽ��:"+resultList.get(i));//��ʾ���ҽ���� 
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
	              System.out.println("��ʾ���ҽ��:"+resultList.get(i));//��ʾ���ҽ���� 
	          }
	      }
    	
//    	
//
    }


   
    
    
    
}
