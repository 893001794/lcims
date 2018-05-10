package com.lccert.crm.report;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

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
	 */
//    public static void findFiles(String baseDirName, String targetFileName, List<File> fileList) {
//        /**
//         * �㷨������
//         * ��ĳ������������ҵ��ļ��г������������ļ��е��������ļ��м��ļ���
//         * ��Ϊ�ļ��������ƥ�䣬ƥ��ɹ��������������Ϊ���ļ��У�������С�
//         * ���в��գ��ظ���������������Ϊ�գ�������������ؽ����
//         */
//        String tempName = null;
//        String fs = System.getProperties().getProperty("file.separator");
//        //�ж�Ŀ¼�Ƿ����
//        //System.out.println("�ж��ļ����Ƿ���ڵ�:"+baseDirName);
//        File baseDir = new File(baseDirName);
//        if (!baseDir.exists() || !baseDir.isDirectory()){
//            System.out.println("�ļ�����ʧ�ܣ�" + baseDirName + "����һ��Ŀ¼��");
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
//                            //ƥ��ɹ������ļ�����ӵ������
//                            fileList.add(readfile.getAbsoluteFile()); 
//                            a++;
//                        }	
////                        System.out.println("�ұ������˶��ٴ���"+a);
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
    				if (FileSearcher.wildcardMatch(targetFileName, tempName)) {
    					//ƥ��ɹ������ļ�����ӵ������
    					fileList.add(readfile.getAbsoluteFile()); 
    				}
    			} else if(readfile.isDirectory()){
    				findFiles(baseDirName + fs + filelist[i],targetFileName,fileList);
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
    	
        //    �ڴ�Ŀ¼�����ļ�
        String baseDIR = "f:/file"; 
        //    ����չ��Ϊtxt���ļ�
        String fileName = "LCZC10100023*.JPG"; 
        List<File> resultList = new ArrayList<File>();
        FileSearcher.findFiles(baseDIR, fileName, resultList); 
        if (resultList.size() == 0) {
            System.out.println("No File Fount.");
        } else {
            for (int i = 0; i < resultList.size(); i++) {
                System.out.println("��ʾ���ҽ��:"+resultList.get(i));//��ʾ���ҽ���� 
            }
        }
    }


}
