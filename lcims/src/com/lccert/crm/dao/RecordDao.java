package com.lccert.crm.dao;

import java.util.List;

public interface RecordDao {
  //�������ڲ�ѯ�ļ�·��
	public List getFilePath(List temp,String date);
	/***
	 * ��recordName����ѯ�ж����ļ���
	 * @param args
	 */
	
	public List getFolder(String area,String date,List temp);
	
	/***
	 * ������ǰ����ѯ����
	 */
		public List getCountFiles(String area,String date,List temp,String obj);
}
