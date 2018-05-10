package com.lccert.crm.vo;

import java.util.List;
/***
 * 测试项目信息的实体类
 * @author tangzp
 *
 */
public class SalesOrderItem {
	private int id;
	private String item_number;  //测试项目代码
	private String name;  //测试项目名称
	private String fullname; //测试项目全称
	private String parentid; //父类id
	private Float saleprice; //销售报价金额
	private Float standprice;  //标准报价金额
	private Float controlprice; //控制报价金额
	private Float outprice;  //外部金额
	private String deleted;  //是否删除
	private String isparent;  //是否非父类
	private String category; //测试项目的类别
	private String normalPeriod;   //普通周期
	private String urgentPeriod;   //加急周期
	private String absolutPeriod;   //特急周期
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
