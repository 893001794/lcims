package com.lccert.oa.db;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.lccert.oa.vo.OaVacationType;

public class OaDB {
	/***
	 * SQL SERVER 2000 连接方式
	 */
	Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    private static final ThreadLocal threadLocal = new ThreadLocal();
    private static final String DRIVERCLASS = "com.mysql.jdbc.Driver";
	public Connection getConnection(){
		 try{ 
		        Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver").newInstance(); 
		        System.out.println("数据库驱动程序注册成功！"); 
		        String url ="jdbc:microsoft:sqlserver://192.168.0.3:1433;DatabaseName=att2008"; 
//		        String url ="jdbc:microsoft:sqlserver://192.168.0.2:1433;DatabaseName=telesales"; 
//		        String url ="jdbc:microsoft:sqlserver://localhost:1433;DatabaseName=OA"; 

		        conn = DriverManager.getConnection(url,"root","tomcat");
		        System.out.println("数据库连接成功"); 
		      } 
		   catch(Exception e){ 
		        e.printStackTrace(); 
		                           }
		return conn; 
	}
	
	// 返回影响多少行，增，删，改
	public int getCount(String sql,List temp) {
		System.out.println(sql);
		conn = new OaDB().getConnection();
		int count = 0;
		try {
			pstmt=conn.prepareCall(sql);
			if (temp != null) {
				for (int i = 0; i < temp.size(); i++) {
					pstmt.setObject(i + 1, temp.get(i));
				}
			}
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}
	
	// 查的公共方法
	public List<?> getInfor(List temp,String sql) {
        List row = new ArrayList();
        List column =null;
    	CallableStatement cs = null;
        try {
            conn = new OaDB().getConnection();
            pstmt=conn.prepareStatement(sql);
            rs=pstmt.executeQuery();
            while(rs.next()){
            	column=new ArrayList();
            	for(int i=0;i<temp.size();i++){
            		column.add(rs.getString(temp.get(i).toString()));
            	}
            	row.add(column);
            }
        } catch (Exception ex) {
           System.out.println("错误信息的输出！！！");
        } finally{
            try{
            	closeAll();
            }catch(Exception e){}
        }
        return row;
}
	
	
	/**
	* 调用输出结果集的存储过程
	*/
	public  List callResult(){
	conn=new OaDB().getConnection();
	ResultSet rs =  null; 
	String userName="";
	List list =new ArrayList();
	Date date=null;
	String type =null;
	try {
		pstmt=conn.prepareStatement("{call dbo.monattend}");
	     rs = pstmt.executeQuery();
	 //循环输出结果
	 while(rs.next()){
		 List temp =new ArrayList();
		 userName =rs.getString("name");
		 date =rs.getTimestamp("checktime");
		 String dateStr=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
		 type=rs.getString("type");
		 temp.add(userName);
		 temp.add(dateStr);
		 temp.add(type);
		 list.add(temp);
//		 System.out.println(userName+":name");
	 }
	} catch (Exception e) {
	 e.printStackTrace();
	} finally {
		closeAll();
	}
	return list;
	}
	
	
	
	public void addAttend(List temp){
		conn=new ConnectionToDB().getConnection();
		CallableStatement cs = null;
		ResultSet rs =  null;
		List list =new ArrayList();
//		 cs = conn.prepareCall("{call attend1()}");
		
			try {
				cs = conn.prepareCall("{call insertatt(?,?,?)}");
				for(int i=0;i<temp.size();i++){
					cs.setObject(i+1, temp.get(i));
			 }
				cs.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				closeAll();
			}
	
		 
	}
	
//	// 返回影响多少行，增，删，改
//	public int getCount(String sql, List temp) {
//		int count = 0;
//		try {
//			pstmt = getConnectionMyS().prepareStatement(sql);
//			if (temp != null) {
//				for (int i = 0; i < temp.size(); i++) {
//					pstmt.setObject(i + 1, temp.get(i));
//				}
//			}
//			count = pstmt.executeUpdate();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return count;
//	}

	
	
	
	// 关闭公共方法
	public void closeAll() {
		try {

			if (rs != null) {
				rs.close();
				rs = null;
			}

			if (pstmt != null) {
				pstmt.close();
				pstmt = null;
			}
			if (conn != null) {
				conn.close();
				conn = null;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		List temp =new ArrayList();
			temp.add("namefull");
		String sql ="select * from customer where namefull like '%中山市东凤镇鑫利金属制品有限公%'";
		List rows =new OaDB().getInfor(temp, sql);
		List column =(List)rows.get(0);
		System.out.print(column.get(0));
//		new OaDB().getConnection();
	}
	
}
