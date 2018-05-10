package com.lccert.crm.project;

import java.util.Date;
import java.util.List;

/**
 * 安规项目实体类
 * @author Eason
 *
 */
public class PhyProject {
	
	private int id;
	private String pid ;
	private String rid;
	
	private String rptype;
	
	private Date rptime;
	
	private String rpclient;
	
	private String contact;
	
	private String samplename;
	
	private String samplecount;
	
	private String samplecategory;
	
	private String samplemodel;
	
	private String createname;
	
	private Date createtime;
	
	private String beginuser;
	
	private Date begintime;
	
	private String enduser;
	
	private Date endtime;
	
	private String engineer;
	
	private String servname;
	
	private String status;
	
	private int istatus;
	private String Isfinish;
	//实验室时间
	private List<ChemLabTime> list;
	
	private String testStandard;   //测试标准
	//获取额定电压
	private String ratedvoltage;
	//获取额定电流
	private String ratedcurrent;
	//获取额定功率
	private String ratedpower;
	//获取其他
	private String other;
	//获取光源类型
	private String lightsourcetype;


	public int getIstatus() {
		return istatus;
	}

	public void setIstatus(int istatus) {
		this.istatus = istatus;
	}

	public String getBeginuser() {
		return beginuser;
	}

	public void setBeginuser(String beginuser) {
		this.beginuser = beginuser;
	}

	public Date getBegintime() {
		return begintime;
	}

	public void setBegintime(Date begintime) {
		this.begintime = begintime;
	}

	public String getEnduser() {
		return enduser;
	}

	public void setEnduser(String enduser) {
		this.enduser = enduser;
	}

	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getServname() {
		return servname;
	}

	public void setServname(String servname) {
		this.servname = servname;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getRptype() {
		return rptype;
	}

	public void setRptype(String rptype) {
		this.rptype = rptype;
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

	public String getSamplename() {
		return samplename;
	}

	public void setSamplename(String samplename) {
		this.samplename = samplename;
	}

	public String getSamplecount() {
		return samplecount;
	}

	public void setSamplecount(String samplecount) {
		this.samplecount = samplecount;
	}

	public String getSamplecategory() {
		return samplecategory;
	}

	public void setSamplecategory(String samplecategory) {
		this.samplecategory = samplecategory;
	}

	public String getSamplemodel() {
		return samplemodel;
	}

	public void setSamplemodel(String samplemodel) {
		this.samplemodel = samplemodel;
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

	public String getTestStandard() {
		return testStandard;
	}

	public void setTestStandard(String testStandard) {
		this.testStandard = testStandard;
	}

	public String getRatedvoltage() {
		return ratedvoltage;
	}

	public void setRatedvoltage(String ratedvoltage) {
		this.ratedvoltage = ratedvoltage;
	}

	public String getRatedcurrent() {
		return ratedcurrent;
	}

	public void setRatedcurrent(String ratedcurrent) {
		this.ratedcurrent = ratedcurrent;
	}

	public String getRatedpower() {
		return ratedpower;
	}

	public void setRatedpower(String ratedpower) {
		this.ratedpower = ratedpower;
	}

	public String getOther() {
		return other;
	}

	public void setOther(String other) {
		this.other = other;
	}

	public String getLightsourcetype() {
		return lightsourcetype;
	}

	public void setLightsourcetype(String lightsourcetype) {
		this.lightsourcetype = lightsourcetype;
	}

	public List<ChemLabTime> getList() {
		return list;
	}

	public void setList(List<ChemLabTime> list) {
		this.list = list;
	}

	public String getIsfinish() {
		return Isfinish;
	}

	public void setIsfinish(String isfinish) {
		Isfinish = isfinish;
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

}
