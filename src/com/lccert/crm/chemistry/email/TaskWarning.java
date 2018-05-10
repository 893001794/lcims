package com.lccert.crm.chemistry.email;

import java.util.Timer;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
/**
 *提前两小时未完成的报告预警
 * 这是一个定时器，每周在特定时间发送当周迟单项目给特定的人员
 * @author tangzp
 *
 */
public class TaskWarning implements ServletContextListener {
	/**
	 * 五分钟的毫秒数
	 */
	private static final long PERIOD_DAY = 5*60*1000;
	
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
			addTimerInNoon();
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
	 * new SendWarning()：要执行的任务
	 * 1000 :1毫秒后开始执行任务
	 * PERIOD_DAY ：相隔多久在执行
	 */
	private void addTimerInNoon() {
		//Time 中schedule（）方法是有多种重载格式的，以适应不同情况。
		//安排在指定的时间执行指定的任务
	   timer.schedule(new SendWarning(),1000,PERIOD_DAY); 
	}

}
