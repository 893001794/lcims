package com.lccert.crm.vo;
/***
 * 测试项目的顶级
 * @author Administrator
 *
 */
public class TopLevel {
	private int id  ; //顶级的id
	private String name ; // 顶级的名称
	private String status ; //判断是否有效
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
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
