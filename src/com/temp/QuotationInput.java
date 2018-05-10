package com.temp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.Project;
import com.lccert.crm.quotation.Quotation;

/**
 * 旧订单操作管理类（已废弃）
 * 
 * @author eason
 * 
 */
public class QuotationInput {

	private static QuotationInput instance = null;

	private QuotationInput() {

	}

	public synchronized static QuotationInput getInstance() {
		if (instance == null) {
			instance = new QuotationInput();
		}
		return instance;
	}

	/**
	 * 添加报价单
	 * 
	 * @param qt
	 * @return
	 */
	public boolean addQuotation(Quotation qt) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "insert into t_quotation(vpid,vcompany,vsales,"
				+ "vprojectcontent,vclient,ftotalprice"
				+ ",vcreateuser,vstatus,vtag,fstandprice) "
				+ "values(?,?,?,?,?,?,?,?,?,?)";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, qt.getPid());
			pstmt.setString(2, qt.getCompany());
			pstmt.setString(3, qt.getSales());
			pstmt.setString(4, qt.getProjectcontent());
			pstmt.setString(5, qt.getClient());
			pstmt.setFloat(6, qt.getTotalprice());
			pstmt.setString(7, qt.getCreateuser());
			pstmt.setString(8, qt.getStatus());
			pstmt.setString(9, qt.getTag());
			pstmt.setFloat(10, qt.getStandprice());

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
	 * 修改报价单
	 * 
	 * @param qt
	 * @return
	 */
	public boolean updateQuotation(Quotation qt) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_quotation set dcompletetime=?,vcompany=?,vsales=?,"
				+ "vprojectcontent=?,vclient=?,vrpclient=?,ftotalprice=?,vinvhead=?,"
				+ "eadvancetype=?,einvtype=?,finvcount=?,vcreateuser=?,"
				+ "vtag=?,einvmethod=?,vinvcontent=?,fstandprice=? where vpid = ?";

		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);

			pstmt
					.setTimestamp(1, new Timestamp(qt.getCompletetime()
							.getTime()));
			pstmt.setString(2, qt.getCompany());
			pstmt.setString(3, qt.getSales());
			pstmt.setString(4, qt.getProjectcontent());
			pstmt.setString(5, qt.getClient());
			pstmt.setFloat(6, qt.getTotalprice());
			pstmt.setString(7, qt.getInvhead());
			pstmt.setString(8, qt.getAdvancetype());
			pstmt.setString(9, qt.getInvtype());
			pstmt.setFloat(10, qt.getInvcount());
			pstmt.setString(11, qt.getCreateuser());
			pstmt.setString(12, qt.getTag());
			pstmt.setString(13, qt.getInvmethod());
			pstmt.setString(14, qt.getInvcontent());
			pstmt.setFloat(15, qt.getStandprice());
			pstmt.setString(16, qt.getPid());
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
	
	
	public synchronized boolean addProject(Project p) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "insert into t_project (vsid,vpid,vrid,"
				+ "eptype,fprice,finsubcost,fpresubcost,"
				+ "vsubname,fpreagcost,vagname"
				+ ",vbuildname,fpresubcost2,vsubname2,fppreacount,dbuildtime,vtestcontent) values (?,?,?,?,?,?"
				+ ",?,?,?,?,?,?,?,?,?,?)";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			p.setSid(makeSid(p.getPid()));
			ChemProject cp = (ChemProject)p.getObj();

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, p.getSid());
			pstmt.setString(2, p.getPid());
			pstmt.setString(3, p.getRid());
			pstmt.setString(4, p.getPtype());
			pstmt.setFloat(5, p.getPrice());
			pstmt.setFloat(6, p.getInsubcost());
			pstmt.setString(7, p.getPresubcost());
			pstmt.setString(8, p.getSubname());
			pstmt.setFloat(9, p.getPreagcost());
			pstmt.setString(10, p.getAgname());
			pstmt.setString(11, p.getBuildname());
			pstmt.setString(12, p.getPresubcost2());
			pstmt.setString(13, p.getSubname2());
			pstmt.setFloat(14, p.getPpreacount());
			pstmt.setTimestamp(15, p.getBuildtime()==null?null:new Timestamp(p.getBuildtime().getTime()));
			pstmt.setString(16, p.getTestcontent());

			pstmt.executeUpdate();

			sql = "insert into t_chem_project (vsid,vrid,vpid,vsamplename,estatus,rpclient) values(?,?,?,?,?,?);";
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, p.getSid());
			pstmt.setString(2, p.getRid());
			pstmt.setString(3, p.getPid());
			pstmt.setString(4, cp.getSamplename());
			pstmt.setString(5, "发证");
			pstmt.setString(6, cp.getRpclient());
			pstmt.executeUpdate();
			
			
			
			sql = "select fppreacount from t_project where vpid = ?";
			float preacount = 0;
			int projectcount = 0;
			

				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, p.getPid());
				rs = pstmt.executeQuery();
				while (rs.next()) {
					preacount += rs.getFloat("fppreacount");
				}

				sql = "select iprojectcount from t_quotation where vpid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, p.getPid());
				rs = pstmt.executeQuery();
				if (rs.next()) {
					projectcount = rs.getInt("iprojectcount");
				}
				
				
				
				projectcount += 1;
				sql = "update t_quotation set iprojectcount = ? where vpid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setInt(1, projectcount);
				pstmt.setString(2, p.getPid());
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
	 * 生成内部对账单号
	 * 
	 * @param pid
	 * @return
	 */
	private synchronized String makeSid(String pid) {

		String sql = "Select vsid from t_project where vpid = ? order by vsid desc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sid = "";
		String end = "";
		try {
			conn = DB.getConn();

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String sub = rs.getString("vsid");
				String last = sub.substring(sub.length() - 1, sub.length());
				end = String.valueOf((char) (last.hashCode() + 1));
			} else {
				end = "A";
			}
			sid = pid + end;

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return sid;
	}

}
