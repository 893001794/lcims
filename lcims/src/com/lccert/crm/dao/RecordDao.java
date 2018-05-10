package com.lccert.crm.dao;

import java.util.List;

public interface RecordDao {
  //根据日期查询文件路径
	public List getFilePath(List temp,String date);
	/***
	 * 按recordName来查询有多少文件夹
	 * @param args
	 */
	
	public List getFolder(String area,String date,List temp);
	
	/***
	 * 根据日前来查询日期
	 */
		public List getCountFiles(String area,String date,List temp,String obj);
}
