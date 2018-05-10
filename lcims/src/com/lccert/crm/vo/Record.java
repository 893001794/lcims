package com.lccert.crm.vo;

import java.util.Date;

/***
 * 录音bean
 * @author Administrator
 *
 */
public class Record {
	private int id ;
	private String area;  //区域（一部、二部、东莞、广州）
	private String recordate;  //录音目录的时间
	private String ecordname ;  //录音名称
	private int  count ;   //录音数目
	private String filepate ;  //文件目录路径
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getRecordate() {
		return recordate;
	}
	public void setRecordate(String recordate) {
		this.recordate = recordate;
	}
	public String getEcordname() {
		return ecordname;
	}
	public void setEcordname(String ecordname) {
		this.ecordname = ecordname;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getFilepate() {
		return filepate;
	}
	public void setFilepate(String filepate) {
		this.filepate = filepate;
	}
	
}
