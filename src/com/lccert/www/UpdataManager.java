package com.lccert.www;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;



/**
 * ��վ���ݶ�ʱ���¹�����
 * ��ʱ������վ���ݵ�����
 * @author Eason
 *
 */
public class UpdataManager implements ServletContextListener {
	/**
	 * ÿ��ĺ�����
	 */
	private static final long PERIOD_DAY = 60*60*24*1000;
	
	/**
	 * ��ʱ��
	 */
	private static Timer timer;

	/**
	 * ��WebӦ������ʱ��ʼ������
	 */
	public void contextInitialized(ServletContextEvent event) {      
		//���嶨ʱ��       
		if(timer == null) {
		  timer = new Timer(true);
		}
		//timer.schedule(new Updata(),0, PERIOD_DAY);
		addTimerInMorning();
		addTimerAtNoon();
		addTimerAfterNoon();
	}
	/**
	 * ��WebӦ�ý���ʱֹͣ����
	 */
	public void contextDestroyed(ServletContextEvent event) {
		if(timer != null) {
			timer.cancel(); // ��ʱ������
		}
	}
	
	private void addTimerInMorning() {
		  Calendar calendar = Calendar.getInstance();   
	      int year = calendar.get(Calendar.YEAR);   
	      int month = calendar.get(Calendar.MONTH);   
	      int day = calendar.get(Calendar.DAY_OF_MONTH);
	      /*** ����ÿ��10��30��00ִ�з��� ***/  
	      calendar.set(year, month, day, 10, 30, 00);
	      Date date = calendar.getTime();
	      
	      Date now = new Date();
	        //��ȡ�趨��ʱ��͵�ǰ��ʱ����������
	      long interval = date.getTime() - now.getTime();
	        //�����ǰʱ���������ʱ�䣬������ʱ������Ϊ��һ������ʱ��
	      if (interval < 0) {
	    	 calendar.add(Calendar.DAY_OF_MONTH, 1);//��������1
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
	      /*** ����ÿ��15��00��00ִ�з��� ***/  
	      calendar.set(year, month, day, 15, 00, 00);
	      Date date = calendar.getTime();
	      
	      Date now = new Date();
	        //��ȡ�趨��ʱ��͵�ǰ��ʱ����������
	      long interval = date.getTime() - now.getTime();
	        //�����ǰʱ���������ʱ�䣬������ʱ������Ϊ��һ������ʱ��
	      if (interval < 0) {
	    	 calendar.add(Calendar.DAY_OF_MONTH, 1);//��������1
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
	      /*** ����ÿ��22��00��00ִ�з��� ***/  
	      calendar.set(year, month, day, 22, 00, 00);
	      Date date = calendar.getTime();
	      
	      Date now = new Date();
	        //��ȡ�趨��ʱ��͵�ǰ��ʱ����������
	      long interval = date.getTime() - now.getTime();
	        //�����ǰʱ���������ʱ�䣬������ʱ������Ϊ��һ������ʱ��
	      if (interval < 0) {
	    	 calendar.add(Calendar.DAY_OF_MONTH, 1);//��������1
	         date = calendar.getTime();
	         interval = date.getTime() - now.getTime();
	      }
		  
		  timer.schedule(new Updata(),interval,PERIOD_DAY); 
//	       timer.schedule(new DeleteFile(),interval,PERIOD_DAY); 
	}
	
	//��ʱɾ���ļ������������
	private static void addTimerAfterNoon(String path) {
		System.out.println("wo yao shanchu wen ");
		Calendar calendar = Calendar.getInstance();   
		int year = calendar.get(Calendar.YEAR);   
		int month = calendar.get(Calendar.MONTH);   
		int day = calendar.get(Calendar.DAY_OF_MONTH);
		/*** ����ÿ��22��00��00ִ�з��� ***/  
		calendar.set(year, month, day, 22, 00, 00);
		Date date = calendar.getTime();
		
		Date now = new Date();
		//��ȡ�趨��ʱ��͵�ǰ��ʱ����������
		long interval = date.getTime() - now.getTime();
		//�����ǰʱ���������ʱ�䣬������ʱ������Ϊ��һ������ʱ��
		if (interval < 0) {
			calendar.add(Calendar.DAY_OF_MONTH, 1);//��������1
			date = calendar.getTime();
			interval = date.getTime() - now.getTime();
		}
		

	}

}
