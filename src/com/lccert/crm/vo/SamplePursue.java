package com.lccert.crm.vo;

import java.util.Date;

/**
 * ��Ʒ�Ľ�/����¼��
 * @author tangzp
 *
 */
public class SamplePursue {
	private int id;
	private String sNo; //��Ʒ���
	private Date outDatetime; //����ʱ��
	private Date inDatetime; //���ʱ��
	private String operator ; //������
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
