package com.lccert.crm.client;

import java.util.Date;

/**
 * �ͻ�״̬ʵ����
 * @author Eason
 *
 */
public class ClientStatusForm {
	private Integer id ;//ʵ��id
	private String clientId ; //�ͻ�id
	private String clientName; //�ͻ�����
	private Date followUpdate; //���ȵǼ�
	private String statusCas; //�������
	private String remark; //��ע
	private String register; //��������õǼ�
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
