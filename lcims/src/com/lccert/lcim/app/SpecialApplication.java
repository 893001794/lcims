package com.lccert.lcim.app;

import java.util.Date;
/***
 * 特殊请款的实体类
 * @author tangzp
 *
 */
public class SpecialApplication {
	
	private int id;
	
	private String speappid;
	
	private String content;
	
	private float price;
	
	private float taxpoint;
	
	private float paycount;
	
	private String adduser;
	
	private Date addtime;
	
	private String auditman;
	
	private Date audittime;
	
	private String isaudit;
	
	private String payman;
	
	private Date paytime;
	
	private String notes;

	public String getIsaudit() {
		return isaudit;
	}

	public void setIsaudit(String isaudit) {
		this.isaudit = isaudit;
	}

	public String getAdduser() {
		return adduser;
	}

	public void setAdduser(String adduser) {
		this.adduser = adduser;
	}

	public Date getAddtime() {
		return addtime;
	}

	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getSpeappid() {
		return speappid;
	}

	public void setSpeappid(String speappid) {
		this.speappid = speappid;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public float getTaxpoint() {
		return taxpoint;
	}

	public void setTaxpoint(float taxpoint) {
		this.taxpoint = taxpoint;
	}

	public float getPaycount() {
		return paycount;
	}

	public void setPaycount(float paycount) {
		this.paycount = paycount;
	}

	public String getAuditman() {
		return auditman;
	}

	public void setAuditman(String auditman) {
		this.auditman = auditman;
	}

	public Date getAudittime() {
		return audittime;
	}

	public void setAudittime(Date audittime) {
		this.audittime = audittime;
	}

	public String getPayman() {
		return payman;
	}

	public void setPayman(String payman) {
		this.payman = payman;
	}

	public Date getPaytime() {
		return paytime;
	}

	public void setPaytime(Date paytime) {
		this.paytime = paytime;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

}
