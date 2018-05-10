package com.lccert.crm.dao.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.lccert.crm.dao.RecordDao;
import com.lccert.oa.db.ImsDB;

public class RecordDaoImpl implements RecordDao {
/***
 * 根据日前来查询日期
 */
	public List getFilePath(List temp,String date) {
		String sql ="select * from t_record where drecordate=?";
//		System.out.println(sql+"-------"+date);
		return new ImsDB().getInforByObject(temp,sql,date);
	}
	/***
	 * 添加Record表
	 * @param temp 用来转载添加的字段
	 * @return
	 */
	public int addRecord(List temp){
		String sql ="insert into t_record (varea,drecordate,vecordname,count,filepate) values (?,?,?,?,?)";
		return new ImsDB().getCount(sql, temp);
	}

	/***
	 * 按recordName来查询有多少文件夹
	 * @param args
	 */
	
	public List getFolder(String area,String date,List temp){
		String sql ="select * from t_record  where varea='"+area+"'  and drecordate='"+date+"'  group by vecordname";
//		System.out.println(sql);
		return new ImsDB().getInfor(temp, sql);
	}
	
	
	/***
	 * 根据日前来查询日期
	 */
		public List getCountFiles(String area,String date,List temp,String obj) {
			String sql ="select count(*) as a  from t_record  where varea='"+area+"'  and drecordate='"+date+"' and  vecordname =?";
			return new ImsDB().getInforByObject(temp,sql,obj);
		}
		
		
	public static void main(String[] args) {
		List folderL=new ArrayList();
		folderL.add("vecordname");
		List rows =new RecordDaoImpl().getFolder("C","20111024",folderL);
		List count =new ArrayList ();
		count.add("a");
		List condition=new ArrayList();
		
		for(int i =0;i<rows.size();i++){
			condition=(List)rows.get(i);
//			List rows1 =new RecordDaoImpl().getCountFiles(count,condition.get(0).toString());
//			for(int j =0;j<rows1.size();j++){
//				List column=(List)rows1.get(j);
//				System.out.println(column.get(0));
//			}
		}
		
	}
}
