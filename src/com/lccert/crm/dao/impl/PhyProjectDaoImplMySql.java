package com.lccert.crm.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.client.ClientForm;
import com.lccert.crm.dao.PhyProjectDao;
import com.lccert.crm.kis.Item;
import com.lccert.crm.project.ChemProjectAction;
import com.lccert.crm.project.PhyProject;
import com.lccert.crm.project.PhyProjectAction;
import com.lccert.crm.project.Project;
import com.lccert.crm.project.ProjectAction;
import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.quotation.QuotationAction;
import com.lccert.crm.vo.PhyStandard;
import com.lccert.www.UpdateWebSite;

/**
 * ������Ŀdaoʵ����
 * ����mysql���ݿ�İ���daoʵ����
 * @author Eason
 *
 */
public class PhyProjectDaoImplMySql implements PhyProjectDao {

	
	/**
	 * ������Ŀ�ŵ�
	 * 
	 * @param p
	 * @return
	 */
	public boolean addPhyProject(Project p) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_project set vnotes=?,vlevel=? where vsid=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			PhyProject pp = (PhyProject)p.getObj();
			//p.setRid(makeRid(p));

			pstmt = DB.prepareStatement(conn, sql);
			
			//pstmt.setString(1, p.getTestcontent());
			pstmt.setString(1, p.getNotes());
			pstmt.setString(2, p.getLevel());
			pstmt.setString(3, p.getSid());

			pstmt.executeUpdate();

			sql = "update t_phy_project set vcontact=?,vcreatename=?,drptime=?,vsamplename=?,vsamplecount=?,vsamplemodel=?,vservname=?,erptype=?,vrid=?,vrpclient=?,vengineer=?,vteststandard=?,vratedvoltage=?,vratedcurrent=?,vratedpower=?,vother=?,vlightsourcetype=?,estatus='����',istatus=3,dcreatetime=now() where vsid=?";

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, pp.getContact());
			pstmt.setString(2, pp.getCreatename());
			pstmt.setTimestamp(3, new Timestamp(pp.getRptime().getTime()));
			pstmt.setString(4, pp.getSamplename());
			pstmt.setString(5, pp.getSamplecount());
			
			pstmt.setString(6, pp.getSamplemodel());
			
			pstmt.setString(7, pp.getServname());
			pstmt.setString(8, pp.getRptype());
			pstmt.setString(9, p.getRid());
			pstmt.setString(10, pp.getRpclient());
			pstmt.setString(11, pp.getEngineer());
			pstmt.setString(12, pp.getTestStandard());
			pstmt.setString(13, pp.getRatedvoltage());
			pstmt.setString(14, pp.getRatedcurrent());
			pstmt.setString(15, pp.getRatedpower());
			pstmt.setString(16, pp.getOther());
			pstmt.setString(17, pp.getLightsourcetype());
			pstmt.setString(18, p.getSid());
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
	 * �������а�����Ŀ�б�
	 * 
	 * @param sql
	 * @return List<Project>
	 */
	public List<Project> getAllPhyProject(String sql) {
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
				PhyProject pp = new PhyProject();
				p.setId(rs.getInt("a.id"));
				p.setSid(rs.getString("a.vsid"));
				p.setPid(rs.getString("a.vpid"));
				p.setRid(rs.getString("a.vrid"));
				p.setPtype(rs.getString("a.eptype"));
				p.setTestcontent(rs.getString("a.vtestcontent"));
				p.setBuildname(rs.getString("a.vbuildname"));
				p.setBuildtime(rs.getTimestamp("a.dbuildtime"));
				p.setPrice(rs.getFloat("a.fprice"));
				p.setPresubcost(rs.getString("a.fpresubcost"));
				p.setSubname(rs.getString("a.vsubname"));
				p.setSubcost(rs.getFloat("a.fsubcost"));
				p.setSubcosttime(rs.getTimestamp("a.dsubcosttime"));
				p.setSubcostnotes(rs.getString("a.vsubcostnotes"));
				p.setPresubcost2(rs.getString("a.fpresubcost2"));
				p.setSubname2(rs.getString("a.vsubname2"));
				p.setSubcost2(rs.getFloat("a.fsubcost2"));
				p.setSubcosttime2(rs.getTimestamp("a.dsubcosttime2"));
				p.setSubcostnotes2(rs.getString("a.vsubcostnotes2"));
				p.setInsubcost(rs.getFloat("a.finsubcost"));
				p.setInsubtag(rs.getString("a.vinsubtag"));
				p.setPreagcost(rs.getFloat("a.fpreagcost"));
				p.setAgname(rs.getString("a.vagname"));
				p.setClientpay(rs.getString("a.eclientpay"));
				p.setClientpay(rs.getString("a.eclientpay"));
				p.setAgcost(rs.getFloat("a.fagcost"));
				p.setAgtime(rs.getTimestamp("a.dagtime"));
				p.setAgnotes(rs.getString("a.vagnotes"));
				p.setAgtag(rs.getString("a.vagtag"));
				p.setOtherscost(rs.getFloat("a.fotherscost"));
				p.setOtherstag(rs.getString("a.votherstag"));
				p.setInvtype(rs.getString("a.einvtype"));
				p.setInvhead(rs.getString("a.vinvhead"));
				p.setInvcontent(rs.getString("a.vinvcontent"));
				p.setPreinvprice(rs.getFloat("a.fpreinvprice"));
				p.setInvprice(rs.getFloat("a.finvprice"));
				p.setProjectsettle(rs.getString("a.vprojectsettle"));
				p.setPpreacount(rs.getFloat("a.fppreacount"));
				p.setPacount(rs.getFloat("a.fpacount"));
				p.setLevel(rs.getString("a.vlevel"));
				p.setType(rs.getString("a.etype"));
				p.setLab(rs.getString("a.elab"));
				p.setIsout(rs.getString("a.isout"));
				p.setNotes(rs.getString("a.vnotes"));
				pp.setRptype(rs.getString("b.erptype"));
				pp.setRptime(rs.getTimestamp("b.drptime"));
				pp.setCreatename(rs.getString("b.vcreatename"));
				pp.setCreatetime(rs.getTimestamp("b.dcreatetime"));
				pp.setBeginuser(rs.getString("b.vbeginuser"));
				pp.setBegintime(rs.getTimestamp("b.dbegintime"));
				pp.setBeginuser(rs.getString("b.venduser"));
				pp.setBegintime(rs.getTimestamp("b.dendtime"));
				pp.setRpclient(rs.getString("b.vrpclient"));
				pp.setEngineer(rs.getString("b.vengineer"));
				pp.setContact(rs.getString("b.vcontact"));
				pp.setServname(rs.getString("b.vservname"));
				pp.setSamplename(rs.getString("b.vsamplename"));
				pp.setSamplecount(rs.getString("b.vsamplecount"));
				pp.setSamplecategory(rs.getString("b.vsamplecategory"));
				pp.setSamplemodel(rs.getString("b.vsamplemodel"));
				pp.setStatus(rs.getString("b.estatus"));
				pp.setRatedvoltage(rs.getString("b.vratedvoltage"));
				pp.setRatedcurrent(rs.getString("b.vratedcurrent"));
				pp.setRatedpower(rs.getString("b.vratedpower"));
				pp.setOther(rs.getString("b.vother"));
				pp.setLightsourcetype(rs.getString("b.vlightsourcetype"));
				p.setObj(pp);
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
	 * ȡ��һ��������Ŀ
	 * @param sql
	 * @return
	 */
	public Project getPhyProject(String sql) {
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
				PhyProject pp = new PhyProject();
				p.setSid(rs.getString("a.vsid"));
				p.setPid(rs.getString("a.vpid"));
				p.setRid(rs.getString("a.vrid"));
				p.setPtype(rs.getString("a.eptype"));
				p.setTestcontent(rs.getString("a.vtestcontent"));
//				p.setBuildname(rs.getString("a.vbuildname"));
				p.setBuildname(rs.getString("b.vservname"));
				p.setBuildtime(rs.getTimestamp("a.dbuildtime"));
				p.setPrice(rs.getFloat("a.fprice"));
				p.setPresubcost(rs.getString("a.fpresubcost"));
				p.setSubname(rs.getString("a.vsubname"));
				p.setSubcost(rs.getFloat("a.fsubcost"));
				p.setSubcosttime(rs.getTimestamp("a.dsubcosttime"));
				p.setSubcostnotes(rs.getString("a.vsubcostnotes"));
				p.setPresubcost2(rs.getString("a.fpresubcost2"));
				p.setSubname2(rs.getString("a.vsubname2"));
				p.setSubcost2(rs.getFloat("a.fsubcost2"));
				p.setSubcosttime2(rs.getTimestamp("a.dsubcosttime2"));
				p.setSubcostnotes2(rs.getString("a.vsubcostnotes2"));
				p.setInsubcost(rs.getFloat("a.finsubcost"));
				p.setInsubtag(rs.getString("a.vinsubtag"));
				p.setPreagcost(rs.getFloat("a.fpreagcost"));
				p.setAgname(rs.getString("a.vagname"));
				p.setClientpay(rs.getString("a.eclientpay"));
				p.setClientpay(rs.getString("a.eclientpay"));
				p.setAgcost(rs.getFloat("a.fagcost"));
				p.setAgtime(rs.getTimestamp("a.dagtime"));
				p.setAgnotes(rs.getString("a.vagnotes"));
				p.setAgtag(rs.getString("a.vagtag"));
				p.setOtherscost(rs.getFloat("a.fotherscost"));
				p.setOtherstag(rs.getString("a.votherstag"));
				p.setInvtype(rs.getString("a.einvtype"));
				p.setInvhead(rs.getString("a.vinvhead"));
				p.setInvcontent(rs.getString("a.vinvcontent"));
				p.setPreinvprice(rs.getFloat("a.fpreinvprice"));
				p.setInvprice(rs.getFloat("a.finvprice"));
				p.setProjectsettle(rs.getString("a.vprojectsettle"));
				p.setPpreacount(rs.getFloat("a.fppreacount"));
				p.setPacount(rs.getFloat("a.fpacount"));
				p.setLevel(rs.getString("a.vlevel"));
				p.setType(rs.getString("a.etype"));
				p.setLab(rs.getString("a.elab"));
				p.setIsout(rs.getString("a.isout"));
				p.setNotes(rs.getString("a.vnotes"));
				p.setAgremarks(rs.getString("a.vagremarks"));
				//**--------------2013-02-23---------
				p.setAssist(rs.getFloat("fassist"));
				pp.setRptype(rs.getString("b.erptype"));
				pp.setRptime(rs.getTimestamp("b.drptime"));
				pp.setCreatename(rs.getString("b.vcreatename"));
				pp.setCreatetime(rs.getTimestamp("b.dcreatetime"));
				pp.setBeginuser(rs.getString("b.vbeginuser"));
				pp.setBegintime(rs.getTimestamp("b.dbegintime"));
				pp.setBeginuser(rs.getString("b.venduser"));
				pp.setBegintime(rs.getTimestamp("b.dendtime"));
				pp.setRpclient(rs.getString("b.vrpclient"));
				pp.setEngineer(rs.getString("b.vengineer"));
				pp.setContact(rs.getString("b.vcontact"));
				pp.setServname(rs.getString("b.vservname"));
				pp.setSamplename(rs.getString("b.vsamplename"));
				pp.setSamplecount(rs.getString("b.vsamplecount"));
				pp.setSamplecategory(rs.getString("b.vsamplecategory"));
				pp.setSamplemodel(rs.getString("b.vsamplemodel"));
				pp.setStatus(rs.getString("b.estatus"));
				pp.setIsfinish(rs.getString("b.isfinish"));
				pp.setList(new ChemProjectDaoImplMySql().getChemLabTime(p.getSid()));
				pp.setTestStandard(rs.getString("b.vteststandard"));
				pp.setRatedvoltage(rs.getString("b.vratedvoltage"));
				pp.setRatedcurrent(rs.getString("b.vratedcurrent"));
				pp.setRatedpower(rs.getString("b.vratedpower"));
				pp.setOther(rs.getString("b.vother"));
				pp.setLightsourcetype(rs.getString("b.vlightsourcetype"));
				
				p.setObj(pp);
				
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
	 * �������а�����Ŀ(��ҳģʽ)
	 * @param pageNo
	 * @param pageSize
	 * @param pid
	 * @return
	 */
	public PageModel getAllPhyProjects(int pageNo, int pageSize, String sql,String countSql) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List<Project> list = new ArrayList<Project>();
		Project p = null;
		//String str = sql + "  limit " + (pageNo - 1) * pageSize + ", " + pageSize;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				p = new Project();
				PhyProject pp = new PhyProject();
				p.setSid(rs.getString("a.vsid"));
				p.setPid(rs.getString("a.vpid"));
				p.setRid(rs.getString("a.vrid"));
				p.setPtype(rs.getString("a.eptype"));
				p.setTestcontent(rs.getString("a.vtestcontent"));
				p.setBuildname(rs.getString("a.vbuildname"));
				p.setBuildtime(rs.getTimestamp("a.dbuildtime"));
				p.setPrice(rs.getFloat("a.fprice"));
				p.setPresubcost(rs.getString("a.fpresubcost"));
				p.setSubname(rs.getString("a.vsubname"));
				p.setSubcost(rs.getFloat("a.fsubcost"));
				p.setSubcosttime(rs.getTimestamp("a.dsubcosttime"));
				p.setSubcostnotes(rs.getString("a.vsubcostnotes"));
				p.setPresubcost2(rs.getString("a.fpresubcost2"));
				p.setSubname2(rs.getString("a.vsubname2"));
				p.setSubcost2(rs.getFloat("a.fsubcost2"));
				p.setSubcosttime2(rs.getTimestamp("a.dsubcosttime2"));
				p.setSubcostnotes2(rs.getString("a.vsubcostnotes2"));
				p.setInsubcost(rs.getFloat("a.finsubcost"));
				p.setInsubtag(rs.getString("a.vinsubtag"));
				p.setPreagcost(rs.getFloat("a.fpreagcost"));
				p.setAgname(rs.getString("a.vagname"));
				p.setClientpay(rs.getString("a.eclientpay"));
				p.setClientpay(rs.getString("a.eclientpay"));
				p.setAgcost(rs.getFloat("a.fagcost"));
				p.setAgtime(rs.getTimestamp("a.dagtime"));
				p.setAgnotes(rs.getString("a.vagnotes"));
				p.setAgtag(rs.getString("a.vagtag"));
				p.setOtherscost(rs.getFloat("a.fotherscost"));
				p.setOtherstag(rs.getString("a.votherstag"));
				p.setInvtype(rs.getString("a.einvtype"));
				p.setInvhead(rs.getString("a.vinvhead"));
				p.setInvcontent(rs.getString("a.vinvcontent"));
				p.setPreinvprice(rs.getFloat("a.fpreinvprice"));
				p.setInvprice(rs.getFloat("a.finvprice"));
				p.setProjectsettle(rs.getString("a.vprojectsettle"));
				p.setPpreacount(rs.getFloat("a.fppreacount"));
				p.setPacount(rs.getFloat("a.fpacount"));
				p.setLevel(rs.getString("a.vlevel"));
				p.setType(rs.getString("a.etype"));
				p.setLab(rs.getString("a.elab"));
				p.setIsout(rs.getString("a.isout"));
				p.setNotes(rs.getString("a.vnotes"));

				pp.setRptype(rs.getString("b.erptype"));
				pp.setRptime(rs.getTimestamp("b.drptime"));
				pp.setCreatename(rs.getString("b.vcreatename"));
				pp.setCreatetime(rs.getTimestamp("b.dcreatetime"));
				pp.setBeginuser(rs.getString("b.vbeginuser"));
				pp.setBegintime(rs.getTimestamp("b.dbegintime"));
				pp.setEnduser(rs.getString("b.venduser"));
				pp.setEndtime(rs.getTimestamp("b.dendtime"));
				pp.setRpclient(rs.getString("b.vrpclient"));
				pp.setEngineer(rs.getString("b.vengineer"));
				pp.setContact(rs.getString("b.vcontact"));
				pp.setServname(rs.getString("b.vservname"));
				pp.setSamplename(rs.getString("b.vsamplename"));
				pp.setSamplecount(rs.getString("b.vsamplecount"));
				pp.setSamplecategory(rs.getString("b.vsamplecategory"));
				pp.setSamplemodel(rs.getString("b.vsamplemodel"));
				pp.setStatus(rs.getString("b.estatus"));
				p.setObj(pp);

				list.add(p);
			}
			int totalRecords = getTotalRecords(conn,countSql);
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
	 * ȡ��������Ŀ
	 * @param sid
	 * @return
	 */
	public boolean cancelPhyProject(Project p) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_phy_project set estatus = 'ȡ��',istatus=12,isfinish = 'y' where vsid=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, p.getSid());

			pstmt.executeUpdate();
			
			sql = "insert into t_phy_project_time(vsid,vrid,vstatus,dtime) values(?,?,'����ȡ��ʱ��',now())";
			
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, p.getSid());
			pstmt.setString(2, p.getRid());
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
	 * �޸İ�����Ŀ
	 * @param p
	 * @return
	 */
	public boolean modifyPhyProject(Project p) {
		String sql = "select * from t_project a,t_phy_project b where a.vsid = b.vsid and a.vsid = '" + p.getSid() + "'";
		Project temp = getPhyProject(sql);
		p.setType(temp.getType());
		p.setLab(temp.getLab());
		p.setIsout(temp.getIsout());
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		sql = "update t_project set vnotes=?,vlevel=?,vrid=?,etype=?,elab=?,isout=? where vsid=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			PhyProject pp = (PhyProject)p.getObj();

			pstmt = DB.prepareStatement(conn, sql);
			//pstmt.setString(1, p.getTestcontent());
			pstmt.setString(1, p.getNotes());
			pstmt.setString(2, p.getLevel());
			pstmt.setString(3, p.getRid());
			pstmt.setString(4, p.getType());
			pstmt.setString(5, p.getLab());
			pstmt.setString(6, p.getIsout());
			pstmt.setString(7, p.getSid());

			pstmt.executeUpdate();
			sql = "update t_phy_project set vcontact=?,drptime=?,vsamplename=?,vsamplecount=?,vsamplecategory=?,vsamplemodel=?,vengineer=?,vservname=?,erptype=?,vrid=?,vrpclient=?,vteststandard=?,vratedvoltage=?,vratedcurrent=?,vratedpower=?,vother=?,vlightsourcetype=?,estatus='����',istatus=3,dcreatetime=now() where vsid=?";

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, pp.getContact());
			pstmt.setTimestamp(2, new Timestamp(pp.getRptime().getTime()));
			pstmt.setString(3, pp.getSamplename());
			pstmt.setString(4, pp.getSamplecount());
			pstmt.setString(5, pp.getSamplecategory());
			pstmt.setString(6, pp.getSamplemodel());
			pstmt.setString(7, pp.getEngineer());
			pstmt.setString(8, pp.getServname());
			pstmt.setString(9, pp.getRptype());
			pstmt.setString(10, p.getRid());
			pstmt.setString(11, pp.getRpclient());
			pstmt.setString(12, pp.getTestStandard());
			pstmt.setString(13, pp.getRatedvoltage());
			pstmt.setString(14, pp.getRatedcurrent());
			pstmt.setString(15, pp.getRatedpower());
			pstmt.setString(16, pp.getOther());
			pstmt.setString(17, pp.getLightsourcetype());
			pstmt.setString(18, p.getSid());

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
	 * ȡ��������
	 * @param conn
	 * @param sql
	 * @return
	 */
	public  int getTotalRecords(Connection conn1 , String sql) {
		/*if(sql.indexOf("limit")>-1){
			sql=sql.substring(0,sql.indexOf("limit"));
		}*/
		Connection conn = DB.getConn();
		int totalRecords = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if(sql.indexOf("count")>-1){
				if (rs.next()) {
					totalRecords = rs.getInt(1);
				}
			}else{
				rs.last();
				totalRecords = rs.getRow();
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
		}
		return totalRecords;
	}

	/**
	 * ������Ŀ״̬
	 * @param sid
	 * @param status
	 * @return
	 */
	public boolean updateStatus(Project p) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String str = "";
		String status = "";
		PhyProject pp = (PhyProject)p.getObj();
		if(pp.getIstatus()==4) {
			str = ",dbegintime=now(),vbeginuser='" + pp.getBeginuser() + "'";
			status = "����";
		} else {
			str = ",dendtime=now(),venduser='" + pp.getEnduser() + "'";
			status = "�������";
		}
		String sql = "update t_phy_project set estatus =?,istatus=?" + str + " where vsid=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, status);
			pstmt.setInt(2, pp.getIstatus());
			pstmt.setString(3, p.getSid());

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
	 * �����ҵر��۵�����ҳģʽ��
	 * @param pageNo
	 * @param pageSize
	 * @param sales
	 * @param pid
	 * @param client
	 * @param parttype
	 * @return
	 */
	public PageModel searchMyPhyProject(int pageNo,int pageSize,String sql) {
		String str = sql + "  limit " + (pageNo - 1) * pageSize + ", " + pageSize;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rsre = null;
		PageModel pm = new PageModel();
		List list = new ArrayList ();
		Project p =null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, str);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				p =new Project();
				PhyProject pp=new PhyProject();
				pp.setCreatetime(rs.getTimestamp("�ŵ�ʱ��"));
				pp.setRptime(rs.getTimestamp("����Ӧ��ʱ��"));
				pp.setServname(rs.getString("�ͷ���Ա"));
				pp.setStatus(rs.getString("��Ŀ״̬"));
				pp.setIsfinish(rs.getString("�Ƿ����"));
				pp.setEngineer(rs.getString("��Ŀ������"));
				pp.setSamplemodel(rs.getString("��Ʒ�ͺ�"));
				pp.setSamplename(rs.getString("��Ʒ����"));
				p.setLevel(rs.getString("��Ŀ�ȼ�"));
				p.setTestcontent(rs.getString("��Ŀ����"));
				p.setRid(rs.getString("������"));
				p.setPid(rs.getString("���۵���"));
				p.setSales(rs.getString("������Ա"));
				p.setObj(pp);
				list.add(p);
			}
			int totalRecords = getTotalRecords(conn, sql);
			pm = new PageModel();
			pm.setPageNo(pageNo);
			pm.setPageSize(pageSize);
			pm.setList(list);
			pm.setTotalRecords(totalRecords);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rsre);
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return pm;
	}

	public float[] getPhyProjectInfor(String sql,List list) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Quotation q =null;
		float[] f = new float[2];
		float totalperformence = 0;
		float total = 0;
		float total1 = 0;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			Set  temp =new HashSet();
			while (rs.next()) {
			q=new Quotation();
			Item i =new Item();
			i.setId(rs.getInt("id"));
			i.setName(rs.getString("name"));
			i.setItemNumber(rs.getString("item_number"));
			q.setTotalprice(rs.getFloat("��Ŀ�۸�"));
			q.setPid(rs.getString("vpid"));
			q.setQuotype(rs.getString("type"));
			q.setObj(i);
			if(q.getQuotype().equals("flu")){
				total+=q.getTotalprice();
			}else{
				total1+=q.getTotalprice();
			}
			
			list.add(q);
			temp.add(q.getPid());
			}
			Iterator  iterator=temp.iterator();//ȡ��Ԫ��
			while(iterator.hasNext()){
				List pList=ProjectAction.getInstance().getAllProjectByPid(iterator.next().toString());
				for(int j=0;j<pList.size();j++){
				    Project p =(Project)pList.get(j);
				    totalperformence+=p.getAgcost();
				}
			}
			f[0]=totalperformence;
			f[1]=total1-total;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return f;
	
	}

	
	
	//������Ŀ���ƺ����+�·ݣ���ȡ������Ŀ��״̬
	public List getPhyStatus(String sql) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList();
		Set  temp =new HashSet();
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				//��һ��set������װ�������ظ�ֵ�Ĵ���
				temp.add(rs.getString("vpid"));
			}
			Iterator  iterator=temp.iterator();//ȡ��Ԫ��
			while(iterator.hasNext()){
				//�ü�������ı��۵���ѯһ�����۵������Ӧ�ö��ٸ������
				List temp1=PhyProjectAction.getInstance().getPhyProjectStatus(iterator.next().toString());
				list.add(temp1);
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
	
	
	/**getPhyStatus
	 * ���ݱ��۵���ѯ�������Ŀ����
	 */
	public List getPhyProjectStatus(String sql) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Project p =null;
		List list =new ArrayList();
		try {
			
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			Set  temp =new HashSet();
			while (rs.next()) {
				p=new Project();
				PhyProject phy=new PhyProject();
				phy.setStatus(rs.getString("Estatus"));
				p.setPid(rs.getString("vpid"));
				p.setRid(rs.getString("vrid"));
				p.setPtype(rs.getString("eptype"));
				p.setTestcontent(rs.getString("vtestcontent"));
				p.setBuildname(rs.getString("vbuildname"));
				p.setSid(rs.getString("vsid"));
				p.setObj(phy);
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

	public Map<String,String> getPhyStatusType(String sql) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Project p =null;
		Map map =new HashMap<Integer, String>();
		try {
			
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			Set  temp =new HashSet();
			while (rs.next()) {
				map.put(rs.getInt("id")+"", rs.getString("vname"));
			}
		}
			catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DB.close(rs);
				DB.close(pstmt);
				DB.close(conn);
			}
			return map;

	}

	public boolean upPhyStart(String type, String rid, String vsid, String fid,int status) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int id = 0;
		String sid = "";
		String pid = "";
		boolean auto = false;
		boolean isok = false;
		Date date = new Date();
		String sql = "";
		//if ("�᰸".equals(type)) {
			//sql = "update t_phy_project set dendtime= now(),eprojectend='y' where vsid = ?";
		//} else if ("��֤".equals(type)) {
			//sql = "update t_phy_project  set dendtime= now() where vsid = ?";
		//} else {
			sql = "insert into t_chem_project_time(vfid,vrid,vsid,vstatus,dtime) values('"
				+ fid + "','" + rid + "',?,'" + type + "',now())";
		//}
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, vsid);
			pstmt.executeUpdate();
			if(type !=null && !"�᰸".equals(type) && !"��֤".equals(type)){
				sql = "update t_phy_project  set estatus = '"+type+"',istatus = 4 where vrid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, rid);
				pstmt.executeUpdate();
			}

			sql = "select * from t_project where vrid = ? order by dbuildtime desc";
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, rid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				id = rs.getInt("id");
				sid = rs.getString("vsid");
				pid = rs.getString("vpid");
			}
			
			
			if (status != 0 && !"�᰸".equals(type)) {
				sql = "update t_chem_flow set status = ? where vfid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setInt(1, status);
				pstmt.setString(2, fid);
				pstmt.executeUpdate();
			}
			if ("�᰸".equals(type)) {
				sql = "update t_phy_project  set estatus = '�᰸',istatus = 9,isfinish = 'y',dendtime=now() where vsid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, vsid);
				pstmt.executeUpdate();


				ChemProjectAction.getInstance().sendProjectStatus(sid);
				//������վ����
				UpdateWebSite up = new UpdateWebSite();
				up.setId(id);
				up.setType("project");
				Thread t = new Thread(up);
				t.start();
				UpdateWebSite w = new UpdateWebSite();
				w.setId(id);
				w.setType("detail");//������Ŀ���ȱ�
				Thread th = new Thread(w);
				th.start();
			}
			if ("�᰸".equals(type) || "dsendtime".equals(type)) {
				sql = "update t_chem_flow set status = 4 where vsid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, sid);
				pstmt.executeUpdate();
				sql = "update t_project set eprojectend = 'y' where vsid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, sid);
				pstmt.executeUpdate();
			}

			if ("��֤".equals(type)) {
				sql = "update t_phy_project  set estatus = '��֤',istatus = 10,isfinish = 'y' where vrid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, rid);
				pstmt.executeUpdate();
				sql = "update t_quotation set eisfinish='y',vstatus = '��Ŀ���' where vpid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, pid);
				pstmt.executeUpdate();
				Quotation qt = QuotationAction.getInstance().getQuotationByPid(pid);
				//������վ����
				UpdateWebSite qtup = new UpdateWebSite();
				qtup.setId(qt.getId());
				qtup.setType("quotation");
				Thread t = new Thread(qtup);
				t.start();
				
				UpdateWebSite up = new UpdateWebSite();
				up.setId(id);
				up.setType("project");
				Thread t1 = new Thread(up);
				t1.start();
				UpdateWebSite w = new UpdateWebSite();
				w.setId(id);
				w.setType("detail");//������Ŀ���ȱ�
				Thread t2 = new Thread(w);
				t2.start();
			}
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
				DB.close(rs);
				DB.close(pstmt);
				DB.close(conn);
		}
		return isok;
		
	}
	
	
	/**
	 * ��̬��ajax��ʽ��ȡ�ò��Ա�׼�б�
	 * @param key
	 * @return
	 */
	public List<PhyStandard> getStandardByAjax(String key) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List<PhyStandard> list = new ArrayList<PhyStandard>();
		String sql = "select * from t_phy_standard  where code like '%" + key + "%' order by lastupdate ";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				PhyStandard ps = new PhyStandard();
				ps.setId(rs.getInt("id"));
				ps.setCode(rs.getString("code"));
				list.add(ps);
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
	
	
	public PhyProject findByConditions(String sql) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PhyProject pp=new PhyProject();
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				pp.setRptype(rs.getString("erptype"));
				pp.setRptime(rs.getTimestamp("drptime"));
				pp.setCreatename(rs.getString("vcreatename"));
				pp.setCreatetime(rs.getTimestamp("dcreatetime"));
				pp.setBeginuser(rs.getString("vbeginuser"));
				pp.setBegintime(rs.getTimestamp("dbegintime"));
				pp.setEnduser(rs.getString("venduser"));
				pp.setEndtime(rs.getTimestamp("dendtime"));
				pp.setRpclient(rs.getString("vrpclient"));
				pp.setEngineer(rs.getString("vengineer"));
				pp.setContact(rs.getString("vcontact"));
				pp.setServname(rs.getString("vservname"));
				pp.setSamplename(rs.getString("vsamplename"));
				pp.setSamplecount(rs.getString("vsamplecount"));
				pp.setSamplecategory(rs.getString("vsamplecategory"));
				pp.setSamplemodel(rs.getString("vsamplemodel"));
				pp.setStatus(rs.getString("estatus"));
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
		return pp;
	}
	
}
