package com.lccert.crm.vo;
/***
 * 包裹实体bean
 * @author Administrator
 *
 */
public class SamplePackage {
	private int id ; //包裹id
	private String pno; //包裹编号
	private String pid;  //报价单号
	private String sid ;  //项目号
	private String packageName;	//托运物品
	private String client;  //邮寄公司
	private String dreceipt; //接受时间
	private String reciptent;  //接受人
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPno() {
		return pno;
	}
	public void setPno(String pno) {
		this.pno = pno;
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
	public String getPackageName() {
		return packageName;
	}
	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getDreceipt() {
		return dreceipt;
	}
	public void setDreceipt(String dreceipt) {
		this.dreceipt = dreceipt;
	}
	public String getReciptent() {
		return reciptent;
	}
	public void setReciptent(String reciptent) {
		this.reciptent = reciptent;
	}
	
	
}
