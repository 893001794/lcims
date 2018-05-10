package com.lccert.crm.kis;

/**
 * 报价单测试项目信息实体类
 * @author Eason
 *
 */
public class QuoItem {

	private int id;
	
	private int orderid;
	
	private Item item;
	
	private float count;
	
	private float saleprice;
	
	private String remark;
	
	private String samplename;
	private int planeId ; //环境测试方法的id
	private int childId ;   //环境测试的二级id
	private float price ;  //实际价格
	

	public int getPlaneId() {
		return planeId;
	}

	public void setPlaneId(int planeId) {
		this.planeId = planeId;
	}

	public int getChildId() {
		return childId;
	}

	public void setChildId(int childId) {
		this.childId = childId;
	}

	public int getOrderid() {
		return orderid;
	}

	public void setOrderid(int orderid) {
		this.orderid = orderid;
	}

	public float getSaleprice() {
		return saleprice;
	}

	public void setSaleprice(float saleprice) {
		this.saleprice = saleprice;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Item getItem() {
		return item;
	}

	public void setItem(Item item) {
		this.item = item;
	}

	public float getCount() {
		return count;
	}

	public void setCount(float count) {
		this.count = count;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getSamplename() {
		return samplename;
	}

	public void setSamplename(String samplename) {
		this.samplename = samplename;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	
	
	
}
