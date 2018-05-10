package com.lccert.crm.chemistry.email;

import java.util.ArrayList;
import java.util.List;

import java.io.FileOutputStream;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import com.lccert.crm.chemistry.util.SendEmail;

public class TestEmail {
//	public static void main(String[] args) {
//		List toList =new ArrayList();
//		toList.add("tangzp@lccert.com");
////		toList.add("tangzp@lccert.com");
//	    //toList.add("service@lccert.com");
//		String head ="JAVAMAIL 附件测试";
//		BodyPart mdp=new MimeBodyPart(); //新建一个存放信件内容的BodyPart对象 
////		 mdp=new MimeBodyPart(); //新建一个存放附件的BodyPart 
//		 try {
//			mdp.setFileName("D:\\22 化学报告\\LCZC\\1203\\LCZC12030562-E.pdf"); //为“内容”文本框中的内容设置标题，并以附件的形式发送 
//			 //mdp.setDataHandler(handler); //给BodyPart设置内容为handler
//			 Multipart mul=new MimeMultipart(); //新建一个MimeMultipart对象来存放多个BodyPart 对象 
//			 mul.addBodyPart(mdp); //将含有附件的BodyPart加入到MimeMulitipart对象中 
//		} catch (MessagingException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//
//
//		String content="前台有你的快递。<br>快递编号为：";
//		new SendEmail().sendEmailPublic(toList,head,content);
//	}
	
	public static void main(String[] args) throws Exception {		
		/**Session类		 * 该类用于定义整个应用程序所需的环境信息及收集客户端与邮件服务器建立网络连接的会话信息		 
		 * * Session对象根据这些信息构建用于邮件收发的Transport和Store对象，以及为客户端创建Message对象时提供信息支持		 */		
		Session session = Session.getDefaultInstance(new Properties());		
		/**		 * Message类		 * 是创建和解析邮件的核心API，它的实例对象代表了一封电子邮件		 */		
		MimeMessage msg = createMessage(session);		
		msg.writeTo(new FileOutputStream("c:\\ComplexMessage.eml"));	
		}		
	public static MimeMessage createMessage(Session session) throws Exception{				
		String from = "zhangzenglun@163.com";		String to = "tangzp@lccert.com";		
		String subject = "HTML邮件";		String body = "<h4>welcome to here</h4>";				
		MimeMessage msg = new MimeMessage(session);		
		msg.setFrom(new InternetAddress(from));		
		/**		 * RecipientType是Message的静态内部类 To代表邮件的主要接受者		 
		 * * setRecipient方法设置一个收件人的地址		 */		
		msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));		
		/**		 * 设置发送邮件的主题		 */		
		msg.setSubject(subject);				
		/**		 * 该方法用于设置MimeMessage对象的邮件体		 */		
		MimeMultipart allMultipart = new MimeMultipart("mixed");				
		MimeBodyPart contentPart = createContent(body,"d:\\image\\slogo.gif");		
		MimeBodyPart attachPart1 = createAttachment("c:\\zip\\test.zip");		
		MimeBodyPart attachPart2 = createAttachment("D:\\classicalSongs\\8.mp3");				
		allMultipart.addBodyPart(contentPart);		
		allMultipart.addBodyPart(attachPart1);		
		allMultipart.addBodyPart(attachPart2);				
		msg.setContent(allMultipart);		
		msg.saveChanges();				
		return msg;	
		}		
	public static MimeBodyPart createContent(String body,String filename) throws Exception{				
		MimeBodyPart contentPart = new MimeBodyPart();		
		MimeMultipart contentMultipart = new MimeMultipart("related");				
		MimeBodyPart htmlBodyPart = new MimeBodyPart();		
		htmlBodyPart.setContent(body,"text/html;charset=gb2312");		
		contentMultipart.addBodyPart(htmlBodyPart);				
		MimeBodyPart gifBodyPart = new MimeBodyPart();		
		FileDataSource fds = new FileDataSource(filename);		
		gifBodyPart.setDataHandler(new DataHandler(fds));		
		gifBodyPart.setContentID("it2315_slogo_gif");		
		contentMultipart.addBodyPart(gifBodyPart);				
		contentPart.setContent(contentMultipart);				
		return contentPart;			
		}		
	
	public static MimeBodyPart createAttachment(String filename) throws Exception{				
		MimeBodyPart attachPart = new MimeBodyPart();		
		FileDataSource fds = new FileDataSource(filename);		
		attachPart.setDataHandler(new DataHandler(fds));		
		attachPart.setFileName(fds.getName());				
		return attachPart;	
		}
	
}
