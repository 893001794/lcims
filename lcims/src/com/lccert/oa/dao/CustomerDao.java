package com.lccert.oa.dao;

import java.util.List;
/***
 * �ͻ�dao
 * @author tangzp
 *
 */
public interface CustomerDao {
	/**
	 * ��ȡ�ͻ���ƺ���������
	 * @return
	 */
	List<?> userList(int status,String keywords);

}
