package com.lccert.oa.db;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
/***
 * ����Access���ݿ�Ĺ�����
 * @author tangzp
 *
 */
public class Odbcdb {
	   String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
	   String url = "jdbc:odbc:driver={" +
	   		" Access Driver (*.mdb)};DBQ=C:/global.asa";
	
	   String user = "";
	   String pwd = "";
	   Connection conn;
	   Statement stmt;
	   ResultSet rs;
	
	   //�������ɹ���������
	   public void connect() {
	    try {
	    Class.forName(driver);
	     conn = DriverManager.getConnection(url,user,pwd);
	     stmt = conn.createStatement();
	     System.out.println("���ӳɹ�");
	    } catch (Exception e) {
	     System.out.println(e);
	    }
	   }
	   //�������Թ���������
	   public void connect2() {
	    try {
	     conn = DriverManager.getConnection(url,user,pwd);
	     stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
	    } catch (Exception e) {
	     System.out.println(e);
	    }
	   }
	  
	   //�ر�����
	   public void close() {
	    try {
	     if (stmt != null) {
	      stmt.close();
	     }
	     if (conn != null) {
	      conn.close();
	     }
	    } catch (Exception e) {
	     System.out.println(e);
	    }
	   }
	  
	   //��ѯ���
	   public ResultSet executeQuery(String sql) {
	    try {
	     if (stmt == null) {
	      connect();
	     }
	     rs = stmt.executeQuery(sql);
	    } catch (Exception e) {
	     System.out.println(e);
	    }
	    return rs;
	   }
	   
	   
	   public static void main(String[] args) throws SQLException {
		new Odbcdb().connect();
		ResultSet rs =new Odbcdb().executeQuery("select * from login");
		while (rs.next()){
			System.out.println(rs.getString("id"));
		}
		
	}
	  }
