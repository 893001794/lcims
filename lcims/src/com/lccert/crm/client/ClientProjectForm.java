package com.lccert.crm.client;

import java.util.List;

/**
 * �ͻ���Ŀʵ����
 * @author Eason
 *
 */
public class ClientProjectForm {
	private Integer id; //ʵ��id
	private String type; //����=1:Ŀ��ͻ�;2:��Ч�ͻ�;3:׼�ɽ��ͻ�;4:�ɽ��ͻ�
	private String clientId;//�ͻ�id
	private String clientName ; //�ͻ�����
	private String procure; //�ͻ�����
	private String projectRound; //��Ŀ����
	private Float projectAmount; //��Ŀ���
	private String sort; //���
	private List<ClientRivalForm> clientRivalList; //�������ּ���
	private List<ClientStatusForm> clientStatusList; //��ϵ����
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	public String getProcure() {
		return procure;
	}
	public void setProcure(String procure) {
		this.procure = procure;
	}
	public String getProjectRound() {
		return projectRound;
	}
	public void setProjectRound(String projectRound) {
		this.projectRound = projectRound;
	}
	public Float getProjectAmount() {
		return projectAmount;
	}
	public void setProjectAmount(Float projectAmount) {
		this.projectAmount = projectAmount;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public List<ClientRivalForm> getClientRivalList() {
		return clientRivalList;
	}
	public void setClientRivalList(List<ClientRivalForm> clientRivalList) {
		this.clientRivalList = clientRivalList;
	}
	public List<ClientStatusForm> getClientStatusList() {
		return clientStatusList;
	}
	public void setClientStatusList(List<ClientStatusForm> clientStatusList) {
		this.clientStatusList = clientStatusList;
	}
	
}
