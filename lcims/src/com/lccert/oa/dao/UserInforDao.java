package com.lccert.oa.dao;

import java.util.List;
/***
 * �û���Ϣdao
 * @author tangzp
 *
 */
public interface UserInforDao {
	/**
	 * ��ȡ������Ա��Ϣ
	 * @return
	 */
	List<?> getAllUserInfor(int groupid);
	/**
	 * ��ȡ���в�����Ϣ
	 * @return
	 */
	List<?> getAllGroupInfor();
	/***
	 * ��ȡadd���е�ĳЩ�ֶ�
	 * @return
	 */
	public List<?> getAllAdd();

}
