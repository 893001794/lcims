package com.lccert.crm.project;

import java.util.Date;
import java.util.List;

/**
 * 化学项目实体类
 * @author Eason
 *
 */
public class ChemProject {
	private String sales;
	private String pid ;
	private String rid ;
	private String client;
	private String sid ;
	//报告应出时间
	private Date rptime;
	//报告客户
	private String rpclient;
	//报告完成时间
	private Date endtime;
	//报告完成人
	private String enduser;
	//报告发出时间
	private Date sendtime;
	//报告发出人
	private String senduser;
	//报告类型
	private String rptype;
	//项目预警
	private String warning;
	//申请表补充信息
	private String appform;
	//流转单数量
	private int flowcount;
	//样品名称
	private String samplename;
	//样品描述
	private String sampledesc;
	//样品数量
	private String samplecount;
	//客户联系人
	private String contact;
	//项目工程师
	private String engineer;
	//项目工分
	private String workpoint;
	//项目是否结束
	private String projectend;
	//项目状态
	private String status;
	//项目排单人
	private String createname;
	//项目排单时间
	private Date createtime;
	//报告是否完成
	private String isfinish;
	//
	private String addnotes;
	//实验室时间
	private List<ChemLabTime> list;
	//客服人员
	private String servname;
	//是否初检完成
	private String ischecked;
	//项目状态ID
	private int istatus;
	//散单、食品、成品
	private String item;
	//附件地址
	private String filepath;
	
	private Date masendtime;
	
	private String ismethod;
	private String clientE;
	
	private Date rpconfirmtime; 		    //报告审核时间
	private Date nucopletintime;	  		//报告审核时间
	private String rpconfirmuser;	  		//报告审核人
	private String nucopletinuser;	    	//报告填数人
	private Object obj;
	private String draft;     //草稿版
	private String paystatus; // 是否已经收齐款
	private String pay; //付款方式；
	private Date drafsinishtime;  //草稿完成时间
	private String granttime; //电子档发送时间
	private String filingNo; //备案编号(化妆品用了定义报告号用)
	private Integer comappid; //化妆品申请表
	
	public String getPaystatus() {
		return paystatus;
	}
	public void setPaystatus(String paystatus) {
		this.paystatus = paystatus;
	}
	public String getPay() {
		return pay;
	}
	public void setPay(String pay) {
		this.pay = pay;
	}
	public String getDraft() {
		return draft;
	}
	public void setDraft(String draft) {
		this.draft = draft;
	}
	public Date getMasendtime() {
		return masendtime;
	}
	public void setMasendtime(Date masendtime) {
		this.masendtime = masendtime;
	}
	public String getIsmethod() {
		return ismethod;
	}
	public void setIsmethod(String ismethod) {
		this.ismethod = ismethod;
	}
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public int getIstatus() {
		return istatus;
	}
	public void setIstatus(int istatus) {
		this.istatus = istatus;
	}
	public String getIschecked() {
		return ischecked;
	}
	public void setIschecked(String ischecked) {
		this.ischecked = ischecked;
	}
	public String getServname() {
		return servname;
	}
	public void setServname(String servname) {
		this.servname = servname;
	}
	public String getAddnotes() {
		return addnotes;
	}
	public void setAddnotes(String addnotes) {
		this.addnotes = addnotes;
	}
	public Date getRptime() {
		return rptime;
	}
	public void setRptime(Date rptime) {
		this.rptime = rptime;
	}
	public String getRpclient() {
		return rpclient;
	}
	public void setRpclient(String rpclient) {
		this.rpclient = rpclient;
	}
	public Date getEndtime() {
		return endtime;
	}
	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}
	public String getEnduser() {
		return enduser;
	}
	public void setEnduser(String enduser) {
		this.enduser = enduser;
	}
	public Date getSendtime() {
		return sendtime;
	}
	public void setSendtime(Date sendtime) {
		this.sendtime = sendtime;
	}
	public String getSenduser() {
		return senduser;
	}
	public void setSenduser(String senduser) {
		this.senduser = senduser;
	}
	public String getRptype() {
		return rptype;
	}
	public void setRptype(String rptype) {
		this.rptype = rptype;
	}
	public String getWarning() {
		return warning;
	}
	public void setWarning(String warning) {
		this.warning = warning;
	}
	public String getAppform() {
		return appform;
	}
	public void setAppform(String appform) {
		this.appform = appform;
	}
	public int getFlowcount() {
		return flowcount;
	}
	public void setFlowcount(int flowcount) {
		this.flowcount = flowcount;
	}
	public String getSamplename() {
		return samplename;
	}
	public void setSamplename(String samplename) {
		this.samplename = samplename;
	}
	public String getSampledesc() {
		return sampledesc;
	}
	public void setSampledesc(String sampledesc) {
		this.sampledesc = sampledesc;
	}
	public String getSamplecount() {
		return samplecount;
	}
	public void setSamplecount(String samplecount) {
		this.samplecount = samplecount;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getEngineer() {
		return engineer;
	}
	public void setEngineer(String engineer) {
		this.engineer = engineer;
	}
	public String getWorkpoint() {
		return workpoint;
	}
	public void setWorkpoint(String workpoint) {
		this.workpoint = workpoint;
	}
	public String getProjectend() {
		return projectend;
	}
	public void setProjectend(String projectend) {
		this.projectend = projectend;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCreatename() {
		return createname;
	}
	public void setCreatename(String createname) {
		this.createname = createname;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public String getIsfinish() {
		return isfinish;
	}
	public void setIsfinish(String isfinish) {
		this.isfinish = isfinish;
	}
	public List<ChemLabTime> getList() {
		return list;
	}
	public void setList(List<ChemLabTime> list) {
		this.list = list;
	}
	public String getClientE() {
		return clientE;
	}
	public void setClientE(String clientE) {
		this.clientE = clientE;
	}

	public String getNucopletinuser() {
		return nucopletinuser;
	}
	public void setNucopletinuser(String nucopletinuser) {
		this.nucopletinuser = nucopletinuser;
	}
	public Date getRpconfirmtime() {
		return rpconfirmtime;
	}
	public void setRpconfirmtime(Date rpconfirmtime) {
		this.rpconfirmtime = rpconfirmtime;
	}
	public Date getNucopletintime() {
		return nucopletintime;
	}
	public void setNucopletintime(Date nucopletintime) {
		this.nucopletintime = nucopletintime;
	}
	public String getRpconfirmuser() {
		return rpconfirmuser;
	}
	public void setRpconfirmuser(String rpconfirmuser) {
		this.rpconfirmuser = rpconfirmuser;
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
	public String getSales() {
		return sales;
	}
	public void setSales(String sales) {
		this.sales = sales;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public Object getObj() {
		return obj;
	}
	public void setObj(Object obj) {
		this.obj = obj;
	}
	public Date getDrafsinishtime() {
		return drafsinishtime;
	}
	public void setDrafsinishtime(Date drafsinishtime) {
		this.drafsinishtime = drafsinishtime;
	}
	public String getGranttime() {
		return granttime;
	}
	public void setGranttime(String granttime) {
		this.granttime = granttime;
	}
	public String getFilingNo() {
		return filingNo;
	}
	public void setFilingNo(String filingNo) {
		this.filingNo = filingNo;
	}
	public Integer getComappid() {
		return comappid;
	}
	public void setComappid(Integer comappid) {
		this.comappid = comappid;
	}
	

}
