package com.lccert.crm.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.dao.SalesOrderItemDao;
import com.lccert.crm.kis.Item;
import com.lccert.crm.user.UserAction;
import com.lccert.crm.vo.SalesOrderItem;
/**
 * 测试项目信息
 * @author lcc
 *
 */
public class SalesOrderItemDaoImpl implements SalesOrderItemDao {
	private static SalesOrderItemDaoImpl soi =null;
	
	public synchronized static SalesOrderItemDaoImpl getInstance() {
		if (soi == null) {
			soi = new SalesOrderItemDaoImpl();
		}
		return soi;
	}
	
	
	
//一级分类下面有多少个子类
	public int childs(String parentName) {
		String sql ="select count(*) as countchild from t_sales_order_item where item_number like '"+parentName+".%'";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int countChilds=0;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				countChilds=rs.getInt("countchild");
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return countChilds;
	}
	
	public List findAllOrderItem() {
		String sql ="select *  from t_sales_order_item order by item_number asc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		SalesOrderItem soi=null;
		ResultSet rs = null;
//		//结合一级和二级
		List list =new ArrayList();
		int countChilds=0;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				soi =new SalesOrderItem();
				soi.setId(rs.getInt("id"));
				soi.setItem_number(rs.getString("item_number"));
				soi.setName(rs.getString("name"));
				soi.setFullname(rs.getString("fullname"));
				soi.setParentid(rs.getString("parentid"));
				soi.setSaleprice(rs.getFloat("saleprice"));
				soi.setStandprice(rs.getFloat("standprice"));
				soi.setControlprice(rs.getFloat("controlprice"));
				soi.setOutprice(rs.getFloat("outprice"));
				soi.setDeleted(rs.getString("deleted"));
				soi.setIsparent(rs.getString("isparent"));
				list.add(soi);
			}
			 
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}

		return list;
	}
	public List findItemByItemNumber(String itemNumber) {
		String sql ="select  * from t_sales_order_item where item_number =?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		SalesOrderItem soi=null;
		ResultSet rs = null;
//		//结合一级和二级
		List list =new ArrayList();
		int countChilds=0;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, itemNumber);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				soi =new SalesOrderItem();
				soi.setName(rs.getString("name"));
				soi.setSaleprice(rs.getFloat("saleprice"));
				soi.setStandprice(rs.getFloat("standprice"));
				soi.setControlprice(rs.getFloat("controlprice"));
				soi.setCategory(rs.getString("vcategory"));
				soi.setNormalPeriod(rs.getString("vnormalPeriod"));
				soi.setUrgentPeriod(rs.getString("vurgentPeriod"));
				soi.setAbsolutPeriod(rs.getString("vabsolutPeriod"));
				list.add(soi);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		
		return list;
	}

	//获取一级分类
	/**
	 * 获得客服人员列表
	 * @return
	 */
	public List getparent() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList();
		Item item =null;
		String sql = "select * from  t_sales_order_item where parentid ='00' and id>708";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				item =new Item();
				item.setItemNumber(rs.getString("item_number"));
				item.setName(rs.getString("name"));
				list.add(item);
				
			
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
			
		}
		return list;
	}
	
	
	//获取二级分类
	public static List getchilds(String parents){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList ();
		SalesOrderItem soi =null;
		String sql = "select * from  t_sales_order_item where parentid !='00'and  isparent ='n' and item_number like '"+parents+".%'";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				soi =new SalesOrderItem();
			    soi.setItem_number(rs.getString("item_number"));
				soi.setName(rs.getString("name"));
				list.add(soi);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	
		return list;
	}
	
	public List findByItemNumber(String itemNumber) {
		String sql ="select  name,saleprice, standprice,controlprice,vcategory,vnormalPeriod,vurgentPeriod,vabsolutPeriod from t_sales_order_item where item_number =?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		SalesOrderItem soi=null;
		ResultSet rs = null;
//		//结合一级和二级
		List list =new ArrayList();
		int countChilds=0;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, itemNumber);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				soi =new SalesOrderItem();
				soi.setName(rs.getString("name"));
				soi.setSaleprice(rs.getFloat("saleprice"));
				soi.setStandprice(rs.getFloat("standprice"));
				soi.setControlprice(rs.getFloat("controlprice"));
				soi.setCategory(rs.getString("vcategory"));
				soi.setNormalPeriod(rs.getString("vnormalPeriod"));
				soi.setUrgentPeriod(rs.getString("vurgentPeriod"));
				soi.setAbsolutPeriod(rs.getString("vabsolutPeriod"));
				list.add(soi);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		
		return list;
	}
	
	
	public boolean  updateByItemNumber(SalesOrderItem sale) {
		boolean falg=true;
		String sql ="update t_sales_order_item set  saleprice=?, standprice=?,controlprice=?,vcategory=?,vnormalPeriod=?,vurgentPeriod=?,vabsolutPeriod =?  where item_number =?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		SalesOrderItem soi=null;
		
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setFloat(1, sale.getSaleprice());
			pstmt.setFloat(2, sale.getStandprice());
			pstmt.setFloat(3, sale.getControlprice());
			pstmt.setString(4, sale.getCategory());
			pstmt.setString(5, sale.getNormalPeriod());
			pstmt.setString(6, sale.getUrgentPeriod());
			pstmt.setString(7, sale.getAbsolutPeriod());
			pstmt.setString(8, sale.getItem_number());
			pstmt.executeUpdate();
		}catch(SQLException e) {
			falg  = false;
		}finally {
			DB.close(pstmt);
			DB.close(conn);
		}
		
		return falg;
	}
	
	//获取三级分类
	public static List getThreeChilds(String parents){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList ();
		SalesOrderItem soi =null;
		String sql = "select * from  t_sales_order_item where parentid !='00'and  isparent ='y' and item_number like '"+parents+".%'";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				soi =new SalesOrderItem();
			    soi.setItem_number(rs.getString("item_number"));
				soi.setName(rs.getString("name"));
				list.add(soi);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	
		return list;
	}
	
	
	public static void main(String[] args) {
		List list =new SalesOrderItemDaoImpl().findByItemNumber("01.01");
		for(int i=0;i<list.size();i++){
		
		}
	}

}
