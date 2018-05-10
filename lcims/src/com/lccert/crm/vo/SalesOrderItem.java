package com.lccert.crm.vo;

import java.util.List;
/***
 * ������Ŀ��Ϣ��ʵ����
 * @author tangzp
 *
 */
public class SalesOrderItem {
	private int id;
	private String item_number;  //������Ŀ����
	private String name;  //������Ŀ����
	private String fullname; //������Ŀȫ��
	private String parentid; //����id
	private Float saleprice; //���۱��۽��
	private Float standprice;  //��׼���۽��
	private Float controlprice; //���Ʊ��۽��
	private Float outprice;  //�ⲿ���
	private String deleted;  //�Ƿ�ɾ��
	private String isparent;  //�Ƿ�Ǹ���
	private String category; //������Ŀ�����
	private String normalPeriod;   //��ͨ����
	private String urgentPeriod;   //�Ӽ�����
	private String absolutPeriod;   //�ؼ�����
	private int countChild;  
	private List Object ; 
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getItem_number() {
		return item_number;
	}
	public void setItem_number(String item_number) {
		this.item_number = item_number;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public String getParentid() {
		return parentid;
	}
	public void setParentid(String parentid) {
		this.parentid = parentid;
	}
	public Float getSaleprice() {
		return saleprice;
	}
	public void setSaleprice(Float saleprice) {
		this.saleprice = saleprice;
	}
	public Float getStandprice() {
		return standprice;
	}
	public void setStandprice(Float standprice) {
		this.standprice = standprice;
	}
	public Float getControlprice() {
		return controlprice;
	}
	public void setControlprice(Float controlprice) {
		this.controlprice = controlprice;
	}
	public Float getOutprice() {
		return outprice;
	}
	public void setOutprice(Float outprice) {
		this.outprice = outprice;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public String getIsparent() {
		return isparent;
	}
	public void setIsparent(String isparent) {
		this.isparent = isparent;
	}
	public int getCountChild() {
		return countChild;
	}
	public void setCountChild(int countChild) {
		this.countChild = countChild;
	}
	public List getObject() {
		return Object;
	}
	public void setObject(List object) {
		Object = object;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getNormalPeriod() {
		return normalPeriod;
	}
	public void setNormalPeriod(String normalPeriod) {
		this.normalPeriod = normalPeriod;
	}
	public String getUrgentPeriod() {
		return urgentPeriod;
	}
	public void setUrgentPeriod(String urgentPeriod) {
		this.urgentPeriod = urgentPeriod;
	}
	public String getAbsolutPeriod() {
		return absolutPeriod;
	}
	public void setAbsolutPeriod(String absolutPeriod) {
		this.absolutPeriod = absolutPeriod;
	} 

}
