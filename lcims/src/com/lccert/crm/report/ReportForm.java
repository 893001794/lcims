package com.lccert.crm.report;

/**
 * 报告模板实体类
 * @author Eason
 *
 */
public class ReportForm {
	
	private int id;
	private String reportid;
	private String testcontent;
	private String testmethod;
	private String category;
	private String lan;
	private int fileid;
	public int getFileid() {
		return fileid;
	}
	public void setFileid(int fileid) {
		this.fileid = fileid;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getReportid() {
		return reportid;
	}
	public void setReportid(String reportid) {
		this.reportid = reportid;
	}
	public String getTestcontent() {
		return testcontent;
	}
	public void setTestcontent(String testcontent) {
		this.testcontent = testcontent;
	}
	public String getTestmethod() {
		return testmethod;
	}
	public void setTestmethod(String testmethod) {
		this.testmethod = testmethod;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getLan() {
		return lan;
	}
	public void setLan(String lan) {
		this.lan = lan;
	}

}
