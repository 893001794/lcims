package com.lccert.crm.readcsv;

import java.util.Date;
/***
 *  读取CSV的文件的实体类
 * @author tangzp
 *
 */
public class ReadCSVForm {
	private String userId;
	private Date registerTime;

	public Date getRegisterTime() {
		return registerTime;
	}
	public void setRegisterTime(Date registerTime) {
		this.registerTime = registerTime;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}



}
