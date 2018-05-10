package com.lccert.crm.vo;
/**
 * 样品实体bean 
 * @author tangzp
 *
 */
public class Sample {
	private int id ; //样品id
	private String sno; //样品编号
	private String pid ;  //报价单号
	private String sid ;  //项目编号
	private String sampleName; //样品名称
	private String model;   //样品类型
	private String speichorot; //存放位置
	private String operator; //操作人
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSno() {
		return sno;
	}
	public void setSno(String sno) {
		this.sno = sno;
	}
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
	public String getSampleName() {
		return sampleName;
	}
	public void setSampleName(String sampleName) {
		this.sampleName = sampleName;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getSpeichorot() {
		return speichorot;
	}
	public void setSpeichorot(String speichorot) {
		this.speichorot = speichorot;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	
	
}
