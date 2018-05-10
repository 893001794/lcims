package com.temp;

import org.apache.log4j.Logger;
import java.net.InetAddress;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.user.UserForm;
import com.lccert.oa.searchFactory.SearchFactory;
import com.lccert.oa.vo.UserInfor;
import java.io.*;
import java.net.*;

public class Test {
	public boolean addverification(){
		List list =new Test().getAllEmal();
		for(int i=0;i<list.size();i++){
			if(isVaildEmail(list.get(i).toString())==true){
				boolean falg=new Test().addMailright(list.get(i).toString());
			}
			
			
			if(isVaildEmail(list.get(i).toString())==false){
				boolean falg=new Test().addMailerror(list.get(i).toString());
				System.out.println(falg);
			}
		}
		return false;
	}
		 public static void main(String[] args) {
			 List list =new Test().getAllEmal();
			 for(int i=0;i<list.size();i++){
					if(isVaildEmail(list.get(i).toString())==true){
						boolean falg=new Test().addMailright(list.get(i).toString().toLowerCase());
					}
					if(isVaildEmail(list.get(i).toString())==false){
						boolean falg=new Test().addMailerror(list.get(i).toString().toLowerCase());
						System.out.println(falg);
					}
				}
		 }
	
	public static boolean isVaildEmail(String email){ 
		 Pattern p = Pattern.compile("^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_-])+(\\.([a-zA-Z0-9_-])+)+$");
		  Matcher m = p.matcher(email);
		  boolean b = m.matches();
	     return b; 
	} 

	
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
	
//	public static boolean validateEmail(String email) {
//		  boolean flag = false;
//		  int pos = email.indexOf("@");
//		  if (pos == -1 || pos == 0 || pos == email.length() - 1) {
//		   return false;
//		  }
//		  String[] strings = email.split("@");
//		  if (strings.length != 2) {// 如果邮箱不是xxx@xxx格式
//		   return false;
//		  }
//		  CharSequence cs = strings[0];
//		  for (int i = 0; i < cs.length(); i++) {
//		   char c = cs.charAt(i);
//		   if (!Character.isLetter(c) && !Character.isDigit(c)) {
//		    return false;
//		   }
//		  }
//		  pos = strings[1].indexOf(".");// 如果@后面没有.，则是错误的邮箱。
//		  if (pos == -1 || pos == 0 || pos == email.length() - 1) {
//		   return false;
//		  }
//		  strings = strings[1].split(".");
//		  for (int j = 0; j < strings.length; j++) {
//		   cs = strings[j];
//		   if (cs.length() == 0) {
//		    return false;
//		   }
//		   for (int i = 0; i < cs.length(); i++) {//如果保护不规则的字符，表示错误
//		    char c = cs.charAt(i);
//		    if (!Character.isLetter(c) && !Character.isDigit(c)) {
//		     return false;
//		    }
//		   }
//
//		  }
//		  return true;
//		 }
	
	
	}




