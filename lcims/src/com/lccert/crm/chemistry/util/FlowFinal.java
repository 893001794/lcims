package com.lccert.crm.chemistry.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lccert.crm.client.ClientForm;
import com.lccert.crm.user.UserForm;
import com.lccert.crm.vo.Diglossia;
import com.lccert.crm.vo.TestChildParent;
import com.lccert.crm.vo.TestParents;
import com.lccert.crm.vo.TestPlan;

/**
 * ��̬�����ݹ�������
 * ȡ�þ�̬���ݿ�������
 * @author Eason
 * 
 */
public class FlowFinal {

	private static FlowFinal instance = null;

	private FlowFinal() {

	}

	// ����ģʽ
	public static FlowFinal getInstance() {
		if (instance == null) {
			instance = new FlowFinal();
		}
		return instance;
	}

	/**
	 * �õ����пͻ�
	 * 
	 * @return
	 */
	public List<ClientForm> getAllClient() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List<ClientForm> list = new ArrayList<ClientForm>();
		String sql = "select * from t_client";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ClientForm client = new ClientForm();
				client.setName(rs.getString("name"));
				client.setEname(rs.getString("ename"));
				list.add(client);
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

	/**
	 * �õ���������������ݱ�ע��Ϣ
	 * 
	 * @return
	 */
	public List<String> getAllAppForm() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List<String> list = new ArrayList<String>();
		String sql = "select * from t_chem_notes";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String str = rs.getString("inform");
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

	/**
	 * �õ����в�����Ŀ���ע��Ϣ
	 * 
	 * @param type
	 * @return
	 */
	public List getAllTestBig(String type,int topLevelId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List<TestParents> list = new ArrayList<TestParents>();
		String sql = "select * from t_chem_test_parent where  id >48 and vstatus ='y' and (typeid like '%"+topLevelId+"%' or typeid ="+topLevelId+") and type = '"+type+"'  order by id asc";
		System.out.println(sql);
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
//			pstmt.setString(1, type);
			rs = pstmt.executeQuery();
			TestParents tp =null;
			while (rs.next()) {
				tp =new TestParents();
				tp.setId(rs.getInt("id"));
				tp.setName(rs.getString("name"));
				tp.setType(rs.getString("type"));
				list.add(tp);
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
	
	
	/**
	 * �õ����в�����ĿС�ע��Ϣ
	 * 
	 * @param type
	 * @return
	 */
	public List getAllTestBig(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List<TestParents> list = new ArrayList<TestParents>();
		String sql = "select * from t_chem_test_parent where id = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			TestParents tp =null;
			while (rs.next()) {
				tp =new TestParents();
				tp.setId(rs.getInt("id"));
				tp.setName(rs.getString("name"));
				tp.setType(rs.getString("type"));
				
				list.add(tp);
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
	/**
	 * �õ����в��Է�����ע��Ϣ
	 * 
	 * @param type
	 * @return
	 */
	public List getAllTestPlan(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List list = new ArrayList();
		String sql = "select  tp.name as a,tc.name as b, ctp.name as c ,ctp.id as id  from t_chem_test_child as tc,t_chem_test_parent as tp, t_chem_test_plan as ctp  where ctp.parentId =? and ctp.vstatus='y' and tp.id =tc.category and tc.id =ctp.parentId";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			TestPlan tp =null;
			while (rs.next()) {
				tp =new TestPlan();
				tp.setParentName(rs.getString("a"));
				tp.setChildName(rs.getString("b"));
				tp.setPlanName(rs.getString("c"));
				tp.setId(rs.getInt("id"));
				list.add(tp);
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

	/**
	 * �õ����в�����ĿС�ע��Ϣ
	 * 
	 * @param type
	 * @return
	 */
	public List getAllTestSmall(String type,int id) {
	
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false; 
		List list = new ArrayList();
		TestChildParent tcp =null;
		String sql = "select  tp.name as a,tc.name as b,tc.id as id  from t_chem_test_child as tc,t_chem_test_parent as tp where tc.type = ? and tc.category =? and tc.vstatus ='y' and  tp.id =tc.category order by id asc";
//		System.out.println(sql);
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, type);
			pstmt.setInt(2, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				tcp=new TestChildParent();
				tcp.setParentName(rs.getString("a"));
				tcp.setChildName(rs.getString("b"));
				tcp.setId(rs.getInt("id"));
				list.add(tcp);
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
	/**
	 * �õ����в�����ĿС�ע��Ϣ
	 * 
	 * @param type
	 * @return
	 */
	public String getNameById(int id) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false; 
		List list = new ArrayList();
		String  planName =null;
		String sql = "select name from t_chem_test_plan where id =?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
		
				planName=rs.getString("name");
			
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
		return planName;
	}
	/**
	 * �õ����Է���������
	 * 
	 * @param type
	 * @return
	 */
	public List getTestPlan(int id,String type) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false; 
		List list =new ArrayList();
		TestPlan tcp =null;
		
		String sql =null;
		if(type.equals("���ı���")||type.equals("��������")){
			
			sql= "select vdescribe1_C as a,vdescribe2_C as b,vdescribe3_C as c  from t_chem_test_plan where id =?";
		}
		if(type.equals("Ӣ�ı���")){
			
			sql= "select vdescribe1_E as a,vdescribe2_E as b,vdescribe3_E as c  from t_chem_test_plan where id =?";
		}
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				tcp=new TestPlan();
				tcp.setParentName(rs.getString("a"));
				tcp.setChildName(rs.getString("b"));
				tcp.setPlanName(rs.getString("c"));
				list.add(tcp);
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
	/**
	 * �õ����Է�������Ӣ������
	 * 
	 * @param type
	 * @return
	 */
	public List diglossia(int id,String type) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false; 
		List list =new ArrayList();
		Diglossia tcp =null;
		
		String sql= "select vdescribe1_C as a,vdescribe2_C as b,vdescribe3_C as c,vdescribe1_E as d,vdescribe2_E as e,vdescribe3_E as f from t_chem_test_plan where id =?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				tcp=new Diglossia();
				tcp.setParentNameC(rs.getString("a"));
				tcp.setChildNameC(rs.getString("b"));
				tcp.setPlanNameC(rs.getString("c"));
				tcp.setParentNameE(rs.getString("d"));
				tcp.setChildNameE(rs.getString("e"));
				tcp.setPlanNameE(rs.getString("f"));
				list.add(tcp);
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
	
//	/**
//	 * �õ����Է���������
//	 * 
//	 * @param type
//	 * @return
//	 */
//	public List getTestPlan(int id) {
//		System.out.println("id:"+id);
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		boolean auto = false; 
//		List list =new ArrayList();
//		TestPlan tcp =null;
//		String sql = "select a.vdescribe as a,b.vdescribe as b,c.vdescribe as c from t_chem_test_parent as a ,t_chem_test_child as b , t_chem_test_plan as c  where a.id =b.category and b.id=c.parentid and c.id =?";
//		try {
//			conn = DB.getConn();
//			auto = conn.getAutoCommit();
//			conn.setAutoCommit(false);
//			
//			pstmt = DB.prepareStatement(conn, sql);
//			pstmt.setInt(1, id);
//			rs = pstmt.executeQuery();
//			if (rs.next()) {
//				tcp=new TestPlan();
//				tcp.setParentName(rs.getString("a"));
//				tcp.setChildName(rs.getString("b"));
//				tcp.setPlanName(rs.getString("c"));
//				list.add(tcp);
//				
//				
//			}
//			
//			conn.commit();
//		} catch (SQLException e) {
//			try {
//				conn.rollback();
//			} catch (Exception e1) {
//				e1.printStackTrace();
//			}
//			e.printStackTrace();
//		} finally {
//			try {
//				conn.setAutoCommit(auto);
//			} catch (Exception e2) {
//				e2.printStackTrace();
//			}
//			DB.close(rs);
//			DB.close(pstmt);
//			DB.close(conn);
//		}
//		return list;
//	}
//	
	
//	public List<String> getAllTestSmall(String type,int id) {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		boolean auto = false;
//		List<String> list = new ArrayList<String>();
//		String sql = "select * from t_chem_test_child where type = ? and category =?";
//		try {
//			conn = DB.getConn();
//			auto = conn.getAutoCommit();
//			conn.setAutoCommit(false);
//			
//			pstmt = DB.prepareStatement(conn, sql);
//			pstmt.setString(1, type);
//			pstmt.setInt(2, id);
//			rs = pstmt.executeQuery();
//			while (rs.next()) {
//				String str = rs.getString("name");
//				list.add(str);
//			}
//			
//			conn.commit();
//		} catch (SQLException e) {
//			try {
//				conn.rollback();
//			} catch (Exception e1) {
//				e1.printStackTrace();
//			}
//			e.printStackTrace();
//		} finally {
//			try {
//				conn.setAutoCommit(auto);
//			} catch (Exception e2) {
//				e2.printStackTrace();
//			}
//			DB.close(rs);
//			DB.close(pstmt);
//			DB.close(conn);
//		}
//		return list;
//	}
	
	/**
	 * ������������
	 * 
	 * @return
	 */
	public Map<String,String> getAllSales() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		Map<String, String> map = new HashMap<String,String>();
		String sql = "select * from t_user where sales = 'y'";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				map.put(id + "", name);
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
		return map;
	}

	/**
	 * �������зֹ�˾����
	 * 
	 * @param company
	 * @return
	 */
	public List<UserForm> getSales(int companyid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String emd="";
		if(companyid ==4){
			companyid=3;
			emd="y";
		}
		List<UserForm> list = new ArrayList<UserForm>();
		String sql ="";
		if(emd.equals("y")){
			sql = "select * from t_user whereedmstatus='y' and sales = 'y' and estatus='��Ч'";
		}else if(companyid == 8){
			sql = "select * from t_user where dept = '���۶���' and sales = 'y' and estatus='��Ч'";
		}else{
			sql = "select * from t_user where  sales = 'y' and estatus='��Ч'";
		}
		System.out.println(sql);
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
//			if(companyid != 8){
//				pstmt.setInt(1, companyid);
//			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				UserForm sales = new UserForm();
				sales.setId(rs.getInt("id"));
				sales.setName(rs.getString("name"));
				list.add(sales);
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
	
	/**
	 * ���ݹ�˾����ȡ�������б�
	 * @param company
	 * @return
	 */
	public List getSales(String company) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List list = new ArrayList();
		String sql = "select name,id  from t_user where company = ?   and sales = 'y'";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, company);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String str = rs.getString("name");
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
	
	/**
	 * �õ����й���ʦ
	 * @return
	 */
	public List<String> getEngineer(String dept) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List<String> list = new ArrayList<String>();
		String sql = "select name from t_user where dept = '" + dept + "' and estatus='��Ч' and id !=121";
		System.out.println(sql);
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String str = rs.getString("name");
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
	
	/**
	 * ȡ�ø��ʽ�б�
	 * @return
	 */
	public Map<String,String> getAdvancetype() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Map<String, String> map = new HashMap<String,String>();
		String sql = "select * from t_sales_order_advancetype ";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				map.put(id + "", name);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return map;
	}
	
	/**
	 * ��ÿͷ���Ա�б�
	 * @return
	 */
	public Map<String,String> getServId(String company) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer str=new StringBuffer();
		if(company !=null){
			str.append("and company ='"+company+"' and estatus='��Ч'");
		}
		Map<String, String> map = new HashMap<String,String>();
		String sql = "select * from t_user where serv = 'y'"+str.toString();
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				map.put(id + "", name);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return map;
	}
	/**
	 * ��ÿͷ���Ա�б�
	 * @return
	 */
	public Map<String,String> getcompanyId(int companyid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer str=new StringBuffer();
		if(companyid !=0){
			str.append("and companyid ='"+companyid+"' and estatus='��Ч'");
		}
		Map<String, String> map = new HashMap<String,String>();
		String sql = "select * from t_user where serv = 'y' and dept ='%�ͷ�%'"+str.toString();
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				map.put(id + "", name);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return map;
	}
	/**
	 * ��ÿͷ���Ա�б�
	 * @return
	 */
	public Map<String,String> getServId(int companyid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Map<String, String> map = new HashMap<String,String>();
		String sql = "select * from t_user where serv = 'y' and estatus='��Ч' and companyid ="+companyid+"";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				map.put(id + "", name);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return map;
	}
	

	public List<UserForm> getServIdByCompanyid(int companyid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List<UserForm> list = new ArrayList<UserForm>();
		String sql = "select * from t_user where companyid = ? and serv = 'y' and estatus='��Ч'";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, companyid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				UserForm sales = new UserForm();
				sales.setId(rs.getInt("id"));
				sales.setName(rs.getString("name"));
				list.add(sales);
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
	public List<UserForm> getServIdByCompanyid1(int companyid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List<UserForm> list = new ArrayList<UserForm>();
		String sql = "select * from t_user where companyid = ? and serv = 'y' and edmstatus='y' and estatus='��Ч'";
		//System.out.println(sql+"--"+companyid);
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, companyid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				UserForm sales = new UserForm();
				sales.setId(rs.getInt("id"));
				sales.setName(rs.getString("name"));
				list.add(sales);
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
	
	/**
	 * ȡ�������б�
	 * @return
	 */
	public Map<String,String> getBank(int companyid,String dept,int userID) {
		String company="";
		if(companyid == 1){
			company="��ɽ";
		}
		if(companyid == 2){
			company="����";
		}
		if(companyid == 3){
			company="��ݸ";
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Map<String, String> map = new HashMap<String,String>();
		String sql ="";
		String strDept="";
		
		if(dept.indexOf("һ��")>-1||dept.indexOf("����")>-1||dept.indexOf("����")>-1||userID==138||userID==100||dept.indexOf("�ͷ�")>-1){
			if(dept.indexOf("һ��")>-1||dept.indexOf("�ͷ�")>-1||userID!=100){
				strDept="һ��";
			}
			if(dept.indexOf("����")>-1){
				strDept="����";
			}
			if(dept.indexOf("����")>-1){
				strDept="����";
			}
			if(userID==100 || userID==385 || userID==409 || userID==418 || userID==419 || userID==420 || userID==421){
				 sql = "select * from t_sales_order_bank where 1=1 and (name like '%����%' or name like '%����%') and estatus ='y'";
			}else{
				 sql = "select * from t_sales_order_bank where 1=1 and name like '%"+strDept+"%' and estatus ='y'";
			}
			
		}else{
			 sql = "select * from t_sales_order_bank where 1=1 and name like '%"+company+"%' and estatus ='y'";
		}
		sql+=" order by id desc ";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				map.put(id + "", name);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return map;
	}
	
	/**
	 * ���������˺����Ʊ���õ�
	 * @return
	 */
	public Map<String,String> getBank(int companyid,String dept,int userID,String selected) {
		String company="";
		if(companyid == 1){
			company="��ɽ";
		}
		if(companyid == 2){
			company="����";
		}
		if(companyid == 3){
			company="��ݸ";
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Map<String, String> map = new HashMap<String,String>();
		String sql ="";
		String strDept="";
		
		if(dept.indexOf("һ��")>-1||dept.indexOf("����")>-1||dept.indexOf("����")>-1||userID==138||userID==100||dept.indexOf("�ͷ�")>-1){
			if(dept.indexOf("һ��")>-1||dept.indexOf("�ͷ�")>-1||userID!=100){
				strDept="һ��";
			}
			if(dept.indexOf("����")>-1){
				strDept="����";
			}
			if(dept.indexOf("����")>-1){
				strDept="����";
			}
			if(userID==100 || userID==385 || userID==409 || userID==418 || userID==419 || userID==420 || userID==421){
				 sql = "select * from t_sales_order_bank where 1=1 and (name like '%����%' or name like '%����%') and estatus ='y'";
			}else{
				 sql = "select * from t_sales_order_bank where 1=1 and name like '%"+strDept+"%' and estatus ='y'";
			}
			
		}else{
			 sql = "select * from t_sales_order_bank where 1=1 and name like '%"+company+"%' and estatus ='y'";
		}
		sql+=" order by id desc ";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				map.put(id + "", name);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return map;
	}
	/**
	 * ȡ�������б�
	 * @return
	 */
//	public Map<String,String> getBank() {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		Map<String, String> map = new HashMap<String,String>();
//		String sql = "select * from t_sales_order_bank";
//		try {
//			conn = DB.getConn();
//			pstmt = DB.prepareStatement(conn, sql);
//			rs = pstmt.executeQuery();
//			while (rs.next()) {
//				int id = rs.getInt("id");
//				String name = rs.getString("name");
//				map.put(id + "", name);
//			}
//
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			DB.close(rs);
//			DB.close(pstmt);
//			DB.close(conn);
//		}
//		return map;
//	}
	/**
	 * ȡ���ļ����б�
	 * @return
	 */
	public Map<String,String> getFileDirect() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Map<String, String> map = new HashMap<String,String>();
		String sql = "select * from t_report_filedirect where tag = 'y' order by id";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				map.put(id + "", name);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return map;
	}
	
	
	/**
	 * ȡ�ú�������
	 * @return
	 */
	public Map<String,String> getagname() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Map<String, String> map = new HashMap<String,String>();
		String sql = "select * from t_agname order by id";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				map.put(id + "", name);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return map;
	}
	
	/**
	 * ȡ���������
	 * @return
	 */
	public Map<String,String> getsubname(String category) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Map<String, String> map = new HashMap<String,String>();
		String sql = "select * from t_subname where category = '" + category + "' order by id";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				map.put(id + "", name);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return map;
	}
	/**
	 * �������ƻ�ȡ���۵Ĺ���
	 * @return
	 */
	public int getUserId(int sales) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int id =0;
		String sql = "select id from t_user where name =?";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, sales);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				id= rs.getInt("id");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return id;
	}
	
	/**
	 * ��ÿͷ���Ա�б�
	 * @return
	 */
	public Map<String,String> getServId() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Map<String, String> map = new HashMap<String,String>();
		String sql = "select * from t_user where serv = 'y' and estatus='��Ч'";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				map.put(id + "", name);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return map;
	}
	/**
	 * ��û�ѧ�ͷ���Ա�б�
	 * @return
	 */
	public List getChemServ() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList();
		String sql = "select * from t_user where serv = 'y' and estatus='��Ч' and company ='��ɽ'  and id !=138";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("email"));
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
