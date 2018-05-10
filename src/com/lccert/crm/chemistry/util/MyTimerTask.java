package com.lccert.crm.chemistry.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimerTask;
/***
 * 测试邮件定时发送
 * @author tangzp
 *
 */
public class MyTimerTask extends TimerTask {
	String now; 
	 public void run() {
	  
	  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	  now=sdf.format(new Date());
	  System.out.println(now);
	  
	 }
	 
	 public String getNow(){
	  return this.now;
	 }

}
