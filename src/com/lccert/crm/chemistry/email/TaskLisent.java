package com.lccert.crm.chemistry.email;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class TaskLisent implements ServletContextListener{
	 Date date = new Date();//�ӵ�ǰ��ʼ��ʱ
	 long timestamp = 30*60*1000;
//	 long timestamp = 1*60*1000;
	 private Timer timer =null;
	public void contextDestroyed(ServletContextEvent sce) {
		System.out.println("����timer��");
		if(timer != null) {
			timer.cancel(); // ��ʱ������
		}
	}
	public void contextInitialized(ServletContextEvent sce) {
		 //���嶨ʱ��       
		timer = new Timer(); 
		if(timer == null) {
		System.out.println("����timer��");
		  timer = new Timer(true);
		}
		//ִ������
		SimpleDateFormat sdf = new SimpleDateFormat("HH");
		if(Integer.parseInt(sdf.format(new Date()))<20){ //ÿ��ĳ��˵��Ӳ�ִ��
		timer.schedule(new TimerTaskTest(),date,timestamp); 
		}
	}
}
