package com.lccert.crm.vo;

import java.util.Date;

/***
 *���ʵ��bean
 * @author Administrator
 *
 */
public class Inventory {
	private String name ;   //��Ʒ����
	private String  standardNo;  //����ͺ�
	private String category ;  //��Ʒ���
	private int pid ;  //��Ʒid
	private int iid ;  //���
	private String unit ;  //��λ
	private float price ;  //��Ʒ�۸�
	private int inventoryNumber;  // ��ɽ���
	private int inventoryNumber1;  //��ݸ ���
	private String area ; //����
	private Date lastTime ; //��ɽ�������ʱ��
	private Date lastTime1 ; //��ݸ�������ʱ��
	private int  TOTAL ;  //��ɽ�ۼ���������
	private int  TOTAL1 ;  //��ݸ�ۼ���������
	private float historyprice; //��ɽ��ʷ����
	private float historyprice1; //��ݸ��ʷ����
	private String client ; // ��Ӧ��
	private String remark ; // ��ע
	private int warning ; //Ԥ����
	
	public int getWarning() {
		return warning;
	}
	public void setWarning(int warning) {
		this.warning = warning;
	}
	
	public Date getLastTime1() {
		return lastTime1;
	}
	public void setLastTime1(Date lastTime1) {
		this.lastTime1 = lastTime1;
	}
	public int getTOTAL1() {
		return TOTAL1;
	}
	public void setTOTAL1(int tOTAL1) {
		TOTAL1 = tOTAL1;
	}
	public float getHistoryprice1() {
		return historyprice1;
	}
	public void setHistoryprice1(float historyprice1) {
		this.historyprice1 = historyprice1;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getRemark() {
		return remark;
	}
	public int getInventoryNumber1() {
		return inventoryNumber1;
	}
	public void setInventoryNumber1(int inventoryNumber1) {
		this.inventoryNumber1 = inventoryNumber1;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getIid() {
		return iid;
	}
	public void setIid(int iid) {
		this.iid = iid;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStandardNo() {
		return standardNo;
	}
	public void setStandardNo(String standardNo) {
		this.standardNo = standardNo;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public int getInventoryNumber() {
		return inventoryNumber;
	}
	public void setInventoryNumber(int inventoryNumber) {
		this.inventoryNumber = inventoryNumber;
	}
	public Date getLastTime() {
		return lastTime;
	}
	public void setLastTime(Date lastTime) {
		this.lastTime = lastTime;
	}
	public int getTOTAL() {
		return TOTAL;
	}
	public void setTOTAL(int tOTAL) {
		TOTAL = tOTAL;
	}
	public float getHistoryprice() {
		return historyprice;
	}
	public void setHistoryprice(float historyprice) {
		this.historyprice = historyprice;
	}
	
	
}
