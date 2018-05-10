package com.lccert.crm.flow;

import java.util.Date;

/**
 * 流转单实体类
 * @author Eason
 *
 */
public class Flow {

	private String fid;
	
	private String sid;

	private String pid;

	private String rid;
	
	private String level;

	private String flowtype;

	private String lab;

	private Date pdtime;

	private String pduser;

	private String testparent;

	private String testchild;

	private int testcount;

	private String notes;

	private String retest;
	
	private String vworkpoint;
	
	private String vworkpoint2;
	
	private int status;
	
	private String testplanC; //中文的测试方法
	private String testplanE;//英文的测试方法
	private String describe ; //描述
	private String cnastatus ;  //是否添加CNAS章
	private String standard;    //安规的测试标准
	private String addsamples; //是退样
	private int security; //防伪码
	public String getFid() {
		return fid;
	}
	public void setFid(String fid) {
		this.fid = fid;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getFlowtype() {
		return flowtype;
	}
	public void setFlowtype(String flowtype) {
		this.flowtype = flowtype;
	}
	public String getLab() {
		return lab;
	}
	public void setLab(String lab) {
		this.lab = lab;
	}
	public Date getPdtime() {
		return pdtime;
	}
	public void setPdtime(Date pdtime) {
		this.pdtime = pdtime;
	}
	public String getPduser() {
		return pduser;
	}
	public void setPduser(String pduser) {
		this.pduser = pduser;
	}
	public String getTestparent() {
		return testparent;
	}
	public void setTestparent(String testparent) {
		this.testparent = testparent;
	}
	public String getTestchild() {
		return testchild;
	}
	public void setTestchild(String testchild) {
		this.testchild = testchild;
	}
	public int getTestcount() {
		return testcount;
	}
	public void setTestcount(int testcount) {
		this.testcount = testcount;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
	public String getRetest() {
		return retest;
	}
	public void setRetest(String retest) {
		this.retest = retest;
	}
	public String getVworkpoint() {
		return vworkpoint;
	}
	public void setVworkpoint(String vworkpoint) {
		this.vworkpoint = vworkpoint;
	}
	public String getVworkpoint2() {
		return vworkpoint2;
	}
	public void setVworkpoint2(String vworkpoint2) {
		this.vworkpoint2 = vworkpoint2;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getTestplanC() {
		return testplanC;
	}
	public void setTestplanC(String testplanC) {
		this.testplanC = testplanC;
	}
	public String getTestplanE() {
		return testplanE;
	}
	public void setTestplanE(String testplanE) {
		this.testplanE = testplanE;
	}
	public String getDescribe() {
		return describe;
	}
	public void setDescribe(String describe) {
		this.describe = describe;
	}
	public String getCnastatus() {
		return cnastatus;
	}
	public void setCnastatus(String cnastatus) {
		this.cnastatus = cnastatus;
	}
	public String getStandard() {
		return standard;
	}
	public void setStandard(String standard) {
		this.standard = standard;
	}
	public String getAddsamples() {
		return addsamples;
	}
	public void setAddsamples(String addsamples) {
		this.addsamples = addsamples;
	}
	public int getSecurity() {
		return security;
	}
	public void setSecurity(int security) {
		this.security = security;
	}
	

	


	

}
