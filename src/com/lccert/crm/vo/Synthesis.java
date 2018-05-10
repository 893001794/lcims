package com.lccert.crm.vo;

import java.util.Date;

/**
 * 获取综合信息（综合包括迟单率，报告编号正确率统计）
 * @author tangzp
 *
 */
public class Synthesis {
	private int id ;
	private String sid;  //项目编号
	private String rid ; //报告编号
	private String pid ;  //报价单号
	private Date rptime ; //应出报告时间
	private Date sendtime ; //报告实际完成时间
	private Date createtime ; //排单时间
	private String level;   //项目等级
	private String testcontent; //测试项目
	private String servname ; //客服人员
	private String engineer ; //工程师
	private String status; //状态
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getTestcontent() {
		return testcontent;
	}
	public void setTestcontent(String testcontent) {
		this.testcontent = testcontent;
	}
	public String getServname() {
		return servname;
	}
	public void setServname(String servname) {
		this.servname = servname;
	}
	public String getEngineer() {
		return engineer;
	}
	public void setEngineer(String engineer) {
		this.engineer = engineer;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getRptime() {
		return rptime;
	}
	public void setRptime(Date rptime) {
		this.rptime = rptime;
	}

	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public Date getSendtime() {
		return sendtime;
	}
	public void setSendtime(Date sendtime) {
		this.sendtime = sendtime;
	}
	

}
