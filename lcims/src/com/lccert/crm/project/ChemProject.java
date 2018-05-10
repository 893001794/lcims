package com.lccert.crm.project;

import java.util.Date;
import java.util.List;

/**
 * ��ѧ��Ŀʵ����
 * @author Eason
 *
 */
public class ChemProject {
	private String sales;
	private String pid ;
	private String rid ;
	private String client;
	private String sid ;
	//����Ӧ��ʱ��
	private Date rptime;
	//����ͻ�
	private String rpclient;
	//�������ʱ��
	private Date endtime;
	//���������
	private String enduser;
	//���淢��ʱ��
	private Date sendtime;
	//���淢����
	private String senduser;
	//��������
	private String rptype;
	//��ĿԤ��
	private String warning;
	//���������Ϣ
	private String appform;
	//��ת������
	private int flowcount;
	//��Ʒ����
	private String samplename;
	//��Ʒ����
	private String sampledesc;
	//��Ʒ����
	private String samplecount;
	//�ͻ���ϵ��
	private String contact;
	//��Ŀ����ʦ
	private String engineer;
	//��Ŀ����
	private String workpoint;
	//��Ŀ�Ƿ����
	private String projectend;
	//��Ŀ״̬
	private String status;
	//��Ŀ�ŵ���
	private String createname;
	//��Ŀ�ŵ�ʱ��
	private Date createtime;
	//�����Ƿ����
	private String isfinish;
	//
	private String addnotes;
	//ʵ����ʱ��
	private List<ChemLabTime> list;
	//�ͷ���Ա
	private String servname;
	//�Ƿ�������
	private String ischecked;
	//��Ŀ״̬ID
	private int istatus;
	//ɢ����ʳƷ����Ʒ
	private String item;
	//������ַ
	private String filepath;
	
	private Date masendtime;
	
	private String ismethod;
	private String clientE;
	
	private Date rpconfirmtime; 		    //�������ʱ��
	private Date nucopletintime;	  		//�������ʱ��
	private String rpconfirmuser;	  		//���������
	private String nucopletinuser;	    	//����������
	private Object obj;
	private String draft;     //�ݸ��
	private String paystatus; // �Ƿ��Ѿ������
	private String pay; //���ʽ��
	private Date drafsinishtime;  //�ݸ����ʱ��
	private String granttime; //���ӵ�����ʱ��
	private String filingNo; //�������(��ױƷ���˶��屨�����)
	private Integer comappid; //��ױƷ�����
	
	public String getPaystatus() {
		return paystatus;
	}
	public void setPaystatus(String paystatus) {
		this.paystatus = paystatus;
	}
	public String getPay() {
		return pay;
	}
	public void setPay(String pay) {
		this.pay = pay;
	}
	public String getDraft() {
		return draft;
	}
	public void setDraft(String draft) {
		this.draft = draft;
	}
	public Date getMasendtime() {
		return masendtime;
	}
	public void setMasendtime(Date masendtime) {
		this.masendtime = masendtime;
	}
	public String getIsmethod() {
		return ismethod;
	}
	public void setIsmethod(String ismethod) {
		this.ismethod = ismethod;
	}
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public int getIstatus() {
		return istatus;
	}
	public void setIstatus(int istatus) {
		this.istatus = istatus;
	}
	public String getIschecked() {
		return ischecked;
	}
	public void setIschecked(String ischecked) {
		this.ischecked = ischecked;
	}
	public String getServname() {
		return servname;
	}
	public void setServname(String servname) {
		this.servname = servname;
	}
	public String getAddnotes() {
		return addnotes;
	}
	public void setAddnotes(String addnotes) {
		this.addnotes = addnotes;
	}
	public Date getRptime() {
		return rptime;
	}
	public void setRptime(Date rptime) {
		this.rptime = rptime;
	}
	public String getRpclient() {
		return rpclient;
	}
	public void setRpclient(String rpclient) {
		this.rpclient = rpclient;
	}
	public Date getEndtime() {
		return endtime;
	}
	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}
	public String getEnduser() {
		return enduser;
	}
	public void setEnduser(String enduser) {
		this.enduser = enduser;
	}
	public Date getSendtime() {
		return sendtime;
	}
	public void setSendtime(Date sendtime) {
		this.sendtime = sendtime;
	}
	public String getSenduser() {
		return senduser;
	}
	public void setSenduser(String senduser) {
		this.senduser = senduser;
	}
	public String getRptype() {
		return rptype;
	}
	public void setRptype(String rptype) {
		this.rptype = rptype;
	}
	public String getWarning() {
		return warning;
	}
	public void setWarning(String warning) {
		this.warning = warning;
	}
	public String getAppform() {
		return appform;
	}
	public void setAppform(String appform) {
		this.appform = appform;
	}
	public int getFlowcount() {
		return flowcount;
	}
	public void setFlowcount(int flowcount) {
		this.flowcount = flowcount;
	}
	public String getSamplename() {
		return samplename;
	}
	public void setSamplename(String samplename) {
		this.samplename = samplename;
	}
	public String getSampledesc() {
		return sampledesc;
	}
	public void setSampledesc(String sampledesc) {
		this.sampledesc = sampledesc;
	}
	public String getSamplecount() {
		return samplecount;
	}
	public void setSamplecount(String samplecount) {
		this.samplecount = samplecount;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getEngineer() {
		return engineer;
	}
	public void setEngineer(String engineer) {
		this.engineer = engineer;
	}
	public String getWorkpoint() {
		return workpoint;
	}
	public void setWorkpoint(String workpoint) {
		this.workpoint = workpoint;
	}
	public String getProjectend() {
		return projectend;
	}
	public void setProjectend(String projectend) {
		this.projectend = projectend;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCreatename() {
		return createname;
	}
	public void setCreatename(String createname) {
		this.createname = createname;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public String getIsfinish() {
		return isfinish;
	}
	public void setIsfinish(String isfinish) {
		this.isfinish = isfinish;
	}
	public List<ChemLabTime> getList() {
		return list;
	}
	public void setList(List<ChemLabTime> list) {
		this.list = list;
	}
	public String getClientE() {
		return clientE;
	}
	public void setClientE(String clientE) {
		this.clientE = clientE;
	}

	public String getNucopletinuser() {
		return nucopletinuser;
	}
	public void setNucopletinuser(String nucopletinuser) {
		this.nucopletinuser = nucopletinuser;
	}
	public Date getRpconfirmtime() {
		return rpconfirmtime;
	}
	public void setRpconfirmtime(Date rpconfirmtime) {
		this.rpconfirmtime = rpconfirmtime;
	}
	public Date getNucopletintime() {
		return nucopletintime;
	}
	public void setNucopletintime(Date nucopletintime) {
		this.nucopletintime = nucopletintime;
	}
	public String getRpconfirmuser() {
		return rpconfirmuser;
	}
	public void setRpconfirmuser(String rpconfirmuser) {
		this.rpconfirmuser = rpconfirmuser;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getSales() {
		return sales;
	}
	public void setSales(String sales) {
		this.sales = sales;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public Object getObj() {
		return obj;
	}
	public void setObj(Object obj) {
		this.obj = obj;
	}
	public Date getDrafsinishtime() {
		return drafsinishtime;
	}
	public void setDrafsinishtime(Date drafsinishtime) {
		this.drafsinishtime = drafsinishtime;
	}
	public String getGranttime() {
		return granttime;
	}
	public void setGranttime(String granttime) {
		this.granttime = granttime;
	}
	public String getFilingNo() {
		return filingNo;
	}
	public void setFilingNo(String filingNo) {
		this.filingNo = filingNo;
	}
	public Integer getComappid() {
		return comappid;
	}
	public void setComappid(Integer comappid) {
		this.comappid = comappid;
	}
	

}
