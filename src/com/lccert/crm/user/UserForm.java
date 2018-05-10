package com.lccert.crm.user;

/**
 * 用户信息实体类
 * @author Eason
 *
 */
public class UserForm {
	
	private int id;

	private String userid;

	private String name;

	private String password;

	private String sex;

	private String tel;
	
	private String phone;

	private String email;

	private String company;

	private String dept;

	private String job;

	private String popdom;

	private String ticketid;
	
	private String serv;
	
	private String sales;
	
	private int companyid;
	
	private String superiorid;  //上级id
	private String reportStart; //是否有权限生成报告模板
	private String ctsname; //
	private String agree; // 是否有同意将离职销售的客户转给某一个销售跟进
	private String pstatus ; //是否显示价格
	private String latelisttype ; //公告栏中是否显示迟单统计
	private String projecttype ; //是否有权限发送电子档报告给客户
	private String  ynucompletin ; //是否有权限对报告填数
	private String yconfirm ;  //是否有权限对报告审核
	private String isShowFspefund ;  //是否有权限查看接待费
	
	


	public String getYnucompletin() {
		return ynucompletin;
	}

	public void setYnucompletin(String ynucompletin) {
		this.ynucompletin = ynucompletin;
	}

	public String getYconfirm() {
		return yconfirm;
	}

	public void setYconfirm(String yconfirm) {
		this.yconfirm = yconfirm;
	}

	public String getProjecttype() {
		return projecttype;
	}

	public void setProjecttype(String projecttype) {
		this.projecttype = projecttype;
	}
	public String getLatelisttype() {
		return latelisttype;
	}

	public void setLatelisttype(String latelisttype) {
		this.latelisttype = latelisttype;
	}

	public String getPstatus() {
		return pstatus;
	}

	public void setPstatus(String pstatus) {
		this.pstatus = pstatus;
	}

	public String getAgree() {
		return agree;
	}

	public void setAgree(String agree) {
		this.agree = agree;
	}

	public int getCompanyid() {
		return companyid;
	}

	public void setCompanyid(int companyid) {
		this.companyid = companyid;
	}

	public String getSales() {
		return sales;
	}

	public void setSales(String sales) {
		this.sales = sales;
	}

	public String getServ() {
		return serv;
	}

	public void setServ(String serv) {
		this.serv = serv;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTicketid() {
		return ticketid;
	}

	public void setTicketid(String ticketid) {
		this.ticketid = ticketid;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getPopdom() {
		return popdom;
	}

	public void setPopdom(String popdom) {
		this.popdom = popdom;
	}

	public String getSuperiorid() {
		return superiorid;
	}

	public void setSuperiorid(String superiorid) {
		this.superiorid = superiorid;
	}

	public String getReportStart() {
		return reportStart;
	}

	public void setReportStart(String reportStart) {
		this.reportStart = reportStart;
	}

	public String getCtsname() {
		return ctsname;
	}

	public void setCtsname(String ctsname) {
		this.ctsname = ctsname;
	}

	public String getIsShowFspefund() {
		return isShowFspefund;
	}

	public void setIsShowFspefund(String isShowFspefund) {
		this.isShowFspefund = isShowFspefund;
	}

	
}
