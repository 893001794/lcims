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
 * 报告发出但是还没有收款的预警
 * 
 * @author tangzp
 * 
 */
public class IssueRPNoPayTask extends TimerTask {
	public void run() {
		System.out.println("开始发送迟单项目..."); // 开始任务
		sendProject();
		System.out.println("发送迟单项目完成..."); // 任务完成
	}

	/**
	 * 通过email方式发送迟单项目
	 */
	private void sendProject() {
		//Date date = new Date();
		//String start = new SimpleDateFormat("yyyy-MM-dd 00:00:00").format(date);
		//String end = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
		List<String> to = new ArrayList<String>();
		//查询所有的发出报告，并且是未付清款得所有客户的报告信息
		PageModel pm =ChemProjectAction.getInstance().searchIssueRPNoPay(0,0,"","","");
		List list=pm.getList();
		//接收该邮件的人员
		to.add("luozh@lccert.com");
		to.add("hadixia@lccert.com");
//		to.add("amyyang@lccert.com");
		to.add("john@lccert.com");
		to.add("clf@lccert.com");
		to.add("huangyh@lccert.com");
		to.add("service@lccert.com");
		to.add("tangzp@lccert.com");
		String head = "[报告已经发放超15天，但是欠款还没有付清，ims发出提醒催款的预警]";
		StringBuffer content = new StringBuffer("[当天催款提醒信息]<br>");
		for(int i=0;i<list.size();i++){
			//根据报价单获取客户信息
			ChemProject cp =(ChemProject)list.get(i);
			Quotation qt =(Quotation)cp.getObj();
			ClientForm cf=ClientAction.getInstance().getClientByName(qt.getClient());
			//当不存在该客户是就创建一个对象
			String payStatus="";
			if(cf == null ){
			cf=new ClientForm();
			}
			//当此客户的付款方式等于"月结"的时候
			if(cf.getPay().equals("月结")){
			//根据该报价单获取该报价单上个月的最后一款报价单是否付款
			payStatus=QuotationAction.getInstance().getPayStatusByTime(qt.getClient());
			}else if(cf.getPay() !=null && !"".equals(cf.getPay())){
			//直接获取但前报价单是否付款完成
			payStatus=qt.getPaystatus();
			}
			//如果该客户的报告已经发了出去，但是欠款还没有付清款则发邮箱警告
			if("n".equals(payStatus)){
				//发送报告的时间+15天是否<=系统，则就发邮箱警告
					content.append("报价单号:" + cp.getPid());
					content.append("<br>报告号:" + cp.getRid());
					content.append("<br>客户名称:"+qt.getClient());
					content.append("<br>报告发出时间:"+cp.getSendtime());
					content.append("<br>最迟回款时间:"+cp.getEndtime());
					content.append("<br>客户付款类型:"+cf.getPay());
					content.append("<br>---------------------------------------<br>");
				}
			
		}
		content.append("<br><br>以上的项目都是报告已经发出超15天，但是还没有收回欠款的，请相关销售尽快催款！！");
		content.append("<br><br>本信息由立创检测LCIMS系统自动发送，请勿回复本邮件。");
		content.append("<br>如有疑问，请联系系统管理员。");
		content.append("<br><br>立创检测<br>日期:"
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
