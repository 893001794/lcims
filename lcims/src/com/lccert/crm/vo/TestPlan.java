package com.lccert.crm.vo;
/***
 * ���̲����Է�����ʵ����
 * @author tangzp
 *
 */
public class TestPlan {
	private int id ;
	private String parentName;   //������Ŀ����
	private String childName;    //����Ҫ������
	private String planName;    //���Է���������
	private int childId ;  //����Ҫ�� ��id
	private String status ;   //�Ƿ���Ч
	private String describe1C  ; //������Ŀ����������
	private String describe2C;   //����Ҫ�����������
	private String describe3C;   //���Է�������������
	private String describe1E;   //������ĿӢ�ĵ�����
	private String describe2E;   //����Ҫ��Ӣ�ĵ�����
	private String describe3E;   //���Է���Ӣ�ĵ�����
	private String cnastatus ;  //�Ƿ��CNAS��
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getParentName() {
		return parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	public String getChildName() {
		return childName;
	}
	public void setChildName(String childName) {
		this.childName = childName;
	}
	public String getPlanName() {
		return planName;
	}
	public void setPlanName(String planName) {
		this.planName = planName;
	}
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getDescribe1C() {
		return describe1C;
	}
	public void setDescribe1C(String describe1C) {
		this.describe1C = describe1C;
	}
	public String getDescribe2C() {
		return describe2C;
	}
	public void setDescribe2C(String describe2C) {
		this.describe2C = describe2C;
	}
	public String getDescribe3C() {
		return describe3C;
	}
	public void setDescribe3C(String describe3C) {
		this.describe3C = describe3C;
	}
	public String getDescribe1E() {
		return describe1E;
	}
	public void setDescribe1E(String describe1E) {
		this.describe1E = describe1E;
	}
	public String getDescribe2E() {
		return describe2E;
	}
	public void setDescribe2E(String describe2E) {
		this.describe2E = describe2E;
	}
	public String getDescribe3E() {
		return describe3E;
	}
	public void setDescribe3E(String describe3E) {
		this.describe3E = describe3E;
	}
	public int getChildId() {
		return childId;
	}
	public void setChildId(int childId) {
		this.childId = childId;
	}
	public String getCnastatus() {
		return cnastatus;
	}
	public void setCnastatus(String cnastatus) {
		this.cnastatus = cnastatus;
	}
	

}
