package com.lccert.crm.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.dao.ChemProjectDao;
import com.lccert.crm.dao.DaoFactory;
import com.lccert.crm.flow.FlowAction;
import com.lccert.crm.project.ChemLabTime;
import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.PhyProject;
import com.lccert.crm.project.PhyProjectAction;
import com.lccert.crm.project.Project;
import com.lccert.crm.project.ProjectTimeAction;
import com.lccert.crm.project.Warnning;
import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.quotation.QuotationAction;
import com.lccert.crm.report.ReportImg;
import com.lccert.crm.vo.Synthesis;
import com.lccert.www.UpdateWebSite;

/**
 * 化学项目dao实现类
 * 基于mysql数据库的化学dao实现类
 * @author Eason
 *
 */
public class ChemProjectDaoImplMySql implements ChemProjectDao {

	/**
	 * 化学项目排单
	 * 
	 * @param p
	 * @return
	 */
	public boolean addChemProject(Project p) {
		ChemProject chemProject=(ChemProject)p.getObj();
		String ptype=chemProject.getItem();
		String filingNo="";
		//生成报告编码
		changeProjectByQuotype(p);
		if(ptype !=null &&!"".equals(ptype)){
			if(ptype.indexOf("化妆品")>-1){
				//生产化妆品编号
				filingNo=makeFilingNo(p);
			}
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_project set vtestcontent=?,vnotes=?,vlevel=?,vrid=?,etype=?,elab=?,isout=?,filingno=? where vsid=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			ChemProject cp = (ChemProject)p.getObj();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, p.getTestcontent());
			pstmt.setString(2, p.getNotes());
			pstmt.setString(3, p.getLevel());
			pstmt.setString(4, p.getRid());
			pstmt.setString(5, p.getType());
			pstmt.setString(6, p.getLab());
			pstmt.setString(7, p.getIsout());
			pstmt.setString(8, filingNo);
			pstmt.setString(9, p.getSid());
			pstmt.executeUpdate();
			sql = "update t_chem_project set vcontact=?,vcreatename=?,drptime=?,vsamplename=?,vsamplecount=?,vservname=?,erptype=?,vrid=?,eitem=?,rpclient=?,rpclientE=?,estatus='流转单',istatus=3,edraft=?,filingno=?,comappid=?,dcreatetime=now() where vsid=?";
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, cp.getContact());
			pstmt.setString(2, cp.getCreatename());
			pstmt.setTimestamp(3, cp.getRptime()==null?null:new Timestamp(cp.getRptime().getTime()));
			pstmt.setString(4, cp.getSamplename());
			pstmt.setString(5, cp.getSamplecount());
			pstmt.setString(6, cp.getServname());
			pstmt.setString(7, cp.getRptype());
			pstmt.setString(8, p.getRid());
			pstmt.setString(9, cp.getItem());
			pstmt.setString(10, cp.getRpclient());
			pstmt.setString(11, cp.getClientE());
			pstmt.setString(12, cp.getDraft());
			pstmt.setString(13, filingNo);
			pstmt.setInt(14, cp.getComappid());
			pstmt.setString(15, p.getSid());
			pstmt.executeUpdate();
			conn.commit();
			isok = true;
			int key = p.getId();
			//更新网站数据
			UpdateWebSite up = new UpdateWebSite();
			up.setId(key);
			up.setType("project");
			Thread t = new Thread(up);
			t.start();
			UpdateWebSite w = new UpdateWebSite();
			w.setId(key);
			w.setType("detail");//更新项目进度表
			Thread th = new Thread(w);
			th.start();
		} catch (Exception e) {
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
	 * 修改化学项目
	 * @param p
	 * @return
	 */
	public boolean modifyChemProject(Project p) {
		String sql = "select * from t_project a,t_chem_project b where a.vsid = b.vsid and a.vrid = '" + p.getRid() + "'";
		Project temp = getChemProject(sql);
		if(p.getType() == null || p.getLab() == null || p.getIsout() == null) {
			p.setType(temp.getType());
			p.setLab(temp.getLab());
			p.setIsout(temp.getIsout());
		} else {
			if(!temp.getType().equals(p.getType()) || !temp.getLab().equals(p.getLab()) || !temp.getIsout().equals(p.getIsout())) {
				
				p.setRid(modRid(p));
			}
		}
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		
		sql = "update t_project set vtestcontent=?,vnotes=?,vlevel=?,vrid=?,etype=?,elab=?,isout=?,vrid=? where vsid=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			ChemProject cp = (ChemProject)p.getObj();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, p.getTestcontent());
			pstmt.setString(2, p.getNotes());
			pstmt.setString(3, p.getLevel());
			pstmt.setString(4, p.getRid());
			pstmt.setString(5, p.getType());
			pstmt.setString(6, p.getLab());
			pstmt.setString(7, p.getIsout());
			pstmt.setString(8, p.getRid());
			pstmt.setString(9, p.getSid());

			pstmt.executeUpdate();

			sql = "update t_chem_project set vcontact=?,drptime=?,vsamplename=?,vsamplecount=?,vservname=?,erptype=?,vrid=?,eitem=?,rpclient=?,estatus='流转单',istatus=3,edraft=?,comappid=?,dcreatetime=now() where vsid=?";

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, cp.getContact());
			pstmt.setTimestamp(2, cp.getRptime()==null?null:new Timestamp(cp.getRptime().getTime()));
			pstmt.setString(3, cp.getSamplename());
			pstmt.setString(4, cp.getSamplecount());
			pstmt.setString(5, cp.getServname());
			pstmt.setString(6, cp.getRptype());
			pstmt.setString(7, p.getRid());
			pstmt.setString(8, cp.getItem());
			pstmt.setString(9, cp.getRpclient());
			pstmt.setString(10, cp.getDraft());
			pstmt.setInt(11, cp.getComappid());
			pstmt.setString(12, p.getSid());

			pstmt.executeUpdate();

			conn.commit();
			isok = true;
			
			int key = p.getId();
			//更新网站数据
			UpdateWebSite up = new UpdateWebSite();
			up.setId(key);
			up.setType("project");
			Thread t = new Thread(up);
			t.start();
			
			UpdateWebSite w = new UpdateWebSite();
			w.setId(key);
			w.setType("detail");//更新项目进度表
			Thread th = new Thread(w);
			th.start();
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
	 * 取得化学项目
	 * @param sql
	 * @return
	 */
	public Project getChemProject(String sql) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Project p = null;
		PhyProject pp=null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				p = new Project();
				pp=new PhyProject();
				ChemProject cp = new ChemProject();
				p.setId(rs.getInt("a.id"));
				p.setSid(rs.getString("a.vsid"));
				p.setPid(rs.getString("a.vpid"));
				//查询报价单类型
				String quotytp=QuotationAction.getInstance().getQuotypeByPid(rs.getString("a.vpid"));
				if(quotytp !=null&&!"".equals(quotytp)&&"add".equals(quotytp)){
					p.setQuotytp("转译单");
				}
				p.setRid(rs.getString("a.vrid"));
				p.setPtype(rs.getString("a.eptype"));
				p.setTestcontent(rs.getString("a.vtestcontent"));
				//安规的排单人员
				pp.setPid(p.getPid());
		    	PhyProject phyProject= PhyProjectAction.getInstance().findByConditions(pp);
		    	if(phyProject !=null){
		    		p.setBuildname(PhyProjectAction.getInstance().findByConditions(pp).getServname());
		    	}
//				p.setBuildname(rs.getString("a.vbuildname"));
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
//				System.out.println(p.getAgremarks()+"--------------");
				p.setOstime(rs.getTimestamp("Dostime"));
				p.setOetime(rs.getTimestamp("Doetime"));
				//***-----------2013-2-23----------
				p.setAssist(rs.getFloat("fassist"));
				cp.setContact(rs.getString("b.vcontact"));
				cp.setEngineer(rs.getString("b.vengineer"));
				cp.setProjectend(rs.getString("b.eprojectend"));
				cp.setRptype(rs.getString("b.erptype"));
				cp.setRptime(rs.getTimestamp("b.drptime"));
				cp.setRpclient(rs.getString("b.rpclient"));
				cp.setCreatename(rs.getString("b.vcreatename"));
				cp.setCreatetime(rs.getTimestamp("b.dcreatetime"));
				cp.setEndtime(rs.getTimestamp("b.dendtime"));
				cp.setEnduser(rs.getString("b.venduser"));
				cp.setIsfinish(rs.getString("b.isfinish"));
				cp.setProjectend(rs.getString("b.eprojectend"));
				cp.setSendtime(rs.getTimestamp("b.dsendtime"));
				cp.setSenduser(rs.getString("b.vsenduser"));
				cp.setRptype(rs.getString("b.erptype"));
				cp.setFlowcount(rs.getInt("b.iflowcount"));
				cp.setSamplename(rs.getString("b.vsamplename"));
				cp.setSamplecount(rs.getString("b.vsamplecount"));
				cp.setSampledesc(rs.getString("b.tsampledesc"));
				cp.setAppform(rs.getString("b.tappform"));
				cp.setAddnotes(rs.getString("b.taddnotes"));
				cp.setServname(rs.getString("b.vservname"));
				cp.setWarning(getWarning(p.getSid()));
				cp.setStatus(rs.getString("b.estatus"));
				cp.setList(getChemLabTime(p.getSid()));
				cp.setWorkpoint(rs.getString("b.vworkpoint"));
				cp.setItem(rs.getString("b.eitem"));
				cp.setFilepath(rs.getString("b.vfilepath"));
				cp.setNucopletintime(rs.getTimestamp("b.dnucopletintime"));
				cp.setNucopletinuser(rs.getString("b.vnucopletinuser"));
				cp.setRpconfirmtime(rs.getTimestamp("b.drpconfirmtime"));
				cp.setRpconfirmuser(rs.getString("b.vrpconfirmuser"));
				cp.setFilingNo(rs.getString("b.filingno"));
				cp.setComappid(rs.getInt("b.comappid"));
				p.setFilingNo(rs.getString("a.filingno"));
				p.setObj(cp);
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
	 * 取得化学项目
	 * @param sql
	 * @return
	 */
	public Project getChemProject1(String sql) {
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
				ChemProject cp = new ChemProject();
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
				
				cp.setContact(rs.getString("b.vcontact"));
				cp.setEngineer(rs.getString("b.vengineer"));
				cp.setProjectend(rs.getString("b.eprojectend"));
				cp.setRptype(rs.getString("b.erptype"));
				cp.setRptime(rs.getTimestamp("b.drptime"));
				cp.setRpclient(rs.getString("b.rpclient"));
				cp.setCreatename(rs.getString("b.vcreatename"));
				cp.setCreatetime(rs.getTimestamp("b.dcreatetime"));
				cp.setEndtime(rs.getTimestamp("b.dendtime"));
				cp.setEnduser(rs.getString("b.venduser"));
				cp.setIsfinish(rs.getString("b.isfinish"));
				cp.setProjectend(rs.getString("b.eprojectend"));
				cp.setSendtime(rs.getTimestamp("b.dsendtime"));
				cp.setSenduser(rs.getString("b.vsenduser"));
				cp.setRptype(rs.getString("b.erptype"));
				cp.setFlowcount(rs.getInt("b.iflowcount"));
				cp.setSamplename(rs.getString("b.vsamplename"));
				cp.setSamplecount(rs.getString("b.vsamplecount"));
				cp.setSampledesc(rs.getString("b.tsampledesc"));
				cp.setAppform(rs.getString("b.tappform"));
				cp.setAddnotes(rs.getString("b.taddnotes"));
				cp.setServname(rs.getString("b.vservname"));
				cp.setWarning(getWarning(p.getSid()));
				cp.setStatus(rs.getString("b.estatus"));
				cp.setList(getChemLabTime(p.getSid()));
				cp.setWorkpoint(rs.getString("b.vworkpoint"));
				cp.setItem(rs.getString("b.eitem"));
				cp.setFilepath(rs.getString("b.vfilepath"));
				cp.setMasendtime(rs.getTimestamp("masendtime"));
				cp.setIsmethod(rs.getString("ismethod"));
				p.setObj(cp);
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
	 * 获取综合信息（综合包括迟单率，报告编号正确率统计）
	 */
	public List getSynthesis(String sql){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List  list = new ArrayList ();
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Synthesis sy = new Synthesis();
				sy.setRid(rs.getString("vrid"));
				sy.setPid(rs.getString("vpid"));
				sy.setCreatetime(rs.getTimestamp("dcreatetime"));
				sy.setRptime(rs.getTimestamp("drptime"));
				sy.setSendtime(rs.getTimestamp("dendtime"));
				sy.setServname(rs.getString("vservname"));
				sy.setEngineer(rs.getString("vengineer"));
				sy.setTestcontent(rs.getString("vtestcontent"));
				sy.setStatus(rs.getString("estatus"));
				list.add(sy);
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
	 * 查找所有化学项目列表
	 * 
	 * @param sql
	 * @return List<Project>
	 */
	public List<Project> getAllChemProject(String sql) {
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
				ChemProject cp = new ChemProject();
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
				p.setNotes(rs.getString("vnotes"));
				cp.setClient(rs.getString("b.rpclient"));
				cp.setContact(rs.getString("b.vcontact"));
				cp.setEngineer(rs.getString("b.vengineer"));
				cp.setProjectend(rs.getString("b.eprojectend"));
				cp.setRptype(rs.getString("b.erptype"));
				cp.setRptime(rs.getTimestamp("b.drptime"));
				cp.setRpclient(rs.getString("b.rpclient"));
				cp.setCreatename(rs.getString("b.vcreatename"));
				cp.setCreatetime(rs.getTimestamp("b.dcreatetime"));
				cp.setEndtime(rs.getTimestamp("b.dendtime"));
				cp.setEnduser(rs.getString("b.venduser"));
				cp.setSendtime(rs.getTimestamp("b.dsendtime"));
				cp.setSenduser(rs.getString("b.vsenduser"));
				cp.setRptype(rs.getString("b.erptype"));
				cp.setFlowcount(rs.getInt("b.iflowcount"));
				cp.setSamplename(rs.getString("b.vsamplename"));
				cp.setSamplecount(rs.getString("b.vsamplecount"));
				cp.setSampledesc(rs.getString("b.tsampledesc"));
				cp.setAppform(rs.getString("b.tappform"));
				cp.setAddnotes(rs.getString("b.taddnotes"));
				cp.setServname(rs.getString("b.vservname"));
				cp.setWarning(getWarning(p.getSid()));
				cp.setStatus(rs.getString("b.estatus"));
				cp.setNucopletintime(rs.getTimestamp("b.dnucopletintime"));
				cp.setNucopletinuser(rs.getString("b.vnucopletinuser"));
				cp.setRpconfirmtime(rs.getTimestamp("b.drpconfirmtime"));
				cp.setRpconfirmuser(rs.getString("b.vrpconfirmuser"));
				cp.setList(getChemLabTime(p.getSid()));
				p.setObj(cp);
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
	
	public List<Project> getlateListDTime(String sql,String start) {
 		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List sun = new ArrayList();
		List<Project> list = new ArrayList<Project>();
		List<Project> temp = new ArrayList<Project>();
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Project p = new Project();
				ChemProject cp = new ChemProject();
				p.setId(rs.getInt("a.id"));
				p.setSid(rs.getString("a.vsid"));
				p.setPid(rs.getString("a.vpid"));
				p.setRid(rs.getString("a.vrid"));
				p.setBuildtime(rs.getTimestamp("Dbuildtime"));
				p.setTestcontent(rs.getString("a.vtestcontent"));
				cp.setRptime(rs.getTimestamp("b.drptime"));
				cp.setEndtime(rs.getTimestamp("b.dendtime"));
				cp.setServname(rs.getString("b.vservname"));
				//cp.setEndtime(rs.getTimestamp("b.dendtime"));
				cp.setSendtime(rs.getTimestamp("b.dsendtime"));
				cp.setSamplename(rs.getString("b.vsamplename"));
				p.setObj(cp);
				temp.add(p);
			}
			
//			String sql1 ="";
//			if("".equals(start)){
//			    sql1="select * from t_project a,t_chem_project b where a.vsid = b.vsid and  time_to_sec( timediff(now(),b.drptime)) >7200 and date(b.drptime)=date(now()) and b.dendtime is  null  order by b.drptime desc";
//			}else{
//				sql1="select * from t_project a,t_chem_project b where a.vsid = b.vsid and  time_to_sec( timediff(now(),b.drptime)) >7200 and date(b.drptime)<=date(now()) and date(b.drptime)>='"+start+"' and b.dendtime is  null  order by b.drptime desc";
//			}
//			pstmt = DB.prepareStatement(conn, sql1);
//			rs = pstmt.executeQuery();
//			while (rs.next()) {
//				Project p1 = new Project();
//				ChemProject cp = new ChemProject();
//				p1.setId(rs.getInt("a.id"));
//				p1.setSid(rs.getString("a.vsid"));
//				p1.setPid(rs.getString("a.vpid"));
//				p1.setRid(rs.getString("a.vrid"));
//				cp.setRptime(rs.getTimestamp("b.drptime"));
//				cp.setEndtime(rs.getTimestamp("b.dendtime"));
//				cp.setServname(rs.getString("b.vservname"));
//				//cp.setEndtime(rs.getTimestamp("b.dendtime"));
//				//cp.setSendtime(rs.getTimestamp("b.dsendtime"));
//				p1.setObj(cp);
//				list.add(p1);
//			}
	
//			sun.add(list);
			sun.add(temp);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return sun;
	}
	
	public List<ChemProject> getSedWarning(String sql){
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
//		List sun = new ArrayList();
		List<ChemProject> temp = new ArrayList<ChemProject>();
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ChemProject cp = new ChemProject();
				cp.setSid(rs.getString("vsid"));
				cp.setPid(rs.getString("vpid"));
				cp.setRid(rs.getString("vrid"));
				cp.setRptime(rs.getTimestamp("drptime"));
				cp.setEndtime(rs.getTimestamp("dendtime"));
				cp.setServname(rs.getString("vservname"));
				cp.setStatus(rs.getString("estatus"));
				//cp.setEndtime(rs.getTimestamp("b.dendtime"));
				cp.setObj(ProjectTimeAction.getInstance().getEndTime(cp.getRid()));
				cp.setSendtime(rs.getTimestamp("dsendtime"));
				cp.setSamplename(rs.getString("vsamplename"));
				temp.add(cp);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return temp;
	}
	/**
	 * 查找所有化学项目(分页模式)
	 * @param pageNo
	 * @param pageSize
	 * @param pid
	 * @return
	 */
	public PageModel getAllChemProjects(int pageNo, int pageSize, String sql) {
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
				ChemProject cp = new ChemProject();
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
//				p.setSubcosttime(rs.getTimestamp("dsubcosttime"));
				p.setSubcostnotes(rs.getString("vsubcostnotes"));
//				p.setPresubcost2(rs.getString("fpresubcost2"));
				p.setSubname2(rs.getString("vsubname2"));
				p.setSubcost2(rs.getFloat("fsubcost2"));
//				p.setSubcosttime2(rs.getTimestamp("dsubcosttime2"));
//				p.setSubcostnotes2(rs.getString("vsubcostnotes2"));
//				p.setInsubcost(rs.getFloat("finsubcost"));
//				p.setInsubtag(rs.getString("vinsubtag"));
				p.setPreagcost(rs.getFloat("fpreagcost"));
				p.setAgname(rs.getString("vagname"));
//				p.setClientpay(rs.getString("eclientpay"));
//				p.setClientpay(rs.getString("eclientpay"));
				p.setAgcost(rs.getFloat("fagcost"));
//				p.setAgtime(rs.getTimestamp("dagtime"));
//				p.setAgnotes(rs.getString("vagnotes"));
//				p.setAgtag(rs.getString("vagtag"));
				p.setOtherscost(rs.getFloat("fotherscost"));
//				p.setOtherstag(rs.getString("votherstag"));
				p.setInvtype(rs.getString("einvtype"));
//				p.setInvhead(rs.getString("vinvhead"));
//				p.setInvcontent(rs.getString("vinvcontent"));
				p.setPreinvprice(rs.getFloat("fpreinvprice"));
				p.setInvprice(rs.getFloat("finvprice"));
//				p.setProjectsettle(rs.getString("vprojectsettle"));
//				p.setPpreacount(rs.getFloat("fppreacount"));
//				p.setPacount(rs.getFloat("fpacount"));
				p.setLevel(rs.getString("vlevel"));
				p.setType(rs.getString("etype"));
				p.setLab(rs.getString("elab"));
				p.setIsout(rs.getString("isout"));
				p.setNotes(rs.getString("vnotes"));
				p.setFilingNo(rs.getString("filingno"));
				cp.setContact(rs.getString("vcontact"));
//				cp.setEngineer(rs.getString("vengineer"));
//				cp.setProjectend(rs.getString("eprojectend"));
				cp.setRptype(rs.getString("erptype"));
				cp.setRptime(rs.getTimestamp("drptime"));
				cp.setRpclient(rs.getString("rpclient"));
				cp.setCreatename(rs.getString("vcreatename"));
				cp.setCreatetime(rs.getTimestamp("dcreatetime"));
				cp.setSendtime(rs.getTimestamp("dsendtime"));
				cp.setSenduser(rs.getString("vsenduser"));
				cp.setRptype(rs.getString("erptype"));
//				cp.setFlowcount(rs.getInt("iflowcount"));
				cp.setSamplename(rs.getString("vsamplename"));
				cp.setSamplecount(rs.getString("vsamplecount"));
				cp.setSampledesc(rs.getString("tsampledesc"));
//				cp.setAppform(rs.getString("tappform"));
//				cp.setAddnotes(rs.getString("taddnotes"));
				cp.setServname(rs.getString("vservname"));
				cp.setWarning(getWarning(p.getSid()));
				cp.setStatus(rs.getString("estatus"));
				cp.setItem(rs.getString("eitem"));
				cp.setList(getChemLabTime(p.getSid()));
//				cp.setWorkpoint(rs.getString("vworkpoint"));
				cp.setIschecked(rs.getString("ischecked"));
				cp.setNucopletintime(rs.getTimestamp("dnucopletintime"));
				cp.setNucopletinuser(rs.getString("vnucopletinuser"));
				cp.setRpconfirmtime(rs.getTimestamp("drpconfirmtime"));
				cp.setRpconfirmuser(rs.getString("vrpconfirmuser"));
				cp.setFilingNo(rs.getString("filingno"));
				p.setObj(cp);
				p.setObjf(FlowAction.getInstance().getNsecurity(p.getRid()));
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
	 * 取消化学项目
	 * @param Project
	 * @return boolean
	 */
	public boolean cancelChemProject(Project p) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_chem_project set estatus = '取消',istatus=12,isfinish = 'y' where vsid=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, p.getSid());

			pstmt.executeUpdate();
			
			sql = "insert into t_chem_project_time(vsid,vrid,vstatus,dtime) values(?,?,'报告取消时间',now())";
			
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, p.getSid());
			pstmt.setString(2, p.getRid());
			pstmt.executeUpdate();
			
			sql = "update t_chem_flow set status = 5 where vsid=?";

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, p.getSid());
			
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
	 * 更改状态
	 * @param Project
	 * @return boolean
	 */
	public boolean upStatus(String status,String rid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_chem_project set estatus =? where vrid=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1,status);
			pstmt.setString(2,rid);
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
	 * 初检完成
	 * @param sid
	 * @return
	 */
	public boolean checkingfinish(String sid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_chem_project set ischecked = 'y' where vsid = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, sid);
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
	 * 更新重测reset时间
	 * @param rid
	 * @return
	 */
	public boolean reTest(String rid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			String sql = "update t_chem_project set dsendtime = null,dendtime = null,eprojectend='n',isfinish='n' where vrid = ?";
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, rid);

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
			pstmt = DB.prepareStatement(conn,sql+" limit 0,200");
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
	 * 根据项目号取得所有预警信息
	 * @param sid
	 * @return
	 */
	public List<Warnning> getAllWarningBySid(String sid) {
		String sql = "select * from t_chem_project_warn where vsid = ? order by dwarntime desc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Warnning> list = new ArrayList<Warnning>();

		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, sid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Warnning w = new Warnning();
				w.setSid(rs.getString("vsid"));
				w.setRid(rs.getString("vrid"));
				w.setWarn(rs.getString("vwarning"));
				w.setWarntime(rs.getTimestamp("dwarntime"));
				list.add(w);
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
	 * 添加报告图片
	 * @param img
	 * @return
	 */
	public boolean addImg(ReportImg img) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "select * from t_reportimg where name = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, img.getName());
			rs = pstmt.executeQuery();
			int id = 0;
			if(rs.next()) {
				id = rs.getInt("id");
			}
			if(id != 0) {
				sql = "update t_reportimg set rid=?,sid=?,name=?,imgurl=? where id=" + id;
			} else {
				sql = "insert into t_reportimg (rid,sid,name,imgurl) values (?,?,?,?)";
			}

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, img.getRid());
			pstmt.setString(2, img.getSid());
			pstmt.setString(3, img.getName());
			pstmt.setString(4, img.getImgurl());
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
	 * 取得报告图片
	 * @param sql
	 * @return
	 */
	public List<ReportImg> getImg(String sql) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ReportImg img = null;
		List<ReportImg> list = new ArrayList<ReportImg>();
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				img = new ReportImg();
				img.setId(rs.getInt("id"));
				img.setRid(rs.getString("rid"));
				img.setSid(rs.getString("sid"));
				img.setName(rs.getString("name"));
				img.setImgurl(rs.getString("imgurl"));
				img.setDetial(rs.getString("detail"));

				list.add(img);
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
	 * 实验室编辑项目
	 * @param p
	 * @param oldwarning
	 * @return
	 */
	public boolean Labmodify(Project p,String oldwarning) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String iswarn = "n";
		ChemProject cp = (ChemProject)p.getObj();
		String sql = "update t_chem_project set vengineer=?,vworkpoint=? where vsid=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, cp.getEngineer());
			pstmt.setString(2, cp.getWorkpoint());
			pstmt.setString(3, p.getSid());

			pstmt.executeUpdate();
			
			if(cp.getWarning()!=null && !"".equals(cp.getWarning()) && !oldwarning.equals(cp.getWarning())) {
				sql = "insert into t_chem_project_warn(vrid,vwarning,vsid,dwarntime) values(?,?,?,now())";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, p.getRid());
				pstmt.setString(2, cp.getWarning());
				pstmt.setString(3, p.getSid());
				
				pstmt.executeUpdate();
			}
			
			sql = "update t_chem_project set eiswarn=? where vsid=?";
			if(cp.getWarning()!=null && !"".equals(cp.getWarning())) {
				iswarn = "y";
			}
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, iswarn);
			pstmt.setString(2, p.getSid());
			
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
	 * 重测RID
	 * @param rid
	 * @return
	 */
	private synchronized String makeReRid(String rid) {
	//System.out.println(rid+"-------");
		String rerid = "";
		String str = rid.substring(4,12);
		String end = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String sql = "Select vrid from t_chem_project where vrid like '%" + str + "%' order by dcreatetime desc";
		
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String sub = rs.getString("vrid");
				//System.out.println(sub);
				//System.out.println(sub+"----sub-----");
				String last = sub.substring(3, 4);
				//System.out.println(last+"-------------");
				//System.out.println(rid+"----"+sub);
				if(sub.equals(rid)) {
					if(last.hashCode()<97){
						 end = "a";
					}
					else{
						end = String.valueOf((char) (last.hashCode() + 1));
					}
				}else{
					end = String.valueOf((char) (last.hashCode() + 1));
				}
				
			} 
			
			rerid = rid.substring(0,3) + end + str;
			//System.out.println(rerid+"-----------------");
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
		return rerid;
	}
	
	/**
	 * 根据报价单类型更新项目报告编号
	 * @param p
	 */
	private void changeProjectByQuotype(Project p) {
		Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
		//System.out.println(qt.getQuotype()+"----------------");
		if("new".equals(qt.getQuotype())) {//新报价单
			//调用自动生成报告号的方法
			p.setRid(makeRid(p));
			
		} else {
			ChemProject cp = (ChemProject)p.getObj();
			Project temp = getChemProject("select * from t_project a,t_chem_project b where a.vsid = b.vsid and a.vrid = '" + p.getRid() + "' order by a.id desc");
			ChemProject ctemp = (ChemProject)temp.getObj();
			p.setType(temp.getType());
			p.setLab(temp.getLab());
			p.setIsout(temp.getIsout());
			cp.setItem(ctemp.getItem());
			p.setTestcontent(temp.getTestcontent());
			cp.setRptype(ctemp.getRptype());
			cp.setServname(ctemp.getServname());
			cp.setContact(ctemp.getContact());
			cp.setSamplename(ctemp.getSamplename());
			cp.setSamplecount(ctemp.getSamplecount());
			p.setObj(cp);
			if("mod".equals(qt.getQuotype())) {
				//调用修改报告号的方法
				p.setRid(makeReRid(p.getRid()));
			}
		}
	}
	
	
	/**
	 * 生产化妆品编号
	 * @param rid
	 * @return
	 */
	private String makeFilingNo(Project p) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ChemProject chemProject=(ChemProject)p.getObj();
		String ptype=chemProject.getItem();
		String filingNoStr="";
		if(ptype !=null &&!"".equals(ptype)){
			if(ptype.equals("化妆品特")){
				filingNoStr+="GDGT";
			}else if(ptype.equals("化妆品非")){
				filingNoStr+="GDGF";
			}else if(ptype.equals("环境")){
			filingNoStr+="GDGH";
			}else{
				return "";
			}
		}
		
		if(chemProject.getFilingNo()!=null){
			filingNoStr+=chemProject.getFilingNo();
		};
		Date date = new Date();
		String year = new SimpleDateFormat("yyyy").format(date);
		filingNoStr+=year;
		boolean auto = false;
		String last = "";
//		String sql = "Select filingNo from t_project as p ,t_quotation as q where isout='n' and eptype='化妆品' and filingno like '"+filingNoStr+"%' and elab = '中山实验室'  and p.vpid =q.vpid order by substring(filingNo,12,16) desc ";
//		String sql = "Select max(substring(filingNo,12,16)) filingNo from t_project  where  filingno like '"+filingNoStr+"%' ";
		
		String sql = "Select filingNo from t_project  where  filingno like '"+filingNoStr+"%' ORDER BY  substring(filingNo,12,16) desc";
		System.out.println("------化妆品编号生成前sql："+sql);
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String sub = rs.getString("filingNo");
				if(sub !=null && !"".equals(sub)){
					int code = Integer.parseInt(sub.substring(12,16));
					code += 1;
					last = new DecimalFormat("00000").format(code);
				}else{
					last = "00001";
				}
			} else {
				last = "00001";
			}
			filingNoStr+=last;
			auto=true;
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
		return filingNoStr;
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
		ChemProject cp =(ChemProject)p.getObj();
		String item=cp.getItem();
		//System.out.println("报告类型："+cp.getRptype());
		Quotation qt = QuotationAction.getInstance().getQuotationByPid(p.getPid());
		String company = qt.getCompany();
		StringBuffer str = new StringBuffer();
		String pstr = "";
		String last = "0";
		str.append("LC");
		if ("中山".equals(company)) {
			str.append("Z");
		} else if ("广州".equals(company)) {
			str.append("G");
		} else if ("东莞".equals(company)) {
			str.append("D");
		}
		if ("化学测试".equals(ptype)||"化妆品".equals(ptype)) {
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
		else if("环境".equals(ptype)){
			pstr = "C";
		}
//		else if("化妆品".equals(ptype)){
//			pstr = "H";
//		}
		str.append(pstr);
		Date date = new Date();
		String year = new SimpleDateFormat("yy").format(date);
		String month = new SimpleDateFormat("MM").format(date);
		str.append(year + month);
		String keyword = pstr + year + month;
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		ResultSet rs = null;
		boolean auto = false;
		String sql = "";
		if("化学测试".equals(ptype)) {
			if("环境".equals(ptype)){
				last="6";
			}
			if ("机构合作".equals(type)) {
				sql ="Select vrid from t_project as p ,t_quotation as q where isout='n' and etype = '"+type+"' and elab = '中山实验室' and vrid like '%"+keyword+"%'  and p.vpid =q.vpid  and q.vclient !='崇高玩具制品厂'  order by substring(vrid,9,12) desc";
			} else if ("y".equals(isout)) {
				sql = "Select vrid from t_project as p ,t_quotation as q where isout = 'y' and vrid  like '%"
					+ keyword + "%' and p.vpid =q.vpid  and q.vclient !='崇高玩具制品厂' order by substring(vrid,9,12) desc";
			} else if ("自测".equals(type)) {
				if ("中山实验室".equals(lab)) {
					//如果公司是崇高公司的就走他本身的编号
					if(qt.getClient().equals("崇高玩具制品厂")){
						sql = "Select vrid from t_project as p ,t_quotation as q where isout='n' and etype = '"
							+ type
							+ "' and elab = '"
							+ lab
							+ "' and vrid like '%"
							+ keyword + "%' and p.vpid =q.vpid  and q.vclient ='崇高玩具制品厂' order by substring(vrid,9,12) desc";
					}
					//如果公司是广东新宝电器就走他本身的编号
					else if(qt.getClient().equals("广东新宝电器")){
					sql = "Select vrid from t_project as p ,t_quotation as q where isout='n' and etype = '"
						+ type
						+ "' and elab = '"
						+ lab
						+ "' and vrid like '%"
						+ keyword + "%' and p.vpid =q.vpid  and q.vclient ='广东新宝电器' order by substring(vrid,9,12) desc";
					}
					else{
						System.out.println("化学单");
					sql = "Select vrid from t_project as p ,t_quotation as q where isout='n' and etype = '"
							+ type
							+ "' and p.eptype != '化妆品'  and elab = '"
							+ lab
							+ "' and (vrid like '%"
							+ keyword+last+ "%' or vrid like '%"
							+ keyword+ "1%') and p.vpid =q.vpid  and q.vclient !='崇高玩具制品厂' order by substring(vrid,9,12) desc";
					}
				} else {
					sql = "Select vrid from t_project as p ,t_quotation as q where isout='n' and etype = '"
							+ type
							+ "' and elab = '"
							+ lab
							+ "' and vrid like '%"
							+ keyword+last + "%' and p.vpid =q.vpid  and q.vclient !='崇高玩具制品厂' order by substring(vrid,9,12) desc";
				}
			}
		}else if("化妆品".equals(ptype)){
			sql = "Select vrid from t_project as p ,t_quotation as q where eptype = '"
				+ ptype
				+ "' ";
			if(item.equals("化妆品特")){
				sql +=" and filingno like '%GDGT%'";
				last="4";
			}else if(item.equals("化妆品非")){
				sql +=" and filingno like '%GDGF%'";
				last="5";
			}else if(item.equals("环境")){
				sql +=" and filingno like '%GDGH%'";
				last="6";
			}else if(item.equals("化妆品LC")){
				last = "3";
			}
			sql +="and vrid like '%"
				+ keyword+last+ "%' and p.vpid =q.vpid  and q.vclient !='崇高玩具制品厂' order by substring(vrid,9,12) desc";
		} else {
			System.out.println("最后的化学单");
			if("环境".equals(ptype)){
				last="6";
			}
			sql = "Select vrid from t_project as p ,t_quotation as q where eptype = '"
				+ ptype
				+ "' and (vrid like '%"
				+ keyword+last+ "%' or vrid like '%"
				+ keyword+ "1%') and p.vpid =q.vpid  and q.vclient !='崇高玩具制品厂' order by substring(vrid,9,12) desc";
		}
		System.out.println(sql+"-------------------");
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String sub = rs.getString("vrid");
//				//--------------2013-01-29---------------
//				String sql1 = "lock tables t_ridno write";  
//			    // 或String sql = "lock tables aa1 read";   
//			    // 如果想锁多个表 lock tables aa1 read ,aa2 write , .....   
//			    String sql2 = "insert into t_ridno (vrid) values ('"+sub+"') ";  
//			    String sql3 = "unlock tables";  
//			    try {  
//			        pstmt1 = conn.prepareStatement(sql1);  
//			        pstmt2 = conn.prepareStatement(sql2);  
//			        pstmt3 = conn.prepareStatement(sql3);  
//			        pstmt1.executeQuery();  
//			        pstmt2.executeQuery();  
//			        pstmt3.executeQuery();  
//			    } catch (Exception e) {  
//			        System.out.println("异常" + e.getMessage());  
//			    }  

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
							if(qt.getClient().equals("崇高玩具制品厂")){
								last = "8901";
							}else if(qt.getClient().equals("广东新宝电器")){
								last = "8801";
							}
							else{
							last = "0001";
							}
						} else {
							last = "6001";
						}
					}
					//-------------------------2010-12-15----------------------
//					 else if ("电子电器安全测试".equals(ptype)) {
//						 last = "0001";
//						} else if ("EMC测试".equals(ptype)) {
//							last = "0001";
//						} else if ("光性能测试".equals(ptype)) {
//							last = "0001";
//						} else if ("能效测试".equals(ptype)) {
//							last = "0001";
//						}
					//-------------------------2010-12-15----------------------
				}else {
					last+= "001";
				}
			}
			str.append(last);
			auto=true;
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
		}else if("化妆品".equals(ptype)){
			pstr = "H";
		}else if("环境".equals(ptype)){
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
				sql = "Select vrid from t_project as p ,t_quotation as q where etype = '"
						+ type + "' and vrid like '%" + keyword
						+ "%' and p.vpid =q.vpid  and q.vclient !='崇高玩具制品厂' order by substring(vrid,9,12) desc";
			} else if ("y".equals(isout)) {
				sql = "Select vrid from t_project as p ,t_quotation as q where isout = 'y' and etype = '" + type + "' and vrid  like '%"
					+ keyword + "%'and p.vpid =q.vpid  and q.vclient !='崇高玩具制品厂' order by substring(vrid,9,12)desc";
			} else if ("自测".equals(type)) {
				if ("中山实验室".equals(lab)) {
					sql = "Select vrid from t_project as p ,t_quotation as q where isout='n' and etype = '"
							+ type
							+ "' and elab = '"
							+ lab
							+ "' and vrid like '%"
							+ keyword + "%'and p.vpid =q.vpid  and q.vclient !='崇高玩具制品厂' order by substring(vrid,9,12)";
				} else {
					sql = "Select vrid from t_project as p ,t_quotation as q where isout='n' and etype = '"
							+ type
							+ "' and elab = '"
							+ lab
							+ "' and vrid like '%"
							+ keyword + "%'and p.vpid =q.vpid  and q.vclient !='崇高玩具制品厂' order by substring(vrid,9,12)";
				}
			}
		} else {
			sql = "Select vrid from t_project as p ,t_quotation as q where eptype = '"
				+ ptype
				+ "' and vrid like '%"
				+ keyword + "%' and p.vpid =q.vpid  and q.vclient !='崇高玩具制品厂' order by substring(vrid,9,12)";
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
					}
					
					else if ("y".equals(isout)) {
						rid = str.append("9000").toString();
					} 
					
					
					else if ("自测".equals(type)) {
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
	 * 取得项目预警
	 * @param rid
	 * @return
	 */
	public String getWarning(String sid) {
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
	public List<ChemLabTime> getChemLabTime(String sid) {
		String sql = "select * from t_chem_project_time where vsid = ? order by dtime desc";
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

	/***
	 * 根据pid来查询开按时间和报告时间
	 * 
	 */
	public List getDcreateTime(String pid) {
		String sql = "select * from t_chem_project where vpid = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList();
		
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("Drptime"));
				list.add(rs.getString("Dcreatetime"));
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

	
	
	
	/***
	 * 根据销售或客服人员来查看它的项目状态
	 * @param pageNo  第几页
	 * @param pageSize  每页显示多少条记录
	 * @param userName  销售或客服的名称
	 * @param dept      部门
	 * @return   
	 */
	public PageModel getChemProject(int pageNo, int pageSize,String userName,String dept,int status,String type) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rsre = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List<ChemProject> list = new ArrayList<ChemProject>();
		StringBuffer str=new StringBuffer();
		String sql="";
//		String sql = "select * from t_system where 1=1  order by createtime desc " + "limit "
//				+ (pageNo - 1) * pageSize + ", " + pageSize;
		if(dept.equals("销售")){
			str.append(" and q.Vsales='"+userName+"'");
		}
//		else if(dept.equals("客服")){
//			str.append(" and  cp.vservname='"+userName+"'");
//			
//		}
		if(status ==1&&type==null){
			sql = "select cp.vpid as a,cp.vrid as b,cp.drptime as c ,cp.Dendtime as h ,cp.vservname as d,q.Vsales as e ,q.Vclient as g  ,cp.Estatus as f,cp.vsid as i,c.pay ,q.epaystatus,p.granttime as granttime  from t_chem_project as cp left join t_quotation as q on q.vpid =cp.vpid left join t_client as c  on c.name=q.vclient  left join  t_project as p on cp.vrid=p.vrid  where year(cp.drptime)=year(now()) and  month(cp.drptime) =month(now()) and day(cp.drptime)=day(now())   and cp.Dendtime is not null  "+str+"  and  cp.vstart!='暂停'  order by c desc" ;
		}else if (status ==0&&(type==null || type.equals("null"))){
			sql= "select cp.vpid as a,cp.vrid as b,cp.drptime as c ,cp.Dendtime as h ,cp.vservname as d,q.Vsales as e ,q.Vclient as g  ,cp.Estatus as f,cp.vsid as i,c.pay,q.epaystatus,p.granttime as granttime from t_chem_project as cp"; 
			sql+=" left join  t_quotation as q on q.vpid =cp.vpid" ;
			sql+=" left join t_client as c  on  c.name=q.vclient";
			sql+=" left join t_project as p on cp.vrid =p.vrid";
			sql+=" where year(cp.drptime)=year(now()) and  month(cp.drptime) =month(now()) ";
			sql+="and day(cp.drptime)=day(now())  and cp.Dendtime is  null "+str+" and    cp.vstart!='暂停' order by c desc"; 
		}
		if(type!=null&&type.equals("tomorrow")){
			SimpleDateFormat yearSdf=new SimpleDateFormat("yyyy");//获取系统年份
			SimpleDateFormat monthSdf=new SimpleDateFormat("MM");//获取系统月份
			int year =Integer.parseInt(yearSdf.format(new Date()));
			int month=Integer.parseInt(monthSdf.format(new Date()));
			String lastDate=getLastDayOfMonth(year,month);
			SimpleDateFormat nowDate=new SimpleDateFormat("yyyy-MM-dd");//获取系统时间
			if(nowDate.equals(lastDate)){//当系统时间等于当月最有一天的时候
				sql="select cp.vpid as a,cp.vrid as b,cp.drptime as c ,cp.Dendtime as h ,cp.vservname as d,q.Vsales as e ,q.Vclient as g  ,cp.Estatus as f,cp.vsid as i,c.pay,q.epaystatus ,p.granttime as granttime from t_chem_project as cp left join t_quotation as q on q.vpid =cp.vpid left join t_client as c  on c.name=q.vclient  left join  t_project as p on cp.vrid=p.vrid    where year(cp.drptime)=year(now()) and  month(cp.drptime) =month(now())+1 and day(cp.drptime)=1    and cp.Dendtime is  null  "+str+"  and  cp.vstart!='暂停' order by c asc ";
			}else{
				sql="select cp.vpid as a,cp.vrid as b,cp.drptime as c ,cp.Dendtime as h ,cp.vservname as d,q.Vsales as e ,q.Vclient as g  ,cp.Estatus as f,cp.vsid as i,c.pay,q.epaystatus ,p.granttime as granttime from t_chem_project as cp left join t_quotation as q on q.vpid =cp.vpid left join t_client as c  on c.name=q.vclient  left join  t_project as p on cp.vrid=p.vrid    where year(cp.drptime)=year(now()) and  month(cp.drptime) =month(now()) and day(cp.drptime)=day(now())+1    and cp.Dendtime is  null   "+str+"  and  cp.vstart!='暂停' order by c asc " ;
			}
			
		}
		if(type!=null&&type.equals("history")){
			sql = "select cp.vpid as a,cp.vrid as b,cp.drptime as c ,cp.Dendtime as h ,cp.vservname as d,q.Vsales as e ,q.Vclient as g  ,cp.Estatus as f,cp.vsid as i,c.pay,q.epaystatus ,p.granttime as granttime from t_chem_project as cp left join t_quotation as q on q.vpid =cp.vpid left join t_client as c  on c.name=q.vclient  left join  t_project as p on cp.vrid=p.vrid  where year(cp.drptime)=year(now()) and  (cp.Dendtime>cp.drptime or(cp.Dendtime is null and  cp.drptime<date(now()))) and cp.Estatus <>'结案' and cp.Estatus<>'发证'   "+str+" and  cp.vstart!='暂停' order by c asc " ;
		}
		if(type!=null&&type.equals("date")){
			sql = "select cp.vpid as a,cp.vrid as b,cp.drptime as c ,cp.Dendtime as h ,cp.vservname as d,q.Vsales as e ,q.Vclient as g  ,cp.Estatus as f,cp.vsid as i,c.pay,q.epaystatus   ,p.granttime as granttime from t_chem_project as cp left join t_quotation as q on q.vpid =cp.vpid left join t_client as c  on c.name=q.vclient  left join  t_project as p on cp.vrid=p.vrid  where year(cp.Dendtime)=year(now()) and  month(cp.Dendtime) =month(now()) and day(cp.Dendtime)=day(now())    and cp.Dendtime is not null  "+str+" and  cp.vstart!='暂停'  order by h desc" ;
		}
		//String sql="select cp.vpid as a,cp.vrid as b,cp.drptime as c ,cp.Dendtime as h ,cp.vservname as d,q.Vsales as e ,q.Vclient as g  ,cp.Estatus as f,cp.vsid as i from t_chem_project as cp,t_quotation as q  where year(cp.drptime)=year(now()) and  month(cp.drptime) =month(now()) and day(cp.drptime)=day(now()) "+str+" and  cp.vstart!='暂停' order by cp.drptime asc";
		/***
		 * 2012-4-6更改的注释的
		 */
//		if(status ==1){
//		 sql = "select cp.vpid as a,cp.vrid as b,cp.drptime as c ,cp.Dendtime as h ,cp.vservname as d,q.Vsales as e ,q.Vclient as g  ,cp.Estatus as f,cp.vsid as i from t_chem_project as cp,t_quotation as q  where year(cp.drptime)=year(now()) and  month(cp.drptime) =month(now()) and day(cp.drptime)=day(now())   and q.vpid =cp.vpid and cp.Dendtime is not null   "+str+" and  cp.vstart!='暂停'  order by f desc " ;
//		} else{
//		sql = "select cp.vpid as a,cp.vrid as b,cp.drptime as c ,cp.Dendtime as h ,cp.vservname as d,q.Vsales as e ,q.Vclient as g  ,cp.Estatus as f,cp.vsid as i from t_chem_project as cp,t_quotation as q  where year(cp.drptime)=year(now()) and  month(cp.drptime) =month(now()) and day(cp.drptime)=day(now())   and q.vpid =cp.vpid and cp.Dendtime is  null   "+str+" and  cp.vstart!='暂停' order by cp.drptime asc " ;
//		}
		String sqlStr=sql+" limit "+ (pageNo - 1) * pageSize + ", " + pageSize;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sqlStr);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ChemProject cp =new ChemProject();
				cp.setPid(rs.getString("a"));
				cp.setRid(rs.getString("b"));
				cp.setRptime(rs.getTimestamp("c"));
				cp.setServname(rs.getString("d"));
				cp.setSales(rs.getString("e"));
				cp.setStatus(rs.getString("f"));
				cp.setClient(rs.getString("g"));
				cp.setEndtime(rs.getTimestamp("h"));
				cp.setSid(rs.getString("i"));
				cp.setPaystatus(rs.getString("epaystatus"));
				cp.setPay(rs.getString("pay"));
				cp.setGranttime(rs.getString("granttime"));
				list.add(cp);
			}
			int totalRecords =DaoFactory.getInstance().getProjectDao().getTotalRecords(conn, sql);
			//System.out.println(totalRecords); 
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
	 * 获取某年某月的最后一天
	 * @param year
	 * @param month
	 * @return
	 */
	public static String getLastDayOfMonth(int year,int month)     {         
		Calendar cal = Calendar.getInstance();         //设置年份         
		cal.set(Calendar.YEAR,year);         //设置月份         
		cal.set(Calendar.MONTH, month-1);         //获取某月最大天数       
		int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);         //设置日历中月份的最大天数       
		cal.set(Calendar.DAY_OF_MONTH, lastDay);         //格式化日期         
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");         
		String lastDayOfMonth = sdf.format(cal.getTime());                   
		return lastDayOfMonth;     
	}
	
	/**
	 * 查找报告发出但是未付款的信息
	 * @param pageNo
	 * @param pageSize
	 * @param pid
	 * @param status 是否需要分页
	 * @return
	 */
	
	public PageModel searchIssueRPNoPay(int pageNo, int pageSize, String sql,String status) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List<ChemProject> list = new ArrayList<ChemProject>();
		ChemProject cp = null;
		String str = sql + "  limit " + (pageNo - 1) * pageSize + ", " + pageSize;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			if(status !=null && !"".equals(status)){
				pstmt = DB.prepareStatement(conn, str);
			}else{
				pstmt = DB.prepareStatement(conn, sql);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				cp = new ChemProject();
				Quotation q =new Quotation();
				cp.setPid(rs.getString("报价单号"));
				cp.setRid(rs.getString("报告号"));
				q.setSales(rs.getString("销售人员"));
				q.setClient(rs.getString("客户名称"));
				q.setCreatetime(rs.getTimestamp("创建时间"));
				cp.setIsmethod(rs.getString("发放形式"));
				q.setPaystatus(rs.getString("是否付款"));
				cp.setSendtime(rs.getTimestamp("报告发放时间"));
				cp.setEndtime(rs.getTimestamp("最迟汇款时间"));
				cp.setObj(q);
				list.add(cp);
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
	
	public String getEtypeByRid(String sql) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String type="";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				type =rs.getString("erptype");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return type;
	}
}
