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
 * 应出报告时间-系统时间<=30分钟就开始触发邮箱发邮件的的任务
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
		
		String head = "[提前2小时的报告预警]" + new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		StringBuffer content = new StringBuffer("[提前2小时的报告预警]<br>");
		content.append("报告预警详细信息：<br><br><br>");
		content.append("报价单号:" + pid);
		content.append("<br>报告号:" + rid);
		content.append("<br>客户名称:" +client);
		content.append("<br>应出报告时间:" + rptime);
		content.append("<br>报告预警时间为:" + new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
		content.append("<br>---------------------------------------<br>");

	    content.append("<br><br>本信息由立创检测LCIMS系统自动发送，请勿回复本邮件。");
		content.append("<br>如有疑问，请联系系统管理员。");
		content.append("<br><br>立创检测<br>日期:" + new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		send(to, head, content.toString());
//	}
	}
	
	
	/**
	 * 将yyyy-MM-dd HH:mm:ss时间转换成long时间
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
	
	
	
	//定义发送邮件的
	private void send(List<String> to, String head, String content) {
		Transport tran = null;
		try {

			Properties p = new Properties(); // Properties p =
												// System.getProperties();
			p.put("mail.smtp.auth", "true");
			p.put("mail.transport.protocol", "smtp");
			p.put("mail.smtp.host", "61.151.239.132");
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
			//BASE64Encoder enc = new BASE64Encoder();
			String subject = head;
			//String subject = new String(head.getBytes("GB18030"),Charset.defaultCharset());
			//msg.setSubject("=?GBK?B?" + enc.encode(subject.getBytes("GBK")) + "?="); // 主题
			msg.setSubject(MimeUtility.encodeText(subject,"GBK","B"));
			msg.setContent(content, "text/html;charset=GBK");//内容
			// 邮件服务器进行验证
			tran = session.getTransport("smtp");
			tran.connect("61.151.239.132", "lcims@lccert.com", "12345678");
			// easonchen@lccert.com是用户名，123456是密码
			tran.sendMessage(msg, msg.getAllRecipients()); // 发送
			//System.out.println("邮件发送成功");
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
