package com.lccert.crm.vo;


/**
 * ��ת�����Դ���bean
 * @author tangzp
 *
 */
public class FlowTestStatus {
	private int id ; //֧��id 
	private String fidTestNo ; //��ת�����Դ���ı��
	private String tester ; //������Ա
	private String barCode ; //����
	private String department ; //����
	private Integer status ; //״̬(0:û������1:��)
	private String barCodeTime ; //�����ʱ��
	private String vfidtestname; //��ת���������
	public String getFidTestNo() {
		return fidTestNo;
	}
	public void setFidTestNo(String fidTestNo) {
		this.fidTestNo = fidTestNo;
	}
	public String getTester() {
		return tester;
	}
	public void setTester(String tester) {
		this.tester = tester;
	}
	public String getBarCode() {
		return barCode;
	}
	public void setBarCode(String barCode) {
		this.barCode = barCode;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getBarCodeTime() {
		return barCodeTime;
	}
	public void setBarCodeTime(String barCodeTime) {
		this.barCodeTime = barCodeTime;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getVfidtestname() {
		return vfidtestname;
	}
	public void setVfidtestname(String vfidtestname) {
		this.vfidtestname = vfidtestname;
	}
	

}
