package com.lccert.crm.chemistry.email;

import java.util.List;

/**
 * email��Ϣʵ����
 * ����email���ռ�����Ϣ�����⡢����
 * @author Eason
 *
 */
public class EmailList {
	private List<String> to; //���ʼ�����
	private String sender ; //������
	
	private String head;//�ʼ�����
	
	private String content; //�ʼ�����
	
	private List attachmentsList; //����
	
	
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
