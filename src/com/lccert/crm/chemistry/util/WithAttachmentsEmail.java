//package com.lccert.crm.chemistry.util;
//
//import java.util.ArrayList;
//import java.util.Date;
//import java.util.List;
//import java.util.Properties;
//
//import javax.activation.DataHandler;
//import javax.activation.FileDataSource;
//import javax.mail.Message;
//import javax.mail.Session;
//import javax.mail.Transport;
//import javax.mail.internet.InternetAddress;
//import javax.mail.internet.MimeBodyPart;
//import javax.mail.internet.MimeMessage;
//import javax.mail.internet.MimeMultipart;
//import javax.mail.internet.MimeUtility;
//
//import com.lccert.crm.chemistry.email.Email;
//
//
///**
// * ����Email������
// * @author Eason
// *
// */
//public class WithAttachmentsEmail implements Runnable {
//	private Email email;
//	
//	public Email getEmail() {
//		return email;
//	}
//
//	public void setEmail(Email email) {
//		this.email = email;
//	}
//
//	public WithAttachmentsEmail() {
//		super();
//	}
//
//	public void run() {
//		send(email);
//	}
//
//	/**
//	 * ����Email
//	 * @param email
//	 */
//	public static void send(Email email) {
//		try {
//
//			Properties p = new Properties(); // Properties p =
//												// System.getProperties();
//			p.put("mail.smtp.auth", "true");
////			p.put("mail.smtp.auth", "false");
//			p.put("mail.transport.protocol", "smtp");
////			p.put("mail.smtp.host", "61.151.239.132");
////			p.put("mail.smtp.host", "smtp2.lccert.com");
//			p.put("mail.smtp.host", "smtp.lccert.com");
//			p.put("mail.smtp.port", "25");
//			// �����Ự
//			Session session = Session.getInstance(p);
//			Message msg = new MimeMessage(session); // ������Ϣ
//
////			msg.setFrom(new InternetAddress("lcims@lccert.com")); // ������
////			msg.setFrom(new InternetAddress("service@lccert.com")); // ������
//			msg.setFrom(new InternetAddress("LCIMS@LCCERT.COM")); // ������
//
//			String toList = getMailList(email.getTo());
//			new InternetAddress();
//			InternetAddress[] iaToList = InternetAddress.parse(toList);
//
//			msg.setRecipients(Message.RecipientType.TO, iaToList); // �ռ���
//
//			msg.setSentDate(new Date()); // ��������
//			//BASE64Encoder enc = new BASE64Encoder();
//			String subject = email.getHead();
//			msg.setSubject(MimeUtility.encodeText(subject,"GBK","B"));
//			//String subject = new String(email.getHead().getBytes("GB18030"),Charset.defaultCharset());
//			//msg.setSubject("=?GBK?B?" + enc.encode(subject.getBytes("GBK")) + "?="); // ����
//			//msg.setSubject(subject);
//			msg.setContent(email.getContent(), "text/html;charset=GBK");// ����
//			//��Ӹ���
//			List attachmentsList =email.getAttachmentsList();
//			//�������������������ֵ�����ʼ�����Ӹ����ķ���
//			if(attachmentsList.size()>0){
//				
//				/**		 * �÷�����������MimeMessage������ʼ���		 */		
//				MimeMultipart allMultipart = new MimeMultipart("mixed");	
//				 for (int i = 0; i < email.getAttachmentsList().size(); i++) {
//		        	 System.out.println("��ʾ���ҽ��:"+email.getAttachmentsList().get(i));//��ʾ���ҽ���� 
//		        	 //email.getAttachmentsList().get(i).toString()·��
//						MimeBodyPart attachPart = createAttachment(email.getAttachmentsList().get(i).toString());				
//						allMultipart.addBodyPart(attachPart);		
//		         }
//				msg.setContent(allMultipart);		
//				msg.saveChanges();		
//			}
//			// �ʼ�������������֤
//			Transport tran = session.getTransport("smtp");
//			//tran.connect("61.151.239.132", "lcims@lccert.com", "12345678");
////			tran.connect("smtp2.lccert.com", "lcims@lccert.com", "22833366lc");
//			tran.connect("smtp.lccert.com", "lcims@lccert.com", "22833399lc");
//			//p.put("mail.smtp.host", );
//			// easonchen@lccert.com���û�����123456������
//			tran.sendMessage(msg, msg.getAllRecipients()); // ����
//			//System.out.println("�ʼ����ͳɹ�");
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
//
//	public static MimeBodyPart createAttachment(String filename) throws Exception{				
//		MimeBodyPart attachPart = new MimeBodyPart();		
//		FileDataSource fds = new FileDataSource(filename);		
//		attachPart.setDataHandler(new DataHandler(fds));		
//		attachPart.setFileName(fds.getName());				
//		return attachPart;	
//		}
//	
//	public static void main(String[] args) {
//		List toList =new ArrayList();
//		toList.add("tangzp@lccert.com");
////	    toList.add(mail.substring(1, mail.length()-1));
//	    //toList.add("service@lccert.com");
//		String head ="ǰ̨�мĸ���Ŀ��)";
//		String content="ǰ̨����Ŀ�ݡ�<br>��ݱ��Ϊ��";
//		new SendEmail().sendEmailPublic(toList,head,content);
//	}
//	/**
//	 * ��ʽ���ռ���
//	 * @param mailArray
//	 * @return
//	 */
//	private static String getMailList(List<String> mailArray) {
//
//		StringBuffer toList = new StringBuffer();
//		int length = mailArray.size();
//		if (mailArray != null && length < 2) {
//			toList.append(mailArray.get(0));
//		} else {
//			for (int i = 0; i < length; i++) {
//				toList.append(mailArray.get(i));
//				if (i != (length - 1)) {
//					toList.append(",");
//				}
//
//			}
//		}
//		return toList.toString();
//
//	}
//
//}
