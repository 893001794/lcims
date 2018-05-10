package com.lccert.crm.chemistry.email;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class TaskLisent implements ServletContextListener{
	 Date date = new Date();//从当前开始计时
	 long timestamp = 30*60*1000;
//	 long timestamp = 1*60*1000;
	 private Timer timer =null;
	public void contextDestroyed(ServletContextEvent sce) {
		System.out.println("销毁timer！");
		if(timer != null) {
			timer.cancel(); // 定时器销毁
		}
	}
	public void contextInitialized(ServletContextEvent sce) {
		 //定义定时器       
		timer = new Timer(); 
		if(timer == null) {
		System.out.println("创建timer！");
		  timer = new Timer(true);
		}
		//执行任务
		SimpleDateFormat sdf = new SimpleDateFormat("HH");
		if(Integer.parseInt(sdf.format(new Date()))<20){ //每天的超八点钟不执行
		timer.schedule(new TimerTaskTest(),date,timestamp); 
		}
	}
}
