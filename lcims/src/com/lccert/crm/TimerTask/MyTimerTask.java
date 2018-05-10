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
 * 时间计时器
 * 适用于计时任务不是太多的情况(3000个左右应该没问题)
 * 
 * 通过设定时间的修正值。影响时间任务的检查频率。比如是1秒检查一次，还是10秒检查一次
 * 
 * 并且在比较任务是否到达执行时间的时候
 * 也会引入修正值。
 * 
 * 例如任务执行时间是13分15秒
 * 当前时间是13分5秒
 * 如果修正值是10秒。则任务在13分5秒的时候就会执行
 * @author tangzp
 *
 */
public class MyTimerTask extends TimerTask{
	static Date date = new Date();//从当前开始计时
	/**
	 * 存储任务id（可以为数据的id），以及到点时间（转换为long）
	 */
	private static Map<String,Long> timeTasks = new ConcurrentHashMap<String, Long>();
	
	/**
	 * 任务提前时间，半个小时。
	 * 以秒为单位。
	 * 比如。距离现在时间还有beforetime时间的时候。任务将执行
	 * private static final long beforetime = 1800;
	 */
	
	/**
	 * 任务提前时间，2个小时。
	 * 以秒为单位。
	 * 比如。距离现在时间还有beforetime时间的时候。任务将执行
	 * 
	 */
	private static final long beforetime = 7200;
	
	/**
	 * 修正值。以秒为单位。
	 * 
	 * 目的：为了减少遍历的次数，如果任务对于时间的要求精度不是特别高，可以加大修正值
	 * 
	 * 最小为1
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
		 * 启动定时器，如果是服务器刚刚启动，通过服务器过滤器启动此功能，并到数据库查找大于当前时间的时间加载到队列中
		 * 
		 * String sql = "查询语句加载大于当前时间的时间数据用来设置定时闹钟";
		 * 获得数据
		 * while(rs.next){
		 * Date date = rs.getDate(时间字段);
		 * String s = rs.getString(数据id字段);
		 * 将时间转换成毫秒后存入timeTasks队列
		 * timeTasks.put(s,getTimeMillis(date.toString()));
		 * }
		 * 
		 * 这里手动创建几组时间
		 */
		
		//时间的毫秒数，直接调用getTimeMillis方法将一个时间的String转换成毫秒数
		//getTimeMillis(new Date().toString);
		//这里直接获得毫秒数.就不通过时间转换了
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
	
		
		//调用的间隔时间，通过修正值设定
		long timestamp = update*1000;
		
		timer.schedule(MyTimerTask.getInstance(), date, timestamp); 
	}
	
	
	/**
	 * 添加新的任务
	 * 需要数据id 和任务执行时间
	 */
	public static void addTask(String userid,Long l){
		timeTasks.put(userid, l);
	}
	/**
	 * 
	 *更改新的任务
	 *需要数据id 和任务执行时间
	 */
	public static void updateTask(String userid,Long l){
		removeTask(userid);//先删除在添加
		addTask(userid,l);
	}
	
	/**
	 * 
	 *删除任务
	 *需要根据数据的id做删除
	 */
	
	public static void removeTask(String userid){
		timeTasks.remove(userid);
	}
	
	@Override
	public void run() {//定时器接口的方法实现。告诉定时器你想做的事情
		Long nowTime=System.currentTimeMillis();//系统当前时间
//		System.out.println(nowTime+"系统时间"+"----"+new Date(System.currentTimeMillis()).toLocaleString());
		//由于需要提前半个小时...所以
		//nowTime = nowTime-beforetime*1000;
//		/System.out.println("系统时间的前半个小时的值："+nowTime+"----"+new Date(nowTime).toLocaleString());
		Set<String> s = timeTasks.keySet();
		//System.out.println("现在剩余任务数量："+timeTasks.size());
		
		/**
		 * 存储已经完成的任务id(数据id），用于移除，因为在调用Map修改移除的时候会出现maxu的锁。不允许删除当前执行的队列。所以在任务执行之后记录移除
		 * 
		 * 不用HashMap了。。。用ConcurrentHashMap..你没有存在的必要 了。。
		 * 
		 */
		for(String ss:s) {//获取map里面的值 (s为value,ss为键)
			long taskTime =timeTasks.get(ss);
			String client="";
			String servname="";
			String rptime="";
			String sales="";
			String dendtime="";
			String rid="";
			List<Project> list=null;
			//减少精确度（无需到毫秒级）
			//将两个毫秒级的时间都除以1000.到秒数级别
			//System.out.println("现在时间毫秒数："+nowTime+"   任务时间毫秒数："+taskTime+"现在时间秒数："+nowTime/1000+"         任务时间秒数："+taskTime/1000);		
			//比较范围。两个时间差在修正值范围内的为符合条件的任务
			if((taskTime/1000-nowTime/1000)<=beforetime) {//应出报告时间-系统时间<=30分钟的值
				System.out.println(taskTime/1000+":taskTime");
				System.out.println(nowTime/1000+":nowTime");
				System.out.println(taskTime/1000-nowTime/1000);
//				System.out.println(ss+":ss的值");
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
//				//根据map的值查询出的的一些需要的值
				new PublicEmail().doSomeThing(ss,client,rptime,sales,servname,dendtime,rid);//做一些事情。比如发邮件
				//发完邮件就把他移除掉
				timeTasks.remove(ss);
		}
		}
	}
//	
	/**
	 * 将yyyy-MM-dd HH:mm:ss时间转换成long时间
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
