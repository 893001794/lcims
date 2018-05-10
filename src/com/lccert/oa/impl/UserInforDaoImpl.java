package com.lccert.oa.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.lccert.oa.dao.UserInforDao;
import com.lccert.oa.db.ConnectionToDB;

import com.lccert.oa.vo.Group;
import com.lccert.oa.vo.UserInfor;

/***
 * 用户信息的实现类
 * @author tangzp
 *
 */
public class UserInforDaoImpl extends  ConnectionToDB implements UserInforDao {

	public List<?> getAllUserInfor(int groupid) {
		ResultSet rs=null;
		List<Object> ls = new ArrayList<Object>();
		StringBuffer str =new StringBuffer();
		if(groupid>0){
			str.append(" and GROUP_ID ="+groupid+"");
		}
		
		String sql = "SELECT GROUP_ID,PSN_NAME,SEX,TEL_NO_DEPT,MOBIL_NO,BP_NO,EMAIL FROM address where 1=1 "+str;

		rs = getResult(null, sql);
		
		try {
			while(rs.next()){
				UserInfor user =new UserInfor();
				user.setGROUP_ID(rs.getInt("GROUP_ID"));
				user.setPSN_NAME(rs.getString("PSN_NAME"));
				user.setSEX(rs.getString("SEX"));
				user.setTEL_NO_DEPT(rs.getString("TEL_NO_DEPT"));
				user.setMOBIL_NO(rs.getString("MOBIL_NO"));
				user.setBP_NO(rs.getString("BP_NO"));
				user.setEMAIL(rs.getString("EMAIL"));
				ls.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeAll();
		}
		
		return ls;
	
	}
	public List<?> getAllAdd() {
		ResultSet rs=null;
		List<Object> ls = new ArrayList<Object>();
		String sql = "SELECT address.PSN_NAME as 姓名,address.NICK_NAME as 昵称,address_group.GROUP_NAME as 部门,address.MINISTRATION as 职位,address.TEL_NO_DEPT as 手机,address.BP_NO as 天翼号,address.EMAIL as 电子邮件地址 FROM address Inner Join address_group ON address_group.GROUP_ID = address.GROUP_ID";
		rs = getResult(null, sql);
		try {
			while(rs.next()){
				UserInfor user =new UserInfor();
				user.setPSN_NAME(rs.getString("姓名"));
				user.setNICK_NAME(rs.getString("昵称"));
				user.setGROUP_NAME(rs.getString("部门"));
				user.setMINISTRATION(rs.getString("职位"));
				user.setMOBIL_NO(rs.getString("手机"));
				user.setBP_NO(rs.getString("天翼号"));
				user.setEMAIL(rs.getString("电子邮件地址"));
				ls.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeAll();
		}
		
		return ls;
		
	}

	public List<?> getAllGroupInfor() {
		ResultSet rs=null;
		List<Object> ls = new ArrayList<Object>();
		
		String sql = "SELECT GROUP_ID,GROUP_NAME FROM address_group";
		rs = getResult(null, sql);
		
		try {
			while(rs.next()){
				Group group =new Group();
				group.setGROUP_ID(rs.getInt("GROUP_ID"));
				group.setGROUP_NAME(rs.getString("GROUP_NAME"));
				ls.add(group);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeAll();
		}
		
		return ls;
	}


}
