package com.lccert.crm.vo;

import java.util.Date;


/**
 * 工程化学检测模块
 * @author lcc
 *
 */
public class ProjectChem {
	private Integer Id	;       //主键，自增
	private String pid	;		//报价单号
	private String rid	;		//报告号
	private String projectcontent	;		//测试的项目名称
	private Date completetime	;		//开案时间（创建的时间）
	private Integer estimate	;		//估计测试的点数
	private Integer itestcount	;		//实际要测试的点数
	private Date createtime	;		//第一轮得结果的时间
	private String projectleader	;		//项目负责人
	private String projectissuer	;	//项目审核人
	private String item;		//样品的类型
	private String sid;			//项目编号
	private String rpclient;    //报告的客户
	private String samplename ; //样品的名称
	private String Object;
	private String Object1;
	private String warning;  //项目预警
	
	public String getObject() {
		return Object;
	}
	public void setObject(String object) {
		Object = object;
	}
	public String getRpclient() {
		return rpclient;
	}
	public void setRpclient(String rpclient) {
		this.rpclient = rpclient;
	}
	public String getSamplename() {
		return samplename;
	}
	public void setSamplename(String samplename) {
		this.samplename = samplename;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public Integer getId() {
		return Id;
	}
	public void setId(Integer id) {
		Id = id;
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
	public String getProjectcontent() {
		return projectcontent;
	}
	public void setProjectcontent(String projectcontent) {
		this.projectcontent = projectcontent;
	}
	public Date getCompletetime() {
		return completetime;
	}
	public void setCompletetime(Date completetime) {
		this.completetime = completetime;
	}
	public Integer getEstimate() {
		return estimate;
	}
	public void setEstimate(Integer estimate) {
		this.estimate = estimate;
	}
	public Integer getItestcount() {
		return itestcount;
	}
	public void setItestcount(Integer itestcount) {
		this.itestcount = itestcount;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public String getProjectleader() {
		return projectleader;
	}
	public void setProjectleader(String projectleader) {
		this.projectleader = projectleader;
	}
	public String getProjectissuer() {
		return projectissuer;
	}
	public void setProjectissuer(String projectissuer) {
		this.projectissuer = projectissuer;
	}
	public String getObject1() {
		return Object1;
	}
	public void setObject1(String object1) {
		Object1 = object1;
	}
	public String getWarning() {
		return warning;
	}
	public void setWarning(String warning) {
		this.warning = warning;
	}
	

}
