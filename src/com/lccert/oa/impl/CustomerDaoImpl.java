package com.lccert.oa.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import java.util.List;

import com.lccert.oa.dao.CustomerDao;
import com.lccert.oa.db.ConnSqlServserDB;
import com.lccert.oa.vo.Customer;

/***
 * 客户的现实类
 * @author tangzp
 *
 */
public class CustomerDaoImpl extends ConnSqlServserDB implements CustomerDao {
	Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
	public List<?> userList(int status,String keywords) {
		        List list = new ArrayList();
		        String sql = "select namefull,nowman from customer where namefull like '%"+keywords+"%'";
		        System.out.println(sql);
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
		        	if(status==4){
		        		str="东莞公司";
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

}
