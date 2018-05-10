package com.lccert.crm.vo;
/**
 * 
 * @author Administrator
 * 测试项目的大类
 *
 */
public class TestParents {
	private int id ;  //主键
	private String name ;  //测试项目名称
	private String type ;  //测试项目类别
	private String status ;  //是否有效         
	private String yle ;    //顶级的id
	public String getYle() {
		return yle;
	}
	public void setYle(String yle) {
		this.yle = yle;
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

}
