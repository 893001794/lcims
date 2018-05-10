package com.lccert.crm.TimerTask;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.ConcurrentHashMap;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import com.lccert.crm.chemistry.email.PublicEmail;
import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.ChemProjectAction;
import com.lccert.crm.project.Project;
import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.quotation.QuotationAction;

/**
 * ʱ���ʱ��
 * �����ڼ�ʱ������̫������(3000������Ӧ��û����)
 * 
 * ͨ���趨ʱ�������ֵ��Ӱ��ʱ������ļ��Ƶ�ʡ�������1����һ�Σ�����10����һ��
 * 
 * �����ڱȽ������Ƿ񵽴�ִ��ʱ���ʱ��
 * Ҳ����������ֵ��
 * 
 * ��������ִ��ʱ����13��15��
 * ��ǰʱ����13��5��
 * �������ֵ��10�롣��������13��5���ʱ��ͻ�ִ��
 * @author tangzp
 *
 */
public class MyTimerTask extends TimerTask{
	static Date date = new Date();//�ӵ�ǰ��ʼ��ʱ
	/**
	 * �洢����id������Ϊ���ݵ�id�����Լ�����ʱ�䣨ת��Ϊlong��
	 */
	private static Map<String,Long> timeTasks = new ConcurrentHashMap<String, Long>();
	
	/**
	 * ������ǰʱ�䣬���Сʱ��
	 * ����Ϊ��λ��
	 * ���硣��������ʱ�仹��beforetimeʱ���ʱ������ִ��
	 * private static final long beforetime = 1800;
	 */
	
	/**
	 * ������ǰʱ�䣬2��Сʱ��
	 * ����Ϊ��λ��
	 * ���硣��������ʱ�仹��beforetimeʱ���ʱ������ִ��
	 * 
	 */
	private static final long beforetime = 7200;
	
	/**
	 * ����ֵ������Ϊ��λ��
	 * 
	 * Ŀ�ģ�Ϊ�˼��ٱ����Ĵ���������������ʱ���Ҫ�󾫶Ȳ����ر�ߣ����ԼӴ�����ֵ
	 * 
	 * ��СΪ1
	 */
	private static final long update = 7200;
	
	
	public MyTimerTask(){}
	
	private static MyTimerTask myTimerTask = null;
	
	public static MyTimerTask getInstance(){
		if(myTimerTask==null) {
			myTimerTask = new MyTimerTask();
		}
		return myTimerTask;
	}
	
	
//	public static void main(String[] args) {
//		startTimerTask();
//		
//	}
	
	public static void startTimerTask(){
		
		/**
		 * ������ʱ��������Ƿ������ո�������ͨ�������������������˹��ܣ��������ݿ���Ҵ��ڵ�ǰʱ���ʱ����ص�������
		 * 
		 * String sql = "��ѯ�����ش��ڵ�ǰʱ���ʱ�������������ö�ʱ����";
		 * �������
		 * while(rs.next){
		 * Date date = rs.getDate(ʱ���ֶ�);
		 * String s = rs.getString(����id�ֶ�);
		 * ��ʱ��ת���ɺ�������timeTasks����
		 * timeTasks.put(s,getTimeMillis(date.toString()));
		 * }
		 * 
		 * �����ֶ���������ʱ��
		 */
		
		//ʱ��ĺ�������ֱ�ӵ���getTimeMillis������һ��ʱ���Stringת���ɺ�����
		//getTimeMillis(new Date().toString);
		//����ֱ�ӻ�ú�����.�Ͳ�ͨ��ʱ��ת����
		long time = System.currentTimeMillis();
		Project p;
		List<Project> list = ChemProjectAction.getInstance().lateListDTime(date.toLocaleString());
		System.out.println(list.size()+"-------------");
		for(int i=0;i<list.size();i++) {
			//System.out.println(list.get(i));
			p = list.get(i);
			ChemProject cp = (ChemProject)p.getObj();
			String rptime =cp.getRptime().toLocaleString();
			//getTimeMillis(rptime);	
			timeTasks.put(p.getPid(),getTimeMillis(rptime));
			//System.out.println(cp.getRptime().toLocaleString()+"-------------");
		}
			Timer timer = new Timer(); 
	
		
		//���õļ��ʱ�䣬ͨ������ֵ�趨
		long timestamp = update*1000;
		
		timer.schedule(MyTimerTask.getInstance(), date, timestamp); 
	}
	
	
	/**
	 * ����µ�����
	 * ��Ҫ����id ������ִ��ʱ��
	 */
	public static void addTask(String userid,Long l){
		timeTasks.put(userid, l);
	}
	/**
	 * 
	 *�����µ�����
	 *��Ҫ����id ������ִ��ʱ��
	 */
	public static void updateTask(String userid,Long l){
		removeTask(userid);//��ɾ�������
		addTask(userid,l);
	}
	
	/**
	 * 
	 *ɾ������
	 *��Ҫ�������ݵ�id��ɾ��
	 */
	
	public static void removeTask(String userid){
		timeTasks.remove(userid);
	}
	
	@Override
	public void run() {//��ʱ���ӿڵķ���ʵ�֡����߶�ʱ��������������
		Long nowTime=System.currentTimeMillis();//ϵͳ��ǰʱ��
//		System.out.println(nowTime+"ϵͳʱ��"+"----"+new Date(System.currentTimeMillis()).toLocaleString());
		//������Ҫ��ǰ���Сʱ...����
		//nowTime = nowTime-beforetime*1000;
//		/System.out.println("ϵͳʱ���ǰ���Сʱ��ֵ��"+nowTime+"----"+new Date(nowTime).toLocaleString());
		Set<String> s = timeTasks.keySet();
		//System.out.println("����ʣ������������"+timeTasks.size());
		
		/**
		 * �洢�Ѿ���ɵ�����id(����id���������Ƴ�����Ϊ�ڵ���Map�޸��Ƴ���ʱ������maxu������������ɾ����ǰִ�еĶ��С�����������ִ��֮���¼�Ƴ�
		 * 
		 * ����HashMap�ˡ�������ConcurrentHashMap..��û�д��ڵı�Ҫ �ˡ���
		 * 
		 */
		for(String ss:s) {//��ȡmap�����ֵ (sΪvalue,ssΪ��)
			long taskTime =timeTasks.get(ss);
			String client="";
			String servname="";
			String rptime="";
			String sales="";
			String dendtime="";
			String rid="";
			List<Project> list=null;
			//���پ�ȷ�ȣ����赽���뼶��
			//���������뼶��ʱ�䶼����1000.����������
			//System.out.println("����ʱ���������"+nowTime+"   ����ʱ���������"+taskTime+"����ʱ��������"+nowTime/1000+"         ����ʱ��������"+taskTime/1000);		
			//�ȽϷ�Χ������ʱ���������ֵ��Χ�ڵ�Ϊ��������������
			if((taskTime/1000-nowTime/1000)<=beforetime) {//Ӧ������ʱ��-ϵͳʱ��<=30���ӵ�ֵ
				System.out.println(taskTime/1000+":taskTime");
				System.out.println(nowTime/1000+":nowTime");
				System.out.println(taskTime/1000-nowTime/1000);
//				System.out.println(ss+":ss��ֵ");
			list = ChemProjectAction.getInstance().lateListDTime1(ss);
		
			for(int i=0;i<list.size();i++){
				Project p =(Project)list.get(i);
				ChemProject cp = (ChemProject)p.getObj();
				client=QuotationAction.getInstance().getQuotationByPid(p.getPid()).getClient();
				Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
				sales=qt.getSales();
				servname=cp.getServname();
				if(cp.getRptime() !=null){
				rptime=cp.getRptime().toLocaleString();
				}
				if(cp.getEndtime() !=null){
				dendtime=cp.getEndtime().toLocaleString();
				rid=p.getRid();
				}
			}
//				//����map��ֵ��ѯ���ĵ�һЩ��Ҫ��ֵ
				new PublicEmail().doSomeThing(ss,client,rptime,sales,servname,dendtime,rid);//��һЩ���顣���緢�ʼ�
				//�����ʼ��Ͱ����Ƴ���
				timeTasks.remove(ss);
		}
		}
	}
//	
	/**
	 * ��yyyy-MM-dd HH:mm:ssʱ��ת����longʱ��
	 * @return
	 */
	public static long getTimeMillis(String date) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		long longDate = 0;
		try {
			longDate = df.parse(date).getTime();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return longDate;
	}

}
