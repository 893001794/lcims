package com.lccert.crm.chemistry.email;

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
import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.client.ClientAction;
import com.lccert.crm.client.ClientForm;
import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.ChemProjectAction;
import com.lccert.crm.project.Project;
import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.quotation.QuotationAction;

/**
 * ���淢�����ǻ�û���տ��Ԥ��
 * 
 * @author tangzp
 * 
 */
public class IssueRPNoPayTask extends TimerTask {
	public void run() {
		System.out.println("��ʼ���ͳٵ���Ŀ..."); // ��ʼ����
		sendProject();
		System.out.println("���ͳٵ���Ŀ���..."); // �������
	}

	/**
	 * ͨ��email��ʽ���ͳٵ���Ŀ
	 */
	private void sendProject() {
		//Date date = new Date();
		//String start = new SimpleDateFormat("yyyy-MM-dd 00:00:00").format(date);
		//String end = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
		List<String> to = new ArrayList<String>();
		//��ѯ���еķ������棬������δ���������пͻ��ı�����Ϣ
		PageModel pm =ChemProjectAction.getInstance().searchIssueRPNoPay(0,0,"","","");
		List list=pm.getList();
		//���ո��ʼ�����Ա
		to.add("luozh@lccert.com");
		to.add("hadixia@lccert.com");
//		to.add("amyyang@lccert.com");
		to.add("john@lccert.com");
		to.add("clf@lccert.com");
		to.add("huangyh@lccert.com");
		to.add("service@lccert.com");
		to.add("tangzp@lccert.com");
		String head = "[�����Ѿ����ų�15�죬����Ƿ�û�и��壬ims�������Ѵ߿��Ԥ��]";
		StringBuffer content = new StringBuffer("[����߿�������Ϣ]<br>");
		for(int i=0;i<list.size();i++){
			//���ݱ��۵���ȡ�ͻ���Ϣ
			ChemProject cp =(ChemProject)list.get(i);
			Quotation qt =(Quotation)cp.getObj();
			ClientForm cf=ClientAction.getInstance().getClientByName(qt.getClient());
			//�������ڸÿͻ��Ǿʹ���һ������
			String payStatus="";
			if(cf == null ){
			cf=new ClientForm();
			}
			//���˿ͻ��ĸ��ʽ����"�½�"��ʱ��
			if(cf.getPay().equals("�½�")){
			//���ݸñ��۵���ȡ�ñ��۵��ϸ��µ����һ��۵��Ƿ񸶿�
			payStatus=QuotationAction.getInstance().getPayStatusByTime(qt.getClient());
			}else if(cf.getPay() !=null && !"".equals(cf.getPay())){
			//ֱ�ӻ�ȡ��ǰ���۵��Ƿ񸶿����
			payStatus=qt.getPaystatus();
			}
			//����ÿͻ��ı����Ѿ����˳�ȥ������Ƿ�û�и���������侯��
			if("n".equals(payStatus)){
				//���ͱ����ʱ��+15���Ƿ�<=ϵͳ����ͷ����侯��
					content.append("���۵���:" + cp.getPid());
					content.append("<br>�����:" + cp.getRid());
					content.append("<br>�ͻ�����:"+qt.getClient());
					content.append("<br>���淢��ʱ��:"+cp.getSendtime());
					content.append("<br>��ٻؿ�ʱ��:"+cp.getEndtime());
					content.append("<br>�ͻ���������:"+cf.getPay());
					content.append("<br>---------------------------------------<br>");
				}
			
		}
		content.append("<br><br>���ϵ���Ŀ���Ǳ����Ѿ�������15�죬���ǻ�û���ջ�Ƿ��ģ���������۾���߿��");
		content.append("<br><br>����Ϣ���������LCIMSϵͳ�Զ����ͣ�����ظ����ʼ���");
		content.append("<br>�������ʣ�����ϵϵͳ����Ա��");
		content.append("<br><br>�������<br>����:"
				+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		send(to, head, content.toString());
		// SendMail send = new SendMail();
		// send.setTo(to);
		// send.setHead(head);
		// send.setContent(content.toString());
		// Thread t = new Thread(send);
		// t.start();
	}

	private void send(List<String> to, String head, String content) {
		Transport tran = null;
		try {

			Properties p = new Properties(); // Properties p =
			p.put("mail.smtp.auth", "true");
			p.put("mail.transport.protocol", "smtp");
//			p.put("mail.smtp.host", "61.151.239.132");
			p.put("mail.smtp.host", "smtp.lccert.com");
			p.put("mail.smtp.port", "25");
			// �����Ự
			Session session = Session.getInstance(p);
			Message msg = new MimeMessage(session); // ������Ϣ

			msg.setFrom(new InternetAddress("lcims@lccert.com")); // ������

			String toList = getMailList(to);
			new InternetAddress();
			InternetAddress[] iaToList = InternetAddress.parse(toList);

			msg.setRecipients(Message.RecipientType.TO, iaToList); // �ռ���

			msg.setSentDate(new Date()); // ��������
			// BASE64Encoder enc = new BASE64Encoder();
			String subject = head;
			// String subject = new
			// String(head.getBytes("GB18030"),Charset.defaultCharset());
			// msg.setSubject("=?GBK?B?" + enc.encode(subject.getBytes("GBK")) +
			// "?="); // ����
			msg.setSubject(MimeUtility.encodeText(subject, "GBK", "B"));
			msg.setContent(content, "text/html;charset=GBK");// ����
			// �ʼ�������������֤
			tran = session.getTransport("smtp");
//			tran.connect("61.151.239.132", "lcims@lccert.com", "12345678");
			tran.connect("smtp.lccert.com", "lcims@lccert.com", "Qq789456123");
			// easonchen@lccert.com���û�����123456������
			tran.sendMessage(msg, msg.getAllRecipients()); // ����
			// System.out.println("�ʼ����ͳɹ�");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (tran != null) {
				try {
					tran.close();
				} catch (MessagingException e) {
					e.printStackTrace();
				}
			}
		}
	}

	private String getMailList(List<String> mailArray) {

		StringBuffer toList = new StringBuffer();
		int length = mailArray.size();
		if (mailArray != null && length < 2) {
			toList.append(mailArray.get(0));
		} else {
			for (int i = 0; i < length; i++) {
				toList.append(mailArray.get(i));
				if (i != (length - 1)) {
					toList.append(",");
				}

			}
		}
		return toList.toString();

	}

}
