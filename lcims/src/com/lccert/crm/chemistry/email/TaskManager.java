package com.lccert.crm.chemistry.email;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.lccert.crm.chemistry.util.IsValidityEmail;


/**
 * 一周前迟单项目发送任务管理器
 * 这是一个定时器，每周在特定时间发送当周迟单项目给特定的人员
 * @author tangzp
 *
 */
public class TaskManager implements ServletContextListener {
	/**
	 * 每天的毫秒数
	 */
	private static final long PERIOD_DAY = 60*60*24*1000;
	/**
	 * 一周内的毫秒数
	 */
	private static final long PERIOD_WEEK = PERIOD_DAY * 7;
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
		
		//先判断今天是否是星期六
		SimpleDateFormat tempDate = new SimpleDateFormat("yyyy-MM-dd"); 
		String datetime = tempDate.format(new java.util.Date()); 
		String year=datetime.substring(0,datetime.indexOf("-"));
		String month=datetime.substring(datetime.indexOf("-")+1, datetime.lastIndexOf("-"));
		if(month.substring(0, 1).equals("0")){
			month=month.substring(1, 2);
		}
		String date =datetime.substring(datetime.lastIndexOf("-")+1,datetime.length());
		if(date.substring(0, 1).equals("0")){
			date=date.substring(1, 2);
		}
		int a =Integer.parseInt(year);
		int b =Integer.parseInt(month);
		int c =Integer.parseInt(date);
		
		if(getXQ(a,b,c).equals("星期六")){

			addTimerInNoon(2);
		}
		
		if(!getXQ(a,b,c).equals("星期日")){
			addTimerInNoon(1);
		}
		//addTimerInMorning();
		//addTimerInNoon(1);
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
	private void addTimerInNoon(int start) {
        Calendar calendar = Calendar.getInstance();   
	      int year = calendar.get(Calendar.YEAR);   
	      int month = calendar.get(Calendar.MONTH);   
	      int day = calendar.get(Calendar.DAY_OF_MONTH);
	      /*** 定制每日00：00：00执行方法 ***/  
	      calendar.set(year, month, day, 21,30, 00);
//	      calendar.set(year, month, day, 14, 58, 00);
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
		  
	      if(start ==1){
	    	  timer.schedule(new StatisticsTask(),interval,PERIOD_DAY);
//	    	  timer.schedule(new StatisticsTask1(),interval,PERIOD_DAY);
	    	  //发送迟单信息
//	    	  //验证邮箱是否有效
//	    	  timer.schedule(new IsValidityEmail(), interval,PERIOD_DAY);
////	    	  //发送报告已发出超15天，但是客户的欠款还没有付清
	    	 // timer.schedule(new IssueRPNoPayTask(), interval,PERIOD_DAY);
	    	 // timer.schedule(new StatisticsTask(), interval,PERIOD_DAY);
//	    	  //将sql servlert 2008的数据库的某个表的值插入到mysql中的attend中去
	    	//  timer.schedule(new OaAttendTask(), interval,PERIOD_DAY);
	      }
	      if(start==2){
//	    	  timer.schedule(new SeverityBackUpTableTask(),interval,PERIOD_DAY); 
	    	
	      }
	}
	
	
	
	//当天是星期几
	public static String getXQ(int year, int month, int day) {
		Calendar c = Calendar.getInstance();
		int i = c.get(Calendar.DAY_OF_WEEK);
		String s = "星期";
		switch (i) {
		case 1:
		s = s + "日";
		break;
		case 2:
		s = s + "一";
		break;
		case 3:
		s = s + "二";
		break;
		case 4:
		s = s + "三";
		break;
		case 5:
		s = s + "四";
		break;
		case 6:
		s = s + "五";
		break;
		case 7:
		s = s + "六";
		break;
		default:
		break;
		}
		return s;
		}

}
