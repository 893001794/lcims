package com.lccert.crm.quotation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import com.lccert.crm.chemistry.util.DB;

public class EdmAction {
	private static EdmAction instance = new EdmAction();

	private EdmAction() {

	}

	public static EdmAction getInstance() {
		return instance;
	}
	
	//查询有多少个采样员
	public Set getAllQC() {
		//System.out.println(pid);
		String sql = "select userid  from t_edm_quoitem";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Set set =new HashSet();
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()){
				String [] userStr=rs.getString("userid").split(",");
				for(int i =0;i<userStr.length;i++){
					set.add(userStr[i]);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return set;
	}
	
	//查询每个采样员一共有多少个状态的统计表
	public List getTypeByUserId(String userId,String year,String month) {
//		System.out.println(userId);
		String sql = "select  (select count(*) from t_edm_quoitem where userid like '%"+userId+"%' and  etype ='A' and vpid like 'LCDE"+year+month+"%') as A, (select count(*)  from t_edm_quoitem where userid like '%"+userId+"%' and  etype ='B' and vpid like 'LCDE"+year+month+"%') as B, (select count(*)  from t_edm_quoitem where userid like '%"+userId+"%' and  etype ='C'and vpid like 'LCDE"+year+month+"%' ) as C,(select count(*)  from t_edm_quoitem where userid like '%"+userId+"%' and  etype ='D' and vpid like 'LCDE"+year+month+"%') as D,(select count(*)  from t_edm_quoitem where userid like '%"+userId+"%' and  etype ='E' and vpid like 'LCDE"+year+month+"%') as E,(select count(*)  from t_edm_quoitem where userid like '%"+userId+"%' and  etype ='F' and vpid like 'LCDE"+year+month+"%' ) as F";
//		System.out.println(sql);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList();
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
		//	pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("A"));
				list.add(rs.getString("B"));
				list.add(rs.getString("C"));
				list.add(rs.getString("D"));
				list.add(rs.getString("E"));
				list.add(rs.getString("F"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return list;
	}
	
	
	//根据id获取用户名称
	public String getUserName(int id){
		String sql = "select name  from t_user where id =?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String name =null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()){
			name =rs.getString("name");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return name;
		
	}
	
	/**
	 * 根据用户名称查询采样员的状态明细表
	 * @param args
	 */
	//查询每个采样员一共有多少个状态的统计表
	public List getAllByUserId(String userId,String year,String month) {
		String sql = "select *  from t_edm_quoitem where userid like '%"+userId+"%' and vpid like 'LCDE"+year+month+"%'";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List temp =new ArrayList();
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
		//	pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				List list =new ArrayList();
				list.add(rs.getString("vpid"));
				list.add(getUserName(Integer.parseInt(userId)));
				list.add(rs.getString("etype"));
				temp.add(list);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return temp;
	}
	
	

	public static void main(String[] args) {
		Set set =new EdmAction().getAllQC();
		Iterator it =set.iterator();
		while(it.hasNext()){
            String temp = it.next().toString();
            String name =new EdmAction().getUserName(Integer.parseInt(temp));
//            System.out.println(name);
     }            

	}
	
}
