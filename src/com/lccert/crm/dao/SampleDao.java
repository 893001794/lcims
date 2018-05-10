package com.lccert.crm.dao;

import java.util.List;

import com.lccert.crm.vo.SamplePackage;
 //��Ʒ��DAO��
public interface SampleDao {
	//���Ӱ�����Ϣ
	public int addSamplePackage(List list);
	//������Ʒ״̬
	public int addSamplePackage1(List list);
	 // ��ѯ������Ϣ
	public List getSamplePackage(List temp);
	//���ݰ����Ż�ȡ������Ϣ
	public List getPackageNo (List list,String pno);
	//���ݰ���id��ȡ������Ϣ
	public List getPackageById (List list,int id);
	//������Ʒ��Ϣ
	public int addSample(List list);
	//������Ʒ�������Ϣ
	public int addSamplePursue(List list);
	//��ѯ��Ʒ
	public List getSample(List list);
	//��ѯ��Ʒ�Ƿ���ֵ
	public List getSampleSno(String sno);
	//����id��ȡ��Ʒ��Ϣ
	public List getSampleById(List list,int id);
	//������Ʒ��Ϣ
	public int upSample(List list);
	 // ���ݱ��۵��Ż�ȡ��Ʒ
	public List getSampleByPid(List list ,String pid,String sno,String client);
	public List getSampleById1(List list,int id);
	//��ѯ��Ʒ������Ϣ
	public List getSamplePurser(List list,String sno);
	//���ɰ����ŵķ���
	public String makePNo();
	//�������ƻ�ȡ�����ַ
	public List getEmailByName(List list,String name);
	//������Ʒ������Ϣ
	public int upOutBound(List list) ;
	//��ȡһ���ֿ�����Ʒ
	public List  getParentLab();
	//��ȡ�����ֿ�����Ʒ
	public List getChildLab(int parentId);
}
