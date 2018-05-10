package com.lccert.oa.vo;
/***
 * 客户的实体类
 * @author tangzp
 *
 */
public class Customer {
	private String namefull ; //客户名称
	private String nowman;   // 销售名称  
	public String getNamefull() {
		return namefull;
	}
	public void setNamefull(String namefull) {
		this.namefull = namefull;
	}
	public String getNowman() {
		return nowman;
	}
	public void setNowman(String nowman) {
		this.nowman = nowman;
	}

}
