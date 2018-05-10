package com.lccert.crm.vo;
/**
 * 品牌表
 * @author tangzp
 *
 */
public class Category {
	private int id ;  //品牌id 
	private String name ; //品牌名称
	private String cs;  //品牌class
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCs() {
		return cs;
	}
	public void setCs(String cs) {
		this.cs = cs;
	}
}
