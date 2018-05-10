package com.lccert.crm.chemistry.email;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import com.lccert.crm.chemistry.util.IsValidityEmail;
public class RecordTask implements ServletContextListener{
	/**
	 * 每天的毫秒数
	 */
	private static final long PERIOD_DAY = 60*60*24*1000;
	/**
	 * 无延迟
	 */
	private static final long NO_DELAY = 0;
	/**
	 * 定时器
	 */
	private Timer timer;

	/**
	 * 在Web应用启动时初始化任务
	 */
	public void contextInitialized(ServletContextEvent event) {       
	        //定义定时器       
		if(timer == null) {
       System.out.println("创建timer！");
		  timer = new Timer(true);
		}
		addTimerInNoon(12,00);
		addTimerInNoon(17,30);
	}
	/**
	 * 在Web应用结束时停止任务
	 */
	public void contextDestroyed(ServletContextEvent event) {
		System.out.println("销毁timer！");
		if(timer != null) {
			timer.cancel(); // 定时器销毁
		}
	}
	
	/**
	 * 添加下午计划任务
	 */
	private void addTimerInNoon(int hour,int minute) {
        Calendar calendar = Calendar.getInstance();   
	      int year = calendar.get(Calendar.YEAR);   
	      int month = calendar.get(Calendar.MONTH);   
	      int day = calendar.get(Calendar.DAY_OF_MONTH);
	      /*** 定制每日00：00：00执行方法 ***/  
//	      calendar.set(year, month, day, 17,30, 00);
	      calendar.set(year, month, day, hour, minute, 00);
	      Date date = calendar.getTime();
	      Date now = new Date();
	        //获取设定的时间和当前的时间差（毫秒数）
	      long interval = date.getTime() - now.getTime();
	        //如果当前时间大于下载时间，则将下载时间设置为下一个下载时间
	      if (interval < 0) {
	    	 calendar.add(Calendar.DAY_OF_MONTH, 1);//将天数加1
	         date = calendar.getTime();
	         interval = date.getTime() - now.getTime();
	      }
	    	  timer.schedule(new RecordEmail(),interval,PERIOD_DAY);
	}
	
	
}
