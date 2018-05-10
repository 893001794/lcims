package com.lccert.crm.chemistry.util;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;
/***
 * 连接数据库
 * @author tangzp
 *
 */
public class ConnectionToDB {
	private static final String DRIVERCLASS = "com.mysql.jdbc.Driver";



	private static final ThreadLocal threadLocal = new ThreadLocal();

	ResultSet rs;

	PreparedStatement pstmt;

	Connection con;

	public Connection getConnection() {
		con = (Connection) threadLocal.get();
		try {
			Class.forName(DRIVERCLASS);
		} catch (Exception e1) {
			e1.printStackTrace();
		} 

		try {
			con = DriverManager.getConnection("jdbc:mysql://192.168.0.2:3336/td_oa?useUnicode=true&characterEncoding=GBK","root","tomcat");
			 System.out.print("连接数据库成功");
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return con;
	}

	// 返回单个记录
	public Vector getSingle(String sql, List temp) {
		Vector<Object> single = new Vector<Object>();
		try {
			pstmt = getConnection().prepareStatement(sql);
			if (temp != null) {
				for (int i = 0; i < temp.size(); i++) {
					pstmt.setObject(i + 1, temp.get(i));
				}
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				single.addElement(rs.getObject(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return single;
	}

	// 返回影响多少行，增，删，改
	public int getCount(String sql, List temp) {
		int count = 0;
		try {
			pstmt = getConnection().prepareStatement(sql);
			if (temp != null) {
				for (int i = 0; i < temp.size(); i++) {
					pstmt.setObject(i + 1, temp.get(i));

				}
			}
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}

	// 返加某一列的记录
	public Vector getColumn(String sql, List temp) {
		Vector<Object> column = new Vector<Object>();
		try {
			pstmt = getConnection().prepareStatement(sql);
			if (temp != null) {
				for (int i = 0; i < temp.size(); i++) {
					pstmt.setObject(i + 1, temp.get(i));
				}
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				column.addElement(rs.getObject(1));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return column;
	}

	// 返回表格中使用的rows,应用于显示表格
	public Vector getRows(String sql, List temp) {
		Vector<Vector<Object>> vector = new Vector<Vector<Object>>();
		try {
			pstmt = getConnection().prepareStatement(sql);
			if (temp != null) {

				for (int i = 0; i < temp.size(); i++) {
					pstmt.setObject(i + 1, temp.get(i));
				}
			}
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Vector<Object> v = new Vector<Object>();
				for (int j = 0; j < rs.getMetaData().getColumnCount(); j++) {
					v.addElement(rs.getObject(j + 1));
				}
				vector.addElement(v);
			}

		} catch (SQLException e) {

			e.printStackTrace();
		}
		return vector;
	}

	// 查的公共方法
	public ResultSet getResult(List temp, String sql) {
		try {
			con = getConnection();// 连接数据库
			pstmt = con.prepareStatement(sql);
			// 判断temp是否有数据
			if (temp != null) {
				for (int i = 0; i < temp.size(); i++) {
					pstmt.setObject(i + 1, temp.get(i));
				}
			}
			// 执行
			rs = pstmt.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}

	// 使用statement 进行处理SQL语句
	public Vector getRowByStmt(String sql) {
		Vector<Vector<Object>> vector = new Vector<Vector<Object>>();
		Statement stmt = null;
		try {
			stmt = getConnection().createStatement();

			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				Vector<Object> v = new Vector<Object>();
				for (int j = 0; j < rs.getMetaData().getColumnCount(); j++) {
					v.addElement(rs.getObject(j + 1));
				}
				vector.addElement(v);
			}

		} catch (SQLException e) {

			e.printStackTrace();
		} 
		return vector;
	}

	// 关闭公共方法
	public void closeAll() {
		try {

			if (rs != null) {
				rs.close();
				rs = null;
			}

			if (pstmt != null) {
				pstmt.close();
				pstmt = null;
			}
			if (con != null) {
				con.close();
				con = null;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}
