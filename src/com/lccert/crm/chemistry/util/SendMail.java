package com.lccert.crm.chemistry.util;

import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import com.lccert.crm.chemistry.email.Email;

/**
 * 发送Email工具类
 * @author Eason
 *
 */
public class SendMail implements Runnable {

//	private static SendMail instance = null;
//
//	private SendMail() {
//
//	}
//
//	public static SendMail getInstance() {
//		if (instance == null) {
//			instance = new SendMail();
//		}
//		return instance;
//	}

//	 public void send(List<String> to,String head,String content) {
//	 for(int i=0;i<to.size();i++) {
//	 System.out.println("email:" + to.get(i));
//	 }
//	 System.out.println("head:" + head);
//	 System.out.println("content:" + content);
//	 }
	
	private Email email;
	
	public Email getEmail() {
		return email;
	}

	public void setEmail(Email email) {
		this.email = email;
	}

	public SendMail() {
		super();
	}
	public void run() {
		send(email);
	}

	/**
	 * 发送Email
	 * @param email
	 */
	public static void send(Email email) {
		try {

			Properties p = new Properties(); // Properties p =
												// System.getProperties();
			p.put("mail.smtp.auth", "true");
//			p.put("mail.smtp.auth", "false");
			p.put("mail.transport.protocol", "smtp");
//			p.put("mail.smtp.host", "61.151.239.132");
//			p.put("mail.smtp.host", "smtp2.lccert.com");
			p.put("mail.smtp.host", "smtp.lccert.com");
			p.put("mail.smtp.port", "25");
			// 建立会话
			Session session = Session.getInstance(p);
			Message msg = new MimeMessage(session); // 建立信息

//			msg.setFrom(new InternetAddress("lcims@lccert.com")); // 发件人
//			msg.setFrom(new InternetAddress("service@lccert.com")); // 发件人
			msg.setFrom(new InternetAddress("LCIMS@LCCERT.COM")); // 发件人

			String toList = getMailList(email.getTo());
			new InternetAddress();
			InternetAddress[] iaToList = InternetAddress.parse(toList);

			msg.setRecipients(Message.RecipientType.TO, iaToList); // 收件人

			msg.setSentDate(new Date()); // 发送日期
			//BASE64Encoder enc = new BASE64Encoder();
			String subject = email.getHead();
			msg.setSubject(MimeUtility.encodeText(subject,"GBK","B"));
			//String subject = new String(email.getHead().getBytes("GB18030"),Charset.defaultCharset());
			//msg.setSubject("=?GBK?B?" + enc.encode(subject.getBytes("GBK")) + "?="); // 主题
			//msg.setSubject(subject);
			msg.setContent(email.getContent(), "text/html;charset=GBK");// 内容
			// 邮件服务器进行验证
			Transport tran = session.getTransport("smtp");
			//tran.connect("61.151.239.132", "lcims@lccert.com", "12345678");
//			tran.connect("smtp2.lccert.com", "lcims@lccert.com", "22833366lc");
			tran.connect("smtp.lccert.com", "lcims@lccert.com", "Qq789456123");
//			tran.connect("192.168.0.241", "lcims@lccert.com", /"22833399lc");
			//p.put("mail.smtp.host", );
			// easonchen@lccert.com是用户名，123456是密码
			tran.sendMessage(msg, msg.getAllRecipients()); // 发送
			//System.out.println("邮件发送成功");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 格式化收件人
	 * @param mailArray
	 * @return
	 */
	private static String getMailList(List<String> mailArray) {

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
