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
 * ��ǰ2Сʱ��Ӧ������Ԥ��
 * @author tangzp
 *
 */
public class SendWarning extends TimerTask {

	@Override
	public void run() {
		sendProject();
	}

	
	/**
	 * ͨ��email��ʽ���ͳٵ���Ŀ
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
		String head = "[��ǰ2Сʱ��Ӧ������Ԥ��]";
		StringBuffer content = new StringBuffer("[2Сʱ��Ҫ���ı���Ԥ����Ϣ]<br>");
		content.append("Ԥ����ϸ��Ϣ��<br><br><br>");
	    content.append("<br>ϵͳʱ��:" +new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
			for(int j=0;j<list.size();j++){
				ChemProject cp = (ChemProject) list.get(j);
				ChemLabTime clt =(ChemLabTime)cp.getObj();
				content.append("<br>���۵���:" + cp.getPid());
				content.append("<br>�����:" + cp.getRid());
				content.append("<br>�ͻ�����:"+ QuotationAction.getInstance().getQuotationByPid(
								cp.getPid()).getClient());
				content.append("<br>Ӧ������ʱ��:" + cp.getRptime()==null?"":cp.getRptime());
				if(clt !=null&&!"".equals(clt)){
					content.append("<br>����Ŀ��ʱ״̬Ϊ��"+clt.getStatus()==null?"":clt.getStatus());
					content.append("<br>��Ŀ״̬ʱ�䣺"+clt.getTime()==null?"":clt.getTime());
				}
				content.append("<br>---------------------------------------<br>");
			}
		content.append("<br>�뾡�촦�����ϱ��棬��Ȼ����ɳٵ�������" );
		content.append("<br><br>����Ϣ���������LCIMSϵͳ�Զ����ͣ�����ظ����ʼ���");
		content.append("<br>�������ʣ�����ϵϵͳ����Ա��");
//		content.append("<br><br>�������<br>����:"+ new SimpleDateFormat("yyyy-MM-dd").format(new Date(new Date().getTime()+28800000)));
		content.append("<br><br>�������<br>����:"+ new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
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
			// �����Ự
			Session session = Session.getInstance(p);
			Message msg = new MimeMessage(session); // ������Ϣ

			msg.setFrom(new InternetAddress("lcims@lccert.com")); // ������

			String toList = getMailList(to);
			new InternetAddress();
			InternetAddress[] iaToList = InternetAddress.parse(toList);
			msg.setRecipients(Message.RecipientType.TO, iaToList); // �ռ���
			msg.setSentDate(new Date());
			String subject = head;
			msg.setSubject(MimeUtility.encodeText(subject, "GBK", "B"));
			msg.setContent(content, "text/html;charset=GBK");// ����
			// �ʼ�������������֤
			tran = session.getTransport("smtp");
		//	tran.connect("61.151.239.132", "lcims@lccert.com", "12345678");
			tran.connect("smtp.lccert.com", "lcims@lccert.com", "Qq789456123");
			// easonchen@lccert.com���û�����123456������
			tran.sendMessage(msg, msg.getAllRecipients()); // ����
			System.out.println("�ʼ����ͳɹ�");
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
