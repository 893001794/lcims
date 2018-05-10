package com.lccert.crm.chemistry.util;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import com.lccert.crm.chemistry.email.Email;
import com.lccert.crm.chemistry.email.EmailList;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeBodyPart;
import javax.activation.FileDataSource;
import javax.activation.DataHandler;
/**
 * 发送Email工具类
 * @author Eason
 *
 */
public class AttachmentsMail implements Runnable {

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
	
	private EmailList emailList;
	
	public EmailList getEmailList() {
		return emailList;
	}

	public void setEmailList(EmailList emailList) {
		this.emailList = emailList;
	}
	public AttachmentsMail() {
		super();
	}

	public void run() {
		attachments(emailList);
	}
	public static void attachments(EmailList email){
		try {
			Properties p = new Properties(); // Properties p =
			p.put("mail.smtp.auth", "true");
			p.put("mail.transport.protocol", "smtp");
			p.put("mail.smtp.host", "smtp.lccert.com");
			p.put("mail.smtp.port", "25");
			// 建立会话
			Session session = Session.getInstance(p);
			Message msg = new MimeMessage(session); // 建立信息
			if(email.getSender()!=null){
				msg.setFrom(new InternetAddress("LCIMS@LCCERT.COM")); // 发件人
//				msg.setFrom(new InternetAddress(email.getSender())); // 发件人
			}else{
				msg.setFrom(new InternetAddress("LCIMS@LCCERT.COM")); // 发件人
			}
			String toList = getMailList(email.getTo());
			new InternetAddress();
			InternetAddress[] iaToList = InternetAddress.parse(toList);
			msg.setRecipients(Message.RecipientType.TO, iaToList); // 收件人
			msg.setSentDate(new Date()); // 发送日期
			//BASE64Encoder enc = new BASE64Encoder();
			String subject = email.getHead();
			msg.setSubject(MimeUtility.encodeText(subject,"GBK","B"));
			Multipart multipart = new MimeMultipart();
			MimeBodyPart body = new MimeBodyPart();
			body.setContent(email.getContent(), "text/html;charset=GBK");
			multipart.addBodyPart(body);//发件内容
			//添加附件
			List attachmentsList =email.getAttachmentsList();
			//如果附件的容器里面有值就在邮件中添加附件的方法
			if(attachmentsList.size()>0){
				/**		 * 该方法用于设置MimeMessage对象的邮件体		 */		
				 for (int i = 0; i < email.getAttachmentsList().size(); i++) {
						MimeBodyPart attachPart = createAttachment(email.getAttachmentsList().get(i).toString());				
						multipart.addBodyPart(attachPart);		
		         }
				 
				msg.setContent(multipart);		
				msg.saveChanges();		
			}
			// 邮件服务器进行验证
			Transport tran = session.getTransport("smtp");
			tran.connect("smtp.lccert.com", "lcims@lccert.com", "Qq789456123");
			tran.sendMessage(msg, msg.getAllRecipients()); // 发送
			//System.out.println("邮件发送成功");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	/***
	 * 
	 * @param filename 增加附件的名称
	 * @return
	 * @throws Exception
	 */
	public static MimeBodyPart createAttachment(String filename) throws Exception{				
		MimeBodyPart attachPart = new MimeBodyPart();		
		FileDataSource fds = new FileDataSource(filename);		
		attachPart.setDataHandler(new DataHandler(fds));		
		attachPart.setFileName(fds.getName());				
		return attachPart;	
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
