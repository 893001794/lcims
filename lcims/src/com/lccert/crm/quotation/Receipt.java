package com.lccert.crm.quotation;

import java.util.Date;

/**
 * 收据bean
 * @author LC
 *
 */
public class Receipt {
	private String id ; //收据id 
	private String receiptNo ; //收据编号
	private String pid ;  // 报价单编号
	private String  client ; //开发票的客户
	private String content ; //开发票的内容
	private Date createtime ;// 开发票的时间
	private float preadvance ; //开发票的金额
	private String receiptpeople ; //开发票的人员
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
