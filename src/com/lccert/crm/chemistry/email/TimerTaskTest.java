package com.lccert.crm.chemistry.email;


import java.util.Date;
import java.util.Timer;    
import java.util.TimerTask;  

import com.lccert.crm.chemistry.util.FileSystem;

public class TimerTaskTest extends TimerTask {
	@Override
	public void run() {
		String fs = System.getProperties().getProperty("file.separator");
//		 String recordPath = fs+"oa"+fs+"42#Record"; 
		 String recordPath = "Y:\\"; 
		//����������ݿ�ķ���
//		 new FileSystem().getFilePath(recordPath+"42#Record");
		 new FileSystem().getFilePath(recordPath);
//		System.out.println("���Ƕ�ʱ������Ҫ�����ˣ�����");
	}
	
	public static void main(String[] args) {
		new TimerTaskTest().run();
	}
}
