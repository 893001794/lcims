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

import com.lccert.crm.chemistry.lab.LabAction;
import com.lccert.crm.chemistry.util.FlowFinal;
import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.ChemProjectAction;
import com.lccert.crm.project.Project;
import com.lccert.crm.quotation.QuotationAction;

/**
 *ÿ�쳭��Сʱ�����سٵ�ͳ�� �����������ʱ��-����Ӧ��ʱ��>2Сʱ��ʱ��ͷ��ʼ�����ص���Ա��
 * @author tangzp
 * 
 */
public class SeverityLateProjectTask extends TimerTask {
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
		System.out.println("��ʼ���ͳٵ���Ŀ..."); // ��ʼ����
		if(!ip.equals("10.11.1.222")&&!ip.equals("192.168.0.10")){
			sendProject();
		}
		System.out.println("���ͳٵ���Ŀ���..."); // �������
	}

	/**
	 * ͨ��email��ʽ���ͳٵ���Ŀ
	 */
	private void sendProject() {
		Date date = new Date();
		String start = new SimpleDateFormat("yyyy-MM-dd 00:00:00").format(date);
		String end = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
		List<String> to = new ArrayList<String>();
		List list = ChemProjectAction.getInstance().getSeverityLateProject("");
		//System.out.println(list.size());
		int[] family = LabAction.getInstance().getSaverityLatePercent("");
	//	System.out.println(family[0]*100/family[1]);
		float latepercent = family[1] == 0 ? 0 : family[0] * 100 / family[1];
		//��ȡ��ѧ�ͷ���Ա
		List servList =FlowFinal.getInstance().getChemServ();
		if(servList.size()>0){
			for(int i=0;i<servList.size();i++){
				to.add(servList.get(i)+"");
			}
		}
		to.add("luozh@lccert.com");
		to.add("hadixia@lccert.com");
		to.add("huangyh@lccert.com");
		to.add("service@lccert.com");
//		to.add("tangzp@lccert.com");
		String head = "[���쳬2Сʱ�����سٵ���Ŀ��Ϣ]" + start + "��" + end + "�ٵ���Ŀ֪ͨ";
		StringBuffer content = new StringBuffer("[�����Զ��ٵ���Ŀ��Ϣ����]<br>");
		content.append("ʱ��Σ�" + start + "��" + end + "�ڼ�����гٵ���Ŀ���£�<br>");
		content.append("�ٵ�������" + family[0] + " / ����Ŀ����:" + family[1] + " / ");
		content.append("�ٵ���Ϊ��" + latepercent + "%;<br>");
		content.append("�ٵ���ϸ��Ϣ��<br><br><br>");
		for(int i=0;i<list.size();i++){
			List temp =(List)list.get(i);
			for(int j=0;j<temp.size();j++){
				Project p = (Project)temp.get(j);
				ChemProject cp = (ChemProject) p.getObj();
				content.append("���۵���:" + p.getPid());
				content.append("<br>�����:" + p.getRid());
				content.append("<br>�ͻ�����:"+ QuotationAction.getInstance().getQuotationByPid(p.getPid()).getClient());
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
		content.append("<br><br>�������<br>����:"
				+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		new EmailConfigure().send(to, head, content.toString());
		// SendMail send = new SendMail();
		// send.setTo(to);
		// send.setHead(head);
		// send.setContent(content.toString());
		// Thread t = new Thread(send);
		// t.start();
	}

	
	
	public static void main(String[] args) {
		
		int[] family = LabAction.getInstance().getSaverityLatePercent("");
		System.out.println(family[0]);
		
		List list = ChemProjectAction.getInstance().getSeverityLateProject("");
		for(int i=0;i<list.size();i++){
			List temp =(List)list.get(i);
			for(int j=0;j<temp.size();j++){
				Project p = (Project)temp.get(j);
				ChemProject cp = (ChemProject) p.getObj();
//				System.out.println(cp.getRptime());
			}
		}
	}

}
