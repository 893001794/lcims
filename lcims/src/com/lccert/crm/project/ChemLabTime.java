package com.lccert.crm.project;

import java.util.Date;

/**
 * 化学项目实验室测试时间状态实体类
 * @author Eason
 *
 */
public class ChemLabTime {

	private int id;

	private String fid;

	private String rid;
	
	private String sid;

	private String status;

	private Date time;

	public String getSid() {
		return sid;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	public String getFid() {
		return fid;
	}

	public void setFid(String fid) {
		this.fid = fid;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

}
