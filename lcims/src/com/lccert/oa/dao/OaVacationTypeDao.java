package com.lccert.oa.dao;

import java.util.List;

/***
 * oaϵͳ��������
 * @author tangzp
 *
 */
public interface OaVacationTypeDao {
	//��ȡ���м������͵���Ϣ
	public List getOaVacationInfor(int month,int year,String beginUser,String status);
	//���ݹؼ���ȥ��ѯ�û���Id
	public int getUserIdByKey(String keyWord);
	//��ȡ��������
	public List getDept();
	//���ݶ�����id��ȡ��������
	public List getIdByParentID(int parentId);
	//���ݲ���id��ȡ��Ա
	public List getNameBydeptId(int deptId);
	//��ȡsql servser 2000 �е�monselect �洢����
	public List getSqlInfor(String userName ,String date);
	public int addAttend(List temp);
}
