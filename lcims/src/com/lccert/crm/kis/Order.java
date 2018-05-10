package com.lccert.crm.kis;

import java.util.Date;
import java.util.List;

import com.lccert.crm.client.ClientForm;
import com.lccert.crm.user.UserForm;

/**
 * ���۵���Ϣʵ����
 * @author tangzp
 *
 */
public class Order {
	
	private int id;
	
	private String pid;
	
	private String quotype;
	
	private Company company;
	
	private UserForm sales;
	
	private UserForm service;
	
	private ClientForm client;
	
	private String circle;
	
	private Bank bank;
	
	private Date quotime;
	
	private Date completetime;
	
	private AdvanceType advancetype;
	
	private String invmethod;
	
	private String invtype;
	
	private float invcount;
	
	private String invhead;
	
	private String invcontent;
	
	private float prespefund;
	
	private String tag;
	
	private String product;
	
	private float saleprice ;  //���۱���
	
	private String productsample;
	
	private float totalprice;
	
	private float standprice;
	
	private String detail;
	
	private String createuser;
	
	private Date createtime;
	
	private String status;
	
	private List<QuoItem> quoitems;
	//���۹��Ʋ��Եĵ���
	private int estimatesPoints;

	private String oldPid;  //�����ɵı��۵���
	private String rpclient ;  //����ͻ�������
	private String greenchannel ;  //��ɫͨ��
	private int confirmid; //��˾����Id
//	private Date dconfirmtime ; // ��ʱ��˵�ʱ�� 
	private String samplePlane; //��Ʒ��ʽ
	private String sampleNo ;  //��Ʒ���
	private String amstart;     //�����ⳡ��ʼʱ��
	private String amend ;		//�����ⳡ����ʱ�� 
	private String pmstart;     //�����ⳡ��ʼʱ��
	private String pmend ;		//�����ⳡ����ʱ�� 
	private Date collection ;   //�ռ�ʱ��
	private Date test  ;      //����ʱ��
	private Date receipt ;    //�յ�ʱ��
	private String projectcontent; // ������Ŀ
	private String UI;  //��ˮ��
	private String projectleader;  //��¼��ݸedm����������Ŀid+����Աid
	private String sampling;  //��¼��ݸedm����������Ա����
	private Date sampltime;  //��¼��ݸedm����������ʱ��
	
	public float getSaleprice() {
		return saleprice;
	}

	public void setSaleprice(float saleprice) {
		this.saleprice = saleprice;
	}

	public Date getSampltime() {
		return sampltime;
	}

	public void setSampltime(Date sampltime) {
		this.sampltime = sampltime;
	}

	public String getSampling() {
		return sampling;
	}

	public void setSampling(String sampling) {
		this.sampling = sampling;
	}

	public String getProjectleader() {
		return projectleader;
	}

	public void setProjectleader(String projectleader) {
		this.projectleader = projectleader;
	}

	public String getUI() {
		return UI;
	}

	public void setUI(String uI) {
		UI = uI;
	}

	public String getAmstart() {
		return amstart;
	}

	public void setAmstart(String amstart) {
		this.amstart = amstart;
	}

	public String getAmend() {
		return amend;
	}

	public void setAmend(String amend) {
		this.amend = amend;
	}

	public String getPmstart() {
		return pmstart;
	}

	public void setPmstart(String pmstart) {
		this.pmstart = pmstart;
	}

	public String getPmend() {
		return pmend;
	}

	public void setPmend(String pmend) {
		this.pmend = pmend;
	}

	public String getProjectcontent() {
		return projectcontent;
	}

	public void setProjectcontent(String projectcontent) {
		this.projectcontent = projectcontent;
	}

	public Date getCollection() {
		return collection;
	}

	public void setCollection(Date collection) {
		this.collection = collection;
	}

	public Date getTest() {
		return test;
	}

	public void setTest(Date test) {
		this.test = test;
	}

	public Date getReceipt() {
		return receipt;
	}

	public void setReceipt(Date receipt) {
		this.receipt = receipt;
	}

	public String getSamplePlane() {
		return samplePlane;
	}

	public void setSamplePlane(String samplePlane) {
		this.samplePlane = samplePlane;
	}

	public String getSampleNo() {
		return sampleNo;
	}

	public void setSampleNo(String sampleNo) {
		this.sampleNo = sampleNo;
	}

	public int getConfirmid() {
		return confirmid;
	}

	public void setConfirmid(int confirmid) {
		this.confirmid = confirmid;
	}

	public int getEstimatesPoints() {
		return estimatesPoints;
	}

	public void setEstimatesPoints(int estimatesPoints) {
		this.estimatesPoints = estimatesPoints;
	}

	public AdvanceType getAdvancetype() {
		return advancetype;
	}

	public void setAdvancetype(AdvanceType advancetype) {
		this.advancetype = advancetype;
	}

	public Bank getBank() {
		return bank;
	}

	public void setBank(Bank bank) {
		this.bank = bank;
	}

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}

	public UserForm getSales() {
		return sales;
	}

	public void setSales(UserForm sales) {
		this.sales = sales;
	}

	public UserForm getService() {
		return service;
	}

	public void setService(UserForm service) {
		this.service = service;
	}

	public ClientForm getClient() {
		return client;
	}

	public void setClient(ClientForm client) {
		this.client = client;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public float getTotalprice() {
		return totalprice;
	}

	public void setTotalprice(float totalprice) {
		this.totalprice = totalprice;
	}

	public float getStandprice() {
		return standprice;
	}

	public void setStandprice(float standprice) {
		this.standprice = standprice;
	}

	public List<QuoItem> getQuoitems() {
		return quoitems;
	}

	public void setQuoitems(List<QuoItem> quoitems) {
		this.quoitems = quoitems;
	}

	public String getInvhead() {
		return invhead;
	}

	public void setInvhead(String invhead) {
		this.invhead = invhead;
	}

	public String getInvcontent() {
		return invcontent;
	}

	public void setInvcontent(String invcontent) {
		this.invcontent = invcontent;
	}

	public float getPrespefund() {
		return prespefund;
	}

	public void setPrespefund(float prespefund) {
		this.prespefund = prespefund;
	}

	public Date getQuotime() {
		return quotime;
	}

	public void setQuotime(Date quotime) {
		this.quotime = quotime;
	}

	public String getCircle() {
		return circle;
	}

	public void setCircle(String circle) {
		this.circle = circle;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getQuotype() {
		return quotype;
	}

	public void setQuotype(String quotype) {
		this.quotype = quotype;
	}

	public Date getCompletetime() {
		return completetime;
	}

	public void setCompletetime(Date completetime) {
		this.completetime = completetime;
	}

	public String getInvmethod() {
		return invmethod;
	}

	public void setInvmethod(String invmethod) {
		this.invmethod = invmethod;
	}

	public String getInvtype() {
		return invtype;
	}

	public void setInvtype(String invtype) {
		this.invtype = invtype;
	}

	public float getInvcount() {
		return invcount;
	}

	public void setInvcount(float invcount) {
		this.invcount = invcount;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public String getProductsample() {
		return productsample;
	}

	public void setProductsample(String productsample) {
		this.productsample = productsample;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getCreateuser() {
		return createuser;
	}

	public void setCreateuser(String createuser) {
		this.createuser = createuser;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getOldPid() {
		return oldPid;
	}

	public void setOldPid(String oldPid) {
		this.oldPid = oldPid;
	}

	public String getRpclient() {
		return rpclient;
	}

	public void setRpclient(String rpclient) {
		this.rpclient = rpclient;
	}

	public String getGreenchannel() {
		return greenchannel;
	}

	public void setGreenchannel(String greenchannel) {
		this.greenchannel = greenchannel;
	}

}
