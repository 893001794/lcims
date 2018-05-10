package com.lccert.crm.vo;
/***
 * 工程部测试方法的实体类
 * @author tangzp
 *
 */
public class TestPlan {
	private int id ;
	private String parentName;   //测试项目名称
	private String childName;    //测试要求名称
	private String planName;    //测试方法的名称
	private int childId ;  //测试要求 的id
	private String status ;   //是否有效
	private String describe1C  ; //测试项目的中文描述
	private String describe2C;   //测试要求的中文描述
	private String describe3C;   //测试方法的中文描述
	private String describe1E;   //测试项目英文的描述
	private String describe2E;   //测试要求英文的描述
	private String describe3E;   //测试方法英文的描述
	private String cnastatus ;  //是否带CNAS章
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getParentName() {
		return parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	public String getChildName() {
		return childName;
	}
	public void setChildName(String childName) {
		this.childName = childName;
	}
	public String getPlanName() {
		return planName;
	}
	public void setPlanName(String planName) {
		this.planName = planName;
	}
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getDescribe1C() {
		return describe1C;
	}
	public void setDescribe1C(String describe1C) {
		this.describe1C = describe1C;
	}
	public String getDescribe2C() {
		return describe2C;
	}
	public void setDescribe2C(String describe2C) {
		this.describe2C = describe2C;
	}
	public String getDescribe3C() {
		return describe3C;
	}
	public void setDescribe3C(String describe3C) {
		this.describe3C = describe3C;
	}
	public String getDescribe1E() {
		return describe1E;
	}
	public void setDescribe1E(String describe1E) {
		this.describe1E = describe1E;
	}
	public String getDescribe2E() {
		return describe2E;
	}
	public void setDescribe2E(String describe2E) {
		this.describe2E = describe2E;
	}
	public String getDescribe3E() {
		return describe3E;
	}
	public void setDescribe3E(String describe3E) {
		this.describe3E = describe3E;
	}
	public int getChildId() {
		return childId;
	}
	public void setChildId(int childId) {
		this.childId = childId;
	}
	public String getCnastatus() {
		return cnastatus;
	}
	public void setCnastatus(String cnastatus) {
		this.cnastatus = cnastatus;
	}
	

}
