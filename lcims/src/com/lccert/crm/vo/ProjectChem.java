package com.lccert.crm.vo;

import java.util.Date;


/**
 * ���̻�ѧ���ģ��
 * @author lcc
 *
 */
public class ProjectChem {
	private Integer Id	;       //����������
	private String pid	;		//���۵���
	private String rid	;		//�����
	private String projectcontent	;		//���Ե���Ŀ����
	private Date completetime	;		//����ʱ�䣨������ʱ�䣩
	private Integer estimate	;		//���Ʋ��Եĵ���
	private Integer itestcount	;		//ʵ��Ҫ���Եĵ���
	private Date createtime	;		//��һ�ֵý����ʱ��
	private String projectleader	;		//��Ŀ������
	private String projectissuer	;	//��Ŀ�����
	private String item;		//��Ʒ������
	private String sid;			//��Ŀ���
	private String rpclient;    //����Ŀͻ�
	private String samplename ; //��Ʒ������
	private String Object;
	private String Object1;
	private String warning;  //��ĿԤ��
	
	public String getObject() {
		return Object;
	}
	public void setObject(String object) {
		Object = object;
	}
	public String getRpclient() {
		return rpclient;
	}
	public void setRpclient(String rpclient) {
		this.rpclient = rpclient;
	}
	public String getSamplename() {
		return samplename;
	}
	public void setSamplename(String samplename) {
		this.samplename = samplename;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public Integer getId() {
		return Id;
	}
	public void setId(Integer id) {
		Id = id;
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
	public String getProjectcontent() {
		return projectcontent;
	}
	public void setProjectcontent(String projectcontent) {
		this.projectcontent = projectcontent;
	}
	public Date getCompletetime() {
		return completetime;
	}
	public void setCompletetime(Date completetime) {
		this.completetime = completetime;
	}
	public Integer getEstimate() {
		return estimate;
	}
	public void setEstimate(Integer estimate) {
		this.estimate = estimate;
	}
	public Integer getItestcount() {
		return itestcount;
	}
	public void setItestcount(Integer itestcount) {
		this.itestcount = itestcount;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public String getProjectleader() {
		return projectleader;
	}
	public void setProjectleader(String projectleader) {
		this.projectleader = projectleader;
	}
	public String getProjectissuer() {
		return projectissuer;
	}
	public void setProjectissuer(String projectissuer) {
		this.projectissuer = projectissuer;
	}
	public String getObject1() {
		return Object1;
	}
	public void setObject1(String object1) {
		Object1 = object1;
	}
	public String getWarning() {
		return warning;
	}
	public void setWarning(String warning) {
		this.warning = warning;
	}
	

}
