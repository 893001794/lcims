package com.lccert.oa.vo;
/***
 * �û���Ϣ��ʵ����
 * @author tangzp
 *
 */
public class UserInfor {
	private int GROUP_ID; //����id
	private String GROUP_NAME; //��������
	private String MINISTRATION; //ְλ
	private String EMAIL;  //�����ַ
	private String PSN_NAME ; //�û�����
	private String NICK_NAME; //�û�Ӣ����
	private String SEX;  //�Ա�
	private String TEL_NO_DEPT; //����
	private String MOBIL_NO ;   //�ֻ�
	private String BP_NO ;   //����
	
	
	
	public String getGROUP_NAME() {
		return GROUP_NAME;
	}
	public void setGROUP_NAME(String gROUP_NAME) {
		GROUP_NAME = gROUP_NAME;
	}
	public String getMINISTRATION() {
		return MINISTRATION;
	}
	public void setMINISTRATION(String mINISTRATION) {
		MINISTRATION = mINISTRATION;
	}
	public String getNICK_NAME() {
		return NICK_NAME;
	}
	public void setNICK_NAME(String nICK_NAME) {
		NICK_NAME = nICK_NAME;
	}
	public String getBP_NO() {
		return BP_NO;
	}
	public void setBP_NO(String bP_NO) {
		BP_NO = bP_NO;
	}

	
	public int getGROUP_ID() {
		return GROUP_ID;
	}
	public void setGROUP_ID(int group_id) {
		GROUP_ID = group_id;
	}
	public String getPSN_NAME() {
		return PSN_NAME;
	}
	public void setPSN_NAME(String psn_name) {
		PSN_NAME = psn_name;
	}
	public String getSEX() {
		return SEX;
	}
	public void setSEX(String sex) {
		SEX = sex;
	}
	public String getTEL_NO_DEPT() {
		return TEL_NO_DEPT;
	}
	public void setTEL_NO_DEPT(String tel_no_dept) {
		TEL_NO_DEPT = tel_no_dept;
	}
	public String getMOBIL_NO() {
		return MOBIL_NO;
	}
	public void setMOBIL_NO(String mobil_no) {
		MOBIL_NO = mobil_no;
	}
	public String getEMAIL() {
		return EMAIL;
	}
	public void setEMAIL(String email) {
		EMAIL = email;
	}

}
