package com.lccert.crm.system;
/***
 * 公告信息的实体类
 * @author tangzp
 *
 */
public class Category {
	private int id;    //公告的id
	private String name ;   //公告类别名称
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

}
