package com.lccert.crm.system;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.lccert.crm.chemistry.email.Email;
import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.chemistry.util.NotesSendMail;
import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.chemistry.util.SendMail;

/**
 * 系统公告管理类（包括Service层和dao层）
 * @author Eason
 *
 */
public class ForumAction {
	private static ForumAction instance = null;

	private ForumAction() {

	}

	public synchronized static ForumAction getInstance() {
		if (instance == null) {
			instance = new ForumAction();
		}
		return instance;
	}
	
	/**
	 * 添加系统公告
	 * @param fr
	 * @return
	 */
	public boolean addForum(Forum fr) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "insert into t_system(head,content,createname,createtime,deadtime,ISCid) values(?,?,?,now(),?,?)";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, fr.getHead());
			pstmt.setString(2, fr.getContent());
			pstmt.setString(3, fr.getCreatename());
			pstmt.setTimestamp(4, new Timestamp(fr.getDeadtime().getTime()));
			pstmt.setInt(5,fr.getIscid());
			
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
	 * 修改系统公告
	 * @param fr
	 * @return
	 */
	public boolean modForum(Forum fr) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_system set head=?,content=? where id=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, fr.getHead());
			pstmt.setString(2, fr.getContent());
			pstmt.setInt(3, fr.getId());
			
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
	 * 修改系统公告
	 * @param fr
	 * @return
	 */
	public static boolean modImagePath(Forum fr) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_system set imagepath=? where id=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, fr.getImagepath());
			pstmt.setInt(2, fr.getId());
			
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
	 * 获得所有公告
	 * @serialData 2010-8-28
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public PageModel getNotes(int pageNo, int pageSize,String status) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rsre = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List<Forum> list = new ArrayList<Forum>();
		StringBuffer str=new StringBuffer();
//		String sql = "select * from t_system where 1=1  order by createtime desc " + "limit "
//				+ (pageNo - 1) * pageSize + ", " + pageSize;
		if(status != null && !"".equals(status)) {
			str.append(" and ISCid = " + status);
		}
		String sql = "select * from t_system where 1=1 and status = 'y' and deadtime>sysdate()"+str+" order by createtime desc " + "limit "
				+ (pageNo - 1) * pageSize + ", " + pageSize;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Forum fr = new Forum();
				fr.setId(rs.getInt("id"));
				fr.setHead(rs.getString("head"));
				fr.setContent(rs.getString("content"));
				fr.setCreatename(rs.getString("createname"));
				fr.setCreatetime(rs.getTimestamp("createtime"));
				fr.setImagepath(rs.getString("imagepath"));
				list.add(fr);
			}
			int totalRecords = getTotalRecords(conn);
			pm.setList(list);
			pm.setPageNo(pageNo);
			pm.setPageSize(pageSize);
			pm.setTotalRecords(totalRecords);

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
			DB.close(rsre);
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return pm;
	}
	
	/**
	 * 取得所有的记录数
	 * @serialData 2010-8-28
	 * 
	 * @param conn
	 *            connection
	 * @return 所有的记录数
	 */
	public int getTotalRecords(Connection conn) {
		String sql = "select count(*) from t_system where status = 'y' and deadtime>sysdate() " ;
		int totalRecords = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				totalRecords = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(stmt);
		}
		return totalRecords;
	}
	
	/**
	 * 根据ID取得系统公告信息
	 * @param id
	 * @return
	 */
	public Forum getNotesById(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rsre = null;
		boolean auto = false;
		Forum fr = null;
		String sql = "select * from t_system where id = " + id;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				fr = new Forum();
				fr.setId(rs.getInt("id"));
				fr.setHead(rs.getString("head"));
				fr.setContent(rs.getString("content"));
				fr.setCreatename(rs.getString("createname"));
				fr.setCreatetime(rs.getTimestamp("createtime"));
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
			DB.close(rsre);
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return fr;
	}
	
	/**
	 * 通过邮件方式发送公告信息
	 * @param forum
	 */
	public synchronized void sendForum(Forum forum) {
		List<String> to = new ArrayList<String>();
		to.add("lc@lccert.com");
		String head = "[LCIMS系统公告] " + forum.getHead();
		String content = forum.getContent();

		Email email = new Email();
		email.setTo(to);
		email.setHead(head);
		email.setContent(content);
		NotesSendMail send = new NotesSendMail();
		send.setEmail(email);
		Thread t = new Thread(send);
		t.start();
	}
	
	/**
	 * 根据ID删除系统公告信息
	 * @param id
	 */
	public void deleteForumById(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		String sql = "delete from t_system where id = " + id;

		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.executeUpdate();
			
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
			DB.close(pstmt);
			DB.close(conn);
		}
	}
}
