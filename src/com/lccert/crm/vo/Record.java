package com.lccert.crm.vo;

import java.util.Date;

/***
 * ¼��bean
 * @author Administrator
 *
 */
public class Record {
	private int id ;
	private String area;  //����һ������������ݸ�����ݣ�
	private String recordate;  //¼��Ŀ¼��ʱ��
	private String ecordname ;  //¼������
	private int  count ;   //¼����Ŀ
	private String filepate ;  //�ļ�Ŀ¼·��
	
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
