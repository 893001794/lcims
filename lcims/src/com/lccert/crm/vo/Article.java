package com.lccert.crm.vo;
/**
 * ��Ʒ�Ǽ�bean
 * @author tangzp
 *
 */
public class Article {
	private int id ; //��Ʒid 
	private String name ; // ��Ʒ����
	private int parentid ; //�����id
	
	
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
