package com.lccert.crm.system;

import java.util.Date;

/**
 * 系统公告内容实体类
 * @author Eason
 *
 */
public class Forum {
	
	private int id;
	
	private String head;
	
	private String content;
	
	private String createname;
	
	private Date createtime;
	private Date deadtime;
	private int iscid;
	private String imagepath;


	public int getIscid() {
		return iscid;
	}

	public void setIscid(int iscid) {
		this.iscid = iscid;
	}

	public Date getDeadtime() {
		return deadtime;
	}

	public void setDeadtime(Date deadtime) {
		this.deadtime = deadtime;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getHead() {
		return head;
	}

	public void setHead(String head) {
		this.head = head;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCreatename() {
		return createname;
	}

	public void setCreatename(String createname) {
		this.createname = createname;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getImagepath() {
		return imagepath;
	}

	public void setImagepath(String imagepath) {
		this.imagepath = imagepath;
	}

}
