package com.lccert.crm.vo;


/**
 * 流转单测试大项bean
 * @author tangzp
 *
 */
public class FlowTestStatus {
	private int id ; //支出id 
	private String fidTestNo ; //流转单测试大项的编号
	private String tester ; //测试人员
	private String barCode ; //条码
	private String department ; //科室
	private Integer status ; //状态(0:没有锁，1:锁)
	private String barCodeTime ; //条码打时间
	private String vfidtestname; //流转单大项测试
	public String getFidTestNo() {
		return fidTestNo;
	}
	public void setFidTestNo(String fidTestNo) {
		this.fidTestNo = fidTestNo;
	}
	public String getTester() {
		return tester;
	}
	public void setTester(String tester) {
		this.tester = tester;
	}
	public String getBarCode() {
		return barCode;
	}
	public void setBarCode(String barCode) {
		this.barCode = barCode;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getBarCodeTime() {
		return barCodeTime;
	}
	public void setBarCodeTime(String barCodeTime) {
		this.barCodeTime = barCodeTime;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getVfidtestname() {
		return vfidtestname;
	}
	public void setVfidtestname(String vfidtestname) {
		this.vfidtestname = vfidtestname;
	}
	

}
