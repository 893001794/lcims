package com.lccert.crm.client;
/**
 * 竞争对手信息实体类
 * @author Eason
 *
 */
public class ClientRivalForm {
	private Integer id ; //实体id
	private String clientId; //客户id
	private String clientName; //客户名称
	private String name ; //名称
	private String rank; //排名
	private String advantage; //优势
	private String inferior; //劣势
	private String chance; //机会点
	private String methods; //报价方式
	private String period; //周期
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}
	public String getAdvantage() {
		return advantage;
	}
	public void setAdvantage(String advantage) {
		this.advantage = advantage;
	}
	public String getInferior() {
		return inferior;
	}
	public void setInferior(String inferior) {
		this.inferior = inferior;
	}
	public String getChance() {
		return chance;
	}
	public void setChance(String chance) {
		this.chance = chance;
	}
	public String getMethods() {
		return methods;
	}
	public void setMethods(String methods) {
		this.methods = methods;
	}
	public String getPeriod() {
		return period;
	}
	public void setPeriod(String period) {
		this.period = period;
	}
	
}
