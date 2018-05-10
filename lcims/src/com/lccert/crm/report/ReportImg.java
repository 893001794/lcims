package com.lccert.crm.report;

/**
 * 报告图片实体类
 * @author Eason
 *
 */
public class ReportImg {
	private int id;
	private String sid;
	private String rid;
	private String name;
	private String imgurl;
	private String detial;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
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
	public String getImgurl() {
		return imgurl;
	}
	public void setImgurl(String imgurl) {
		this.imgurl = imgurl;
	}
	public String getDetial() {
		return detial;
	}
	public void setDetial(String detial) {
		this.detial = detial;
	}

}
