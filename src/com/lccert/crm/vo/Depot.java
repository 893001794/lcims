package com.lccert.crm.vo;

import java.util.Date;

/**
 * �ֿ�bean 
 * @author tangzp
 *
 */
public class Depot {
	private int id ;  //�ֿ�id��
	private String did ; //�ʲ����
	private int aid ; //��Ʒid ��
	private int userid ; //�û���Id
	private String client; //��Ӧ������
	private String specification;  //����ͺ�
	private float price ; //��Ʒ���
	private String  brand ;  //Ʒ��
	private int number ;   //����
	private String unitofaccount; //���㵥λ
	private int deptid ; //����id
	private  String usestatus;   //ʹ��״̬
	private Date userdate;  //ʹ������
	private String aperture  ;  //���λ��
	private int keepid ;   //������
	private  String fundstype;  //������Դ
	private Date calibration ;  //У׼����
	private Date nextcal ;   //��У׼����
	private String application ; // �������
	private String contract ; // ��ͬ���
	private String acceptance ;  // ���ձ���
	private String invoiceno  ;  //��Ʊ����
	private String invoicecode ;   // ��Ʊ����
	private String remarks ;   // ��ע
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDid() {
		return did;
	}
	public void setDid(String did) {
		this.did = did;
	}
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getSpecification() {
		return specification;
	}
	public void setSpecification(String specification) {
		this.specification = specification;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public String getUnitofaccount() {
		return unitofaccount;
	}
	public void setUnitofaccount(String unitofaccount) {
		this.unitofaccount = unitofaccount;
	}
	public int getDeptid() {
		return deptid;
	}
	public void setDeptid(int deptid) {
		this.deptid = deptid;
	}
	public String getUsestatus() {
		return usestatus;
	}
	public void setUsestatus(String usestatus) {
		this.usestatus = usestatus;
	}
	public Date getUserdate() {
		return userdate;
	}
	public void setUserdate(Date userdate) {
		this.userdate = userdate;
	}
	public String getAperture() {
		return aperture;
	}
	public void setAperture(String aperture) {
		this.aperture = aperture;
	}
	public int getKeepid() {
		return keepid;
	}
	public void setKeepid(int keepid) {
		this.keepid = keepid;
	}
	public String getFundstype() {
		return fundstype;
	}
	public void setFundstype(String fundstype) {
		this.fundstype = fundstype;
	}
	public Date getCalibration() {
		return calibration;
	}
	public void setCalibration(Date calibration) {
		this.calibration = calibration;
	}
	public Date getNextcal() {
		return nextcal;
	}
	public void setNextcal(Date nextcal) {
		this.nextcal = nextcal;
	}
	public String getApplication() {
		return application;
	}
	public void setApplication(String application) {
		this.application = application;
	}
	public String getContract() {
		return contract;
	}
	public void setContract(String contract) {
		this.contract = contract;
	}
	public String getAcceptance() {
		return acceptance;
	}
	public void setAcceptance(String acceptance) {
		this.acceptance = acceptance;
	}
	public String getInvoiceno() {
		return invoiceno;
	}
	public void setInvoiceno(String invoiceno) {
		this.invoiceno = invoiceno;
	}
	public String getInvoicecode() {
		return invoicecode;
	}
	public void setInvoicecode(String invoicecode) {
		this.invoicecode = invoicecode;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	
}
