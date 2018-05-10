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
//		String head ="JAVAMAIL ��������";
//		BodyPart mdp=new MimeBodyPart(); //�½�һ������ż����ݵ�BodyPart���� 
////		 mdp=new MimeBodyPart(); //�½�һ����Ÿ�����BodyPart 
//		 try {
//			mdp.setFileName("D:\\22 ��ѧ����\\LCZC\\1203\\LCZC12030562-E.pdf"); //Ϊ�����ݡ��ı����е��������ñ��⣬���Ը�������ʽ���� 
//			 //mdp.setDataHandler(handler); //��BodyPart��������Ϊhandler
//			 Multipart mul=new MimeMultipart(); //�½�һ��MimeMultipart��������Ŷ��BodyPart ���� 
//			 mul.addBodyPart(mdp); //�����и�����BodyPart���뵽MimeMulitipart������ 
//		} catch (MessagingException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//
//
//		String content="ǰ̨����Ŀ�ݡ�<br>��ݱ��Ϊ��";
//		new SendEmail().sendEmailPublic(toList,head,content);
//	}
	
	public static void main(String[] args) throws Exception {		
		/**Session��		 * �������ڶ�������Ӧ�ó�������Ļ�����Ϣ���ռ��ͻ������ʼ������������������ӵĻỰ��Ϣ		 
		 * * Session���������Щ��Ϣ���������ʼ��շ���Transport��Store�����Լ�Ϊ�ͻ��˴���Message����ʱ�ṩ��Ϣ֧��		 */		
		Session session = Session.getDefaultInstance(new Properties());		
		/**		 * Message��		 * �Ǵ����ͽ����ʼ��ĺ���API������ʵ�����������һ������ʼ�		 */		
		MimeMessage msg = createMessage(session);		
		msg.writeTo(new FileOutputStream("c:\\ComplexMessage.eml"));	
		}		
	public static MimeMessage createMessage(Session session) throws Exception{				
		String from = "zhangzenglun@163.com";		String to = "tangzp@lccert.com";		
		String subject = "HTML�ʼ�";		String body = "<h4>welcome to here</h4>";				
		MimeMessage msg = new MimeMessage(session);		
		msg.setFrom(new InternetAddress(from));		
		/**		 * RecipientType��Message�ľ�̬�ڲ��� To�����ʼ�����Ҫ������		 
		 * * setRecipient��������һ���ռ��˵ĵ�ַ		 */		
		msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));		
		/**		 * ���÷����ʼ�������		 */		
		msg.setSubject(subject);				
		/**		 * �÷�����������MimeMessage������ʼ���		 */		
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
