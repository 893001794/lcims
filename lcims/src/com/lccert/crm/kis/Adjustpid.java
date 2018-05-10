package com.lccert.crm.kis;
/***
 * 报价单类型除new以外的类型的实体类
 * @author tangzp
 *
 */
public class Adjustpid {
	private String pid ;  //报价单号
	private String rid ;  //报告编号
	private Float fadjustinvcount;  //修改报价单总金额
	private String status ;  //状态(判断是否审核)
	private String equotype ;  //报价单的类型(补充重测、添加报告、冲红报价单 )
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
	public Float getFadjustinvcount() {
		return fadjustinvcount;
	}
	public void setFadjustinvcount(Float fadjustinvcount) {
		this.fadjustinvcount = fadjustinvcount;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getEquotype() {
		return equotype;
	}
	public void setEquotype(String equotype) {
		this.equotype = equotype;
	}

}
