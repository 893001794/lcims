package com.lccert.crm.chemistry.email;

import java.util.List;

/**
 * email��Ϣʵ����
 * ����email���ռ�����Ϣ�����⡢����
 * @author Eason
 *
 */
public class Email {
	private List<String> to;
	
	private String head;
	
	private String content;

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
