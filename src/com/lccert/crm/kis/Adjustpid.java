package com.lccert.crm.kis;
/***
 * ���۵����ͳ�new��������͵�ʵ����
 * @author tangzp
 *
 */
public class Adjustpid {
	private String pid ;  //���۵���
	private String rid ;  //������
	private Float fadjustinvcount;  //�޸ı��۵��ܽ��
	private String status ;  //״̬(�ж��Ƿ����)
	private String equotype ;  //���۵�������(�����ز⡢��ӱ��桢��챨�۵� )
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
	public Float getFadjustinvcount() {
		return fadjustinvcount;
	}
	public void setFadjustinvcount(Float fadjustinvcount) {
		this.fadjustinvcount = fadjustinvcount;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getEquotype() {
		return equotype;
	}
	public void setEquotype(String equotype) {
		this.equotype = equotype;
	}

}
