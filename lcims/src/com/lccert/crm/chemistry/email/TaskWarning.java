package com.lccert.crm.chemistry.email;

import java.util.Timer;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
/**
 *��ǰ��Сʱδ��ɵı���Ԥ��
 * ����һ����ʱ����ÿ�����ض�ʱ�䷢�͵��ܳٵ���Ŀ���ض�����Ա
 * @author tangzp
 *
 */
public class TaskWarning implements ServletContextListener {
	/**
	 * ����ӵĺ�����
	 */
	private static final long PERIOD_DAY = 5*60*1000;
	
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
			addTimerInNoon();
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
	 * new SendWarning()��Ҫִ�е�����
	 * 1000 :1�����ʼִ������
	 * PERIOD_DAY ����������ִ��
	 */
	private void addTimerInNoon() {
		//Time ��schedule�����������ж������ظ�ʽ�ģ�����Ӧ��ͬ�����
		//������ָ����ʱ��ִ��ָ��������
	   timer.schedule(new SendWarning(),1000,PERIOD_DAY); 
	}

}
