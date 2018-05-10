package com.lccert.crm.flow;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.project.ChemProject;
import com.lccert.crm.project.Project;

/**
 * 流转单管理工具类（包括service层和dao层）
 * 
 * @author tangzp
 *
 */
public class FlowAction {
	
	private static FlowAction instance = null;

	private FlowAction() {

	}

	public synchronized static FlowAction getInstance() {
		if (instance == null) {
			instance = new FlowAction();
		}
		return instance;
	}
	
	/**
	 * 生成流转单号：rid + A/B/C/D/E + 001~999
	 * @param rid
	 * @param flowtype
	 * @return
	 */
	public synchronized String makeFid(String rid,String flowtype,String retest) {
//		System.out.println(rid+"-----"+flowtype+"---"+retest);
		String sql = "Select vfid from t_chem_flow where vrid=? and eflowtype=? and eretest=? order by dpdtime desc";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String fid = "";
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, rid);
			pstmt.setString(2, flowtype);
			pstmt.setString(3, retest);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String sub = rs.getString("vfid");
				int code = Integer.parseInt(sub.substring(sub.length()-3,sub.length()));
				code += 1;
				fid = sub.substring(0,sub.length()-3) + new DecimalFormat("000").format(code);
			} 
			if("n".equals(retest)){
				if("无机流转单".equals(flowtype)) {
					fid = rid + "A-001";
				} else if("有机流转单".equals(flowtype)) {
					fid = rid + "B-001";
				} else if("食品流转单".equals(flowtype)) {
					fid = rid + "C-001";
				} else if("外包流转单".equals(flowtype)) {
					fid = rid + "D-001";
				} else if("机构合作流转单".equals(flowtype)) {
					fid = rid + "E-001";
				} else if("自测流转单".equals(flowtype)) {
					fid = rid + "G-001";
				}else if("微生物流转单".equals(flowtype)) {
					fid = rid + "W-001";
				}
				
			} else {
				if("无机流转单".equals(flowtype)) {
					fid = rid + "F-001";
				} else if("有机流转单".equals(flowtype)) {
					fid = rid + "F-002";
				} else if("食品流转单".equals(flowtype)) {
					fid = rid + "F-003";
				} else if("外包流转单".equals(flowtype)) {
					fid = rid + "F-004";
				} else if("机构合作流转单".equals(flowtype)) {
					fid = rid + "F-005";
				}else if("自测流转单".equals(flowtype)) {
					fid = rid + "F-006";
				}else if("微生物流转单".equals(flowtype)) {
					fid = rid + "F-007";
				}
			}
//			System.out.println(fid+"fid");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return fid;
	}
	
	/**
	 * 添加流转单
	 * @param flow
	 * @param cp
	 * @return
	 */
	public boolean addFlow(Flow flow,Project p,String oldwarning) {
//		System.out.println(flow.getRid());
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String iswarn = "n";
		ChemProject cp = (ChemProject)p.getObj();
		if(cp.getWarning()!=null && !"".equals(cp.getWarning())) {
			iswarn = "y";
		}
		
		String sql = "insert into t_chem_flow(vfid,vpid,vrid,"
			+ "eflowtype,vlab,vtestparent,vtestchild,vtestplan_C,vtestplan_E,itestcount,eretest,"
			+ "vpduser,vsid,vlevel,vdescribe,vcnastatus,vstandard,eaddsamples,dpdtime) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now())";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, flow.getFid());
			pstmt.setString(2, flow.getPid());
			pstmt.setString(3, flow.getRid());
			pstmt.setString(4, flow.getFlowtype());
			pstmt.setString(5, flow.getLab());
			pstmt.setString(6, flow.getTestparent());
			pstmt.setString(7, flow.getTestchild());
			pstmt.setString(8, flow.getTestplanC());
			pstmt.setString(9, flow.getTestplanE());
			pstmt.setInt(10, flow.getTestcount());
			pstmt.setString(11, flow.getRetest());
			pstmt.setString(12, flow.getPduser());
			pstmt.setString(13, flow.getSid());
			pstmt.setString(14, flow.getLevel());
			pstmt.setString(15, flow.getDescribe());
			pstmt.setString(16, flow.getCnastatus());
			pstmt.setString(17, flow.getStandard());
			pstmt.setString(18, flow.getAddsamples());
			//System.out.println(flow.getCnastatus());
			pstmt.executeUpdate();
			
			sql = "update t_chem_project set tappform=?,tsampledesc=?,eiswarn=? where vrid = ?";
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, cp.getAppform());
			pstmt.setString(2, cp.getSampledesc());
			pstmt.setString(3, iswarn);
			pstmt.setString(4, p.getRid());
			
			pstmt.executeUpdate();
			
			if(cp.getWarning()!=null && !"".equals(cp.getWarning()) && !oldwarning.equals(cp.getWarning())) {
				sql = "insert into t_chem_project_warn(vrid,vwarning,vsid,dwarntime) values(?,?,?,now())";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, p.getRid());
				pstmt.setString(2, cp.getWarning());
				pstmt.setString(3, p.getSid());
				
				pstmt.executeUpdate();
			}
			String testparent=flow.getTestparent();
			//测试部门化学KPI流程和规则中添加流转单测试大项表
			if(testparent!=null && !"".equals(testparent)) {
				//截取流转单号如：LCZC10029001F-003截取后：LCZC10029001F
				String vfidStr="";
				if(flow.getFid().indexOf("-")>-1){
					vfidStr=flow.getFid().substring(0, flow.getFid().indexOf("-"));
				}else{
					vfidStr=flow.getFid();
				}
				if(testparent.indexOf(";")>-1){
					int i=0;//流转单测试大项编号(流转单号+测试大项目自增长号)
					String[] strArr=testparent.split(";");
					Map<String, String> map =new HashMap<String, String>();
					for(String tempArr:strArr){
						map.put(tempArr, tempArr);
					}
					for(String keyTemp:map.keySet()){
						i++;
						String vfidtestNo=vfidStr+"-"+i;
						sql = "insert into t_flow_test(vfid,vfidtestNo,vfidtestname) values(?,?,?)";
						pstmt = DB.prepareStatement(conn, sql);
						pstmt.setString(1, flow.getFid());
						pstmt.setString(2,vfidtestNo);
						pstmt.setString(3,map.get(keyTemp));
						pstmt.executeUpdate();
					}
				}else{
					vfidStr=vfidStr+"-"+1;
					sql = "insert into t_flow_test(vfid,vfidtestNo,vfidtestname) values(?,?,?)";
					pstmt = DB.prepareStatement(conn, sql);
					pstmt.setString(1, flow.getFid());
					pstmt.setString(2,vfidStr);
					pstmt.setString(3,testparent);
					pstmt.executeUpdate();
				}	
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
	 * 添加安规流转单
	 * @param flow
	 * @param cp
	 * @return
	 */
	public boolean addPhyFlow(Flow flow,String oldWarning ,String warning) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String iswarn = "n";
		String sql = "insert into t_chem_flow(vfid,vpid,vrid,"
			+ "eflowtype,vlab,vtestplan_C,vtestplan_E,eretest,"
			+ "vsid,vlevel,notes,dpdtime) values(?,?,?,?,?,?,?,?,?,?,?,now())";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, flow.getFid());
			pstmt.setString(2, flow.getPid());
			pstmt.setString(3, flow.getRid());
			pstmt.setString(4, flow.getFlowtype());
			pstmt.setString(5, flow.getLab());
			pstmt.setString(6, flow.getTestplanC());
			pstmt.setString(7, flow.getTestplanE());
			pstmt.setString(8, flow.getRetest());
			pstmt.setString(9, flow.getSid());
			pstmt.setString(10, flow.getLevel());
			pstmt.setString(11, flow.getNotes());
			pstmt.executeUpdate();
			
			if(warning!=null && !"".equals(warning) && !oldWarning.equals(warning)) {
//			if(warning!=null && !"".equals(warning) ) {
				sql = "insert into t_chem_project_warn(vrid,vwarning,vsid,dwarntime) values(?,?,?,now())";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, flow.getRid());
				pstmt.setString(2, warning);
				pstmt.setString(3, flow.getSid());
				
				pstmt.executeUpdate();
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
	
	
public boolean modifyphyFlow(Flow flow,String oldWarning ,String warning,String oldfid) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String iswarn = "n";
		
//		String sql = "update t_chem_flow set vfid=?,"
//			+ "eflowtype=?,vlab=?,vtestparent=?,vtestchild=?,vtestplan_C=?,vtestplan_E=?,itestcount=?,eretest=?,vdescribe=? "
//			+ "where vfid=?";
		
		
		String sql = "update t_chem_flow set vfid=?,eflowtype=?,vlab=?,vtestplan_C=?,vtestplan_E=?,eretest=?,notes=? where vfid=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, flow.getFid());
			pstmt.setString(2, flow.getFlowtype());
			pstmt.setString(3, flow.getLab());
			pstmt.setString(4, flow.getTestplanC());
			pstmt.setString(5, flow.getTestplanE());
			pstmt.setString(6, flow.getRetest());
			pstmt.setString(7, flow.getNotes());
			pstmt.setString(8, oldfid);
			
			System.out.println("1:"+flow.getFid()+"2:"+flow.getFlowtype()+"3:"+flow.getLab()+"4:"+flow.getTestplanC()+"5:"+flow.getTestplanC()+"6:"+flow.getRetest()+"7:"+flow.getNotes());
			pstmt.executeUpdate();
			
			if(warning!=null && !"".equals(warning) && !oldWarning.equals(warning)) {
//			if(warning!=null && !"".equals(warning) ) {
				sql = "insert into t_chem_project_warn(vrid,vwarning,vsid,dwarntime) values(?,?,?,now())";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, flow.getRid());
				pstmt.setString(2, warning);
				pstmt.setString(3, flow.getSid());
				
				pstmt.executeUpdate();
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
	 * 修改流转单
	 * @param flow
	 * @param cp
	 * @return
	 */
	public boolean modifyFlow(Flow flow,Project p,String oldfid,String oldwarning) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String iswarn = "n";
		ChemProject cp = (ChemProject)p.getObj();
		if(cp.getWarning()!=null && !"".equals(cp.getWarning())) {
			iswarn = "y";
		}
//		String sql = "update t_chem_flow set vfid=?,"
			String sql = "update t_chem_flow set "
			+ " eflowtype=?,vlab=?,vtestparent=?,vtestchild=?,vtestplan_C=?,vtestplan_E=?,itestcount=?,eretest=?,vdescribe=?,eaddsamples=? "
			+ " where vfid=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
//			pstmt.setString(1, flow.getFid());
			pstmt.setString(1, flow.getFlowtype());
			pstmt.setString(2, flow.getLab());
			pstmt.setString(3, flow.getTestparent());
			pstmt.setString(4, flow.getTestchild());
			pstmt.setString(5, flow.getTestplanC());
			pstmt.setString(6, flow.getTestplanE());
			pstmt.setInt(7, flow.getTestcount());
			pstmt.setString(8,flow.getRetest());
			pstmt.setString(9, flow.getDescribe());
			pstmt.setString(10, flow.getAddsamples());
			pstmt.setString(11, oldfid);
			
			
			pstmt.executeUpdate();
			
			sql = "update t_chem_project set tappform=?,tsampledesc=?,eiswarn=? where vsid = ?";
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, cp.getAppform());
			pstmt.setString(2, cp.getSampledesc());
			pstmt.setString(3, iswarn);
			pstmt.setString(4, p.getSid());
			
			pstmt.executeUpdate();
			
			if(cp.getWarning()!=null && !"".equals(cp.getWarning()) && !oldwarning.equals(cp.getWarning())) {
				sql = "insert into t_chem_project_warn(vrid,vwarning,vsid,dwarntime) values(?,?,?,now())";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, p.getRid());
				pstmt.setString(2, cp.getWarning());
				pstmt.setString(3, p.getSid());
				pstmt.executeUpdate();
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
	 * 删除流转单
	 * @param fid
	 */
	public void delFlow(String fid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		String sql = "delete from t_chem_flow where vfid = ?";

		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, fid);

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
	
	/**
	 * 根据报告编号rid查找流转单
	 * @param rid
	 * @return
	 */
	public List<Flow> getFlowByRid(String rid) {
		String sql = "select * from t_chem_flow where status <> 5  and ((vtestplan_C is not null )or( vtestplan_E is not null)) and vrid = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Flow> list = new ArrayList<Flow>();
		
		
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, rid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Flow flow = new Flow();
				flow.setFid(rs.getString("vfid"));
				flow.setPid(rs.getString("vpid"));
				flow.setSid(rs.getString("vsid"));
				flow.setRid(rs.getString("vrid"));
				flow.setFlowtype(rs.getString("eflowtype"));
				flow.setLab(rs.getString("vlab"));
				flow.setPduser(rs.getString("vpduser"));
				flow.setPdtime(rs.getTimestamp("dpdtime"));
				flow.setTestparent(rs.getString("vtestparent"));
				flow.setTestchild(rs.getString("vtestchild"));
				flow.setTestcount(rs.getInt("itestcount"));
				flow.setVworkpoint(rs.getString("vworkpoint"));
				flow.setVworkpoint2(rs.getString("vworkpoint2"));
				flow.setStatus(rs.getInt("status"));
				
				list.add(flow);
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
	
	/**
	 * 根据项目号sid查找流转单
	 * @param rid
	 * @return
	 */
	public List<Flow> getFlowBySid(String sid) {
		String sql = "select * from t_chem_flow where status <> 5 and vsid = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Flow> list = new ArrayList<Flow>();
		
		
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, sid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Flow flow = new Flow();
				flow.setFid(rs.getString("vfid"));
				flow.setPid(rs.getString("vpid"));
				flow.setSid(rs.getString("vsid"));
				flow.setRid(rs.getString("vrid"));
				flow.setFlowtype(rs.getString("eflowtype"));
				flow.setLab(rs.getString("vlab"));
				flow.setPduser(rs.getString("vpduser"));
				flow.setPdtime(rs.getTimestamp("dpdtime"));
				flow.setTestparent(rs.getString("vtestparent"));
				flow.setTestchild(rs.getString("vtestchild"));
				flow.setTestcount(rs.getInt("itestcount"));
				flow.setVworkpoint(rs.getString("vworkpoint"));
				flow.setVworkpoint2(rs.getString("vworkpoint2"));
				flow.setSecurity(rs.getInt("nsecurity"));
				flow.setStatus(rs.getInt("status"));
				
				list.add(flow);
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
	
	
	public int getNsecurity(String rid) {
		String sql = "select nsecurity from t_chem_flow where status <> 5 and vrid = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int security = 0;
		
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
//			System.out.println(sql+"---"+rid);
			pstmt.setString(1,rid);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				security=rs.getInt("nsecurity");
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return security;
	}
	
	public synchronized boolean LabFlowmodify(Flow flow,Project p,String oldwarning) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String iswarn = "n";
		ChemProject cp = (ChemProject)p.getObj();
		String sql = "update t_chem_flow set vworkpoint=?,vworkpoint2=? where vfid=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, flow.getVworkpoint());
			pstmt.setString(2, flow.getVworkpoint2());
			pstmt.setString(3, flow.getFid());

			pstmt.executeUpdate();

			if(cp.getWarning() !=null && !"".equals(cp.getWarning()) && oldwarning.equals(cp.getWarning())) {
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
	 * 根据流转单编号fid查找流转单
	 * @param fid
	 * @return
	 */
	public Flow getFlowByFid(String fid) {
		String sql = "select * from t_chem_flow where vfid = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Flow flow = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, fid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				flow = new Flow();
				flow.setFid(rs.getString("vfid"));
				flow.setSid(rs.getString("vsid"));
				flow.setPid(rs.getString("vpid"));
				flow.setRid(rs.getString("vrid"));
				flow.setFlowtype(rs.getString("eflowtype"));
				flow.setLab(rs.getString("vlab"));
				flow.setPduser(rs.getString("vpduser"));
				flow.setPdtime(rs.getTimestamp("dpdtime"));
				flow.setTestparent(rs.getString("vtestparent"));
				flow.setTestchild(rs.getString("vtestchild"));
				flow.setTestplanC(rs.getString("vtestplan_C"));
				flow.setTestplanE(rs.getString("vtestplan_E"));
				flow.setTestcount(rs.getInt("itestcount"));
				flow.setRetest(rs.getString("eretest"));
				flow.setVworkpoint(rs.getString("vworkpoint"));
				flow.setVworkpoint2(rs.getString("vworkpoint2"));
				flow.setDescribe(rs.getString("vdescribe"));
				flow.setNotes(rs.getString("notes"));
				flow.setSecurity(rs.getInt("nsecurity"));
				flow.setAddsamples(rs.getString("eaddsamples"));
			}
//			System.out.println(flow.getSecurity());
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return flow;
	}
	/**
	 * 根据报价单号查找流转单
	 * @param fid
	 * @return
	 */
	public Flow getFlowByPid(String rid) {
		String sql = "select * from t_chem_flow where vrid =?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Flow flow = null;
		
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, rid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				flow = new Flow();
				flow.setRid(rs.getString("vrid"));
				flow.setPid(rs.getString("vpid"));
				flow.setSid(rs.getString("vsid"));
				flow.setTestcount(rs.getInt("itestcount"));
				flow.setPdtime(rs.getTimestamp("dpdtime"));
			
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return flow;
	}
	
	/**
	 * 根据报告号来查找pid
	 * @param fid
	 * @return
	 */
	public String  getPidByRid(String rid) {
		String sql = "select vpid from t_chem_flow where vrid = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String  pid = null;
		
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, rid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
			
			pid=rs.getString("vpid");
			
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return pid;
	}
	
	/**
	 * 搜索流转单
	 * @param keywords
	 * @param type
	 * @return
	 */
	public List<Flow> searchFlow(String keywords,String type) {
		
		String sql = "";
		if("pid".equals(type)) {
			sql = "select * from t_chem_flow where status <> 5 and vpid like '%" + keywords + "%'";
		} else if("rid".equals(type)) {
			sql = "select * from t_chem_flow where status <> 5 and vrid like '%" + keywords + "%'";
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Flow> list = new ArrayList<Flow>();
		Flow flow = null;
		
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				flow = new Flow();
				flow.setFid(rs.getString("vfid"));
				flow.setSid(rs.getString("vsid"));
				flow.setPid(rs.getString("vpid"));
				flow.setRid(rs.getString("vrid"));
				flow.setFlowtype(rs.getString("eflowtype"));
				flow.setLab(rs.getString("vlab"));
				flow.setPduser(rs.getString("vpduser"));
				flow.setPdtime(rs.getTimestamp("dpdtime"));
				flow.setTestparent(rs.getString("vtestparent"));
				flow.setTestchild(rs.getString("vtestchild"));
				flow.setTestcount(rs.getInt("itestcount"));
				flow.setSecurity(rs.getInt("nsecurity"));
				flow.setStatus(rs.getInt("status"));
				
				list.add(flow);
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
	
	//判断流转单的中文描述或英文描述是否为空
	public boolean isDescribe(String flowid){
		String sql = "select * from t_chem_flow where vfid=? and vdescribe is not null;";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean flag=false;
		
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, flowid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
			
				flag=true;
			
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return flag;
	}
	
	//根据报告号来查询描述
	public List  findDescribe(String rid){
		String sql = "select * from t_chem_flow where vrid=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list =new ArrayList();
		Flow flow ;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, rid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				flow =new Flow();
				flow.setTestplanC(rs.getString("vtestplan_C"));
				flow.setTestplanE(rs.getString("vtestplan_E"));
				list.add(flow);
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
	
	
	
	/**
	 * 取消流转单
	 * @param fid
	 * @return
	 */
	public synchronized boolean cancelFlow(String fid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_chem_flow set status = 5 where vfid=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, fid);
			
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
	 * 得到二级分类的名称
	 * 
	 * @param type
	 * @return
	 */
	public String getchildNameByPlanName(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false; 
		//List list =new ArrayList();
		String childName="";
		String sql = "select a.name as childName from t_chem_test_child as a ,t_chem_test_plan as b where a.id =b.parentid   and  b.id =?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				childName =rs.getString("childName");
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
		return childName;
	}
	
	
	public void addSecurityBySid(int  security, String rid){
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_chem_flow set nsecurity = ? where vrid=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1,security);
			pstmt.setString(2, rid);
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
	}
	
	
	/**
	 * 根据项目号sid查找流转单
	 * @param rid
	 * @return
	 */
	public int getSecurityByRid(String rid) {
		String sql = "select nsecurity from t_chem_flow where status <> 5 and vrid = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int security=0;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1,rid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				security=rs.getInt("nsecurity");
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return security;
	}
	
	
	/**
	 * 根据报告编号rid查找流转单
	 * @param rid
	 * @return
	 */
	public List<Flow> getRidByProject(String parent,String child,String describe,String planC,String planE,String cnas) {
		StringBuffer str =new StringBuffer();
		if(parent !=null&&!"".equals(parent)){
			str.append(" and vtestparent like  '%"+parent+"%'");
		}
		if(child !=null&&!"".equals(child)){
			str.append(" and vtestchild like  '%"+child+"%'");
		}
		if(describe !=null&&!"".equals(describe)){
			str.append(" and vdescribe like  '%"+describe+"%'");
		}
		if(planC !=null&&!"".equals(planC)){
			str.append(" and vtestplan_C like  '%"+planC+"%'");
		}
		if(planE !=null&&!"".equals(planE)){
			str.append(" and vtestplan_E like  '%"+planE+"%'");
		}
		if(cnas !=null&&!"".equals(cnas)){
			str.append(" and vcnastatus='"+cnas+"'");
		}
		String sql = "SELECT vrid,vtestchild,vtestparent,vdescribe FROM t_chem_flow where 1=1 "+str;
		//System.out.println(sql);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Flow> list = new ArrayList<Flow>();
		
		
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Flow flow = new Flow();
				flow.setRid(rs.getString("vrid"));
				flow.setTestparent(rs.getString("vtestparent"));
				flow.setTestchild(rs.getString("vtestchild"));
				flow.setDescribe(rs.getString("vdescribe"));
				list.add(flow);
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
}
