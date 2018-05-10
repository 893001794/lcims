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
 * ������Ŀdaoʵ����
 * ����mysql���ݿ������daoʵ����
 * @author Eason
 *
 */
public class ProjectDaoImplMySql implements ProjectDao {

	/**
	 * �������Ŀ
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
		
		if(!("��ѧ����".equals(p.getPtype())||p.getPtype().indexOf("��ױƷ")>-1||p.getPtype().indexOf("����")>-1)) {
			p.setRid(makeRid(p));//�ǻ�ѧ��Ŀ(������Ŀ)���ɱ�����
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
			
//			//������վ����
//			int key = 0;
//			rs = pstmt.getGeneratedKeys();
//			if(rs.next()) {
//				key = rs.getInt(1);
//			}
			
			//---------------------------2010-12-14---------------------------------------
			
			if(!("��ѧ����".equals(p.getPtype())||p.getPtype().indexOf("��ױƷ")>-1||p.getPtype().indexOf("����")>-1))  {
				sql = "insert into t_phy_project (vsid,vpid,vrid,estatus,istatus) values(?,?,?,'����',1);";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, p.getSid());
				pstmt.setString(2, p.getPid());
				pstmt.setString(3, p.getRid());
				pstmt.executeUpdate();
			} else {
			//---------------------------2010-12-14---------------------------------------
				sql = "insert into t_chem_project (vsid,vpid,estatus,istatus) values(?,?,'����',1)";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, p.getSid());
				pstmt.setString(2, p.getPid());
				pstmt.executeUpdate();
			}

			

			conn.commit();

			updateStatus(p.getPid(),p.getPtype());
			
//			//������վ����
//			UpdateWebSite up = new UpdateWebSite();
//			up.setId(key);
//			up.setType("project");
//			Thread t = new Thread(up);
//			t.start();
//			
//			UpdateWebSite w = new UpdateWebSite();
//			w.setId(key);
//			w.setType("detail");//������Ŀ���ȱ�
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
	 * ����������Ŀ
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
//			//������վ����
//			int key = 0;
//			rs = pstmt.getGeneratedKeys();
//			if(rs.next()) {
//				key = rs.getInt(1);
//			}

			
			//---------------------------2010-12-14---------------------------------------
			if(!("��ѧ����".equals(p.getPtype())||"��ױƷ".equals(p.getPtype()))) {
				sql = "insert into t_phy_project (vsid,vpid,vrid,estatus,istatus) values(?,?,?,'����',1);";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, p.getSid());
				pstmt.setString(2, p.getPid());
				pstmt.setString(3, p.getRid());
				//System.out.println(p.getRid()+"---------------------------");
				pstmt.executeUpdate();
			} else {
			//---------------------------2010-12-14---------------------------------------
				sql = "insert into t_chem_project (vsid,vpid,estatus,istatus) values(?,?,'����',1)";
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
			
//			//������վ����
//			UpdateWebSite up = new UpdateWebSite();
//			up.setId(key);
//			up.setType("project");
//			Thread t = new Thread(up);
//			t.start();
//			
//			UpdateWebSite w = new UpdateWebSite();
//			w.setId(key);
//			w.setType("detail");//������Ŀ���ȱ�
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
	 * �޸��ڲ����˵�
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
		if(!("��ѧ����".equals(p.getPtype())||p.getPtype().indexOf("��ױƷ")>-1||p.getPtype().indexOf("����")>-1))  {
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
	 * ɾ����Ŀ
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
	 * ������Ŀ
	 * @param sql SQL���
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
				
				if(!("��ѧ����".equals(p.getPtype())||p.getPtype().indexOf("��ױƷ")>-1||p.getPtype().indexOf("����")>-1))  {
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
	 * ������Ŀ
	 * @param sql SQL���
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
	 * ����������Ŀ
	 * 
	 * @param sql  sql���
	 * @return List<Project> ��Ŀ�б�
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
				if(!("��ѧ����".equals(p.getPtype())||"��ױƷ".equals(p.getPtype())||"����".equals(p.getPtype()))) {
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
	 * ����������Ŀ(��ҳģʽ)
	 * @param pageNo
	 * @param pageSize
	 * @param sql
	 * @return PageModel ��ҳģ��
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
				
//				if(!"��ѧ����".equals(p.getPtype())) {
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
	 * ���ݾɵı��۵����ҵ��µı��۵���Ϣ
	 * 
	 */
	
	public List getQuotation(String pid) {
		String sql ="select  * from t_quotation where vpid like '%"+pid+"'";
		Connection conn = null;
		PreparedStatement pstmt = null;
		SalesOrderItem soi=null;
		ResultSet rs = null;
//		//���һ���Ͷ���
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
	 * ȡ�ð�����Ŀ
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
	 * ȡ�û�ѧ��Ŀ
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
	 * ȡ��������
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
	 * �����ڲ����˵���
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
	 * �Զ����ɱ�����
	 * 
	 * @return rid ������
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
		if ("��ɽ".equals(company)) {
			str.append("Z");
		} else if ("����".equals(company)) {
			str.append("G");
		} else if ("��ݸ".equals(company)) {
			str.append("D");
		}
		if ("��ѧ����".equals(ptype)) {
			if ("��ݸʵ����".equals(lab)) {
				//str.append("D");
				pstr = "D";
			} else {
				//str.append("C");
				pstr = "C";
			}

		} else if ("���ӵ�����ȫ����".equals(ptype)) {
			//str.append("S");
			pstr = "S";
		} else if ("EMC����".equals(ptype)) {
			//str.append("E");
			pstr = "E";
		} else if ("�����ܲ���".equals(ptype)) {
			//str.append("P");
			pstr = "P";
		} else if ("��Ч����".equals(ptype)) {
			//str.append("P");
			pstr = "N";
		}else if ("��ױƷ".equals(ptype)){
			pstr = "H";
		}else if ("����".equals(ptype)){
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
		
		if("��ѧ����".equals(ptype)) {
			if ("��������".equals(type)) {
				sql = "Select vrid from t_project where etype = '"
						+ type + "' and vrid like '%" + keyword
						+ "%' order by substring(vrid,9,12) desc";
			} else if ("y".equals(isout)) {
				sql = "Select vrid from t_project where isout = 'y' and vrid  like '%"
					+ keyword + "%' order by substring(vrid,9,12) desc";
			} else if ("�Բ�".equals(type)) {
				if ("��ɽʵ����".equals(lab)) {
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
				if("��ѧ����".equals(ptype)) {
					if ("��������".equals(type)) {
						last = "8000";
					} else if ("y".equals(isout)) {
						last = "9000";
					} else if ("�Բ�".equals(type)) {
						if ("��ɽʵ����".equals(lab)) {
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
	 * �޸ı�����
	 * 
	 * @return rid ������
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
		if ("��ɽ".equals(company)) {
			str.append("Z");
		} else if ("����".equals(company)) {
			str.append("G");
		} else if ("��ݸ".equals(company)) {
			str.append("D");
		}
		if ("��ѧ����".equals(ptype)) {
			if ("��ݸʵ����".equals(lab)) {
				//str.append("D");
				pstr = "D";
			} else {
				//str.append("C");
				pstr = "C";
			}

		} else if ("���ӵ�����ȫ����".equals(ptype)) {
			//str.append("S");
			pstr = "S";
		} else if ("EMC����".equals(ptype)) {
			//str.append("E");
			pstr = "E";
		} else if ("�����ܲ���".equals(ptype)) {
			//str.append("P");
			pstr = "P";
		} else if ("��Ч����".equals(ptype)) {
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
		
		if("��ѧ����".equals(ptype)) {
			if ("��������".equals(type)) {
				sql = "Select vrid from t_project where etype = '"
						+ type + "' and vrid like '%" + keyword
						+ "%' order by substring(vrid,9,12)";
			} else if ("y".equals(isout)) {
				sql = "Select vrid from t_project where isout = 'y' and vrid  like '%"
					+ keyword + "%' order by substring(vrid,9,12)";
			} else if ("�Բ�".equals(type)) {
				if ("��ɽʵ����".equals(lab)) {
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
				if("��ѧ����".equals(ptype)) {
					if ("��������".equals(type)) {
						rid = str.append("8000").toString();
					} else if ("y".equals(isout)) {
						rid = str.append("9000").toString();
					} else if ("�Բ�".equals(type)) {
						if ("��ɽʵ����".equals(lab)) {
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
	 * �жϸ�rid�Ƿ����
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
	 * �ֽ���Ŀ��ͬʱ�����������
	 * @param pid
	 * @return
	 */
	private synchronized boolean updateStatus(String pid,String ptype) {
		//����ĿƱ���ܽ��
		float invtotal = 0;
		//����Ŀ��������ܼ�
		float preacount = 0;
		//����Ŀ����
		int projectcount = 0;
		//���зְ���Ԥ��
		float presubcost = 0;
		//����ʵ�ʷְ���
		float subcost = 0;
		//�����ڲ��ְ���
		float insubcost = 0;
		//���к���������Ԥ��
		float preagcost = 0;
		//����ʵ�ʺϼƻ�������
		float agcost = 0;
		//����Ŀ�ܽ��
		float price = 0;
		//���۵����
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
			
			
			//���¶�������Ŀ���������������Ԥ���ⲿ�ְ��ѡ�ʵ���ⲿ�ְ��ѡ��ڲ��ְ��ѡ�Ԥ�������������á������������á���������
			sql = "update t_quotation set iprojectcount=?,fpreacount=?,fpresubcost=?,fsubcost=?,finsubcost=?,fpreagcost=?,fagcost=?,vstatus = '������' where vpid = ?";
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
			
			//���ΪƱ��֧����ʽΪ'����Ŀ'����������Ŀ�ܽ��
			if("����Ŀ".equals(invmethod)) {
				sql = "update t_quotation set finvcount = ? where vpid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setFloat(1, invtotal);
				pstmt.setString(2, pid);
				pstmt.executeUpdate();
			}
			
			//�������Ŀ�ܽ��==������������ŵ�
			if (price == totalprice) {
				if(!("��ѧ����".equals(ptype)||"��ױƷ".equals(ptype)||"����".equals(ptype))){
				sql = "update t_phy_project set estatus = '�ŵ�',istatus = 2 where vpid = ? and estatus = '����'";
				}else{
				sql = "update t_chem_project set estatus = '�ŵ�',istatus = 2 where vpid = ? and estatus = '����'";
				}
				System.out.println(sql);
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, pid);
				pstmt.executeUpdate();
			}
				
/**	
				sql = "update t_quotation set fpreacount = ?,vstatus = '������' where vpid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setFloat(1, preacount);
				pstmt.setString(2, pid);
				pstmt.executeUpdate();
			}

			// ע��total����totalpriceʱ�������Ӧ�ò����������Ϣ
			if (total > totalprice) {
				if (total == totalprice) {
					sql = "update t_chem_project set estatus = '��',istatus = 13 where vpid = ?";
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
	 * ȡ����ĿԤ��
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
	 * �õ�ChemLabTime��Ϣ
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
	 * ��ȡ���۵����ͣ���ѧ/���棩 
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
	 * �жϸ�rid�Ƿ����
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
