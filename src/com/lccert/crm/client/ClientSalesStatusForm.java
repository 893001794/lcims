package com.lccert.crm.client;
/**
 * �ͻ����۸������ȱ�ʵ����
 * @author Eason
 *
 */
public class ClientSalesStatusForm {
	private Integer id; 
	private String clientid; //�ͻ�id
	private String clientType; //�ͻ�����
	private String clientName; //�ͻ�����
	private String nature ; //��Ҫ��
	private String basicInfor; //�ͻ�������Ϣ
	private String rivalInfor ; //����������Ϣ
	private String procureFlow; //�ɹ�����
	private String projectInfor ; //��Ŀ��Ϣ
	private String inquirYstage; //ѯ�۽׶�
	private String salesStrategy; //���۲���
	private float totalPrice ;//���۽��
	private float signBackPrice; //���ۻ�ǩ���
	private String sampleInfor; //��Ʒ��Ϣ
	private String partPayment ; //����֧������
	private String invoice; //֧Ʊ����
	private String certificate; //����֤��
	private String satisFaction; //����̶�
	private String remark; //��ע
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
