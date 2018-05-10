package com.lccert.crm.chemistry.email;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.lccert.crm.chemistry.util.IsValidityEmail;


/**
 * һ��ǰ�ٵ���Ŀ�������������
 * ����һ����ʱ����ÿ�����ض�ʱ�䷢�͵��ܳٵ���Ŀ���ض�����Ա
 * @author tangzp
 *
 */
public class SBLTaskManager implements ServletContextListener {
	/**
	 * ÿ��ĺ�����
	 */
	private static final long PERIOD_DAY = 60*60*24*1000;
	/**
	 * һ���ڵĺ�����
	 */
	private static final long PERIOD_WEEK = PERIOD_DAY * 7;
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
		
		//���жϽ����Ƿ���������
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
		
		if(getXQ(a,b,c).equals("������")){

			addTimerInNoon(2);
		}
		
		if(!getXQ(a,b,c).equals("������")){

			addTimerInNoon(1);
		}
		//addTimerInMorning();
		//addTimerInNoon(1);
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
//	private void addTimerInMorning() {
//		  Calendar calendar = Calendar.getInstance();   
//	      int year = calendar.get(Calendar.YEAR);   
//	      int month = calendar.get(Calendar.MONTH);   
//	      int day = calendar.get(Calendar.DAY_OF_MONTH);
//	      /*** ����ÿ��00��00��00ִ�з��� ***/  
//	      calendar.set(year, month, day, 11, 26, 00);
//	      Date date = calendar.getTime();
//	      
//	      Date now = new Date();
//	        //��ȡ�趨��ʱ��͵�ǰ��ʱ����������
//	      long interval = date.getTime() - now.getTime();
//	        //�����ǰʱ���������ʱ�䣬������ʱ������Ϊ��һ������ʱ��
//	      if (interval < 0) {
//	    	 calendar.add(Calendar.DAY_OF_MONTH, 1);//��������1
//	         date = calendar.getTime();
//	         interval = date.getTime() - now.getTime();
//	      }
//		  
//		  timer.schedule(new LateProjectTask(),interval,PERIOD_DAY); 
//	}
	/**
	 * ���ÿһ�ܵ�����
	 */
//	private void addWeekTime() {
//		 //System.out.println("-----------------------------------------------------�쿴���Ұѣ�����ÿ��������ͻᱻ���õ�");
//		Calendar calendar = Calendar.getInstance();   
//		calendar.set(Calendar.HOUR_OF_DAY,   18); 
//		calendar.set(Calendar.MINUTE,   00); 
//		calendar.set(Calendar.SECOND,   0); 
//		calendar.set(2010,   8,   25);//   ���ǽ���,�Ժ����ÿ����18��00����,���ʼ���������Լ�д��. 
//		timer.schedule(new BackUpTableTask(),calendar.getTime(), PERIOD_WEEK);
//	}
	
	/**
	 * �������ƻ�����
	 */
	private void addTimerInNoon(int start) {
        	Calendar calendar = Calendar.getInstance();   
	      int year = calendar.get(Calendar.YEAR);   
	      int month = calendar.get(Calendar.MONTH);   
	      int day = calendar.get(Calendar.DAY_OF_MONTH);
	      /*** ����ÿ��00��00��00ִ�з��� ***/  
	      calendar.set(year, month, day, 23, 50, 00);
//	      calendar.set(year, month, day, 9, 2, 00);
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
		  
	      if(start ==1){
	    	  //���ͳٵ���Ϣ
	    	  timer.schedule(new SeverityLateProjectTask(),interval,PERIOD_DAY); 
//	    	  //��֤�����Ƿ���Ч
//	    	  timer.schedule(new IsValidityEmail(), interval,PERIOD_DAY);
////	    	  //���ͱ����ѷ�����15�죬���ǿͻ���Ƿ�û�и���
//	    	  timer.schedule(new IssueRPNoPayTask(), interval,PERIOD_DAY);
//	    	  timer.schedule(new StatisticsTask(), interval,PERIOD_DAY);
//	    	  //��sql servlert 2008�����ݿ��ĳ�����ֵ���뵽mysql�е�attend��ȥ
//	    	  timer.schedule(new OaAttendTask(), interval,PERIOD_DAY);
//	    	  timer.schedule(new PublicEmail(), interval,PERIOD_DAY);
	      }
	      if(start==2){
	    	  //һ�ܳ�2Сʱ�����سٵ�
//	    	  timer.schedule(new SeverityBackUpTableTask(),interval,PERIOD_DAY); 
//	    	  timer.schedule(new StatisticsTask(), interval,PERIOD_DAY);
	      }
	}
	
	
	
	//���������ڼ�
	public static String getXQ(int year, int month, int day) {
		Calendar c = Calendar.getInstance();
		int i = c.get(Calendar.DAY_OF_WEEK);
		String s = "����";
		switch (i) {
		case 1:
		s = s + "��";
		break;
		case 2:
		s = s + "һ";
		break;
		case 3:
		s = s + "��";
		break;
		case 4:
		s = s + "��";
		break;
		case 5:
		s = s + "��";
		break;
		case 6:
		s = s + "��";
		break;
		case 7:
		s = s + "��";
		break;
		default:
		break;
		}
		return s;
		}

}
