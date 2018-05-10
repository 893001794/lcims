package com.lccert.crm.kis;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.lccert.crm.chemistry.util.DB;

/**
 * 测试项目管理类（包括Service层和dao层）
 * @author Eason
 *
 */
public class ItemAction {
	private static ItemAction instance = null;

	private ItemAction() {

	}

	public synchronized static ItemAction getInstance() {
		if (instance == null) {
			instance = new ItemAction();
		}
		return instance;
	}
	
	/**
	 * 通过关键字查找测试项目
	 * @param key
	 * @return
	 */
	public List<Item> getItemByKeyWords(String key) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Item> list = new ArrayList<Item>();
		String sql = "select * from t_sales_order_item where isparent = 'y' and deleted='n' and (item_number like '%" + key + "%' or name like '%" + key + "%')";
try {
			conn = DB.getConn();

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Item item = new Item();
				item.setId(rs.getInt("id"));
				item.setItemNumber(rs.getString("item_number"));
				item.setName(rs.getString("name"));
				item.setSaleprice(rs.getFloat("saleprice"));
				item.setStandprice(rs.getFloat("standprice"));
				item.setControlprice(rs.getFloat("controlprice"));
				item.setOutprice(rs.getFloat("outprice"));
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
	public List<Item> getEndByKeyWords(String key) {
//		System.out.println(key+"---key");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Item> list = new ArrayList<Item>();
		String sql = "select * from t_sales_order_item where isparent = 'y' and estatus='y' and deleted='n' and (item_number like '%" + key + "%' or name like '%" + key + "%')";
//		System.out.println(sql);
		
		try {
			conn = DB.getConn();
			
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Item item = new Item();
				item.setId(rs.getInt("id"));
				item.setItemNumber(rs.getString("item_number"));
				item.setName(rs.getString("name"));
				item.setSaleprice(rs.getFloat("saleprice"));
				item.setStandprice(rs.getFloat("standprice"));
				item.setControlprice(rs.getFloat("controlprice"));
				item.setOutprice(rs.getFloat("outprice"));
				item.setPlane(rs.getString("vplane"));
//				System.out.println(item.getPlane());
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
	
	
	/**
	 * 通过关键字查找EMC测试项目
	 * @param key
	 * @return
	 */
	public List<Item> getItemEMCByKeyWords(String key) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Item> list = new ArrayList<Item>();
		String sql = "select * from t_sales_order_item where isparent = 'y' and deleted='n' and (item_number like '29.02%' or item_number like '29.03%') and (item_number like '%" + key + "%' or name like '%" + key + "%')";
try {
			conn = DB.getConn();

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Item item = new Item();
				item.setId(rs.getInt("id"));
				item.setItemNumber(rs.getString("item_number"));
				item.setName(rs.getString("name"));
				item.setSaleprice(rs.getFloat("saleprice"));
				item.setStandprice(rs.getFloat("standprice"));
				item.setControlprice(rs.getFloat("controlprice"));
				item.setOutprice(rs.getFloat("outprice"));
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
/**
 * 查询环境测试的方法描述
 * @param company
 * @return
 */
	public List getEdmPlane(String planeId) {
//		System.out.println(planeId);
		int id =0;
		if(planeId !=null){
			id=Integer.parseInt(planeId);
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List list = new ArrayList();
		String sql = "select *  from t_edm_test_plan where id=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String str = rs.getString("vname");
				int id1=rs.getInt("id");
//				UserForm user =new UserForm();
//				user.setName(rs.getString("name"));
//				user.setId(rs.getInt("id"));
				list.add(id1);
				list.add(str);
			}

			conn.commit();
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(auto);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return list;
	}
	public List getEdmChild(String planeId) {
		int id =0;
		if(planeId !=null){
			id=Integer.parseInt(planeId);
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List list = new ArrayList();
		String sql = "select * from t_edm_test_child as etc where etc.id=? ";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int id1=rs.getInt("etc.id");
				String str = rs.getString("etc.vname");
//				UserForm user =new UserForm();
//				user.setName(rs.getString("name"));
//				user.setId(rs.getInt("id"));
				list.add(id1);
				list.add(str);
			}
			
			conn.commit();
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(auto);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return list;
	}
	public String  getEdmYleParent(String planeId) {
		int id =0;
		if(planeId !=null){
			id=Integer.parseInt(planeId);
		}
	
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String str="";
		String sql = "select ety.vparentid  from t_edm_test_plan as etp,t_edm_test_yle as ety where etp.id =? and etp.vplaneid=ety.id";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				 str = rs.getString("ety.vparentid");
			}
			conn.commit();
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(auto);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return str;
	}
	//-------------------2011-04-27--------------------------------
	/**
	 * 所有父类测试项项目的代号
	 * @param key
	 * @return
	 */
	public List<Item> getPhpItemNumber() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Item> list = new ArrayList<Item>();
		String sql = "select * from t_sales_order_item where parentid ='00' and item_number >=25";
		try {
			conn = DB.getConn();

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Item item = new Item();
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
	
	public List<Item> getPhp2ItemNumber(String pareid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Item> list = new ArrayList<Item>();
		String sql = "select * from t_sales_order_item where item_number >=25 and parentid !='00' and isparent ='y' and parentid='"+pareid+"'";
//		System.out.println(sql);
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Item item = new Item();
				item.setName(rs.getString("name"));
				item.setItemNumber(rs.getString("item_number"));
				//System.out.println(item.getName());
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
	
	
	
	//--------------------2011-04-27---------------------------------
	
	
	/**
	 * 所有父类测试项项目的代号
	 * @param key
	 * @return
	 */
	public List<Item> getAllItemNumber() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Item> list = new ArrayList<Item>();
		String sql = "select * from t_sales_order_item where parentid ='00' and id >1000 and id <1554";
		try {
			conn = DB.getConn();

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Item item = new Item();
				item.setItemNumber(rs.getString("item_number"));
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
	/**
	 * 根据测试项目名称取得测试项目详细信息
	 * @param name 测试项目名称
	 * @return
	 */
	public Item getItemByName(String name) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Item item = new Item();
		String sql = "select * from t_sales_order_item where name = ?";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				item.setId(rs.getInt("id"));
				item.setItemNumber(rs.getString("item_number"));
				item.setName(rs.getString("name"));
				item.setSaleprice(rs.getFloat("saleprice"));
				item.setStandprice(rs.getFloat("standprice"));
				item.setControlprice(rs.getFloat("controlprice"));
				item.setOutprice(rs.getFloat("outprice"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return item;
	}
	/**
	 * 根据二级的id获取二级的价格
	 */
	public List getPrice(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList ();
		String sql = "select * from t_edm_test_child where id = ?";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				list.add(rs.getFloat("ftotalprice"));
				list.add(rs.getString("etype"));
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
}
