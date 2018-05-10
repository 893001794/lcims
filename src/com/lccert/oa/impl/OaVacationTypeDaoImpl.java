package com.lccert.oa.impl;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import com.lccert.oa.dao.OaVacationTypeDao;
import com.lccert.oa.db.ConnectionToDB;
import com.lccert.oa.db.OaDB;
import com.lccert.oa.vo.OaVacationType;


public class OaVacationTypeDaoImpl implements OaVacationTypeDao {
	ConnectionToDB ct=new ConnectionToDB();
	//获取oa中的attend表的存储过程
	public List getOaVacationInfor(int month, int year, String beginUser,String status) {
		Connection con =ct.getConnection();
		CallableStatement cs = null;
		ResultSet rs =  null;
		List list =new ArrayList();
		OaVacationType ovt=null;
		try {
//		 cs = con.prepareCall("{call attend(?,?,?)}");
		 cs = con.prepareCall("{call attend(?,?,?)}");
		 cs.setInt(1, month);
		 cs.setInt(2, year);
		 cs.setString(3, beginUser);
		 rs = cs.executeQuery();
		 //循环输出结果
		 while(rs.next()){
		  ovt=new OaVacationType();
		  ovt.setBegin_user(rs.getString("begin_user"));
		  ovt.setData_1(rs.getString("data_1"));
		  ovt.setData_3(rs.getString("data_3"));
		  ovt.setData_11(rs.getString("data_11"));
		  ovt.setData_5(rs.getString("data_5"));
		  ovt.setData_6(rs.getString("data_6"));
		  ovt.setData_111(rs.getString("data_12"));
		  ovt.setData_112(rs.getString("data_13"));
		  ovt.setData_7(rs.getString("data_7"));
		  ovt.setData_8(rs.getString("data_8"));
		  ovt.setData_8(rs.getString("data_8"));
		  ovt.setRun_id(rs.getString("run_id"));
		  list.add(ovt);
		 }
		} catch (Exception e) {
		 e.printStackTrace();
		} finally {
		 try {
		  if(rs != null){
		   rs.close();
		  }
		  if(cs != null){
		   cs.close();
		  }
		  if(con != null){
		   con.close();
		  }
		 } catch (Exception ex) {
		  ex.printStackTrace();
		 }
		}
		return list;
		}

	/***
	 * 根据关键字去查询用户的Id
	 */
	public int getUserIdByKey(String keyWord) {
		
		return 0;
	}

	//获取顶级部门
	
	public List getDept() {
		List temp =new ArrayList();
		temp.add("dept_id");
		temp.add("dept_name");
		String sql ="select * from department where dept_parent =0";
		return ct.getInfor(temp, sql);
	}

	//根据顶级id获取他的二级的部门id
	public List getIdByParentID(int parentId) {
		List temp =new ArrayList();
		temp.add("dept_id");
		String sql ="select dept_id  from department where dept_parent ="+parentId+"";
		return ct.getInfor(temp, sql);
	}

	//根据部门Id获取用户名和id
	public List getNameBydeptId(int deptId) {
		List temp =new ArrayList();
		temp.add("uId");
		temp.add("user_id");
		temp.add("user_name");
		String sql ="select uId,user_id ,user_name from user  where  dept_id !=0 and  dept_id !=17 and dept_id ="+deptId+"";
		return ct.getInfor(temp, sql);
	}
	
	//获取sql servser2000 2008中的monselect存储过程
	public List getSqlInfor(String userName ,String date){
		List temp =new ArrayList();
		temp.add("userid");
		temp.add("checktime");
		String sql ="{call dbo.monselect('"+userName+"','"+date+"')}";
		System.out.println(sql+"---oasql");
		return new OaDB().getInfor(temp, sql);
	}

	public int addAttend(List temp) {
		String sql ="{call dbo.moninsert(?,?,?,?,?)}";
		return new OaDB().getCount(sql,temp);
	}
	
	
}
