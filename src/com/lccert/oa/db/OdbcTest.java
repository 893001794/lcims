package com.lccert.oa.db;



import java.sql.*;  
import java.net.InetAddress;  
/***
 * ��������Access�����ݿ���
 * @author Administrator
 *
 */
public class OdbcTest {  
	public static void main(String[] args) {     
		try {        
		// ע�������ṩ����       
		Class.forName("org.objectweb.rmijdbc.Driver").newInstance();       
		// ���������ַ���        
		String strurl = "jdbc:rmi://192.168.0.3/jdbc:odbc:yiliu";
		//192.168.70.100Ϊaccess ���ݿ����ڵķ�������ַ��test_dbΪodbc����Դ��       
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


	