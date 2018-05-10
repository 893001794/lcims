package com.lccert.crm.vo;

import java.util.Date;

/**
 * 样品的进/入库记录表
 * @author tangzp
 *
 */
public class SamplePursue {
	private int id;
	private String sNo; //样品编号
	private Date outDatetime; //出库时间
	private Date inDatetime; //入库时间
	private String operator ; //操作人
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getsNo() {
		return sNo;
	}
	public void setsNo(String sNo) {
		this.sNo = sNo;
	}
	public Date getOutDatetime() {
		return outDatetime;
	}
	public void setOutDatetime(Date outDatetime) {
		this.outDatetime = outDatetime;
	}
	public Date getInDatetime() {
		return inDatetime;
	}
	public void setInDatetime(Date inDatetime) {
		this.inDatetime = inDatetime;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	
}
