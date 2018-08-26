package com.lccert.crm.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.dao.ProjectDao;
import com.lccert.crm.flow.Flow;
import com.lccert.crm.project.ChemLabTime;
import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.PhyProject;
import com.lccert.crm.project.Project;
import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.quotation.QuotationAction;
import com.lccert.crm.vo.FinishProject;
import com.lccert.crm.vo.SalesOrderItem;

/**
 * 所有项目dao实现类
 * 基于mysql数据库的所有dao实现类
 * @author Eason
 *
 */
public class ProjectDaoImplMySql implements ProjectDao {

	/**
	 * 添加新项目
	 * @param pj
	 * @param cp
	 * @return
	 */
	public boolean addStatement(Project p) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "";

		if(!("化学测试".equals(p.getPtype())||p.getPtype().indexOf("化妆品")>-1||p.getPtype().indexOf("环境")>-1)) {
			p.setRid(makeRid(p));//非化学项目(安规项目)生成报告编号
			sql = "insert into t_project (vsid,vpid,vrid,"
				+ "eptype,etype,elab,isout,fprice,finsubcost,fpresubcost,"
				+ "vsubname,fpreagcost,vagname,fpreinvprice,einvtype,"
				+ "vinvhead,vinvcontent,vbuildname,fpresubcost2,vsubname2,"
				+ "fppreacount,eclientpay,vtestcontent,dbuildtime) values (?,?,'" + p.getRid() + "',?,'" + p.getType() + "','" + p.getLab() + "'"
				+ ",'" + p.getIsout() + "',?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now())";
//			        insert into t_project (vsid,vpid,"
//					+ "eptype,fprice,finsubcost,fpresubcost,"
//					+ "vsubname,fpreagcost,vagname,fpreinvprice,einvtype,"
//					+ "vinvhead,vinvcontent,vbuildname,fpresubcost2,vsubname2,fppreacount,eclientpay,dbuildtime) values (?,?,?,?,?,?"
//					+ ",?,?,?,?,?,?,?,?,?,?,?,?,now()
		} else {
			sql = "insert into t_project (vsid,vpid,"
				+ "eptype,fprice,finsubcost,fpresubcost,"
				+ "vsubname,fpreagcost,vagname,fpreinvprice,einvtype,"
				+ "vinvhead,vinvcontent,vbuildname,fpresubcost2,vsubname2,fppreacount,eclientpay,vtestcontent,dbuildtime) values (?,?,?,?,?,?"
				+ ",?,?,?,?,?,?,?,?,?,?,?,?,?,now())";
		}

		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			p.setSid(makeSid(p.getPid()));

			pstmt = DB.prepareStatement(conn, sql,Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, p.getSid());
			pstmt.setString(2, p.getPid());
			pstmt.setString(3, p.getPtype());
			pstmt.setFloat(4, p.getPrice());
			pstmt.setFloat(5, p.getInsubcost());
			pstmt.setString(6, p.getPresubcost());
			pstmt.setString(7, p.getSubname());
			pstmt.setFloat(8, p.getPreagcost());
			pstmt.setString(9, p.getAgname());
			pstmt.setFloat(10, p.getPreinvprice());
			pstmt.setString(11, p.getInvtype());
			pstmt.setString(12, p.getInvhead());
			pstmt.setString(13, p.getInvcontent());
			pstmt.setString(14, p.getBuildname());
			pstmt.setString(15, p.getPresubcost2());
			pstmt.setString(16, p.getSubname2());
			pstmt.setFloat(17, p.getPpreacount());
			pstmt.setString(18, p.getClientpay());
			pstmt.setString(19, p.getTestcontent());
			pstmt.executeUpdate();

//			//更新网站数据
//			int key = 0;
//			rs = pstmt.getGeneratedKeys();
//			if(rs.next()) {
//				key = rs.getInt(1);
//			}

			//---------------------------2010-12-14---------------------------------------

			if(!("化学测试".equals(p.getPtype())||p.getPtype().indexOf("化妆品")>-1||p.getPtype().indexOf("环境")>-1))  {
				sql = "insert into t_phy_project (vsid,vpid,vrid,estatus,istatus) values(?,?,?,'立项',1);";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, p.getSid());
				pstmt.setString(2, p.getPid());
				pstmt.setString(3, p.getRid());
				pstmt.executeUpdate();
			} else {
			//---------------------------2010-12-14---------------------------------------
				sql = "insert into t_chem_project (vsid,vpid,estatus,istatus) values(?,?,'立项',1)";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, p.getSid());
				pstmt.setString(2, p.getPid());
				pstmt.executeUpdate();
			}



			conn.commit();

			updateStatus(p.getPid(),p.getPtype());

//			//更新网站数据
//			UpdateWebSite up = new UpdateWebSite();
//			up.setId(key);
//			up.setType("project");
//			Thread t = new Thread(up);
//			t.start();
//
//			UpdateWebSite w = new UpdateWebSite();
//			w.setId(key);
//			w.setType("detail");//更新项目进度表
//			Thread th = new Thread(w);
//			th.start();

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
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return isok;
	}



	/**
	 * 添加免费新项目
	 * @param pj
	 * @param cp
	 * @return
	 */
	public boolean addFreeStatement(Project p) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "insert into t_project (vsid,vpid,"
				+ "eptype,fprice,finsubcost,fpresubcost,"
				+ "vsubname,fpreagcost,vagname,fpreinvprice,einvtype,"
				+ "vinvhead,vinvcontent,vbuildname,fpresubcost2,vsubname2,fppreacount,eclientpay,dbuildtime) values (?,?,?,?,?,?"
				+ ",?,?,?,?,?,?,?,?,?,?,?,?,now())";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			p.setSid(makeSid(p.getPid()));
			pstmt = DB.prepareStatement(conn, sql,Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, p.getSid());
			pstmt.setString(2, p.getPid());
			pstmt.setString(3, p.getPtype());
			pstmt.setFloat(4, p.getPrice());
			pstmt.setFloat(5, p.getInsubcost());
			pstmt.setString(6, p.getPresubcost());
			pstmt.setString(7, p.getSubname());
			pstmt.setFloat(8, p.getPreagcost());
			pstmt.setString(9, p.getAgname());
			pstmt.setFloat(10, p.getPreinvprice());
			pstmt.setString(11, p.getInvtype());
			pstmt.setString(12, p.getInvhead());
			pstmt.setString(13, p.getInvcontent());
			pstmt.setString(14, p.getBuildname());
			pstmt.setString(15, p.getPresubcost2());
			pstmt.setString(16, p.getSubname2());
			pstmt.setFloat(17, p.getPpreacount());
			pstmt.setString(18, p.getClientpay());
			pstmt.executeUpdate();
//			//更新网站数据
//			int key = 0;
//			rs = pstmt.getGeneratedKeys();
//			if(rs.next()) {
//				key = rs.getInt(1);
//			}


			//---------------------------2010-12-14---------------------------------------
			if(!("化学测试".equals(p.getPtype())||"化妆品".equals(p.getPtype()))) {
				sql = "insert into t_phy_project (vsid,vpid,vrid,estatus,istatus) values(?,?,?,'立项',1);";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, p.getSid());
				pstmt.setString(2, p.getPid());
				pstmt.setString(3, p.getRid());
				//System.out.println(p.getRid()+"---------------------------");
				pstmt.executeUpdate();
			} else {
			//---------------------------2010-12-14---------------------------------------
				sql = "insert into t_chem_project (vsid,vpid,estatus,istatus) values(?,?,'立项',1)";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, p.getSid());
				pstmt.setString(2, p.getPid());
				pstmt.executeUpdate();
			}

			sql = "update t_quotation set equotype = 'mod' where vpid = ?";
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, p.getPid());
			pstmt.executeUpdate();

			conn.commit();

			updateStatus(p.getPid(),p.getPtype());

//			//更新网站数据
//			UpdateWebSite up = new UpdateWebSite();
//			up.setId(key);
//			up.setType("project");
//			Thread t = new Thread(up);
//			t.start();
//
//			UpdateWebSite w = new UpdateWebSite();
//			w.setId(key);
//			w.setType("detail");//更新项目进度表
//			Thread th = new Thread(w);
//			th.start();

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
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return isok;
	}

	/**
	 * 修改内部对账单
	 *
	 * @param p
	 * @return
	 */
	public boolean modifyStatement(Project p) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "";
		if(!("化学测试".equals(p.getPtype())||p.getPtype().indexOf("化妆品")>-1||p.getPtype().indexOf("环境")>-1))  {
			sql = "update t_project set eptype='" + p.getPtype() + "',etype='" + p.getType() + "',elab='" + p.getLab() + "',"
				+ "isout='" + p.getIsout() + "',fprice=?,finsubcost=?,fpresubcost=?,"
				+ "vsubname=?,fpreagcost=?,vagname=?,fpreinvprice=?,einvtype=?,"
				+ "vinvhead=?,vinvcontent=?,fpresubcost2=?,vsubname2=?,fppreacount=?,eclientpay=?,vtestcontent=?" +
				 " where vsid = ?";
		} else {
			sql = "update t_project set "
				+ "fprice=?,finsubcost=?,fpresubcost=?,"
				+ "vsubname=?,fpreagcost=?,vagname=?,fpreinvprice=?,einvtype=?,"
				+ "vinvhead=?,vinvcontent=?,fpresubcost2=?,vsubname2=?,fppreacount=?,eclientpay=?,vtestcontent=?"
				+ " where vsid = ?";
		}

		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setFloat(1, p.getPrice());
			pstmt.setFloat(2, p.getInsubcost());
			pstmt.setString(3, p.getPresubcost());
			pstmt.setString(4, p.getSubname());
			pstmt.setFloat(5, p.getPreagcost());
			pstmt.setString(6, p.getAgname());
			pstmt.setFloat(7, p.getPreinvprice());
			pstmt.setString(8, p.getInvtype());
			pstmt.setString(9, p.getInvhead());
			pstmt.setString(10, p.getInvcontent());
			pstmt.setString(11, p.getPresubcost2());
			pstmt.setString(12, p.getSubname2());
			pstmt.setFloat(13, p.getPpreacount());
			pstmt.setString(14, p.getClientpay());
			pstmt.setString(15, p.getTestcontent());
			pstmt.setString(16, p.getSid());
			pstmt.executeUpdate();
			conn.commit();
			updateStatus(p.getPid(),p.getPtype());
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


	//  "dostime=?,dortime=?,dbqtime,doetime"
	//


	/**
	 * 删除项目
	 */
	public void delProject(String sql,Project p) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;

		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.executeUpdate();

			if(p != null) {
				updateStatus(p.getPid(),p.getPtype());
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
			DB.close(pstmt);
			DB.close(conn);
		}
	}

	/**
	 * 查找项目
	 * @param sql SQL语句
	 * @return
	 */
	public Project getProject(String sql) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Project p = null;

		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				p = new Project();
				p.setId(rs.getInt("id"));
				p.setSid(rs.getString("vsid"));
				p.setPid(rs.getString("vpid"));
				p.setRid(rs.getString("vrid"));
				p.setPtype(rs.getString("eptype"));
				p.setTestcontent(rs.getString("vtestcontent"));
				p.setBuildname(rs.getString("vbuildname"));
				p.setBuildtime(rs.getTimestamp("dbuildtime"));
				p.setPrice(rs.getFloat("fprice"));
				p.setPresubcost(rs.getString("fpresubcost"));
				p.setSubname(rs.getString("vsubname"));
				p.setSubcost(rs.getFloat("fsubcost"));
				p.setSubcosttime(rs.getTimestamp("dsubcosttime"));
				p.setSubcostnotes(rs.getString("vsubcostnotes"));
				p.setPresubcost2(rs.getString("fpresubcost2"));
				p.setSubname2(rs.getString("vsubname2"));
				p.setSubcost2(rs.getFloat("fsubcost2"));
				p.setSubcosttime2(rs.getTimestamp("dsubcosttime2"));
				p.setSubcostnotes2(rs.getString("vsubcostnotes2"));
				p.setInsubcost(rs.getFloat("finsubcost"));
				p.setInsubtag(rs.getString("vinsubtag"));
				p.setPreagcost(rs.getFloat("fpreagcost"));
				p.setAgname(rs.getString("vagname"));
				p.setClientpay(rs.getString("eclientpay"));
				p.setClientpay(rs.getString("eclientpay"));
				p.setAgcost(rs.getFloat("fagcost"));
				p.setAgtime(rs.getTimestamp("dagtime"));
				p.setAgnotes(rs.getString("vagnotes"));
				p.setAgtag(rs.getString("vagtag"));
				p.setOtherscost(rs.getFloat("fotherscost"));
				p.setOtherstag(rs.getString("votherstag"));
				p.setInvtype(rs.getString("einvtype"));
				p.setInvhead(rs.getString("vinvhead"));
				p.setInvcontent(rs.getString("vinvcontent"));
				p.setPreinvprice(rs.getFloat("fpreinvprice"));
				p.setInvprice(rs.getFloat("finvprice"));
				p.setProjectsettle(rs.getString("vprojectsettle"));
				p.setPpreacount(rs.getFloat("fppreacount"));
				p.setPacount(rs.getFloat("fpacount"));
				p.setLevel(rs.getString("vlevel"));
				p.setType(rs.getString("etype"));
				p.setLab(rs.getString("elab"));
				p.setIsout(rs.getString("isout"));
				p.setNotes(rs.getString("vnotes"));
				p.setOstime(rs.getTimestamp("dostime"));
				p.setOrtime(rs.getTimestamp("dortime"));
				p.setBqtime(rs.getTimestamp("dBqtime"));
				p.setOetime(rs.getTimestamp("doetime"));
				p.setTuvno(rs.getString("vtuvno"));
				p.setTuvpshort(rs.getString("vtuvpshort"));
				p.setLcrealprice(rs.getFloat("flcrealprice"));
				p.setOeprice(rs.getFloat("foeprice"));

				if(!("化学测试".equals(p.getPtype())||p.getPtype().indexOf("化妆品")>-1||p.getPtype().indexOf("环境")>-1))  {
					PhyProject pp = new PhyProject();
					getPhyProject(pp,p.getSid());
					p.setObj(pp);
				} else {
					ChemProject cp = new ChemProject();
					getChemProject(cp,p.getSid());
					p.setObj(cp);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return p;
	}




	/**
	 * 查找项目
	 * @param sql SQL语句
	 * @return
	 */
	public Flow getFlowByRid(String sql) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Flow f = null;

		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				f= new Flow();
				f.setSid(rs.getString("vsid"));
				f.setPid(rs.getString("vpid"));
				f.setRid(rs.getString("vrid"));
				f.setFid(rs.getString("vfid"));

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return f;
	}



	/**
	 * 查找所有项目
	 *
	 * @param sql  sql语句
	 * @return List<Project> 项目列表
	 */
	public List<Project> getAllProjects(String sql) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Project p = null;
		List<Project> list = new ArrayList<Project>();
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {

				p = new Project();
				p.setId(rs.getInt("id"));
				p.setSid(rs.getString("vsid"));
				p.setPid(rs.getString("vpid"));
				p.setRid(rs.getString("vrid"));
				p.setPtype(rs.getString("eptype"));
				p.setTestcontent(rs.getString("vtestcontent"));
				p.setBuildname(rs.getString("vbuildname"));
				p.setBuildtime(rs.getTimestamp("dbuildtime"));
				p.setPrice(rs.getFloat("fprice"));
				p.setPresubcost(rs.getString("fpresubcost"));
				p.setSubname(rs.getString("vsubname"));
				p.setSubcost(rs.getFloat("fsubcost"));
				p.setSubcosttime(rs.getTimestamp("dsubcosttime"));
				p.setSubcostnotes(rs.getString("vsubcostnotes"));
				p.setPresubcost2(rs.getString("fpresubcost2"));
				p.setSubname2(rs.getString("vsubname2"));
				p.setSubcost2(rs.getFloat("fsubcost2"));
				p.setSubcosttime2(rs.getTimestamp("dsubcosttime2"));
				p.setSubcostnotes2(rs.getString("vsubcostnotes2"));
				p.setInsubcost(rs.getFloat("finsubcost"));
				p.setInsubtag(rs.getString("vinsubtag"));
				p.setPreagcost(rs.getFloat("fpreagcost"));
				p.setAgname(rs.getString("vagname"));
				p.setClientpay(rs.getString("eclientpay"));
				p.setClientpay(rs.getString("eclientpay"));
				p.setAgcost(rs.getFloat("fagcost"));
				p.setAgtime(rs.getTimestamp("dagtime"));
				p.setAgnotes(rs.getString("vagnotes"));
				p.setAgtag(rs.getString("vagtag"));
				p.setOtherscost(rs.getFloat("fotherscost"));
				p.setOtherstag(rs.getString("votherstag"));
				p.setInvtype(rs.getString("einvtype"));
				p.setInvhead(rs.getString("vinvhead"));
				p.setInvcontent(rs.getString("vinvcontent"));
				p.setPreinvprice(rs.getFloat("fpreinvprice"));
				p.setInvprice(rs.getFloat("finvprice"));
				p.setProjectsettle(rs.getString("vprojectsettle"));
				p.setPpreacount(rs.getFloat("fppreacount"));
				p.setPacount(rs.getFloat("fpacount"));
				p.setLevel(rs.getString("vlevel"));
				p.setType(rs.getString("etype"));
				p.setLab(rs.getString("elab"));
				p.setIsout(rs.getString("isout"));
				p.setNotes(rs.getString("vnotes"));
				p.setGranttime(rs.getString("granttime"));
				//------------------2010-12-15--------------------------
				if(!("化学测试".equals(p.getPtype())||"化妆品".equals(p.getPtype())||"环境".equals(p.getPtype()))) {
					PhyProject pp = new PhyProject();
					getPhyProject(pp,p.getSid());
					p.setObj(pp);
				} else {
					//------------------2010-12-15--------------------------

					ChemProject cp = new ChemProject();
					getChemProject(cp,p.getSid());
					p.setObj(cp);
				}

				list.add(p);
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
	 * 查找所有项目(分页模式)
	 * @param pageNo
	 * @param pageSize
	 * @param sql
	 * @return PageModel 分页模型
	 */
	public PageModel getAllProjects(int pageNo, int pageSize, String sql) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List<Project> list = new ArrayList<Project>();
		Project p = null;
		String str = sql + "  limit " + (pageNo - 1) * pageSize + ", " + pageSize;

		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, str);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				p = new Project();
				p.setId(rs.getInt("id"));
				p.setSid(rs.getString("vsid"));
				p.setPid(rs.getString("vpid"));
				p.setRid(rs.getString("vrid"));
				p.setPtype(rs.getString("eptype"));
				p.setTestcontent(rs.getString("vtestcontent"));
				p.setBuildname(rs.getString("vbuildname"));
				p.setBuildtime(rs.getTimestamp("dbuildtime"));
				p.setPrice(rs.getFloat("fprice"));
				p.setPresubcost(rs.getString("fpresubcost"));
				p.setSubname(rs.getString("vsubname"));
				p.setSubcost(rs.getFloat("fsubcost"));
				p.setSubcosttime(rs.getTimestamp("dsubcosttime"));
				p.setSubcostnotes(rs.getString("vsubcostnotes"));
				p.setPresubcost2(rs.getString("fpresubcost2"));
				p.setSubname2(rs.getString("vsubname2"));
				p.setSubcost2(rs.getFloat("fsubcost2"));
				p.setSubcosttime2(rs.getTimestamp("dsubcosttime2"));
				p.setSubcostnotes2(rs.getString("vsubcostnotes2"));
				p.setInsubcost(rs.getFloat("finsubcost"));
				p.setInsubtag(rs.getString("vinsubtag"));
				p.setPreagcost(rs.getFloat("fpreagcost"));
				p.setAgname(rs.getString("vagname"));
				p.setClientpay(rs.getString("eclientpay"));
				p.setClientpay(rs.getString("eclientpay"));
				p.setAgcost(rs.getFloat("fagcost"));
				p.setAgtime(rs.getTimestamp("dagtime"));
				p.setAgnotes(rs.getString("vagnotes"));
				p.setAgtag(rs.getString("vagtag"));
				p.setOtherscost(rs.getFloat("fotherscost"));
				p.setOtherstag(rs.getString("votherstag"));
				p.setInvtype(rs.getString("einvtype"));
				p.setInvhead(rs.getString("vinvhead"));
				p.setInvcontent(rs.getString("vinvcontent"));
				p.setPreinvprice(rs.getFloat("fpreinvprice"));
				p.setInvprice(rs.getFloat("finvprice"));
				p.setProjectsettle(rs.getString("vprojectsettle"));
				p.setPpreacount(rs.getFloat("fppreacount"));
				p.setPacount(rs.getFloat("fpacount"));
				p.setLevel(rs.getString("vlevel"));
				p.setType(rs.getString("etype"));
				p.setLab(rs.getString("elab"));
				p.setIsout(rs.getString("isout"));
				p.setNotes(rs.getString("vnotes"));

//				if(!"化学测试".equals(p.getPtype())) {
//					PhyProject pp = new PhyProject();
//					getPhyProject(pp,p.getSid());
//					p.setObj(pp);
//				} else {
					ChemProject cp = new ChemProject();
					getChemProject(cp,p.getSid());
					p.setObj(cp);
//				}

				list.add(p);
			}
			int totalRecords = getTotalRecords(conn,sql);
			pm = new PageModel();
			pm.setPageNo(pageNo);
			pm.setPageSize(pageSize);
			pm.setList(list);
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
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return pm;
	}

	/**
	 * 根据旧的报价单号找到新的报价单信息
	 *
	 */

	public List getQuotation(String pid) {
		String sql ="select  * from t_quotation where vpid like '%"+pid+"'";
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
				Quotation qt = new Quotation();
				qt.setPid(rs.getString("vpid"));
				qt.setQuotype(rs.getString("equotype"));
				qt.setInvcount(rs.getFloat("finvcount"));
				qt.setOldPid(rs.getString("voldpid"));
				list.add(qt);
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
	public PageModel searchProjects(int pageNo, int pageSize, String sql) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List<FinishProject> list = new ArrayList<FinishProject>();
		FinishProject fp = null;
		String str = sql + "  limit " + (pageNo - 1) * pageSize + ", " + pageSize;

		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, str);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				fp = new FinishProject();
				fp.setPid(rs.getString("a.vpid"));
				fp.setObj(getQuotation(fp.getPid()));
				//fp.setOldPid(rs.getString("a.voldpid"));
				fp.setSid(rs.getString("b.vsid"));
				fp.setRid(rs.getString("b.vrid"));
				fp.setClient(rs.getString("a.vclient"));
				fp.setRptype(rs.getString("c.erptype"));
				fp.setPrice(rs.getFloat("a.ftotalprice"));
				fp.setPaystatus(rs.getString("a.epaystatus"));
				fp.setSales(rs.getString("a.vsales"));
				fp.setStatus(rs.getString("c.estatus"));

				list.add(fp);
			}
			int totalRecords = getTotalRecords(conn,sql);
			pm = new PageModel();
			pm.setPageNo(pageNo);
			pm.setPageSize(pageSize);
			pm.setList(list);
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
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return pm;
	}


	/**
	 * 取得安规项目
	 * @param pp
	 * @param sid
	 */
	private void getPhyProject(PhyProject pp,String sid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from t_phy_project where vsid = ?";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, sid);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				pp.setRptype(rs.getString("erptype"));
				pp.setRptime(rs.getTimestamp("drptime"));
				pp.setCreatename(rs.getString("vcreatename"));
				pp.setCreatetime(rs.getTimestamp("dcreatetime"));
				pp.setBeginuser(rs.getString("vbeginuser"));
				pp.setBegintime(rs.getTimestamp("dbegintime"));
				pp.setBeginuser(rs.getString("venduser"));
				pp.setBegintime(rs.getTimestamp("dendtime"));
				pp.setRpclient(rs.getString("vrpclient"));
				pp.setEngineer(rs.getString("vengineer"));
				pp.setContact(rs.getString("vcontact"));
				pp.setServname(rs.getString("vservname"));
				pp.setSamplename(rs.getString("vsamplename"));
				pp.setSamplecount(rs.getString("vsamplecount"));
				pp.setSamplecategory(rs.getString("vsamplecategory"));
				pp.setSamplemodel(rs.getString("vsamplemodel"));
				pp.setStatus(rs.getString("estatus"));
				pp.setIstatus(rs.getInt("istatus"));
				pp.setRatedpower(rs.getString("vratedpower"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}

	/**
	 * 取得化学项目
	 * @param cp
	 * @param sid
	 */
	private void getChemProject(ChemProject cp,String sid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from t_chem_project where vsid = ?";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, sid);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				cp.setContact(rs.getString("vcontact"));
				cp.setEngineer(rs.getString("vengineer"));
				cp.setProjectend(rs.getString("eprojectend"));
				cp.setRptype(rs.getString("erptype"));
				cp.setRptime(rs.getTimestamp("drptime"));
				cp.setRpclient(rs.getString("rpclient"));
				cp.setCreatename(rs.getString("vcreatename"));
				cp.setCreatetime(rs.getTimestamp("dcreatetime"));
				cp.setEndtime(rs.getTimestamp("dendtime"));
				cp.setEnduser(rs.getString("venduser"));
				cp.setIsfinish(rs.getString("isfinish"));
				cp.setProjectend(rs.getString("eprojectend"));
				cp.setSendtime(rs.getTimestamp("dsendtime"));
				cp.setSenduser(rs.getString("vsenduser"));
				cp.setRptype(rs.getString("erptype"));
				cp.setFlowcount(rs.getInt("iflowcount"));
				cp.setSamplename(rs.getString("vsamplename"));
				cp.setSamplecount(rs.getString("vsamplecount"));
				cp.setSampledesc(rs.getString("tsampledesc"));
				cp.setAppform(rs.getString("tappform"));
				cp.setAddnotes(rs.getString("taddnotes"));
				cp.setServname(rs.getString("vservname"));
				cp.setWarning(getWarning(sid));
				cp.setStatus(rs.getString("estatus"));
				cp.setIstatus(rs.getInt("istatus"));
				cp.setList(getChemLabTime(sid));
				cp.setWorkpoint(rs.getString("vworkpoint"));
				cp.setDraft(rs.getString("edraft"));
				cp.setFilingNo(rs.getString("filingno"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}


	/**
	 * 取得总条数
	 * @param conn
	 * @param sql
	 * @return
	 */
	public int getTotalRecords(Connection conn , String sql) {
		int totalRecords = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			rs.last();
			totalRecords = rs.getRow();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
		}
		return totalRecords;
	}



	/**
	 * 生成内部对账单号
	 *
	 * @param pid
	 * @return
	 */
	private synchronized String makeSid(String pid) {
		String sql = "Select vsid from t_project where vpid = ? order by id desc";
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
				//System.out.println(sub+":sub");
				String last = sub.split("-")[1];
				//System.out.println(last+":last");
//				String last = sub.substring(sub.length() - 1, sub.length());
				int code = Integer.parseInt(last);
				//System.out.println(code+":code");
				code += 1;
				end = "-" + code;
			} else {
				end = "-1";
			}
			sid = pid + end;
//			System.out.println(sid);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return sid;
	}

	/**
	 * 自动生成报告编号
	 *
	 * @return rid 报告编号
	 */
	private synchronized String makeRid(Project p) {
		String ptype = p.getPtype();
		String lab = p.getLab();
		String type = p.getType();
		String isout = p.getIsout();
		Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
		String company = qt.getCompany();
		StringBuffer str = new StringBuffer();
		String pstr = "";
		String last = "";
		str.append("LC");
		if ("中山".equals(company)) {
			str.append("Z");
		} else if ("广州".equals(company)) {
			str.append("G");
		} else if ("东莞".equals(company)) {
			str.append("D");
		}
		if ("化学测试".equals(ptype)) {
			if ("东莞实验室".equals(lab)) {
				//str.append("D");
				pstr = "D";
			} else {
				//str.append("C");
				pstr = "C";
			}

		} else if ("电子电器安全测试".equals(ptype)) {
			//str.append("S");
			pstr = "S";
		} else if ("EMC测试".equals(ptype)) {
			//str.append("E");
			pstr = "E";
		} else if ("光性能测试".equals(ptype)) {
			//str.append("P");
			pstr = "P";
		} else if ("能效测试".equals(ptype)) {
			//str.append("P");
			pstr = "N";
		}else if ("化妆品".equals(ptype)){
			pstr = "H";
		}else if ("环境".equals(ptype)){
			pstr = "J";
		}
		str.append(pstr);
		Date date = new Date();
		String year = new SimpleDateFormat("yy").format(date);
		String month = new SimpleDateFormat("MM").format(date);
		str.append(year + month);
		String keyword = pstr + year + month;

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String sql = "";

		if("化学测试".equals(ptype)) {
			if ("机构合作".equals(type)) {
				sql = "Select vrid from t_project where etype = '"
						+ type + "' and vrid like '%" + keyword
						+ "%' order by substring(vrid,9,12) desc";
			} else if ("y".equals(isout)) {
				sql = "Select vrid from t_project where isout = 'y' and vrid  like '%"
					+ keyword + "%' order by substring(vrid,9,12) desc";
			} else if ("自测".equals(type)) {
				if ("中山实验室".equals(lab)) {
					sql = "Select vrid from t_project where isout='n' and etype = '"
							+ type
							+ "' and elab = '"
							+ lab
							+ "' and vrid like '%"
							+ keyword + "%' order by substring(vrid,9,12) desc";
				} else {
					sql = "Select vrid from t_project where isout='n' and etype = '"
							+ type
							+ "' and elab = '"
							+ lab
							+ "' and vrid like '%"
							+ keyword + "%' order by substring(vrid,9,12) desc";
				}
			}
		} else {
			sql = "Select vrid from t_project where eptype = '"
				+ ptype
				+ "' and vrid like '%"
				+ keyword + "%' order by substring(vrid,9,12) desc";
		}
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String sub = rs.getString("vrid");
				int code = Integer.parseInt(sub.substring(8, sub.length()));
				code += 1;
				last = new DecimalFormat("0000").format(code);
			} else {
				if("化学测试".equals(ptype)) {
					if ("机构合作".equals(type)) {
						last = "8000";
					} else if ("y".equals(isout)) {
						last = "9000";
					} else if ("自测".equals(type)) {
						if ("中山实验室".equals(lab)) {
							last = "0001";
						} else {
							last = "6000";
						}
					}
				} else {
					last = "0001";
				}
			}
			str.append(last);
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
		return str.toString();
	}


	/**
	 * 修改报告编号
	 *
	 * @return rid 报告编号
	 */
	private synchronized String modRid(Project p) {
		String rid = "";
		String ptype = p.getPtype();
		String lab = p.getLab();
		String type = p.getType();
		String isout = p.getIsout();
		Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
		String company = qt.getCompany();
		StringBuffer str = new StringBuffer();
		String pstr = "";
		String last = "";
		str.append("LC");
		if ("中山".equals(company)) {
			str.append("Z");
		} else if ("广州".equals(company)) {
			str.append("G");
		} else if ("东莞".equals(company)) {
			str.append("D");
		}
		if ("化学测试".equals(ptype)) {
			if ("东莞实验室".equals(lab)) {
				//str.append("D");
				pstr = "D";
			} else {
				//str.append("C");
				pstr = "C";
			}

		} else if ("电子电器安全测试".equals(ptype)) {
			//str.append("S");
			pstr = "S";
		} else if ("EMC测试".equals(ptype)) {
			//str.append("E");
			pstr = "E";
		} else if ("光性能测试".equals(ptype)) {
			//str.append("P");
			pstr = "P";
		} else if ("能效测试".equals(ptype)) {
			//str.append("P");
			pstr = "N";
		}
		str.append(pstr);
		Date date = new Date();
		String year = new SimpleDateFormat("yy").format(date);
		String month = new SimpleDateFormat("MM").format(date);
		str.append(year + month);
		String keyword = pstr + year + month;

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String sql = "";

		if("化学测试".equals(ptype)) {
			if ("机构合作".equals(type)) {
				sql = "Select vrid from t_project where etype = '"
						+ type + "' and vrid like '%" + keyword
						+ "%' order by substring(vrid,9,12)";
			} else if ("y".equals(isout)) {
				sql = "Select vrid from t_project where isout = 'y' and vrid  like '%"
					+ keyword + "%' order by substring(vrid,9,12)";
			} else if ("自测".equals(type)) {
				if ("中山实验室".equals(lab)) {
					sql = "Select vrid from t_project where isout='n' and etype = '"
							+ type
							+ "' and elab = '"
							+ lab
							+ "' and vrid like '%"
							+ keyword + "%' order by substring(vrid,9,12)";
				} else {
					sql = "Select vrid from t_project where isout='n' and etype = '"
							+ type
							+ "' and elab = '"
							+ lab
							+ "' and vrid like '%"
							+ keyword + "%' order by substring(vrid,9,12)";
				}
			}
		} else {
			sql = "Select vrid from t_project where eptype = '"
				+ ptype
				+ "' and vrid like '%"
				+ keyword + "%' order by substring(vrid,9,12)";
		}
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String word = "";
				String sub = rs.getString("vrid");
				int code = Integer.parseInt(sub.substring(8, sub.length()));
				code += 1;
				last = new DecimalFormat("0000").format(code);
				word = keyword + last;
				if(!isRid(word)) {
					rid = str.toString() + last;
					break;
				}
			}
			if("".equals(rid)){
				if("化学测试".equals(ptype)) {
					if ("机构合作".equals(type)) {
						rid = str.append("8000").toString();
					} else if ("y".equals(isout)) {
						rid = str.append("9000").toString();
					} else if ("自测".equals(type)) {
						if ("中山实验室".equals(lab)) {
							rid = str.append("0001").toString();
						} else {
							rid = str.append("6000").toString();
						}
					}
				} else {
					rid = str.append("0001").toString();
				}
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
		return rid;
	}

	/**
	 * 判断该rid是否存在
	 * @param rid
	 * @return
	 */
	private boolean isRid(String rid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean isexits = false;
		String sql = "select * from t_project where vrid like '%" + rid + "%'";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				isexits = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return isexits;
	}



	/**
	 * 分解项目，同时更新相关数据
	 * @param pid
	 * @return
	 */
	private synchronized boolean updateStatus(String pid,String ptype) {
		//分项目票据总金额
		float invtotal = 0;
		//分项目核算基数总计
		float preacount = 0;
		//分项目数量
		int projectcount = 0;
		//所有分包费预计
		float presubcost = 0;
		//所有实际分包费
		float subcost = 0;
		//所有内部分包费
		float insubcost = 0;
		//所有合作机构费预计
		float preagcost = 0;
		//所有实际合计机构费用
		float agcost = 0;
		//分项目总金额
		float price = 0;
		//报价单金额
		float totalprice = 0;
		boolean isok = false;
		String invmethod = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DB.getConn();

			String sql = "select sum(fppreacount),sum(fpreinvprice),count(*),sum(fpresubcost),sum(fsubcost),sum(fpresubcost2),sum(fsubcost2),sum(finsubcost),sum(fpreagcost),sum(fagcost),sum(fprice) from t_project where vpid = ?";
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				preacount = rs.getFloat(1);
				invtotal = rs.getFloat(2);
				projectcount = rs.getInt(3);
				presubcost = rs.getFloat(4) + rs.getFloat(6);
				subcost = rs.getFloat(5) + rs.getFloat(7);
				insubcost = rs.getFloat(8);
				preagcost = rs.getFloat(9);
				agcost = rs.getFloat(10);
				price = rs.getFloat(11);
			}

			sql = "select * from t_quotation where vpid = ?";
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalprice = rs.getFloat("ftotalprice");
			}


			//更新订单分项目数量、核算基数、预估外部分包费、实际外部分包费、内部分包费、预估合作机构费用、合作机构费用、订单进度
			sql = "update t_quotation set iprojectcount=?,fpreacount=?,fpresubcost=?,fsubcost=?,finsubcost=?,fpreagcost=?,fagcost=?,vstatus = '进行中' where vpid = ?";
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, projectcount);
			pstmt.setFloat(2, preacount);
			pstmt.setFloat(3, presubcost);
			pstmt.setFloat(4, subcost);
			pstmt.setFloat(5, insubcost);
			pstmt.setFloat(6, preagcost);
			pstmt.setFloat(7, agcost);
			pstmt.setString(8, pid);

			pstmt.executeUpdate();


			sql = "select einvmethod from t_quotation where vpid = ?";
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				invmethod = rs.getString("einvmethod");
			}

			//如果为票据支付方式为'分项目'，则计算分项目总金额
			if("分项目".equals(invmethod)) {
				sql = "update t_quotation set finvcount = ? where vpid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setFloat(1, invtotal);
				pstmt.setString(2, pid);
				pstmt.executeUpdate();
			}

			//如果分项目总金额==订单金额，则继续排单
			if (price == totalprice) {
				if(!("化学测试".equals(ptype)||"化妆品".equals(ptype)||"环境".equals(ptype))){
				sql = "update t_phy_project set estatus = '排单',istatus = 2 where vpid = ? and estatus = '立项'";
				}else{
				sql = "update t_chem_project set estatus = '排单',istatus = 2 where vpid = ? and estatus = '立项'";
				}
				System.out.println(sql);
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, pid);
				pstmt.executeUpdate();
			}

/**
				sql = "update t_quotation set fpreacount = ?,vstatus = '进行中' where vpid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setFloat(1, preacount);
				pstmt.setString(2, pid);
				pstmt.executeUpdate();
			}

			// 注意total大于totalprice时的情况，应该不可以添加信息
			if (total > totalprice) {
				if (total == totalprice) {
					sql = "update t_chem_project set estatus = '错单',istatus = 13 where vpid = ?";
					pstmt = DB.prepareStatement(conn, sql);
					pstmt.setString(1, pid);
					pstmt.executeUpdate();
				}
			}
**/
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return isok;
	}

	/**
	 * 取得项目预警
	 * @param rid
	 * @return
	 */
	private String getWarning(String sid) {
		String sql = "select * from t_chem_project_warn where vsid = ? order by dwarntime desc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String warning = null;

		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, sid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				warning = rs.getString("vwarning");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return warning;
	}

	/**
	 * 得到ChemLabTime信息
	 * @param sid
	 */
	private List<ChemLabTime> getChemLabTime(String sid) {
		String sql = "select * from t_chem_project_time where vsid = ? order by vstatus";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ChemLabTime clt = null;
		List<ChemLabTime> list = new ArrayList<ChemLabTime>();

		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, sid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				clt = new ChemLabTime();
				clt.setId(rs.getInt("id"));
				clt.setFid(rs.getString("vfid"));
				clt.setRid(rs.getString("vrid"));
				clt.setSid(rs.getString("vsid"));
				clt.setStatus(rs.getString("vstatus"));
				clt.setTime(rs.getTimestamp("dtime"));
				list.add(clt);
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
	 * 获取报价单类型（化学/安规）
	 * @param pid
	 * @return
	 */
	public String getprojectStatus(String pid) {
		String sql = "select eptype from t_project  where vpid = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String status="";

		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			while (rs.next()) {

				status=rs.getString("eptype");

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return status;
	}

	public String getprojectRid(String sid) {
		String sql = "select vrid from t_project  where vsid = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String rid="";

		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, sid);
			rs = pstmt.executeQuery();
			while (rs.next()) {

				rid=rs.getString("vrid");

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return rid;
	}



	/**
	 * 判断该rid是否存在
	 * @param rid
	 * @return
	 */
	public String isChemOrPhy(String rid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String eptype="";
		String sql = "select eptype from t_project where vrid = '" + rid + "'";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				eptype=rs.getString("eptype");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return eptype;
	}
}
