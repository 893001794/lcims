package com.lccert.oa.db;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.lccert.oa.vo.OaVacationType;
/***
 * 连接多个数据库的测试类
 * @author tangzp
 *
 */

public class MyTest {

String strDriver="sun.jdbc.odbc.JdbcOdbcDriver";
String strUrl="jdbc:odbc:driver={Microsoft Access Driver (*.mdb)};DBQ=C:/global.asa";
String strUserName="";
String strPassword="";
String strSQL="select * from login";
Connection conn;
Statement stmt;
ResultSet rs;


public MyTest(){

 System.out.println("进入构造器");
 try{
	 
	 //
  Class.forName(strDriver);

  conn=DriverManager.getConnection(strUrl, strUserName, strPassword);

  stmt=conn.createStatement();

  rs=stmt.executeQuery(strSQL);

  System.out.println("以返回结果集");

 
  while(rs.next()){
   System.out.println(rs.getString("id"));
  }
 
 }catch(Exception e){
  System.out.println("报错");
  e.printStackTrace();
 }

}


public static void main(String args[]){
ConnectionToDB con =new ConnectionToDB();
//con.getConnection();
	List temp =new ArrayList();
	temp.add("dept_id");
	String sql ="select dept_id  from department where dept_parent =29";
	List row=con.getInfor(temp, sql);
for(int i=0;i<row.size();i++){
	List column =(List)row.get(i);
		List list =new ArrayList();
		list.add("uId");
		list.add("user_id");
		list.add("user_name");
		String sql1 ="select uId,user_id ,user_name from user  where  dept_id !=0 and  dept_id !=17 and dept_id ="+Integer.parseInt(column.get(0).toString())+"";
		System.out.println(sql1);
		List row1=con.getInfor(list, sql1);
		for(int j=0;j<row1.size();j++){
			List column1 =(List)row1.get(j);
			System.out.println(column1.get(0));
		}
}

}




}


