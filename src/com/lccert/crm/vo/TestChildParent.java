package com.lccert.crm.vo;
/***
 * ���̲���������Ŀ����Ҫ��ʵ����
 * @author tangzp
 *
 */
public class TestChildParent {
	private String childName;  //������ĿҪ�������
	private String parentName ;  //�����ĸ�������
	private int parentId ;  //�����id 
	private int id ;   //����
	private String type ;   //����Ҫ������
	private String status;  //�Ƿ���Ч
	public String getChildName() {
		return childName;
	}
	public void setChildName(String childName) {
		this.childName = childName;
	}
	public String getParentName() {
		return parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getParentId() {
		return parentId;
	}
	public void setParentId(int parentId) {
		this.parentId = parentId;
	}

}
