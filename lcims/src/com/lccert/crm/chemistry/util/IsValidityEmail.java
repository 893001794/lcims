package com.lccert.crm.chemistry.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.TimerTask;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.lccert.crm.user.UserForm;


/**
 * �ж������Ƿ���Ч
 * @author LC
 *
 */
public class IsValidityEmail extends TimerTask{
	@Override
	public void run() {
		addverification();
	}
	public static void main(String[] args) {
		new IsValidityEmail().addverification();
	}
	//������֤
	public boolean addverification(){
		boolean falg=false;
		//��ȡt_email���������ֵ
		List list =new IsValidityEmail().getAllEmal();
		System.out.println(list.size());
		for(int i=0;i<list.size();i++){
			//���������Ϊ��Ч������ͽ��������ַ��ӵ�t_mailright����
			if(isVaildEmail(list.get(i).toString())==true){
				 falg=new IsValidityEmail().addMailright(list.get(i).toString());
			}
			
			//���������Ϊ��Ч������ͽ��������ַ��ӵ�t_mailerror����
			else if(isVaildEmail(list.get(i).toString())==false){
				 falg=new IsValidityEmail().addMailerror(list.get(i).toString());
			}
		}
		return falg;
	}
		
	//��֤�����Ƿ���Ч �ķ��� 
	public static boolean isVaildEmail(String email){ 
		 Pattern p = Pattern.compile("^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_-])+(\\.([a-zA-Z0-9_-])+)+$");
		  Matcher m = p.matcher(email);
		  boolean b = m.matches();
	     return b; 
	} 

	/***
	 * ��Ӵ��������ַ
	 * @param mail���������������
	 * @return
	 */
	public boolean addMailerror(String mail) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "insert into t_mailerror(email) values(?)";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, mail);
			pstmt.executeUpdate();
			//��ӵ�ͬʱ����ɾ��
			if(deleMail(mail) ==true){
			conn.commit();
			}
			isok = true;
		} catch (SQLException e) {
			isok = false;
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(auto);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			DB.close(pstmt);
			DB.close(conn);
		}
		return isok;
	}
	
	/***
	 * �����ȷ�������ַ
	 * @param mail����ȷ���������
	 * @return
	 */
	public boolean addMailright(String mail) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "insert into t_mailright(email) values(?)";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, mail);
			pstmt.executeUpdate();
			conn.commit();
			//��ӵ�ͬʱ����ɾ��
			deleMail(mail);
			isok = true;
		} catch (SQLException e) {
			isok = false;
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(auto);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			DB.close(pstmt);
			DB.close(conn);
		}
		return isok;
	}
	
	//ɾ���ʼ���Ϣ
	public boolean deleMail(String mail) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "delete from t_mail where email=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, mail);
			pstmt.executeUpdate();
			conn.commit();
			isok = true;
		} catch (SQLException e) {
			isok = false;
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(auto);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			DB.close(pstmt);
			DB.close(conn);
		}
		return isok;
	}
	
	/***
	 * ��ѯ���Ե���Ϣ
	 * @return
	 */
	public List getAllEmal() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		UserForm user = null;
		List list =new ArrayList();
		String sql = "select email from t_mail ";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				String mail ="" ;
				mail=rs.getString("email");
				list.add(mail);
			}
			
			conn.commit();
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(auto);
			} catch (Exception e2) {
			}
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return list;
	}



}
