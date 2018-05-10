package com.lccert.crm.client;

import java.util.Date;

/**
 * 客户信息实体类
 * @author Eason
 *
 */
public class ClientForm {
	
	private int id;

	private String clientid;
	
	private String password;

	private String name;

	private String shortname;

	private String ename;

	private ContactForm contact;

	private String product;

	private String clevel;

	private String creditlevel;

	private String pay;

	private String addr;

	private String eaddr;

	private String zipcode;

	private String area;

	private int salesid;

	private Date createtime;

	private String status;
	
	private String sales;
	private int contactid;
	
	private int applicant ; //申请人
	
	private Date dperformance ;  //统计业绩的基
	
	
	public Date getDperformance() {
		return dperformance;
	}

	public void setDperformance(Date dperformance) {
		this.dperformance = dperformance;
	}

	public String getSales() {
		return sales;
	}

	public void setSales(String sales) {
		this.sales = sales;
	}


	
	public int getApplicant() {
		return applicant;
	}

	public void setApplicant(int applicant) {
		this.applicant = applicant;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getSalesid() {
		return salesid;
	}

	public void setSalesid(int salesid) {
		this.salesid = salesid;
	}

	public String getShortname() {
		return shortname;
	}

	public void setShortname(String shortname) {
		this.shortname = shortname;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public ContactForm getContact() {
		return contact;
	}

	public void setContact(ContactForm contact) {
		this.contact = contact;
	}

	public String getClientid() {
		return clientid;
	}

	public void setClientid(String clientid) {
		this.clientid = clientid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEname() {
		return ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public String getClevel() {
		return clevel;
	}

	public void setClevel(String clevel) {
		this.clevel = clevel;
	}

	public String getCreditlevel() {
		return creditlevel;
	}

	public void setCreditlevel(String creditlevel) {
		this.creditlevel = creditlevel;
	}

	public String getPay() {
		return pay;
	}

	public void setPay(String pay) {
		this.pay = pay;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getEaddr() {
		return eaddr;
	}

	public void setEaddr(String eaddr) {
		this.eaddr = eaddr;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}


	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getContactid() {
		return contactid;
	}

	public void setContactid(int contactid) {
		this.contactid = contactid;
	}

}
