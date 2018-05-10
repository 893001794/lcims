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
import com.lccert.crm.project.ChemLabTime;
import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.ChemProjectAction;
import com.lccert.crm.quotation.QuotationAction;
/***
 * 提前2小时的应出报告预警
 * @author tangzp
 *
 */
public class SendWarning extends TimerTask {

	@Override
	public void run() {
		sendProject();
	}

	
	/**
	 * 通过email方式发送迟单项目
	 */
	private void sendProject() {
		List<String> to = new ArrayList<String>();
		List list = ChemProjectAction.getInstance().getSedWarning();
		to.add("luozh@lccert.com");
		to.add("jinyl@lccert.com");
		to.add("hadixia@lccert.com");
		to.add("polinlin@lccert.com");
		to.add("wuji@lccert.com");
		to.add("chaifen@lccert.com");
		to.add("pinkli@lccert.com");
		String head = "[提前2小时的应出报告预警]";
		StringBuffer content = new StringBuffer("[2小时候要出的报告预警信息]<br>");
		content.append("预警详细信息：<br><br><br>");
	    content.append("<br>系统时间:" +new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
			for(int j=0;j<list.size();j++){
				ChemProject cp = (ChemProject) list.get(j);
				ChemLabTime clt =(ChemLabTime)cp.getObj();
				content.append("<br>报价单号:" + cp.getPid());
				content.append("<br>报告号:" + cp.getRid());
				content.append("<br>客户名称:"+ QuotationAction.getInstance().getQuotationByPid(
								cp.getPid()).getClient());
				content.append("<br>应出报告时间:" + cp.getRptime()==null?"":cp.getRptime());
				if(clt !=null&&!"".equals(clt)){
					content.append("<br>该项目现时状态为："+clt.getStatus()==null?"":clt.getStatus());
					content.append("<br>项目状态时间："+clt.getTime()==null?"":clt.getTime());
				}
				content.append("<br>---------------------------------------<br>");
			}
		content.append("<br>请尽快处理以上报告，不然将造成迟单！！！" );
		content.append("<br><br>本信息由立创检测LCIMS系统自动发送，请勿回复本邮件。");
		content.append("<br>如有疑问，请联系系统管理员。");
//		content.append("<br><br>立创检测<br>日期:"+ new SimpleDateFormat("yyyy-MM-dd").format(new Date(new Date().getTime()+28800000)));
		content.append("<br><br>立创检测<br>日期:"+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		if(list.size()>0){
			send(to, head, content.toString());
		}
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
			// 建立会话
			Session session = Session.getInstance(p);
			Message msg = new MimeMessage(session); // 建立信息

			msg.setFrom(new InternetAddress("lcims@lccert.com")); // 发件人

			String toList = getMailList(to);
			new InternetAddress();
			InternetAddress[] iaToList = InternetAddress.parse(toList);
			msg.setRecipients(Message.RecipientType.TO, iaToList); // 收件人
			msg.setSentDate(new Date());
			String subject = head;
			msg.setSubject(MimeUtility.encodeText(subject, "GBK", "B"));
			msg.setContent(content, "text/html;charset=GBK");// 内容
			// 邮件服务器进行验证
			tran = session.getTransport("smtp");
		//	tran.connect("61.151.239.132", "lcims@lccert.com", "12345678");
			tran.connect("smtp.lccert.com", "lcims@lccert.com", "Qq789456123");
			// easonchen@lccert.com是用户名，123456是密码
			tran.sendMessage(msg, msg.getAllRecipients()); // 发送
			System.out.println("邮件发送成功");
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
