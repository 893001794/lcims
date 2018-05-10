package com.lccert.crm.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.jms.Topic;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.dao.ChemTestDao;
import com.lccert.crm.vo.TestChildParent;
import com.lccert.crm.vo.TestParents;
import com.lccert.crm.vo.TestPlan;
import com.lccert.crm.vo.TopLevel;
/***
 * 化学测试的现实类
 * @author tangzp
 *
 */
public class ChemTestDaoImpl implements ChemTestDao {
	
private static ChemTestDaoImpl soi =null;
	
	public synchronized static ChemTestDaoImpl getInstance() {
		if (soi == null) {
			soi = new ChemTestDaoImpl();
		}
		return soi;
	}
	/**
	 * 查询测试要求的所以名称
	 * 
	 */
	public List findChemTestChild() {
		String sql ="select ctc.id as id ,ctc.name as name,ctc.type as type,ctc.vstatus as vstatus ,ctp.name as parentname  from t_chem_test_child as ctc , t_chem_test_parent as ctp   where ctc.id>=101 and  ctc.category =ctp.id order by ctc.vstatus,ctp.id asc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList();
		TestChildParent testP ;
		
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				testP =new TestChildParent();
				testP.setId(rs.getInt("id"));
				testP.setChildName(rs.getString("name"));
				testP.setType(rs.getString("type"));
				testP.setStatus(rs.getString("vstatus"));
				testP.setParentName(rs.getString("parentname"));
			list.add(testP);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	
		return list ;

	}

	
	/**
	 * 查询测试项目的所以名称
	 * 
	 */
	public List findChemTestParent() {
		String sql ="select id, name,type,vstatus  from t_chem_test_parent where id>=101  order by id asc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList();
		TestParents testP ;
		
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				testP =new TestParents();
				testP.setId(rs.getInt("id"));
				testP.setName(rs.getString("name"));
				testP.setType(rs.getString("type"));
				testP.setStatus(rs.getString("vstatus"));
				
			list.add(testP);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	
		return list ;
	}
	
	/**
	 * 添加二级分类
	 */
	public boolean addChild(TestChildParent tp) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = true;

		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			String sql = "insert into  t_chem_test_child(name,type,category,vstatus) values(?,?,?,?)";
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, tp.getChildName());
			pstmt.setString(2, tp.getType());
			pstmt.setInt(3, tp.getParentId());
			pstmt.setString(4, tp.getStatus());
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			isok = false;
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
		return isok;
	}
	
	/**
	 * 添加一级分类
	 */
	
	
	public boolean addParent(TestParents tp) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = true;

		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			String sql = "insert into  t_chem_test_parent(name,type,vstatus,typeid) values(?,?,?,?)";
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, tp.getName());
			pstmt.setString(2, tp.getType());
			pstmt.setString(3, tp.getStatus());
			pstmt.setString(4, tp.getYle());
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			isok = false;
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
		return isok;

	}
	/**
	 *更改一级分类
	 */
	public boolean upParent(TestParents tp) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = true;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			String sql = "update t_chem_test_parent set  name=?,type=?,vstatus=?,typeid=? where id=?";
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, tp.getName());
			pstmt.setString(2, tp.getType());
			pstmt.setString(3, tp.getStatus());
			pstmt.setString(4, tp.getYle());
			pstmt.setInt(5, tp.getId());
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			isok = false;
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
		return isok;

	}
	
	/**
	 * 修改二级分类
	 */
	public boolean upChild(TestChildParent tp) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = true;

		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			String sql = "update t_chem_test_child set  name=?,type=?,category=?,vstatus=? where id =?";
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, tp.getChildName());
			pstmt.setString(2, tp.getType());
			pstmt.setInt(3, tp.getParentId());
			pstmt.setString(4, tp.getStatus());
			pstmt.setInt(5, tp.getId());
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			isok = false;
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
		return isok;
	}
	
	/**
	 * 更改三级分类
	 */
	public boolean upPlan(TestPlan tp) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = true;

		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			String sql = "update  t_chem_test_plan set name=?,parentid=?,vstatus=?,vdescribe1_C=?,vdescribe2_C=?,vdescribe3_C=?,vdescribe1_E=?,vdescribe2_E=?,vdescribe3_E=?,vcnastatus=? where id=?";
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, tp.getChildName());
			pstmt.setInt(2, tp.getChildId());
			pstmt.setString(3, tp.getStatus());
			pstmt.setString(4, tp.getDescribe1C());
			pstmt.setString(5, tp.getDescribe2C());
			pstmt.setString(6, tp.getDescribe3C());
			pstmt.setString(7, tp.getDescribe1E());
			pstmt.setString(8, tp.getDescribe2E());
			pstmt.setString(9, tp.getDescribe3E());
			pstmt.setString(10, tp.getCnastatus());
			pstmt.setInt(11, tp.getId());
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			isok = false;
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
		return isok;
	}
	/**
	 * 添加三级分类
	 */
	public boolean addPlan(TestPlan tp) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = true;

		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			String sql = "insert into  t_chem_test_plan(name,parentid,vstatus,vdescribe1_C,vdescribe2_C,vdescribe3_C,vdescribe1_E,vdescribe2_E,vdescribe3_E,vcnastatus) values(?,?,?,?,?,?,?,?,?,?)";
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, tp.getChildName());
			pstmt.setInt(2, tp.getChildId());
			pstmt.setString(3, tp.getStatus());
			pstmt.setString(4, tp.getDescribe1C());
			pstmt.setString(5, tp.getDescribe2C());
			pstmt.setString(6, tp.getDescribe3C());
			pstmt.setString(7, tp.getDescribe1E());
			pstmt.setString(8, tp.getDescribe2E());
			pstmt.setString(9, tp.getDescribe3E());
			pstmt.setString(10, tp.getCnastatus());
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			isok = false;
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
		return isok;
	}
	
	/**
	 * 根据条件查询所以测试要求值
	 */
	public List findChemTestChild(String type) {
		String sql ="select ctc.id as id ,ctc.name as name,ctc.type as type,ctc.vstatus as vstatus ,ctp.name as parentname  from t_chem_test_child as ctc , t_chem_test_parent as ctp   where ctc.id>=101 and ctc.vstatus ='y' and ctp.id = ctc.category and ctc.type ='"+type+"' order by ctc.vstatus,ctp.id asc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList();
		TestChildParent testP ;
		
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				testP =new TestChildParent();
				testP.setId(rs.getInt("id"));
				testP.setChildName(rs.getString("name"));
				testP.setType(rs.getString("type"));
				testP.setStatus(rs.getString("vstatus"));
				testP.setParentName(rs.getString("parentname"));
			list.add(testP);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	
		return list ;
	
	}
	public List findChemTestParent(String type) {
		String sql ="select * from t_chem_test_parent where id>=101 and type='"+type+"' order by id asc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList();
		TestParents testP ;
		
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				testP =new TestParents();
				testP.setId(rs.getInt("id"));
				testP.setName(rs.getString("name"));
				testP.setType(rs.getString("type"));
				testP.setStatus(rs.getString("vstatus"));
			list.add(testP);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	
		return list ;
	
	}
	public List findChemTestPlan(String type) {
		String sql ="select tp.*,ctc.name as childName, ctp.name as parentName  from t_chem_test_plan as tp , t_chem_test_child as ctc , t_chem_test_parent as ctp where tp.id>=101 and ctp.id = ctc.category and tp.parentid=ctc.id  and tp.name like '%"+type+"%'  order by  tp.vstatus ,ctp.id asc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList();
		TestPlan testP ;
		
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				testP =new TestPlan();
				testP.setId(rs.getInt("id"));
				testP.setPlanName(rs.getString("name"));
				testP.setStatus(rs.getString("vstatus"));
				testP.setChildName(rs.getString("childName"));
				testP.setParentName(rs.getString("parentName"));
				testP.setCnastatus(rs.getString("vcnastatus"));
			list.add(testP);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	
		return list ;
	
	}
	public List findChemTestPlan() {
		String sql ="select tp.*,ctc.name as childName, ctp.name as parentName  from t_chem_test_plan as tp , t_chem_test_child as ctc , t_chem_test_parent as ctp  where tp.id>=101 and ctp.id = ctc.category and tp.parentid=ctc.id   order by  tp.vstatus ,ctp.id asc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList();
		TestPlan testP ;
		
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				testP =new TestPlan();
				testP.setId(rs.getInt("id"));
				testP.setPlanName(rs.getString("name"));
				testP.setStatus(rs.getString("vstatus"));
				testP.setChildName(rs.getString("childName"));
				testP.setParentName(rs.getString("parentName"));
				testP.setCnastatus(rs.getString("vcnastatus"));
			list.add(testP);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	
		return list ;

	}
	
	
	
	public String isCNAS(int id) {
		String sql ="select vcnastatus from t_chem_test_plan where id="+id;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String isCNAS="";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				
				isCNAS=rs.getString("vcnastatus");
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	
		return isCNAS ;

	}
	
	
	
	/**
	 * 根据id 查询一级分类
	 */
	public TestParents getParentsById(int id) {
		String sql ="select * from t_chem_test_parent where id>=101 and vstatus ='y'and id="+id+" order by id asc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		TestParents testP = null ;
		
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				testP =new TestParents();
				testP.setId(rs.getInt("id"));
				testP.setName(rs.getString("name"));
				testP.setType(rs.getString("type"));
				testP.setStatus(rs.getString("vstatus"));
				testP.setYle(rs.getString("typeid"));
		
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	
		return testP;
	}
	
	
	public TestChildParent findChildById(int id) {
		String sql ="select tcc.*,tcp.name as parentName  from t_chem_test_child as tcc,t_chem_test_parent as tcp where tcc.id>=101 and tcc.vstatus ='y' and tcc.category=tcp.id and tcc.id ="+id+" order by id asc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		TestChildParent testP =null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				testP =new TestChildParent();
				testP.setId(rs.getInt("id"));
				testP.setChildName(rs.getString("name"));
				testP.setType(rs.getString("type"));
				testP.setStatus(rs.getString("vstatus"));
				testP.setParentName(rs.getString("parentName"));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	
		return testP ;
	
	}
	
	public TestPlan findPlanById(int id) {
		String sql ="select tcp.*,tcc.name as childName,tcc.id as childid from t_chem_test_plan as tcp,t_chem_test_child as tcc where tcp.id>=101  and tcp.parentid=tcc.id and tcp.id="+id+" order by id asc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		TestPlan testP =null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				testP =new TestPlan();
				testP.setId(rs.getInt("id"));
				testP.setChildId(rs.getInt("childid"));
				testP.setPlanName(rs.getString("name"));
				testP.setStatus(rs.getString("vstatus"));
				testP.setDescribe1C(rs.getString("vdescribe1_C"));
				testP.setDescribe2C(rs.getString("vdescribe2_C"));
				testP.setDescribe3C(rs.getString("vdescribe3_C"));
				testP.setDescribe1E(rs.getString("vdescribe1_E"));
				testP.setDescribe2E(rs.getString("vdescribe2_E"));
				testP.setDescribe3E(rs.getString("vdescribe3_E"));
				testP.setChildName(rs.getString("childName"));
				testP.setCnastatus(rs.getString("vcnastatus"));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	
		return testP ;

	}
	
	/***
	 * 添加顶级的信息
	 */
	public boolean addTopLevel(String levelName,String chemteststatus) {
//		System.out.println(levelName+":levelName--"+chemteststatus+"---");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = true;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			String sql = "insert into  t_chem_test_type(name,status)values(?,?)";
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1,levelName);
			pstmt.setString(2, chemteststatus);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			isok = false;
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
		return isok;
	}
	public List findTopLevel() {
		String sql ="select id, name,status  from t_chem_test_type order by id asc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList();
		TopLevel tl ;
		
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				tl =new TopLevel();
				tl.setId(rs.getInt("id"));
				tl.setName(rs.getString("name"));
				tl.setStatus(rs.getString("status"));
				
			list.add(tl);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	
		return list ;
	}

}
