package com.lccert.oa.db;



import java.sql.*;  
import java.net.InetAddress;  
/***
 * 测试连接Access的数据库类
 * @author Administrator
 *
 */
public class OdbcTest {  
	public static void main(String[] args) {     
		try {        
		// 注册数据提供程序       
		Class.forName("org.objectweb.rmijdbc.Driver").newInstance();       
		// 数据链接字符串        
		String strurl = "jdbc:rmi://192.168.0.3/jdbc:odbc:yiliu";
		//192.168.70.100为access 数据库所在的服务器地址，test_db为odbc数据源名       
		java.sql.Connection c = DriverManager.getConnection(strurl, "", "");        
		java.sql.Statement st = c.createStatement();       
		java.sql.ResultSet rs = st.executeQuery("select * from login");        
		java.sql.ResultSetMetaData md = rs.getMetaData();        
		while(rs.next()) {          
		System.out.print("\n");          
		for(int i=1; i<= md.getColumnCount(); i++) {            
			System.out.print(rs.getString(i) + " | ");         
			}        
		}        rs.close();     
			} catch(Exception e) {       
				e.printStackTrace();     
				}    
			} 


	}


	