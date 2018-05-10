package com.lccert.crm.chemistry.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
/**
 * ����ĸȫ��ת��Ϊ��д
 * @author Administrator
 *
 */
public class ByteArrayList {
	public static void main(String[] args) {   
        String stp = "A1";   
      System.out.println(new ByteArrayList().getTranForm(stp));
           
    }   
	
	public String getTranForm(String stp){
		 byte buf [] = stp.getBytes();   
	        ByteArrayInputStream input = new ByteArrayInputStream(buf);   
	        ByteArrayOutputStream output = new ByteArrayOutputStream();   
	        transForm(input,output);   
	        byte resault [] = output.toByteArray();   
//	        System.out.println(new String(resault));   
	        return new String(resault);
	}
    public static void transForm(InputStream in,OutputStream out){   
        int info = 0;   
        try {   
            while((info = in.read()) != -1){   
                //��ȡ��Ϣ   
                int uppInfo = Character.toUpperCase((char)info);   
                //�� �������ֽ���Ϣ ת���ɴ�д   
                out.write(uppInfo);   
            }   
        } catch (IOException e) {   
            e.printStackTrace();   
        }   
           
    }   

}
