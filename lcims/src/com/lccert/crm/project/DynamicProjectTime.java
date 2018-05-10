package com.lccert.crm.project;

import java.util.Date;

/**
 * 动态时间状态实体类
 * 用于记录一些特殊的动态时间状态，例如：发送补样、换样通知，收到补样、换样通知等
 * @author tangzp
 *
 */
public class DynamicProjectTime {
	
	private int id;
	
	private String rid;
	
	private String sid;
	
	private String user;
	
	private String event;
	
	private Date time;
	
	private String filepath;

	public String getFilepath() {
		return filepath;
	}

	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	
	public String getSid() {
		return sid;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getEvent() {
		return event;
	}

	public void setEvent(String event) {
		this.event = event;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

}
