package com.lccert.crm.vo;

import java.util.Date;

/**
 * ��ȡ�ۺ���Ϣ���ۺϰ����ٵ��ʣ���������ȷ��ͳ�ƣ�
 * @author tangzp
 *
 */
public class Synthesis {
	private int id ;
	private String sid;  //��Ŀ���
	private String rid ; //������
	private String pid ;  //���۵���
	private Date rptime ; //Ӧ������ʱ��
	private Date sendtime ; //����ʵ�����ʱ��
	private Date createtime ; //�ŵ�ʱ��
	private String level;   //��Ŀ�ȼ�
	private String testcontent; //������Ŀ
	private String servname ; //�ͷ���Ա
	private String engineer ; //����ʦ
	private String status; //״̬
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getTestcontent() {
		return testcontent;
	}
	public void setTestcontent(String testcontent) {
		this.testcontent = testcontent;
	}
	public String getServname() {
		return servname;
	}
	public void setServname(String servname) {
		this.servname = servname;
	}
	public String getEngineer() {
		return engineer;
	}
	public void setEngineer(String engineer) {
		this.engineer = engineer;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getRptime() {
		return rptime;
	}
	public void setRptime(Date rptime) {
		this.rptime = rptime;
	}

	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public Date getSendtime() {
		return sendtime;
	}
	public void setSendtime(Date sendtime) {
		this.sendtime = sendtime;
	}
	

}
