package com.lccert.oa.vo;
/***
 * 部门的实体类
 * @author tangzp
 *
 */
public class Group {
	private int GROUP_ID ;  //部门id
	private String GROUP_NAME ; //部门名称
	public int getGROUP_ID() {
		return GROUP_ID;
	}
	public void setGROUP_ID(int group_id) {
		GROUP_ID = group_id;
	}
	public String getGROUP_NAME() {
		return GROUP_NAME;
	}
	public void setGROUP_NAME(String group_name) {
		GROUP_NAME = group_name;
	}

}
