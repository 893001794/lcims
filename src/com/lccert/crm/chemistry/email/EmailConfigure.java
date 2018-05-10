package com.lccert.crm.chemistry.email;

import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

/***
 * 邮件的配置方法
 * @author LC
 *
 */
public class EmailConfigure {
	
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
	
	public void send(List<String> to, String head, String content) {
		Transport tran = null;
		try {

			Properties p = new Properties(); // Properties p =
			p.put("mail.smtp.auth", "true");
			p.put("mail.transport.protocol", "smtp");
//			p.put("mail.smtp.host", "61.151.239.132");
			p.put("mail.smtp.host", "smtp.lccert.com");
			p.put("mail.smtp.port", "25");
			// 建立会话
			Session session = Session.getInstance(p);
			Message msg = new MimeMessage(session); // 建立信息

			msg.setFrom(new InternetAddress("lcims@lccert.com")); // 发件人

			String toList = getMailList(to);
			new InternetAddress();
			InternetAddress[] iaToList = InternetAddress.parse(toList);

			msg.setRecipients(Message.RecipientType.TO, iaToList); // 收件人

			msg.setSentDate(new Date()); // 发送日期
			// BASE64Encoder enc = new BASE64Encoder();
			String subject = head;
			// String subject = new
			// String(head.getBytes("GB18030"),Charset.defaultCharset());
			// msg.setSubject("=?GBK?B?" + enc.encode(subject.getBytes("GBK")) +
			// "?="); // 主题
			msg.setSubject(MimeUtility.encodeText(subject, "GBK", "B"));
			msg.setContent(content, "text/html;charset=GBK");// 内容
			// 邮件服务器进行验证
			tran = session.getTransport("smtp");
//			tran.connect("61.151.239.132", "lcims@lccert.com", "12345678");
//			tran.connect("smtp2.lccert.com", "lcims@lccert.com", "22833366lc");
			tran.connect("smtp.lccert.com", "lcims@lccert.com", "Qq789456123");
			
			// easonchen@lccert.com是用户名，123456是密码
			tran.sendMessage(msg, msg.getAllRecipients()); // 发送
			// System.out.println("邮件发送成功");
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
}
