package com.lccert.crm.vo;
/**
 * 物品登记bean
 * @author tangzp
 *
 */
public class Article {
	private int id ; //物品id 
	private String name ; // 物品名称
	private int parentid ; //父类的id
	
	
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
	public int getParentid() {
		return parentid;
	}
	public void setParentid(int parentid) {
		this.parentid = parentid;
	}

}
