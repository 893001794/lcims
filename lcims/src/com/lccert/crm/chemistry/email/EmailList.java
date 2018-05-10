package com.lccert.crm.chemistry.email;

import java.util.List;

/**
 * email信息实体类
 * 保存email的收件人信息、主题、内容
 * @author Eason
 *
 */
public class EmailList {
	private List<String> to; //收邮件的人
	private String sender ; //发件人
	
	private String head;//邮件标题
	
	private String content; //邮件内容
	
	private List attachmentsList; //附件
	
	
	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public List getAttachmentsList() {
		return attachmentsList;
	}

	public void setAttachmentsList(List attachmentsList) {
		this.attachmentsList = attachmentsList;
	}

	public List<String> getTo() {
		return to;
	}

	public void setTo(List<String> to) {
		this.to = to;
	}

	public String getHead() {
		return head;
	}

	public void setHead(String head) {
		this.head = head;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
}
