package com.lccert.crm.chemistry.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.lccert.crm.chemistry.email.Email;
import com.lccert.crm.chemistry.email.EmailList;
import com.lccert.crm.dao.impl.ChemProjectDaoImplMySql;
import com.lccert.crm.project.PhyProject;
import com.lccert.crm.project.Project;
import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.quotation.QuotationAction;

/**
 * 发送邮箱的公共抽象类
 * @author Administrator
 *
 */
public class SendEmail {
	/***
	 * 
	 * @param to 收件人
	 * @param head 标题
	 * @param content 邮件内容
	 * 
	 */
	public synchronized void sendEmailPublic(List to,String head,String content) {
		Email email = new Email();
		email.setTo(to);
		email.setHead(head);
		email.setContent(content);
		SendMail send = new SendMail();
		send.setEmail(email);
		Thread t = new Thread(send);
		t.start();
	}
	/***
	 * 
	 * @param to 收件人
	 * @param head 标题
	 * @param content 邮件内容
	 * @param attachmentsList 附件
	 */
	public synchronized void WithAttachmentsEmail(String senderMail,List to,String head,String content,List attachmentsList) {
		EmailList email = new EmailList();
		email.setSender(senderMail);
		email.setTo(to);
		email.setHead(head);
		email.setContent(content);
		email.setAttachmentsList(attachmentsList);
		AttachmentsMail am = new AttachmentsMail();
		am.setEmailList(email);
		Thread t = new Thread(am);
		t.start();
	}
}
