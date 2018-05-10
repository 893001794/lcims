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
import com.lccert.crm.chemistry.util.PageModel;

/**
 * 客户销售跟进进度表
 * @author Administrator
 *
 */
public class ClientSalesStatusAction {
	private static ClientSalesStatusAction clientSalesStatusAction=new ClientSalesStatusAction();
	private ClientSalesStatusAction(){
		
	}
	public static ClientSalesStatusAction getInstance(){
		return  clientSalesStatusAction;
	}
	
	public ClientSalesStatusForm findByClientId(int clientId){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rsre = null;
		boolean auto = false;
		ClientSalesStatusForm clientSalesStatus = new ClientSalesStatusForm();
		String sql = "select c.clientid clientid ,c.name,cs.* from t_client c "
				+ " left join t_client_sales_status cs on c.clientid=cs.clientid " +
				" where cs.clientid = "+clientId;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				clientSalesStatus.setId(rs.getInt("id"));
				clientSalesStatus.setClientid(rs.getString("clientid"));
				clientSalesStatus.setClientName(rs.getString("name"));
				clientSalesStatus.setNature(rs.getString("nature"));
				clientSalesStatus.setBasicInfor(rs.getString("basicinfor"));
				clientSalesStatus.setRivalInfor(rs.getString("rivalinfor"));
				clientSalesStatus.setProcureFlow(rs.getString("procureflow"));
				clientSalesStatus.setProjectInfor(rs.getString("projectinfor"));
				clientSalesStatus.setInquirYstage(rs.getString("inquirystage"));
				clientSalesStatus.setSalesStrategy(rs.getString("salesstrategy"));
				clientSalesStatus.setTotalPrice(rs.getFloat("totalprice"));
				clientSalesStatus.setSignBackPrice(rs.getFloat("signbackprice"));
				clientSalesStatus.setSampleInfor(rs.getString("sampleinfor"));
				clientSalesStatus.setPartPayment(rs.getString("partpayment"));
				clientSalesStatus.setInvoice(rs.getString("invoice"));
				clientSalesStatus.setCertificate(rs.getString("certificate"));
				clientSalesStatus.setSatisFaction(rs.getString("satisfaction"));
				clientSalesStatus.setRemark(rs.getString("remark")==null?"":rs.getString("remark"));
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
		return clientSalesStatus;
	}
	/**
	 * 取得每个销售负责的客户信息跟进进度表
	 * 
	 * @param pageNo
	 * @param pageSize
	 * @param sales
	 * @return
	 */
	public PageModel getClientStatus(int pageNo, int pageSize, int salesid,String clientName) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rsre = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		String condition="";
		List<ClientSalesStatusForm> list = new ArrayList<ClientSalesStatusForm>();
		String sql = "select c.clientid clientid ,c.name,cs.* from t_client c "
				+ " left join t_client_sales_status cs on c.clientid=cs.clientid " +
				" where c.salesid = "+salesid;
			if(clientName !=null && !"".equals(clientName)){
				condition=" and c.name like '%"+clientName+"% ";
			}
			sql+= " limit " + (pageNo - 1) * pageSize + ", " + pageSize;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ClientSalesStatusForm clientSalesStatus = new ClientSalesStatusForm();
				clientSalesStatus.setClientid(rs.getString("clientid"));
				clientSalesStatus.setClientName(rs.getString("name"));
				clientSalesStatus.setNature(rs.getString("nature"));
				clientSalesStatus.setBasicInfor(rs.getString("basicinfor"));
				clientSalesStatus.setRivalInfor(rs.getString("rivalinfor"));
				clientSalesStatus.setProcureFlow(rs.getString("procureflow"));
				clientSalesStatus.setProjectInfor(rs.getString("projectinfor"));
				clientSalesStatus.setInquirYstage(rs.getString("inquirystage"));
				clientSalesStatus.setSalesStrategy(rs.getString("salesstrategy"));
				clientSalesStatus.setTotalPrice(rs.getFloat("totalprice"));
				clientSalesStatus.setSignBackPrice(rs.getFloat("signbackprice"));
				clientSalesStatus.setSampleInfor(rs.getString("sampleinfor"));
				clientSalesStatus.setPartPayment(rs.getString("partpayment"));
				clientSalesStatus.setInvoice(rs.getString("invoice"));
				clientSalesStatus.setCertificate(rs.getString("certificate"));
				clientSalesStatus.setSatisFaction(rs.getString("satisfaction"));
				clientSalesStatus.setClientType(rs.getString("clienttype"));
				clientSalesStatus.setRemark(rs.getString("remark"));
				list.add(clientSalesStatus);
			}
			int totalRecords = getTotalRecords(conn,"select count(*) from t_client c left join t_client_sales_status cs on c.clientid=cs.clientid where c.salesid = "+salesid+condition);
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
	 * 
	 * @param conn
	 *            connection
	 * @return 所有的记录数
	 */
	private int getTotalRecords(Connection conn,String sql) {
		//String sql = "select count(*) from t_client";
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
	 * 添加销售跟进客户总报表
	 * @param order
	 * @return
	 */
	public synchronized int addClientSalesStatus(ClientSalesStatusForm clientSalesStatus) {
		//跟进客户名称查询客户id
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		int isok = 0;
//		clientid,clientname,nature,basicinfor,rivalinfor,procureflow,projectinfor,inquirystage,salesstrategy,totalprice,signbackprice,sampleinfor,partpayment,invoice,certificate,satisfaction,remark
		String sql ="";
		if(clientSalesStatus.getId() !=null && !"".equals(clientSalesStatus)){
			sql="update t_client_sales_status set clientid=?,clientname=?,nature=?,basicinfor=?,rivalinfor=?,procureflow=?,projectinfor=?,inquirystage=?,salesstrategy=?,totalprice=?,signbackprice=?,sampleinfor=?,partpayment=?,invoice=?,certificate=?,satisfaction=?,remark=?,clientType=? where id="+clientSalesStatus.getId();
		}else{
			sql="insert into t_client_sales_status(clientid,clientname,nature,basicinfor,rivalinfor,procureflow,projectinfor," +
				"inquirystage,salesstrategy," +
				"totalprice,signbackprice,sampleinfor,partpayment,invoice,certificate,satisfaction,remark,clientType,createtime)"
				+ " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now())";
		}
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql,Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1,Integer.parseInt(clientSalesStatus.getClientid()));
			pstmt.setString(2,clientSalesStatus.getClientName());
			pstmt.setString(3,clientSalesStatus.getNature());
			pstmt.setString(4,clientSalesStatus.getBasicInfor());
			pstmt.setString(5,clientSalesStatus.getRivalInfor());
			pstmt.setString(6,clientSalesStatus.getProcureFlow());
			pstmt.setString(7,clientSalesStatus.getProjectInfor());
			pstmt.setString(8,clientSalesStatus.getInquirYstage());
			pstmt.setString(9,clientSalesStatus.getSalesStrategy());
			pstmt.setFloat(10,clientSalesStatus.getTotalPrice());
			pstmt.setFloat(11,clientSalesStatus.getSignBackPrice());
			pstmt.setString(12,clientSalesStatus.getSampleInfor());
			pstmt.setString(13,clientSalesStatus.getPartPayment());
			pstmt.setString(14,clientSalesStatus.getInvoice());
			pstmt.setString(15,clientSalesStatus.getCertificate());
			pstmt.setString(16,clientSalesStatus.getSatisFaction());
			pstmt.setString(17,clientSalesStatus.getRemark());
			pstmt.setString(18, clientSalesStatus.getClientType());

//			pstmt.setTimestamp(6, new Timestamp(order.getCompletetime().getTime()));
			pstmt.executeUpdate();
			rs = pstmt.getGeneratedKeys();
			rs.next();
			int key = clientSalesStatus.getId()!=null?clientSalesStatus.getId():rs.getInt(1);
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
}
