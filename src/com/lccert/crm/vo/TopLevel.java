package com.lccert.crm.vo;
/***
 * ������Ŀ�Ķ���
 * @author Administrator
 *
 */
public class TopLevel {
	private int id  ; //������id
	private String name ; // ����������
	private String status ; //�ж��Ƿ���Ч
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}