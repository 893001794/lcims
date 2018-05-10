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
 * �û���Ϣ��ʵ����
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
		String sql = "SELECT address.PSN_NAME as ����,address.NICK_NAME as �ǳ�,address_group.GROUP_NAME as ����,address.MINISTRATION as ְλ,address.TEL_NO_DEPT as �ֻ�,address.BP_NO as �����,address.EMAIL as �����ʼ���ַ FROM address Inner Join address_group ON address_group.GROUP_ID = address.GROUP_ID";
		rs = getResult(null, sql);
		try {
			while(rs.next()){
				UserInfor user =new UserInfor();
				user.setPSN_NAME(rs.getString("����"));
				user.setNICK_NAME(rs.getString("�ǳ�"));
				user.setGROUP_NAME(rs.getString("����"));
				user.setMINISTRATION(rs.getString("ְλ"));
				user.setMOBIL_NO(rs.getString("�ֻ�"));
				user.setBP_NO(rs.getString("�����"));
				user.setEMAIL(rs.getString("�����ʼ���ַ"));
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
