package com.lccert.crm.project;

import java.util.Date;

/**
 * 项目预警信息实体类
 * @author Eason
 *
 */
public class Warnning {
	
	private String sid;

	private String rid;

	private String warn;

	private Date warntime;

	public String getSid() {
		return sid;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getWarn() {
		return warn;
	}

	public void setWarn(String warn) {
		this.warn = warn;
	}

	public Date getWarntime() {
		return warntime;
	}

	public void setWarntime(Date warntime) {
		this.warntime = warntime;
	}

}
