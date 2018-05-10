package com.lccert.crm.chemistry.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
/**
 * 将字母全部转换为大写
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
                //读取信息   
                int uppInfo = Character.toUpperCase((char)info);   
                //将 读出的字节信息 转化成大写   
                out.write(uppInfo);   
            }   
        } catch (IOException e) {   
            e.printStackTrace();   
        }   
           
    }   

}
