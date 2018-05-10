package com.lccert.crm.kis;

/**
 * 测试项目实体类
 * @author Eason
 *
 */
public class Item {
	
	private int id;
	
	private String itemNumber;
	
	private String name;
	
	private String fullname;
	
	private float saleprice;
	
	private float standprice;
	
	private float controlprice;
	
	private float outprice;
	private String deleted;
	private String status ; //只显示环境的项目
	private String cma  ;  //是否带章
	private String plane;  //调用方法的id
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCma() {
		return cma;
	}

	public void setCma(String cma) {
		this.cma = cma;
	}

	public String getPlane() {
		return plane;
	}

	public void setPlane(String plane) {
		this.plane = plane;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getItemNumber() {
		return itemNumber;
	}

	public void setItemNumber(String itemNumber) {
		this.itemNumber = itemNumber;
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

	public float getSaleprice() {
		return saleprice;
	}

	public void setSaleprice(float saleprice) {
		this.saleprice = saleprice;
	}

	public float getStandprice() {
		return standprice;
	}

	public void setStandprice(float standprice) {
		this.standprice = standprice;
	}

	public float getControlprice() {
		return controlprice;
	}

	public void setControlprice(float controlprice) {
		this.controlprice = controlprice;
	}

	public float getOutprice() {
		return outprice;
	}

	public void setOutprice(float outprice) {
		this.outprice = outprice;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

}
