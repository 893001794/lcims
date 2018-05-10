package com.lccert.crm.client;

import java.sql.Connection;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import com.lccert.crm.chemistry.util.DB;
/**
 * 客户项目跟进管理类（包括service层和dao层）
 * @author Eason
 *
 */
public class ClientProjectAction {
	
	private static ClientProjectAction instance = null;

	private ClientProjectAction() {

	}

	public synchronized static ClientProjectAction getInstance() {
		if (instance == null) {
			instance = new ClientProjectAction();
		}
		return instance;
	}
	/**
	 * 添加报价单
	 * @param order
	 * @return
	 */
	public synchronized int addClientProject(ClientProjectForm clientProject) {
		//跟进客户名称查询客户id
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		int isok = 0;
		String sql = "insert into t_client_project(clientid,clientname,type,procure,projectround,projectamount,sort,createtime)"
				+ " values(?,?,?,?,?,?,?,now())";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql,Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1,Integer.parseInt(clientProject.getClientId()));
			pstmt.setString(2,clientProject.getClientName());
			pstmt.setString(3,clientProject.getType());
			pstmt.setString(4,clientProject.getProcure());
			pstmt.setString(5,clientProject.getProjectRound());
			pstmt.setFloat(6,clientProject.getProjectAmount());
			pstmt.setString(7, clientProject.getSort());
//			pstmt.setTimestamp(6, new Timestamp(order.getCompletetime().getTime()));
			pstmt.executeUpdate();
			rs = pstmt.getGeneratedKeys();
			rs.next();
			int key = rs.getInt(1);
			List<ClientRivalForm> list = clientProject.getClientRivalList();
			sql = "insert into t_client_rival(clientid,clientname,name,rank,advantage,inferior,chance,methods,period,createtime) values(?,?,?,?,?,?,?,?,?,now())";
			pstmt = DB.prepareStatement(conn, sql);
			for(int i=0;i<list.size();i++) {
				ClientRivalForm clientRival = list.get(i);
				pstmt.setInt(1, Integer.parseInt(clientProject.getClientId()));
				pstmt.setString(2, clientProject.getClientName());
				pstmt.setString(3, clientRival.getName());
				pstmt.setString(4, clientRival.getRank());
				pstmt.setString(5, clientRival.getAdvantage());
				pstmt.setString(6, clientRival.getInferior());
				pstmt.setString(7, clientRival.getChance());
				pstmt.setString(8, clientRival.getMethods());
				pstmt.setString(9,clientRival.getPeriod());
				pstmt.addBatch();
			}
			pstmt.executeBatch();
			conn.commit();
			List<ClientStatusForm> clientStatusList= clientProject.getClientStatusList();
			sql = "insert into t_client_status(clientid,clientname,followupdate,statuscas,remark,register,createtime) values(?,?,?,?,?,?,now())";
			pstmt = DB.prepareStatement(conn, sql);
			for(int i=0;i<clientStatusList.size();i++) {
				ClientStatusForm clientStatus = clientStatusList.get(i);
				pstmt.setInt(1, Integer.parseInt(clientProject.getClientId()));
				pstmt.setString(2, clientProject.getClientName());
//				System.out.println(quoitem.getItem().getId()+"---");
				pstmt.setTimestamp(3, new Timestamp(clientStatus.getFollowUpdate().getTime()));
				pstmt.setString(4, clientStatus.getStatusCas());
				pstmt.setString(5, clientStatus.getRemark());
				pstmt.setString(6, clientStatus.getRegister());
				pstmt.addBatch();
			}
			pstmt.executeBatch();
			conn.commit();
			isok = key;
		} catch (SQLException e) {
			isok = 0;
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
	 * @param order
	 * @return
	 */
	public synchronized int modifyClientProject(ClientProjectForm clientProject) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		int isok = 0;
		String sql = "update t_client_project set type=?,procure=?,projectround=?,projectamount=?,sort=? where id=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1,clientProject.getType());
			pstmt.setString(2,clientProject.getProcure());
			pstmt.setString(3,clientProject.getProjectRound());
			pstmt.setFloat(4,clientProject.getProjectAmount());
			pstmt.setString(5, clientProject.getSort());
			pstmt.setInt(6, clientProject.getId());
			pstmt.executeUpdate();
			List<ClientRivalForm> list = clientProject.getClientRivalList();
			for(int i=0;i<list.size();i++) {
				ClientRivalForm clientRival = list.get(i);
				if(clientRival.getId()==null ||clientRival.getId()==0) {
					sql = "insert into t_client_rival(clientid,clientname,name,rank,advantage,inferior,chance,methods,period,createtime) values(?,?,?,?,?,?,?,?,?,now())";
				} else {
					sql = "update t_client_rival set clientid=?,clientname=?,name=?,rank=?,advantage=?,inferior=?,chance=?,methods=?,period=? where id=" + clientRival.getId();
				}
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setInt(1, Integer.parseInt(clientProject.getClientId()));
				pstmt.setString(2, clientProject.getClientName());
				pstmt.setString(3, clientRival.getName());
				pstmt.setString(4, clientRival.getRank());
				pstmt.setString(5, clientRival.getAdvantage());
				pstmt.setString(6, clientRival.getInferior());
				pstmt.setString(7, clientRival.getChance());
				pstmt.setString(8, clientRival.getMethods());
				pstmt.setString(9,clientRival.getPeriod());
				pstmt.executeUpdate();
			}
			
			List<ClientStatusForm> clientStatusList= clientProject.getClientStatusList();
			for(int i=0;i<clientStatusList.size();i++) {
				ClientStatusForm clientStatus=clientStatusList.get(i);
				if(clientStatus.getId()==null ||clientStatus.getId()==0) {
					sql = "insert into t_client_status(clientid,clientname,followupdate,statuscas,remark,register,createtime) values(?,?,?,?,?,?,now())";
				} else {
					sql = "update t_client_status set clientid=?,clientname=?,followupdate=?,statuscas=?,remark=?,register=? where id=" + clientStatus.getId();
				}
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setInt(1, Integer.parseInt(clientProject.getClientId()));
				pstmt.setString(2, clientProject.getClientName());
				pstmt.setTimestamp(3, new Timestamp(clientStatus.getFollowUpdate().getTime()));
				pstmt.setString(4, clientStatus.getStatusCas());
				pstmt.setString(5, clientStatus.getRemark());
				pstmt.setString(6, clientStatus.getRegister());
				pstmt.executeUpdate();
			}
			conn.commit();
			isok = 1;
		} catch (SQLException e) {
			isok = 0;
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
	 * 根据客户Id查询
	 * @param orderid
	 * @return
	 */
	public ClientProjectForm findClientProject(int clientId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		ClientProjectForm clientProject = new ClientProjectForm();
		String sql = "select * from t_client_project where clientid = ? order by id desc";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, clientId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				clientProject.setId(rs.getInt("id"));
				clientProject.setClientId(rs.getString("clientid"));
				clientProject.setClientName(rs.getString("clientname"));
				clientProject.setProcure(rs.getString("procure"));
				clientProject.setProjectRound(rs.getString("projectround"));
				clientProject.setType(rs.getString("type"));
				clientProject.setProjectAmount(rs.getFloat("projectamount"));
				clientProject.setSort(rs.getString("sort"));
				clientProject.setClientRivalList(findClientRivals(Integer.parseInt(clientProject.getClientId())));
				clientProject.setClientStatusList(findClientStatuss(Integer.parseInt(clientProject.getClientId())));
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
		return clientProject;
	}
	/**
	 * 根据客户Id查询竞争对手表
	 * @param clientId
	 * @return
	 */
	public List<ClientRivalForm> findClientRivals(int clientId){
		List<ClientRivalForm> clientRivalList=new ArrayList<ClientRivalForm>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String sql = "select * from t_client_rival where clientid = ? order by id";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, clientId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ClientRivalForm clientRival = new ClientRivalForm();
				clientRival.setId(rs.getInt("id"));
				clientRival.setClientId(rs.getString("clientid"));
				clientRival.setClientName(rs.getString("clientname"));
				clientRival.setName(rs.getString("name"));
				clientRival.setRank(rs.getString("rank"));
				clientRival.setAdvantage(rs.getString("advantage"));
				clientRival.setInferior(rs.getString("inferior"));
				clientRival.setChance(rs.getString("chance"));
				clientRival.setMethods(rs.getString("methods"));
				clientRival.setPeriod(rs.getString("period"));
				clientRivalList.add(clientRival);
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
		return clientRivalList;
	}
	/**
	 * 根据客户Id查询客户跟进表
	 * @param clientId
	 * @return
	 */
	public List<ClientStatusForm> findClientStatuss(int clientId){
		List<ClientStatusForm> clientStatusList=new ArrayList<ClientStatusForm>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String sql = "select * from t_client_status where clientid = ? order by id";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, clientId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ClientStatusForm clientStatus = new ClientStatusForm();
				clientStatus.setId(rs.getInt("id"));
				clientStatus.setClientId(rs.getString("clientid"));
				clientStatus.setClientName(rs.getString("clientname"));
				clientStatus.setFollowUpdate(rs.getTimestamp("followupdate"));
				clientStatus.setStatusCas(rs.getString("statuscas"));
				clientStatus.setRemark(rs.getString("remark")); 
				clientStatus.setRegister(rs.getString("register"));
				clientStatusList.add(clientStatus);
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
		return clientStatusList;
	}
}
