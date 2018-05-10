package com.lccert.www;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;



/**
 * 网站数据定时更新管理器
 * 定时更新网站数据的内容
 * @author Eason
 *
 */
public class UpdataManager implements ServletContextListener {
	/**
	 * 每天的毫秒数
	 */
	private static final long PERIOD_DAY = 60*60*24*1000;
	
	/**
	 * 定时器
	 */
	private static Timer timer;

	/**
	 * 在Web应用启动时初始化任务
	 */
	public void contextInitialized(ServletContextEvent event) {      
		//定义定时器       
		if(timer == null) {
		  timer = new Timer(true);
		}
		//timer.schedule(new Updata(),0, PERIOD_DAY);
		addTimerInMorning();
		addTimerAtNoon();
		addTimerAfterNoon();
	}
	/**
	 * 在Web应用结束时停止任务
	 */
	public void contextDestroyed(ServletContextEvent event) {
		if(timer != null) {
			timer.cancel(); // 定时器销毁
		}
	}
	
	private void addTimerInMorning() {
		  Calendar calendar = Calendar.getInstance();   
	      int year = calendar.get(Calendar.YEAR);   
	      int month = calendar.get(Calendar.MONTH);   
	      int day = calendar.get(Calendar.DAY_OF_MONTH);
	      /*** 定制每日10：30：00执行方法 ***/  
	      calendar.set(year, month, day, 10, 30, 00);
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
		  
		  timer.schedule(new Updata(),interval,PERIOD_DAY); 
	}
	
	private void addTimerAtNoon() {
		Calendar calendar = Calendar.getInstance();   
	      int year = calendar.get(Calendar.YEAR);   
	      int month = calendar.get(Calendar.MONTH);   
	      int day = calendar.get(Calendar.DAY_OF_MONTH);
	      /*** 定制每日15：00：00执行方法 ***/  
	      calendar.set(year, month, day, 15, 00, 00);
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
		  
		  timer.schedule(new Updata(),interval,PERIOD_DAY); 
	}
	
	
	private static void addTimerAfterNoon() {
		Calendar calendar = Calendar.getInstance();   
	      int year = calendar.get(Calendar.YEAR);   
	      int month = calendar.get(Calendar.MONTH);   
	      int day = calendar.get(Calendar.DAY_OF_MONTH);
	      /*** 定制每日22：00：00执行方法 ***/  
	      calendar.set(year, month, day, 22, 00, 00);
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
		  
		  timer.schedule(new Updata(),interval,PERIOD_DAY); 
//	       timer.schedule(new DeleteFile(),interval,PERIOD_DAY); 
	}
	
	//定时删除文件夹里面的内容
	private static void addTimerAfterNoon(String path) {
		System.out.println("wo yao shanchu wen ");
		Calendar calendar = Calendar.getInstance();   
		int year = calendar.get(Calendar.YEAR);   
		int month = calendar.get(Calendar.MONTH);   
		int day = calendar.get(Calendar.DAY_OF_MONTH);
		/*** 定制每日22：00：00执行方法 ***/  
		calendar.set(year, month, day, 22, 00, 00);
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
		

	}

}
