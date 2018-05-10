package com.lccert.crm.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.oa.vo.Group;

/**
 * 用户管理类（包括Service层和dao层）
 * @author Eason
 *
 */
public class UserAction {

	private static UserAction instance = null;

	private UserAction() {

	}

	public synchronized static UserAction getInstance() {
		if (instance == null) {
			instance = new UserAction();
		}
		return instance;
	}

	/**
	 * 根据userid查找用户
	 * 
	 * @param userid
	 * @return boolean
	 */
	public boolean findUserById(String userid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "select * from t_user where userid = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				isok = true;
			}
			conn.commit();
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
	 * 添加用户
	 * 
	 * @param user
	 * @return
	 */
	public boolean addUser(UserForm user) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "insert into t_user(userid,password,name,sex,tel,email,company,dept,job,ticketid,popdom,phone,serv,sales,isShowFspefund,companyid,superiorid,createtime) values(?,md5(?),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now())";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, user.getUserid());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getName());
			pstmt.setString(4, user.getSex());
			pstmt.setString(5, user.getTel());
			pstmt.setString(6, user.getEmail());
			pstmt.setString(7, user.getCompany());
			pstmt.setString(8, user.getDept());
			pstmt.setString(9, user.getJob());
			pstmt.setString(10, user.getTicketid());
			pstmt.setString(11, user.getPopdom());
			pstmt.setString(12, user.getPhone());
			pstmt.setString(13, user.getServ());
			pstmt.setString(14, user.getSales());
			pstmt.setString(15, user.getIsShowFspefund());
			pstmt.setInt(16, user.getCompanyid());
			pstmt.setString(17, user.getSuperiorid());
			pstmt.executeUpdate();
			conn.commit();
			isok = true;
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
			DB.close(pstmt);
			DB.close(conn);
		}
		return isok;
	}

	/**
	 * 检查登录
	 * 
	 * @param username
	 * @param password
	 * @return
	 */
	public UserForm checkLogin(String username, String password) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		UserForm user = null;
		String sql = "select * from t_user where userid = ? and password = md5(?) and estatus = '有效'";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				user = new UserForm();
				user.setId(rs.getInt("id"));
				user.setUserid(rs.getString("userid"));
				user.setCompany(rs.getString("company"));
				user.setDept(rs.getString("dept"));
				user.setName(rs.getString("name"));
				user.setSex(rs.getString("sex"));
				user.setTel(rs.getString("tel"));
				user.setJob(rs.getString("job"));
				user.setEmail(rs.getString("email"));
				user.setPopdom(rs.getString("popdom"));
				user.setTicketid(rs.getString("ticketid"));
				user.setCompanyid(rs.getInt("companyid"));
				user.setSales(rs.getString("sales"));
				user.setServ(rs.getString("serv"));
				user.setCtsname(rs.getString("ctsname"));
				user.setReportStart(rs.getString("reportStart"));
				user.setAgree(rs.getString("eagree"));
				user.setPstatus(rs.getString("epstatus"));
				user.setLatelisttype(rs.getString("latelisttype"));
				user.setProjecttype(rs.getString("projecttype"));
				user.setYconfirm(rs.getString("yconfirm"));
				user.setYnucompletin(rs.getString("ynucompletin"));
				user.setIsShowFspefund(rs.getString("isShowFspefund"));
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
			}
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return user;
	}
	
	
	/**
	 * 根据部门获取组
	 * 
	 * @param company
	 * @return
	 */
	public List getGroupts(String  dept) {
		if(dept.equals("1")){
			dept="销售一部";
		}
		if(dept.equals("2")){
			dept="销售二部";
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List list = new ArrayList ();
		String sql ="";
			sql = "select distinct(g.id),g.name from t_user as u,t_group as g   where  g.id =u.groupid and u.dept =? and u.groupid is not null ";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, dept);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				List column=new ArrayList();
				column.add(rs.getInt("id"));
				column.add(rs.getString("name"));
				list.add(column);
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
	 * 根据id获取组
	 * 
	 * @param company
	 * @return
	 */
	public Group grouptById(int  id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		Group group =new Group();
		String sql ="";
			sql = "select * from t_group  where id=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				group.setGROUP_ID(rs.getInt("id"));
				group.setGROUP_NAME(rs.getString("name"));
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
		return group;
	}
	
	public boolean checkVerificatime(String password) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		UserForm user = null;
		String sql = "select * from t_user where verification = 'y' and password = md5(?) and estatus = '有效'";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, password);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				auto=true;
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
			}
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return auto;
	}
	/**
	 * 根据用户ID查找用户
	 * @param userid
	 * @return
	 */
	public UserForm getUserById(String userid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserForm user = null;
		boolean auto = false;
		String sql = "select * from t_user where userid = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				user = new UserForm();
				user.setUserid(rs.getString("userid"));
				user.setPassword(rs.getString("password"));
				user.setCompany(rs.getString("company"));
				user.setDept(rs.getString("dept"));
				user.setName(rs.getString("name"));
				user.setSex(rs.getString("sex"));
				user.setTel(rs.getString("tel"));
				user.setJob(rs.getString("job"));
				user.setEmail(rs.getString("email"));
				user.setPopdom(rs.getString("popdom"));
				user.setTicketid(rs.getString("ticketid"));
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
		return user;
	}
	
	/**
	 * 根据id查找用户信息
	 * @param id
	 * @return
	 */
	public UserForm getUserById(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserForm user = null;
		boolean auto = false;
		String sql = "select * from t_user where id = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				user = new UserForm();
				user.setId(rs.getInt("id"));
				user.setUserid(rs.getString("userid"));
				user.setPassword(rs.getString("password"));
				user.setCompany(rs.getString("company"));
				user.setDept(rs.getString("dept"));
				user.setName(rs.getString("name"));
				user.setSex(rs.getString("sex"));
				user.setTel(rs.getString("tel"));
				user.setPhone(rs.getString("phone"));
				user.setJob(rs.getString("job"));
				user.setEmail(rs.getString("email"));
				user.setPopdom(rs.getString("popdom"));
				user.setTicketid(rs.getString("ticketid"));
				user.setCompanyid(rs.getInt("companyid"));
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
		return user;
	}

	/**
	 * 通过用户名查找用户
	 * 
	 * @param to
	 * @param name
	 */
	public void findUserByName(List<String> to, String name) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String sql = "select * from t_user where name = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String email = rs.getString("email");
				to.add(email);
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
	}

	/**
	 * 查找所有经理的EMAIL
	 * 
	 * @param to
	 */
	public void findMangagerEmails(List<String> to) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String sql = "select * from t_user where job like '%经理%'";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String email = rs.getString("email");
				to.add(email);
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

	}

	/**
	 * 修改密码
	 * 
	 * @param userid
	 *            用户代码
	 * @param password
	 *            密码
	 */
	public void modifyPassword(String userid, String password) {
		String sql = "update t_user set password=md5(?) where userid=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, password);
			pstmt.setString(2, userid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	
	
	public void modifyUser(String userid) {
		String sql = "update t_user set serv='y',companyid='1' where userid=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	
	/**
	 * 根据用户名取得ID
	 * @param name
	 * @return
	 */
	public int getIdByName(String name) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		int id = 0;
		String sql = "select id from t_user where name = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				id = rs.getInt("id");
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
		return id;
	}
	
	/**
	 * 根据用户名取得用户信息
	 * @param name
	 * @return
	 */
	public UserForm getUserByName(String name) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		UserForm user = new UserForm();
		String sql = "select * from t_user where name = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				user.setId(rs.getInt("id"));
				user.setUserid(rs.getString("userid"));
				user.setPassword(rs.getString("password"));
				user.setCompany(rs.getString("company"));
				user.setCompanyid(rs.getInt("companyid"));
				user.setDept(rs.getString("dept"));
				user.setName(rs.getString("name"));
				user.setSex(rs.getString("sex"));
				user.setTel(rs.getString("tel"));
				user.setDept(rs.getString("dept"));
				user.setJob(rs.getString("job"));
				user.setEmail(rs.getString("email"));
				user.setPopdom(rs.getString("popdom"));
				user.setTicketid(rs.getString("ticketid"));
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
		return user;
	}
	
	/**
	 * 根据id查询他是否有上级领导，如果没有，那么他就是最高级的
	 * @param id
	 * @return
	 */
	public String getSuperioridById(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String superiorid = "";
		String sql = "select superiorid from t_user where id = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				superiorid = rs.getString("superiorid");
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
		return superiorid;
	}
	
	/**
	 * 
	 * 获取所有superiorid
	 * @param id
	 * @return
	 */
	public List getSuperiorid() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List list =new ArrayList();
		String sql = "select superiorid from t_user where superiorid is not null";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("superiorid"));
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
	 * 根据上级的superiorid获取该上司的所有下名称
	 * @param id
	 * @return
	 */
	
	public List getUserBySuperiorid(int superiorid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserForm user = null;
		boolean auto = false;
		List list =new ArrayList();
		String sql = "select * from t_user where 1=1 and estatus='有效' and superiorid like '%"+superiorid+"%' or id ="+superiorid+"";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				user = new UserForm();
				user.setId(rs.getInt("id"));
				user.setUserid(rs.getString("userid"));
				user.setPassword(rs.getString("password"));
				user.setCompany(rs.getString("company"));
				user.setDept(rs.getString("dept"));
				user.setName(rs.getString("name"));
				user.setSex(rs.getString("sex"));
				user.setTel(rs.getString("tel"));
				user.setPhone(rs.getString("phone"));
				user.setJob(rs.getString("job"));
				user.setEmail(rs.getString("email"));
				user.setPopdom(rs.getString("popdom"));
				user.setTicketid(rs.getString("ticketid"));
				list.add(user);
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
	 * 根据id取得用户名
	 * @param id
	 * @return
	 */
	public String getNameById(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String name = "";
		String sql = "select name from t_user where id = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				name = rs.getString("name");
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
		return name;
	}

/**
 * 获取所有环境检测人员
 * @return
 */
	public List getEdmQC() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List list =new ArrayList();
		UserForm user=null;
		String sql = "select * from t_user where eqc ='y'";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				user=new UserForm();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				list.add(user);
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
}
