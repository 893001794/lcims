package com.lccert.crm.vo;
/***
 * 工程部第三级项目测试要求实体类
 * @author tangzp
 *
 */
public class TestChildParent {
	private String childName;  //测试项目要求的名称
	private String parentName ;  //关联的父类名称
	private int parentId ;  //父类的id 
	private int id ;   //主键
	private String type ;   //测试要求的类别
	private String status;  //是否有效
	public String getChildName() {
		return childName;
	}
	public void setChildName(String childName) {
		this.childName = childName;
	}
	public String getParentName() {
		return parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getParentId() {
		return parentId;
	}
	public void setParentId(int parentId) {
		this.parentId = parentId;
	}

}
