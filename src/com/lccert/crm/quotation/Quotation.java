package com.lccert.crm.quotation;

import java.util.Date;

/**
 * ����ʵ����
 * 
 * @author eason
 * 
 */
public class Quotation {

	private int id;
	
	private String pid;

	private String quotype;

	private String client;

	private String projectcontent;

	private String sales;

	private String company;

	private String createuser;

	private Date createtime;

	private String confirmuser;

	private Date confirmtime;
	
	private Date completetime;

	private String advancetype;

	private float totalprice;

	private float preadvance;

	private String creditcard;

	private Date paytime;

	private String paynotes;

	private float sepay;

	private String sepayacount;

	private String sepaynotes;

	private Date sepaytime;

	private float prebalance;

	private float balance;

	private String balanceacount;

	private String balancenotes;

	private Date balancetime;

	private float refund;

	private String refunddesc;

	private int projectcount;

	private String isfinish;

	private String paymentclear;

	private float prespefund;

	private float spefund;

	private String spefundtype;

	private Date spefundtime;

	private String spefunddesc;

	private float preacount;

	private float acount;

	private Date invtime;

	private String invcode;

	private float invcount;
	
	private float invprice;

	private String invmethod;

	private String invcontent;

	private String invhead;

	private String invtype;

	private String status;

	private String tag;

	private String econfrim;
	
	private String audit;
	
	private String auditman;
	
	private Date audittime;
	
	private float standprice;
	
	private float tax;
	
	private float subcost;
	
	private float presubcost;
	
	private float totalperformence;
	
	private float preagcost;
	
	private float agcost;
	
	private float insubcost;
	
	private float othercost;
	
	private String paystatus;
	
	private String collRemarks; //�տע
	private int clientid;  //��ȡ�û���Ϣ
	private String object ;
	private Object obj;
	private float sumOtherscost ;
	private float adjustinvcount;    //���ı��۵����ܽ��
	private String oldPid;   //�����ɵı��۵�
	private String rpclient; //����ͻ�����
	private String greenchannel;  //��ɫͨ��
	private float projectPrice ;  //������Ŀ�Ľ��;
	private int confirmid ;  //��¼���ۺ����������id
	private float advarceFactor ; //Ԥ�տ�ϵ��
	private float sepayFactor ;  //�����տ�ϵ��
	private float balanceFactor; //β���տ�ϵ��
	private String amstart ; // �����ⳡ��ʼʱ��
	private String amend  ;  //�����ⳡ����ʱ��
	private String pmstart ; //���� �ⳡ��ʼʱ��
	private String pmend  ;  //�����ⳡ����ʱ��
	private String product;  //��Ʒ����
	private Date collection ;   //�ռ�ʱ��
	private Date test  ;      //����ʱ��
	private Date receipt ;    //�յ�ʱ��
	private Date finish  ;    //���۵����ʱ��
	private float deductions ; //׷��ֿ�ϵ��
	private float channel ; //ͨ��ϵ��
	
	private String sampling;  //��¼��ݸedm����������Ա����
	private Date sampltime;  //��¼��ݸedm����������ʱ�� 
	private String createname ;  //�ŵ���Ա
	private String lock ; //��
	private String sealup ; //��
	private float fluSum ; //�����
	private String clientContact ; //��ȡ�ͻ�����
	private String badDebt; //���˿ۿ�
	private Integer groupId ;//����

	public String getSealup() {
		return sealup;
	}

	public void setSealup(String sealup) {
		this.sealup = sealup;
	}

	public float getFluSum() {
		return fluSum;
	}
	public void setFluSum(float fluSum) {
		this.fluSum = fluSum;
	}
	public String getLock() {
		return lock;
	}
	public void setLock(String lock) {
		this.lock = lock;
	}
	public String getCreatename() {
		return createname;
	}
	public void setCreatename(String createname) {
		this.createname = createname;
	}
	public String getSampling() {
		return sampling;
	}
	public void setSampling(String sampling) {
		this.sampling = sampling;
	}
	public Date getSampltime() {
		return sampltime;
	}
	public void setSampltime(Date sampltime) {
		this.sampltime = sampltime;
	}
	public float getDeductions() {
		return deductions;
	}
	public void setDeductions(float deductions) {
		this.deductions = deductions;
	}
	public float getChannel() {
		return channel;
	}
	public void setChannel(float channel) {
		this.channel = channel;
	}
	public Date getFinish() {
		return finish;
	}
	public void setFinish(Date finish) {
		this.finish = finish;
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
	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public float getAdvarceFactor() {
		return advarceFactor;
	}
	public void setAdvarceFactor(float advarceFactor) {
		this.advarceFactor = advarceFactor;
	}
	public float getSepayFactor() {
		return sepayFactor;
	}
	public void setSepayFactor(float sepayFactor) {
		this.sepayFactor = sepayFactor;
	}
	public float getBalanceFactor() {
		return balanceFactor;
	}
	public void setBalanceFactor(float balanceFactor) {
		this.balanceFactor = balanceFactor;
	}
	public String getPaystatus() {
		return paystatus;
	}
	public int getConfirmid() {
		return confirmid;
	}

	public void setConfirmid(int confirmid) {
		this.confirmid = confirmid;
	}
	public void setPaystatus(String paystatus) {
		this.paystatus = paystatus;
	}

	public float getOthercost() {
		return othercost;
	}

	public void setOthercost(float othercost) {
		this.othercost = othercost;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public float getSubcost() {
		return subcost;
	}

	public void setSubcost(float subcost) {
		this.subcost = subcost;
	}

	public float getPresubcost() {
		return presubcost;
	}

	public void setPresubcost(float presubcost) {
		this.presubcost = presubcost;
	}

	public float getPreagcost() {
		return preagcost;
	}

	public void setPreagcost(float preagcost) {
		this.preagcost = preagcost;
	}

	public float getAgcost() {
		return agcost;
	}

	public void setAgcost(float agcost) {
		this.agcost = agcost;
	}

	public float getInsubcost() {
		return insubcost;
	}

	public void setInsubcost(float insubcost) {
		this.insubcost = insubcost;
	}

	public String getEconfrim() {
		return econfrim;
	}

	public void setEconfrim(String econfrim) {
		this.econfrim = econfrim;
	}

	public float getTotalperformence() {
		return totalperformence;
	}

	public void setTotalperformence(float totalperformence) {
		this.totalperformence = totalperformence;
	}

	public float getTax() {
		return tax;
	}

	public void setTax(float tax) {
		this.tax = tax;
	}

	public String getAuditman() {
		return auditman;
	}

	public void setAuditman(String auditman) {
		this.auditman = auditman;
	}

	public Date getAudittime() {
		return audittime;
	}

	public void setAudittime(Date audittime) {
		this.audittime = audittime;
	}

	public float getInvprice() {
		return invprice;
	}

	public void setInvprice(float invprice) {
		this.invprice = invprice;
	}

	public float getStandprice() {
		return standprice;
	}

	public void setStandprice(float standprice) {
		this.standprice = standprice;
	}

	public String getAudit() {
		return audit;
	}

	public void setAudit(String audit) {
		this.audit = audit;
	}

	public String getInvmethod() {
		return invmethod;
	}

	public void setInvmethod(String invmethod) {
		this.invmethod = invmethod;
	}

	public String getInvcontent() {
		return invcontent;
	}

	public void setInvcontent(String invcontent) {
		this.invcontent = invcontent;
	}

	public float getPreadvance() {
		return preadvance;
	}

	public void setPreadvance(float preadvance) {
		this.preadvance = preadvance;
	}

	public String getCreditcard() {
		return creditcard;
	}

	public void setCreditcard(String creditcard) {
		this.creditcard = creditcard;
	}

	public Date getPaytime() {
		return paytime;
	}

	public void setPaytime(Date paytime) {
		this.paytime = paytime;
	}

	public String getPaynotes() {
		return paynotes;
	}

	public void setPaynotes(String paynotes) {
		this.paynotes = paynotes;
	}

	public float getSepay() {
		return sepay;
	}

	public void setSepay(float sepay) {
		this.sepay = sepay;
	}

	public String getSepayacount() {
		return sepayacount;
	}

	public void setSepayacount(String sepayacount) {
		this.sepayacount = sepayacount;
	}

	public String getSepaynotes() {
		return sepaynotes;
	}

	public void setSepaynotes(String sepaynotes) {
		this.sepaynotes = sepaynotes;
	}

	public Date getSepaytime() {
		return sepaytime;
	}

	public void setSepaytime(Date sepaytime) {
		this.sepaytime = sepaytime;
	}

	public float getPrebalance() {
		return prebalance;
	}

	public void setPrebalance(float prebalance) {
		this.prebalance = prebalance;
	}

	public float getBalance() {
		return balance;
	}

	public void setBalance(float balance) {
		this.balance = balance;
	}

	public String getBalanceacount() {
		return balanceacount;
	}

	public void setBalanceacount(String balanceacount) {
		this.balanceacount = balanceacount;
	}

	public String getBalancenotes() {
		return balancenotes;
	}

	public void setBalancenotes(String balancenotes) {
		this.balancenotes = balancenotes;
	}

	public Date getBalancetime() {
		return balancetime;
	}

	public void setBalancetime(Date balancetime) {
		this.balancetime = balancetime;
	}

	public float getRefund() {
		return refund;
	}

	public void setRefund(float refund) {
		this.refund = refund;
	}

	public String getRefunddesc() {
		return refunddesc;
	}

	public void setRefunddesc(String refunddesc) {
		this.refunddesc = refunddesc;
	}

	public int getProjectcount() {
		return projectcount;
	}

	public void setProjectcount(int projectcount) {
		this.projectcount = projectcount;
	}

	public String getIsfinish() {
		return isfinish;
	}

	public void setIsfinish(String isfinish) {
		this.isfinish = isfinish;
	}

	public String getPaymentclear() {
		return paymentclear;
	}

	public void setPaymentclear(String paymentclear) {
		this.paymentclear = paymentclear;
	}

	public float getPrespefund() {
		return prespefund;
	}

	public void setPrespefund(float prespefund) {
		this.prespefund = prespefund;
	}

	public float getSpefund() {
		return spefund;
	}

	public void setSpefund(float spefund) {
		this.spefund = spefund;
	}

	public String getSpefundtype() {
		return spefundtype;
	}

	public void setSpefundtype(String spefundtype) {
		this.spefundtype = spefundtype;
	}

	public Date getSpefundtime() {
		return spefundtime;
	}

	public void setSpefundtime(Date spefundtime) {
		this.spefundtime = spefundtime;
	}

	public String getSpefunddesc() {
		return spefunddesc;
	}

	public void setSpefunddesc(String spefunddesc) {
		this.spefunddesc = spefunddesc;
	}

	public float getPreacount() {
		return preacount;
	}

	public void setPreacount(float preacount) {
		this.preacount = preacount;
	}

	public float getAcount() {
		return acount;
	}

	public void setAcount(float acount) {
		this.acount = acount;
	}

	public Date getInvtime() {
		return invtime;
	}

	public void setInvtime(Date invtime) {
		this.invtime = invtime;
	}

	public String getInvcode() {
		return invcode;
	}

	public void setInvcode(String invcode) {
		this.invcode = invcode;
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

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getProjectcontent() {
		return projectcontent;
	}

	public void setProjectcontent(String projectcontent) {
		this.projectcontent = projectcontent;
	}

	public String getSales() {
		return sales;
	}

	public void setSales(String sales) {
		this.sales = sales;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
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

	public String getConfirmuser() {
		return confirmuser;
	}

	public void setConfirmuser(String confirmuser) {
		this.confirmuser = confirmuser;
	}

	public Date getConfirmtime() {
		return confirmtime;
	}

	public void setConfirmtime(Date confirmtime) {
		this.confirmtime = confirmtime;
	}

	public Date getCompletetime() {
		return completetime;
	}

	public void setCompletetime(Date completetime) {
		this.completetime = completetime;
	}

	public String getAdvancetype() {
		return advancetype;
	}

	public void setAdvancetype(String advancetype) {
		this.advancetype = advancetype;
	}

	public float getTotalprice() {
		return totalprice;
	}

	public void setTotalprice(float totalprice) {
		this.totalprice = totalprice;
	}

	public float getInvcount() {
		return invcount;
	}

	public void setInvcount(float invcount) {
		this.invcount = invcount;
	}

	public String getInvhead() {
		return invhead;
	}

	public void setInvhead(String invhead) {
		this.invhead = invhead;
	}

	public String getInvtype() {
		return invtype;
	}

	public void setInvtype(String invtype) {
		this.invtype = invtype;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getCollRemarks() {
		return collRemarks;
	}

	public void setCollRemarks(String collRemarks) {
		this.collRemarks = collRemarks;
	}

	public String getObject() {
		return object;
	}

	public void setObject(String object) {
		this.object = object;
	}

	public float getSumOtherscost() {
		return sumOtherscost;
	}

	public void setSumOtherscost(float sumOtherscost) {
		this.sumOtherscost = sumOtherscost;
	}

	public int getClientid() {
		return clientid;
	}

	public void setClientid(int clientid) {
		this.clientid = clientid;
	}

	public float getAdjustinvcount() {
		return adjustinvcount;
	}

	public void setAdjustinvcount(float adjustinvcount) {
		this.adjustinvcount = adjustinvcount;
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

	public float getProjectPrice() {
		return projectPrice;
	}

	public void setProjectPrice(float projectPrice) {
		this.projectPrice = projectPrice;
	}

	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}
	public String getClientContact() {
		return clientContact;
	}
	public void setClientContact(String clientContact) {
		this.clientContact = clientContact;
	}
	public String getBadDebt() {
		return badDebt;
	}
	public void setBadDebt(String badDebt) {
		this.badDebt = badDebt;
	}
	public Integer getGroupId() {
		return groupId;
	}
	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}




}
