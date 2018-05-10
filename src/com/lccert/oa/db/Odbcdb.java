package com.lccert.oa.db;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
/***
 * 连接Access数据库的工具类
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
	
	   //创建不可滚动的连接
	   public void connect() {
	    try {
	    Class.forName(driver);
	     conn = DriverManager.getConnection(url,user,pwd);
	     stmt = conn.createStatement();
	     System.out.println("连接成功");
	    } catch (Exception e) {
	     System.out.println(e);
	    }
	   }
	   //创建可以滚动的连接
	   public void connect2() {
	    try {
	     conn = DriverManager.getConnection(url,user,pwd);
	     stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
	    } catch (Exception e) {
	     System.out.println(e);
	    }
	   }
	  
	   //关闭连接
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
	  
	   //查询语句
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
