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
 * �ͻ�����ʵ��
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
		        		str="����һ��";
		        		}
		        	if(status==2){
		        		str="���۶���";
		        		}
		        	if(status==3){
		        		str="���ݹ�˾";
		        		}
		        	if(status==4){
		        		str="��ݸ��˾";
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
		           System.out.println("������Ϣ�����������");
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
