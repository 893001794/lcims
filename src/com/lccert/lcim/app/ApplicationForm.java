package com.lccert.lcim.app;

import java.util.Date;
/***
 * 请款的实体类
 * @author tangzp
 *
 */
public class ApplicationForm {
	
	private int id;
	
	private String app_id;
	
	private String inv_type;
	
	private String inv_head;
	
	private String inv_accept;
	
	private String app_user;
	
	private Date app_time;
	
	private String pay_method;
	
	private String pay_type;
	
	private Date prepay_time1;
	
	private Date prepay_time2;
	
	private Date prepay_time3;
	
	private Date pay_time;
	
	private String pay_man;
	
	private String contract_code1;
	
	private String contract_code2;
	
	private String contract_code3;
	
	private String contract_content1;
	
	private String contract_content2;
	
	private String contract_content3;
	
	private float contract_price1;
	
	private float contract_price2;
	
	private float contract_price3;
	
	private float first_pay;
	
	private float second_pay;
	
	private float third_pay;
	
	private String isaudit;
	
	private String auditman;
	
	private Date audit_time;
	
	private Supplier sup;
	
	private String dept;
	
	private int item;
	
	private String tags;

	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}

	public int getItem() {
		return item;
	}

	public void setItem(int item) {
		this.item = item;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public Supplier getSup() {
		return sup;
	}

	public void setSup(Supplier sup) {
		this.sup = sup;
	}

	public String getIsaudit() {
		return isaudit;
	}

	public void setIsaudit(String isaudit) {
		this.isaudit = isaudit;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getApp_id() {
		return app_id;
	}

	public void setApp_id(String app_id) {
		this.app_id = app_id;
	}

	public String getInv_type() {
		return inv_type;
	}

	public void setInv_type(String inv_type) {
		this.inv_type = inv_type;
	}

	public String getInv_head() {
		return inv_head;
	}

	public void setInv_head(String inv_head) {
		this.inv_head = inv_head;
	}

	public String getInv_accept() {
		return inv_accept;
	}

	public void setInv_accept(String inv_accept) {
		this.inv_accept = inv_accept;
	}

	public String getApp_user() {
		return app_user;
	}

	public void setApp_user(String app_user) {
		this.app_user = app_user;
	}

	public Date getApp_time() {
		return app_time;
	}

	public void setApp_time(Date app_time) {
		this.app_time = app_time;
	}

	public String getPay_method() {
		return pay_method;
	}

	public void setPay_method(String pay_method) {
		this.pay_method = pay_method;
	}

	public String getPay_type() {
		return pay_type;
	}

	public void setPay_type(String pay_type) {
		this.pay_type = pay_type;
	}

	public Date getPrepay_time1() {
		return prepay_time1;
	}

	public void setPrepay_time1(Date prepay_time1) {
		this.prepay_time1 = prepay_time1;
	}

	public Date getPrepay_time2() {
		return prepay_time2;
	}

	public void setPrepay_time2(Date prepay_time2) {
		this.prepay_time2 = prepay_time2;
	}

	public Date getPrepay_time3() {
		return prepay_time3;
	}

	public void setPrepay_time3(Date prepay_time3) {
		this.prepay_time3 = prepay_time3;
	}

	public Date getPay_time() {
		return pay_time;
	}

	public void setPay_time(Date pay_time) {
		this.pay_time = pay_time;
	}

	public String getPay_man() {
		return pay_man;
	}

	public void setPay_man(String pay_man) {
		this.pay_man = pay_man;
	}

	public String getContract_code1() {
		return contract_code1;
	}

	public void setContract_code1(String contract_code1) {
		this.contract_code1 = contract_code1;
	}

	public String getContract_code2() {
		return contract_code2;
	}

	public void setContract_code2(String contract_code2) {
		this.contract_code2 = contract_code2;
	}

	public String getContract_code3() {
		return contract_code3;
	}

	public void setContract_code3(String contract_code3) {
		this.contract_code3 = contract_code3;
	}

	public String getContract_content1() {
		return contract_content1;
	}

	public void setContract_content1(String contract_content1) {
		this.contract_content1 = contract_content1;
	}

	public String getContract_content2() {
		return contract_content2;
	}

	public void setContract_content2(String contract_content2) {
		this.contract_content2 = contract_content2;
	}

	public String getContract_content3() {
		return contract_content3;
	}

	public void setContract_content3(String contract_content3) {
		this.contract_content3 = contract_content3;
	}

	public float getContract_price1() {
		return contract_price1;
	}

	public void setContract_price1(float contract_price1) {
		this.contract_price1 = contract_price1;
	}

	public float getContract_price2() {
		return contract_price2;
	}

	public void setContract_price2(float contract_price2) {
		this.contract_price2 = contract_price2;
	}

	public float getContract_price3() {
		return contract_price3;
	}

	public void setContract_price3(float contract_price3) {
		this.contract_price3 = contract_price3;
	}

	public float getFirst_pay() {
		return first_pay;
	}

	public void setFirst_pay(float first_pay) {
		this.first_pay = first_pay;
	}

	public float getSecond_pay() {
		return second_pay;
	}

	public void setSecond_pay(float second_pay) {
		this.second_pay = second_pay;
	}

	public float getThird_pay() {
		return third_pay;
	}

	public void setThird_pay(float third_pay) {
		this.third_pay = third_pay;
	}

	public String getAuditman() {
		return auditman;
	}

	public void setAuditman(String auditman) {
		this.auditman = auditman;
	}

	public Date getAudit_time() {
		return audit_time;
	}

	public void setAudit_time(Date audit_time) {
		this.audit_time = audit_time;
	}

}
