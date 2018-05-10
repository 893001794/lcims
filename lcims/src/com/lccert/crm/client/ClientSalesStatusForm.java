package com.lccert.crm.client;
/**
 * 客户销售跟进进度表实体类
 * @author Eason
 *
 */
public class ClientSalesStatusForm {
	private Integer id; 
	private String clientid; //客户id
	private String clientType; //客户类型
	private String clientName; //客户名称
	private String nature ; //重要性
	private String basicInfor; //客户基本信息
	private String rivalInfor ; //竞争对手信息
	private String procureFlow; //采购流程
	private String projectInfor ; //项目信息
	private String inquirYstage; //询价阶段
	private String salesStrategy; //销售策略
	private float totalPrice ;//报价金额
	private float signBackPrice; //报价会签金额
	private String sampleInfor; //样品信息
	private String partPayment ; //款项支付部门
	private String invoice; //支票部分
	private String certificate; //报告证书
	private String satisFaction; //满意程度
	private String remark; //备注
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getClientid() {
		return clientid;
	}
	public void setClientid(String clientid) {
		this.clientid = clientid;
	}
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	public String getNature() {
		return nature;
	}
	public void setNature(String nature) {
		this.nature = nature;
	}
	public String getBasicInfor() {
		return basicInfor;
	}
	public void setBasicInfor(String basicInfor) {
		this.basicInfor = basicInfor;
	}
	public String getRivalInfor() {
		return rivalInfor;
	}
	public void setRivalInfor(String rivalInfor) {
		this.rivalInfor = rivalInfor;
	}
	public String getProcureFlow() {
		return procureFlow;
	}
	public void setProcureFlow(String procureFlow) {
		this.procureFlow = procureFlow;
	}
	public String getProjectInfor() {
		return projectInfor;
	}
	public void setProjectInfor(String projectInfor) {
		this.projectInfor = projectInfor;
	}
	public String getInquirYstage() {
		return inquirYstage;
	}
	public void setInquirYstage(String inquirYstage) {
		this.inquirYstage = inquirYstage;
	}
	public String getSalesStrategy() {
		return salesStrategy;
	}
	public void setSalesStrategy(String salesStrategy) {
		this.salesStrategy = salesStrategy;
	}
	public float getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(float totalPrice) {
		this.totalPrice = totalPrice;
	}
	public float getSignBackPrice() {
		return signBackPrice;
	}
	public void setSignBackPrice(float signBackPrice) {
		this.signBackPrice = signBackPrice;
	}
	public String getSampleInfor() {
		return sampleInfor;
	}
	public void setSampleInfor(String sampleInfor) {
		this.sampleInfor = sampleInfor;
	}
	public String getPartPayment() {
		return partPayment;
	}
	public void setPartPayment(String partPayment) {
		this.partPayment = partPayment;
	}
	public String getInvoice() {
		return invoice;
	}
	public void setInvoice(String invoice) {
		this.invoice = invoice;
	}
	public String getCertificate() {
		return certificate;
	}
	public void setCertificate(String certificate) {
		this.certificate = certificate;
	}
	public String getSatisFaction() {
		return satisFaction;
	}
	public void setSatisFaction(String satisFaction) {
		this.satisFaction = satisFaction;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getClientType() {
		return clientType;
	}
	public void setClientType(String clientType) {
		this.clientType = clientType;
	}
	
	
}
