package com.lccert.crm.chemistry.email;

import java.text.ParseException;
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

import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.ChemProjectAction;
import com.lccert.crm.project.Project;
import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.quotation.QuotationAction;
import com.lccert.crm.user.UserAction;
/**
 * Ӧ������ʱ��-ϵͳʱ��<=30���ӾͿ�ʼ�������䷢�ʼ��ĵ�����
 * @author lcc
 *
 */

public class PublicEmail{

	public void doSomeThing(String pid,String client,String rptime,String sales,String servname,String dendtime,String rid){
		
		List<String> to = new ArrayList<String>();
//		to.add("luozh@lccert.com");
//		to.add("wuyj@lccert.com");
//		to.add("hadixia@lccert.com");
//		to.add("amyyang@lccert.com");
//		to.add("john@lccert.com");
//		to.add("clf@lccert.com");
//		to.add("huangyh@lccert.com");
//		to.add("service@lccert.com");
		
//		UserAction.getInstance().findUserByName(to, sales);
//		UserAction.getInstance().findUserByName(to, servname);
		
		to.add("tangzp@lccert.com");
		
		String head = "[��ǰ2Сʱ�ı���Ԥ��]" + new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		StringBuffer content = new StringBuffer("[��ǰ2Сʱ�ı���Ԥ��]<br>");
		content.append("����Ԥ����ϸ��Ϣ��<br><br><br>");
		content.append("���۵���:" + pid);
		content.append("<br>�����:" + rid);
		content.append("<br>�ͻ�����:" +client);
		content.append("<br>Ӧ������ʱ��:" + rptime);
		content.append("<br>����Ԥ��ʱ��Ϊ:" + new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
		content.append("<br>---------------------------------------<br>");

	    content.append("<br><br>����Ϣ���������LCIMSϵͳ�Զ����ͣ�����ظ����ʼ���");
		content.append("<br>�������ʣ�����ϵϵͳ����Ա��");
		content.append("<br><br>�������<br>����:" + new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		send(to, head, content.toString());
//	}
	}
	
	
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
	
	
	
	//���巢���ʼ���
	private void send(List<String> to, String head, String content) {
		Transport tran = null;
		try {

			Properties p = new Properties(); // Properties p =
												// System.getProperties();
			p.put("mail.smtp.auth", "true");
			p.put("mail.transport.protocol", "smtp");
			p.put("mail.smtp.host", "61.151.239.132");
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
			//BASE64Encoder enc = new BASE64Encoder();
			String subject = head;
			//String subject = new String(head.getBytes("GB18030"),Charset.defaultCharset());
			//msg.setSubject("=?GBK?B?" + enc.encode(subject.getBytes("GBK")) + "?="); // ����
			msg.setSubject(MimeUtility.encodeText(subject,"GBK","B"));
			msg.setContent(content, "text/html;charset=GBK");//����
			// �ʼ�������������֤
			tran = session.getTransport("smtp");
			tran.connect("61.151.239.132", "lcims@lccert.com", "12345678");
			// easonchen@lccert.com���û�����123456������
			tran.sendMessage(msg, msg.getAllRecipients()); // ����
			//System.out.println("�ʼ����ͳɹ�");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(tran != null) {
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
