package com.lccert.crm.client;

import java.util.Date;

/**
 * 客户状态实体类
 * @author Eason
 *
 */
public class ClientStatusForm {
	private Integer id ;//实体id
	private String clientId ; //客户id
	private String clientName; //客户名称
	private Date followUpdate; //进度登记
	private String statusCas; //跟进情况
	private String remark; //备注
	private String register; //出差或来访登记
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getClientId() {
		return clientId;
	}
	public void setClientId(String clientId) {
		this.clientId = clientId;
	}
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	
	public Date getFollowUpdate() {
		return followUpdate;
	}
	public void setFollowUpdate(Date followUpdate) {
		this.followUpdate = followUpdate;
	}
	public String getStatusCas() {
		return statusCas;
	}
	public void setStatusCas(String statusCas) {
		this.statusCas = statusCas;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getRegister() {
		return register;
	}
	public void setRegister(String register) {
		this.register = register;
	}
	
}
