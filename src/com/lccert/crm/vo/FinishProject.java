package com.lccert.crm.vo;

import java.util.List;
/***
 * 完成的项目实体类
 * @author tangzp
 *
 */
public class FinishProject {
	
	private String pid;
	
	private String sid;
	
	private String rid;
	
	private String client;
	
	private String rptype;
	
	private float price;
	
	private String paystatus;
	
	private String sales;
	
	private String status;
	
	private List  obj ; // 关联旧的报价单号

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getSid() {
		return sid;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getRptype() {
		return rptype;
	}

	public void setRptype(String rptype) {
		this.rptype = rptype;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public String getPaystatus() {
		return paystatus;
	}

	public void setPaystatus(String paystatus) {
		this.paystatus = paystatus;
	}

	public String getSales() {
		return sales;
	}

	public void setSales(String sales) {
		this.sales = sales;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}


	public List getObj() {
		return obj;
	}

	public void setObj(List obj) {
		this.obj = obj;
	}

}
