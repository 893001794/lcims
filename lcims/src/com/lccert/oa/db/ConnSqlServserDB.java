package com.lccert.oa.db;

import java.io.FileInputStream;

import java.io.FileNotFoundException;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.internet.MimeMessage;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.oa.vo.Customer;
import com.lccert.oa.vo.OaVacationType;
import com.lccert.oa.vo.UserForm;
import com.mysql.jdbc.Statement;
/***
 * SQL SERVER 2000 连接方式
 */
public class ConnSqlServserDB {
	
	Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
	public Connection getConnection(String status){
		 try{ 
		        Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver").newInstance(); 
//		        System.out.println("数据库驱动程序注册成功！"); 
		        String url ="";
		        if(status.equals("销售一部")){
		        	url ="jdbc:microsoft:sqlserver://192.168.0.2:1433;DatabaseName=telesales"; 
		        }else   if(status.equals("销售二部")){
		        	url ="jdbc:microsoft:sqlserver://192.168.0.3:1433;DatabaseName=telesales"; 
//		        	url ="jdbc:microsoft:sqlserver://192.168.0.3:1433;DatabaseName=att2008"; 
		        }else   if(status.equals("广州公司")){
		        	url ="jdbc:microsoft:sqlserver://192.168.1.254:1433;DatabaseName=telesales"; 
		        }else   if(status.equals("东莞公司")){
		        	url ="jdbc:microsoft:sqlserver://10.11.1.223:1433;DatabaseName=telesales"; 
		        }
		        
		        
		       
		        conn = DriverManager.getConnection(url,"root","tomcat");
//		        System.out.println("数据库连接成功"); 
		      } 
		   catch(Exception e){ 
		        e.printStackTrace(); 
		        System.out.print("test-error");
		                           }
		return conn; 
	}
	
	//查询oa(sql server2000)t_user表中的username和password值
	public List<?> userNameAndPwd(String drep,String ctsname) {
		        List list = new ArrayList();
//		        select * from t_user where userid = ? and password = md5(?) and estatus = '有效'
		        String sql = "select username,password from users where username=?";
		        try {
		            conn = getConnection(drep);
		            ps=conn.prepareStatement(sql);
		            ps.setString(1, ctsname);
		            rs=ps.executeQuery();
		            while(rs.next()){
		            	UserForm uf = new UserForm();
		            	uf.setCtsname(rs.getString("username"));
		            	uf.setPwd(rs.getString("password"));
		                list.add(uf);
		            }
		        } catch (Exception ex) {
		           System.out.println("错误信息的输出！！！");
		        } finally{
		            try{
		                if(rs!=null)rs.close();
		                if(ps!=null)ps.close();
		                if(conn!=null)conn.close();
		            }catch(SQLException e){}
		        }
		        return list;
	}
	
	
	/**
	* 调用输出结果集的存储过程
	*/
	public  List callResult(){
	conn=new ConnSqlServserDB().getConnection("销售二部");
	CallableStatement cs = null;
	ResultSet rs =  null; 
	String userName="";
	List list =new ArrayList();
	String type="";
	Date date=null;
	try {
		
//		 ps=conn.prepareStatement("{call dbo.attend}");
		 ps=conn.prepareStatement("{call dbo.monattend}");
	     rs = ps.executeQuery();

	
	 //循环输出结果
	 while(rs.next()){
		 List temp =new ArrayList();
		 userName =rs.getString("name");
		 date =rs.getTimestamp("checktime");
		 type =rs.getString("type");
		 temp.add(userName);
		 temp.add(date);
		 temp.add(type);
		 list.add(temp);
		 
//		 System.out.println(userName+":name");
	 }
	
//	 for(int i=1;rs.next();i++){
//		 System.out.println(i+"----i");
//		 System.out.println(rs.getString(i));
//		 
//	 }
//	 }
	} catch (Exception e) {
	 e.printStackTrace();
	} finally {
	 try {
	  if(rs != null){
	   rs.close();
	  }
	  if(cs != null){
	   cs.close();
	  }
	  if(conn != null){
	   conn.close();
	  }
	 } catch (Exception ex) {
	  ex.printStackTrace();
	 }
	}
	return list;
	}
	
	// 返回影响多少行，增，删，改
	public int getCount(String sql,List temp) {
		 conn = getConnection("销售一部");
		int count = 0;
		try {
			ps=conn.prepareCall(sql);
			if (temp != null) {
				for (int i = 0; i < temp.size(); i++) {
					ps.setObject(i + 1, temp.get(i));
				}
			}
			count = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public boolean modiyPwd(String newPwd ,String userName,String drep){
		String sql = "update users set password=? where username=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean falg =false;
		try {
			 conn = getConnection(drep);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newPwd);
			pstmt.setString(2, userName);
			pstmt.executeUpdate();
			conn.commit();
			falg=true;
		} catch (SQLException e) {
			falg=false;
			e.printStackTrace();
		} finally {
			DB.close(pstmt);
			DB.close(conn);
		}
		return falg;
	}

//	  public static void main(String[] args) {
////		  List list =new ConnSqlServserDB().callResult();
////		  for(int i=0;i<list.size();i++){
////			  List temp =(List)list.get(i);
////			  System.out.println(temp.get(0)+"-----"+temp.get(1));
////			
////		  }
//		 List list = new ConnSqlServserDB().userNameAndPwd("销售一部","candy");
//		 System.out.println(list.size()+"----------------------");
//		 for(int i=0;i<list.size();i++){
//			 UserForm uf =(UserForm)list.get(i);
//			 System.out.print("用户名："+uf.getCtsname()+"\n");
//			 System.out.print("密码："+uf.getPwd());
//		 }
//	}
//	  
	  public static void main(String[] args) {
		  List list =new ArrayList();
		  list.add("namefull");
		  list.add("tel");
		  list.add("nameshort");
		  list.add("keyman");
		  list.add("lastdate");
		  list.add("backdate");
		  list.add("followstep");
		  list.add("city");
		  list.add("calling");
		  list.add("nowman");
		  list.add("relation");
		  list.add("total_Item");
		  list.add("total_Page");
		  List temp =new ArrayList ();
		  temp.add("customer");
		  temp.add("custID");
		  temp.add("0");
		  temp.add("namefull,tel,nameshort,keyman,CONVERT(VARCHAR(10),lastdate,120) as lastdate,CONVERT(VARCHAR(10),backdate,120)as backdate ,followstep,city,calling,nowman,relation");
		  temp.add("25");
		  temp.add("2");
		  temp.add(" 1=1 and step ='成交' and nowman='jojo'");
		 
		List countList =new ConnSqlServserDB().getInfor1(temp,list,"");
		//System.out.println(countList.get(1)+"********---------");
		List rows =(List)countList.get(0);
		System.out.println(rows.size()+"********---------");
		for(int i=0;i<rows.size();i++){
			List columns =(List)rows.get(i);
			for(int j=0;j<columns.size();j++){
				System.out.print(columns.get(j)+"   ");
			}
			System.out.println();
		}
	}
	  public List<?> userList(int status,String keywords) {
	        List list = new ArrayList();
	        String sql = "select namefull,keyman,tel,email,nowman from customer where email !='' ";
//	        System.out.println(sql);
	        try {
	        	String str="";
	        	if(status==1){
	        		str="销售一部";
	        		}
	        	if(status==2){
	        		str="销售二部";
	        		}
	        	if(status==3){
	        		str="广州公司";
	        		}
	            conn = getConnection(str);
	            ps=conn.prepareStatement(sql);
	            rs=ps.executeQuery();
	            while(rs.next()){
	            	Customer c = new Customer();
	            	c.setNamefull(rs.getString("namefull"));
	            	c.setNowman(rs.getString("nowman"));
	                list.add(c);
	            }
	        } catch (Exception ex) {
	           System.out.println("错误信息的输出！！！");
	        } finally{
	            try{
	                if(rs!=null)rs.close();
	                if(ps!=null)ps.close();
	                if(conn!=null)conn.close();
	            }catch(SQLException e){}
	        }
	        return list;
}





public void readEmlFile(String fileName) throws MessagingException { 

    try {

        //TODO readEmlFile

        InputStream fis = new FileInputStream(fileName);

        Object emlObj = (Object)fis;

        Session mailSession = Session.getDefaultInstance(System.getProperties(), null);

        MimeMessage msg = new MimeMessage(mailSession,fis);


    } catch (FileNotFoundException e) {
        e.printStackTrace();
    }

}


// 查的公共方法
public List<?> getInfor(List temp,String sql) {
    List row = new ArrayList();
    List column =null;
	CallableStatement cs = null;
    try {
        conn = getConnection("销售一部");
        ps=conn.prepareStatement(sql);
        rs=ps.executeQuery();
        while(rs.next()){
        	column=new ArrayList();
        	for(int i=0;i<temp.size();i++){
        		column.add(rs.getString(temp.get(i).toString()));
        	}
        	row.add(column);
        }
    } catch (Exception ex) {
    	ex.printStackTrace();
       //System.out.println("错误信息的输出！！！");
    } finally{
        try{
        	closeAll();
        }catch(Exception e){}
    }
    return row;
}

//public static void main(String[] args) {
//	List temp =new ArrayList();
//	temp.add("nameshort");
//	temp.add("keyman");
//	temp.add("tel");
//	temp.add("fax");
//	temp.add("email");
//	temp.add("add1");
//	temp.add("nowman");
//	String sql ="select nameshort,keyman,tel,fax,email,add1,nowman from customer where custID =30609";
//	List rows =new ConnSqlServserDB().getInfor(temp, sql);
//	for(int i =0;i<rows.size();i++){
//		List columns =(List)rows.get(i);
//		for(int j=0;j<columns.size();j++){
//			System.out.println(columns.get(j));
//		}
//	}
//	
//}

public List<?> getInfor1(List list ,List temp,String sql) {
	int count=0;
	List countList =new ArrayList();
    List row = new ArrayList();
    List column =null;
	CallableStatement cs = null;
    try {
	        conn = getConnection("销售一部");
	        cs = conn.prepareCall("{call up_Pager(?,?,?,?,?,?,?)}");
	        for(int i=0;i<list.size();i++){
	        	cs.setObject(i+1, list.get(i).toString());
	        }
	        ResultSet rs = cs.executeQuery();
	        int a =0;
	        while(rs.next()){
	        	a+=1;
	        	column=new ArrayList();
	        	for(int i=0;i<temp.size();i++){
	        		column.add(rs.getString(temp.get(i).toString()));
	        		if(i==temp.size()-2){
	        			count=Integer.parseInt(rs.getString(temp.get(i).toString()));
	        		}
	        	}
	        	
	        	row.add(column);
	        }
//	        System.out.println(a+"----a");
	        countList.add(row);
	        countList.add(count);
		    } catch (Exception ex) {
		    	ex.printStackTrace();
		    } finally{
		        try{
		        	closeAll();
		        }catch(Exception e){}
		    }
		    return countList;
}
//关闭公共方法
public void closeAll() {
	try {

		if (rs != null) {
			rs.close();
			rs = null;
		}

		if (ps != null) {
			ps.close();
			ps = null;
		}
		if (conn != null) {
			conn.close();
			conn = null;
		}

	} catch (SQLException e) {
		e.printStackTrace();
	}
}


}
