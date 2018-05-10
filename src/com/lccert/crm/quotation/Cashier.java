package com.lccert.crm.quotation;

import java.util.Date;

/***
 * 出纳表
 * @author LC
 *
 */
public class Cashier {
	private int id;
	private String client;   //客户
	private float subtotal ; //小计
	private String creditcard ;  //账号
	private String ui;  //流转号
	private Date createTime ; //日期
	
	
	public String getCreditcard() {
		return creditcard;
	}
	public void setCreditcard(String creditcard) {
		this.creditcard = creditcard;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public float getSubtotal() {
		return subtotal;
	}
	public void setSubtotal(float subtotal) {
		this.subtotal = subtotal;
	}
	public String getUi() {
		return ui;
	}
	public void setUi(String ui) {
		this.ui = ui;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	

}
