package com.lccert.crm.dao;

import java.util.List;

import com.lccert.crm.vo.Subject;

/**
 * ��Ŀdao
 * @author LC
 *
 */
public interface SubjectDao {
	 //�����������Ʋ�ѯһ���Ͷ�������
	public Subject getSubByFirstSubName(String firstName);
}
