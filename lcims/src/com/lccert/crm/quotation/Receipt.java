package com.lccert.crm.quotation;

import java.util.Date;

/**
 * �վ�bean
 * @author LC
 *
 */
public class Receipt {
	private String id ; //�վ�id 
	private String receiptNo ; //�վݱ��
	private String pid ;  // ���۵����
	private String  client ; //����Ʊ�Ŀͻ�
	private String content ; //����Ʊ������
	private Date createtime ;// ����Ʊ��ʱ��
	private float preadvance ; //����Ʊ�Ľ��
	private String receiptpeople ; //����Ʊ����Ա
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getReceiptNo() {
		return receiptNo;
	}
	public void setReceiptNo(String receiptNo) {
		this.receiptNo = receiptNo;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public float getPreadvance() {
		return preadvance;
	}
	public void setPreadvance(float preadvance) {
		this.preadvance = preadvance;
	}
	public String getReceiptpeople() {
		return receiptpeople;
	}
	public void setReceiptpeople(String receiptpeople) {
		this.receiptpeople = receiptpeople;
	}
	

}
