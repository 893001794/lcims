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
	 * ÿ��ĺ�����
	 */
	private static final long PERIOD_DAY = 60*60*24*1000;
	/**
	 * ���ӳ�
	 */
	private static final long NO_DELAY = 0;
	/**
	 * ��ʱ��
	 */
	private Timer timer;

	/**
	 * ��WebӦ������ʱ��ʼ������
	 */
	public void contextInitialized(ServletContextEvent event) {       
	        //���嶨ʱ��       
		if(timer == null) {
       System.out.println("����timer��");
		  timer = new Timer(true);
		}
		addTimerInNoon(12,00);
		addTimerInNoon(17,30);
	}
	/**
	 * ��WebӦ�ý���ʱֹͣ����
	 */
	public void contextDestroyed(ServletContextEvent event) {
		System.out.println("����timer��");
		if(timer != null) {
			timer.cancel(); // ��ʱ������
		}
	}
	
	/**
	 * �������ƻ�����
	 */
	private void addTimerInNoon(int hour,int minute) {
        Calendar calendar = Calendar.getInstance();   
	      int year = calendar.get(Calendar.YEAR);   
	      int month = calendar.get(Calendar.MONTH);   
	      int day = calendar.get(Calendar.DAY_OF_MONTH);
	      /*** ����ÿ��00��00��00ִ�з��� ***/  
//	      calendar.set(year, month, day, 17,30, 00);
	      calendar.set(year, month, day, hour, minute, 00);
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
	    	  timer.schedule(new RecordEmail(),interval,PERIOD_DAY);
	}
	
	
}
