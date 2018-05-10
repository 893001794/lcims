package com.lccert.crm.client;

import java.util.List;

/**
 * 客户项目实体类
 * @author Eason
 *
 */
public class ClientProjectForm {
	private Integer id; //实体id
	private String type; //类型=1:目标客户;2:有效客户;3:准成交客户;4:成交客户
	private String clientId;//客户id
	private String clientName ; //客户名称
	private String procure; //客户意向
	private String projectRound; //项目周期
	private Float projectAmount; //项目金额
	private String sort; //类别
	private List<ClientRivalForm> clientRivalList; //竞争对手集合
	private List<ClientStatusForm> clientStatusList; //联系进度
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
