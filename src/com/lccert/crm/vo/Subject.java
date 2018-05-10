package com.lccert.crm.vo;
/**
 * 财务入账科目
 * @author tangzhouping
 *
 */
public class Subject {
	private Integer id;    //科目id
	private String firstname;   //一级科目名称
	private String secondname;  //二级科目名称
	private String threename ; //三级科目名称
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getFirstname() {
		return firstname;
	}
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	public String getSecondname() {
		return secondname;
	}
	public void setSecondname(String secondname) {
		this.secondname = secondname;
	}
	public String getThreename() {
		return threename;
	}
	public void setThreename(String threename) {
		this.threename = threename;
	}
	
	
}
