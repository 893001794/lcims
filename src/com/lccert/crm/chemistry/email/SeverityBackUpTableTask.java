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
 * ����һ��ǰ�����سٵ���Ŀ
 * ͨ��email��ʽ���ͳٵ���������ݸ���ص���Ա
 * @author tangzp
 *
 */
public class SeverityBackUpTableTask extends TimerTask {  
	private InetAddress addr;
	String ip=null;
   public void run() {  
	   try{
			addr = InetAddress.getLocalHost();
			ip = addr.getHostAddress();//��ñ���IP
	} catch (UnknownHostException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	//����ipΪ192.168.0.10������
	    System.out.println("��ʼִ������..."); //��ʼ����  
		if(!ip.equals("10.11.1.222")&&!ip.equals("192.168.0.10")){
               sendProject();
		}
        System.out.println("ִ���������..."); //�������        
   }
   
   	/**
   	 * ͨ��email��ʽ���ͳٵ���Ŀ
   	 */
	private void sendProject() {
		Date date = new Date();
		//��ȡ���ܵ�ʱ��
		String start = new SimpleDateFormat("yyyy-MM-dd").format(new Date(((date.getTime()/1000)-60*60*24*7)*1000));
		String end = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		List<String> to = new ArrayList<String>();
		List<Project> list = ChemProjectAction.getInstance().getSeverityLateProject(start);
		int[] family = LabAction.getInstance().getSaverityLatePercent(start);
		float latepercent = family[1]==0 ? 0 : family[0] * 100 / family[1];
		//�ǵÿ�����
		to.add("luozh@lccert.com");
		to.add("hadixia@lccert.com");
//		to.add("amyyang@lccert.com");
//		to.add("john@lccert.com");
//		to.add("clf@lccert.com");
		to.add("huangyh@lccert.com");
		to.add("service@lccert.com");
		to.add("tangzp@lccert.com");
		String head = "[һ��ǰ��2Сʱ�����سٵ���Ŀ��Ϣ]" + start + "��" + end + "�ٵ���Ŀ֪ͨ";
		StringBuffer content = new StringBuffer("[һ��ǰ�ٵ���Ŀ��Ϣ����]<br>");
		content.append("ʱ��Σ�" + start + "��" + end + "�ڼ�����гٵ���Ŀ���£�<br>");
		content.append("�ٵ�������" + family[0] + " / ����Ŀ����:" + family[1] + "/ ");
		content.append("�ٵ���Ϊ��" + latepercent + "%;<br>");
		content.append("�ٵ���ϸ��Ϣ��<br><br><br>");
		for(int i=0;i<list.size();i++){
			List temp =(List)list.get(i);
			for(int j=0;j<temp.size();j++){
				Project p = (Project)temp.get(j);
				ChemProject cp = (ChemProject) p.getObj();
				content.append("���۵���:" + p.getPid());
				content.append("<br>�����:" + p.getRid());
				content.append("<br>�ͻ�����:"
						+ QuotationAction.getInstance().getQuotationByPid(
								p.getPid()).getClient());
				content.append("<br>Ӧ������ʱ��:" + cp.getRptime());
				if(cp.getEndtime()==null){
					content.append("<br>ʵ�����ʱ��:���滹û����ɣ��뾡�����" );
				}else{
				    content.append("<br>ʵ�����ʱ��:" + cp.getEndtime());
				}
				content.append("<br>---------------------------------------<br>");
			}
		}
		content.append("<br><br>����Ϣ���������LCIMSϵͳ�Զ����ͣ�����ظ����ʼ���");
		content.append("<br>�������ʣ�����ϵϵͳ����Ա��");
		content.append("<br><br>�������<br>����:"+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		
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
