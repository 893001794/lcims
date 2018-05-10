package com.lccert.crm.chemistry.email;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.TimerTask;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import sun.misc.BASE64Encoder;

import com.lccert.crm.chemistry.lab.LabAction;
import com.lccert.crm.chemistry.util.SendMail;
import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.ChemProjectAction;
import com.lccert.crm.project.Project;
import com.lccert.crm.quotation.QuotationAction;

/**
 * 发送一周前的严重迟单项目
 * 通过email方式发送迟单的相关内容给相关的人员
 * @author tangzp
 *
 */
public class SeverityBackUpTableTask extends TimerTask {  
	private InetAddress addr;
	String ip=null;
   public void run() {  
	   try{
			addr = InetAddress.getLocalHost();
			ip = addr.getHostAddress();//获得本机IP
	} catch (UnknownHostException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	//电脑ip为192.168.0.10不发送
	    System.out.println("开始执行任务..."); //开始任务  
		if(!ip.equals("10.11.1.222")&&!ip.equals("192.168.0.10")){
               sendProject();
		}
        System.out.println("执行任务完成..."); //任务完成        
   }
   
   	/**
   	 * 通过email方式发送迟单项目
   	 */
	private void sendProject() {
		Date date = new Date();
		//获取上周的时间
		String start = new SimpleDateFormat("yyyy-MM-dd").format(new Date(((date.getTime()/1000)-60*60*24*7)*1000));
		String end = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		List<String> to = new ArrayList<String>();
		List<Project> list = ChemProjectAction.getInstance().getSeverityLateProject(start);
		int[] family = LabAction.getInstance().getSaverityLatePercent(start);
		float latepercent = family[1]==0 ? 0 : family[0] * 100 / family[1];
		//记得开来他
		to.add("luozh@lccert.com");
		to.add("hadixia@lccert.com");
//		to.add("amyyang@lccert.com");
//		to.add("john@lccert.com");
//		to.add("clf@lccert.com");
		to.add("huangyh@lccert.com");
		to.add("service@lccert.com");
		to.add("tangzp@lccert.com");
		String head = "[一周前超2小时的严重迟单项目信息]" + start + "至" + end + "迟单项目通知";
		StringBuffer content = new StringBuffer("[一周前迟单项目信息发布]<br>");
		content.append("时间段：" + start + "至" + end + "期间的所有迟单项目如下：<br>");
		content.append("迟单数量：" + family[0] + " / 总项目数量:" + family[1] + "/ ");
		content.append("迟单率为：" + latepercent + "%;<br>");
		content.append("迟单详细信息：<br><br><br>");
		for(int i=0;i<list.size();i++){
			List temp =(List)list.get(i);
			for(int j=0;j<temp.size();j++){
				Project p = (Project)temp.get(j);
				ChemProject cp = (ChemProject) p.getObj();
				content.append("报价单号:" + p.getPid());
				content.append("<br>报告号:" + p.getRid());
				content.append("<br>客户名称:"
						+ QuotationAction.getInstance().getQuotationByPid(
								p.getPid()).getClient());
				content.append("<br>应出报告时间:" + cp.getRptime());
				if(cp.getEndtime()==null){
					content.append("<br>实际完成时间:报告还没有完成，请尽快完成" );
				}else{
				    content.append("<br>实际完成时间:" + cp.getEndtime());
				}
				content.append("<br>---------------------------------------<br>");
			}
		}
		content.append("<br><br>本信息由立创检测LCIMS系统自动发送，请勿回复本邮件。");
		content.append("<br>如有疑问，请联系系统管理员。");
		content.append("<br><br>立创检测<br>日期:"+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		
		new EmailConfigure().send(to, head, content.toString());
	}
	public static void main(String[] args) {
		
		new SeverityBackUpTableTask().sendProject();
//		
//		Date date =new Date();
//		String start = new SimpleDateFormat("yyyy-MM-dd").format(new Date(((date.getTime()/1000)-60*60*24*7)*1000));
//		//System.out.println(start);
//		String end = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
//		List<String> to = new ArrayList<String>();
//		
//		
//		
//		int[] family = LabAction.getInstance().getSaverityLatePercent(start);
////		System.out.println(family[0]);
////		System.out.println(family[1]);
////		System.out.println(family[1]==0 ? 0 : family[0] * 100 / family[1]);
//		
//		
//		List<Project> list = ChemProjectAction.getInstance().getSeverityLateProject(start);
//		//List list = ChemProjectAction.getInstance().getSeverityLateProject("");
//		for(int i=0;i<list.size();i++){
//			List temp =(List)list.get(i);
//			for(int j=0;j<temp.size();j++){
//				Project p = (Project)temp.get(j);
//				ChemProject cp = (ChemProject) p.getObj();
//				System.out.println(cp.getRptime());
//			}
//		}
	}

} 
