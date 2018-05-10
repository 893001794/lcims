package com.lccert.crm.chemistry.barcode;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.jspsmart.upload.Request;
import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.flow.Flow;
import com.lccert.crm.project.ChemLabTime;
import com.lccert.crm.project.ChemProjectAction;
import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.quotation.QuotationAction;
import com.lccert.www.HttpRequest;
import com.lccert.www.UpdateWebSite;

/**
 * ��ѧ��Ŀ�����������
 * ��Ҫ�����ڹ����������¼����Ϣ
 * @author eason
 * 
 */
public class BarCodeAction {

	private static BarCodeAction instance = null;

	private BarCodeAction() {

	}

	public synchronized static BarCodeAction getInstance() {
		if (instance == null) {
			instance = new BarCodeAction();
		}
		return instance;
	}

	/**
	 * ������ת����fid������ת��
	 * 
	 * @param fid
	 * @return
	 */
	public Flow getFlowByFid(String keywords) {
		
		String sql = "select * from t_chem_flow where vfid like '%" + keywords
				+ "%'";
		System.out.println(sql);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Flow flow = null;

		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				flow = new Flow();
				flow.setFid(rs.getString("vfid"));
				flow.setPid(rs.getString("vpid"));
				flow.setRid(rs.getString("vrid"));
				flow.setFlowtype(rs.getString("eflowtype"));
				flow.setLab(rs.getString("vlab"));
				flow.setPduser(rs.getString("vpduser"));
				flow.setPdtime(rs.getTimestamp("dpdtime"));
				flow.setTestparent(rs.getString("vtestparent"));
				flow.setTestchild(rs.getString("vtestchild"));
				flow.setTestcount(rs.getInt("itestcount"));
				flow.setRetest(rs.getString("eretest"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return flow;
	}

	
	
	public boolean updateTime(String type, String rid, String vsid, String fid, int status,String tableName) {
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
		if ("dendtime".equals(type)) {
			sql = "update "+tableName+" set " + type
					+ " = now(),eprojectend='y' where vsid = ?";
		} else if ("dsendtime".equals(type)) {
			sql = "update "+tableName+" set " + type
					+ " = now() where vsid = ?";
		} else {
			sql = "insert into t_chem_project_time(vfid,vrid,vsid,vstatus,dtime) values('"
					+ fid + "','" + rid + "',?,'" + type + "',now())";
		}
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, vsid);
			pstmt.executeUpdate();
			sql = "select * from t_project where vrid = ? order by dbuildtime desc";
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, rid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				id = rs.getInt("id");
				sid = rs.getString("vsid");
				pid = rs.getString("vpid");
			}
			if (status != 0) {
				sql = "update t_chem_flow set status = ? where vfid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setInt(1, status);
				pstmt.setString(2, fid);
				pstmt.executeUpdate();
			}
			if ("�ز��л��Ʊ���ʼʱ��".equals(type) || "�ز��޻��Ʊ���ʼʱ��".equals(type)
					|| "�ز�ʳƷ�Ʊ���ʼʱ��".equals(type)) {
				sql = "update "+tableName+" set estatus = '�ز�',istatus = 6 where vrid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, rid);
				pstmt.executeUpdate();
				ChemProjectAction.getInstance().sendProjectStatus(sid);
			}
			if ("�л��Ʊ���ʼʱ��".equals(type) || "�޻��Ʊ���ʼʱ��".equals(type)
					|| "ʳƷ�Ʊ���ʼʱ��".equals(type)) {
				sql = "update "+tableName+" set estatus = '����',istatus = 4 where vrid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, rid);
				pstmt.executeUpdate();
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

			if ("�޻��������ʱ��".equals(type) || "�ز��޻��������ʱ��".equals(type)
					|| "�ز��л��������ʱ��".equals(type) || "�л��������ʱ��".equals(type)
					|| "�ز�ʳƷ���������ʱ��".equals(type) || "ʳƷ���������ʱ��".equals(type)) {
				int flowcount = 0;//��ת������
				int finishcount = 0;//��ת��ʵ���������������
				sql = "select count(*) from t_chem_flow where vsid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, sid);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					flowcount = rs.getInt(1);
				}
				String s = "select count(*) from t_chem_project_time where vsid = ? and vstatus like '%�������ʱ��%'";
				pstmt = DB.prepareStatement(conn, s);
				pstmt.setString(1, sid);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					finishcount = rs.getInt(1);
				}
				if(flowcount != 0 && finishcount !=0 && flowcount == finishcount) {
					sql = "update "+tableName+" set estatus = '�������',istatus = 5 where vrid = ?";
					pstmt = DB.prepareStatement(conn, sql);
					pstmt.setString(1, rid);
					pstmt.executeUpdate();
				//	ChemProjectAction.getInstance().sendLabLateProject(sid,date);
				}
			}
			if("����������".equals(type)){
				sql = "update  t_project_chem_test set isfinish='y' where vrid =?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, rid);
				pstmt.executeUpdate();
			}
			if ("dendtime".equals(type)) {
				sql = "update "+tableName+" set estatus = '�᰸',istatus = 9,isfinish = 'y' where vrid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, rid);
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

			if ("dendtime".equals(type) || "dsendtime".equals(type)) {
				sql = "update t_chem_flow set status = 4 where vsid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, sid);
				pstmt.executeUpdate();
				sql = "update t_project set eprojectend = 'y' where vsid = ?";
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, sid);
				pstmt.executeUpdate();
				Quotation q=QuotationAction.getInstance().getQuotationByPid(pid);
				if(q.getFinish() == null){
					sql = "update t_quotation set dfinish=now() where vpid = ?";
				}
				pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1, pid);
				pstmt.executeUpdate();
			}
			if ("dsendtime".equals(type)) {
				sql = "update "+tableName+" set estatus = '��֤',istatus = 10,isfinish = 'y' where vrid = ?";
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

	
	public void getUpdateStatus(String type,String vsid ){
	
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null ;
		boolean auto=false;
		
		conn = DB.getConn();
		try {
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
		
			if("�޻��Ʊ���ʼʱ��".equals(type)){
				sql = "update t_project set Vstatus='A1' where vsid = ?";
			}
			else if("�޻�ǰ����ʼʱ��".equals(type)){
				sql = "update t_project set Vstatus='A2' where vsid = ?";
			}
			else if("�޻��ϻ���ʼʱ��".equals(type)){
				sql = "update t_project set Vstatus='A3' where vsid = ?";
			}
			else if("�޻��������ʱ��".equals(type)){
				sql = "update t_project set Vstatus='A4' where vsid = ?";
			}
			else if("�л��Ʊ���ʼʱ��".equals(type)){
				sql = "update t_project set Vstatus='B1' where vsid = ?";
			}
			else if("�л�ǰ����ʼʱ��".equals(type)){
				sql = "update t_project set Vstatus='B2' where vsid = ?";
			}
			else if("gcms1�л��ϻ���ʼʱ��".equals(type)){
				sql = "update t_project set Vstatus='B3G1' where vsid = ?";
			}
			else if("gcms2�л��ϻ���ʼʱ��".equals(type)){
				sql = "update t_project set Vstatus='B3G2' where vsid = ?";
			}
			else if("�л��������ʱ��".equals(type)){
				sql = "update t_project set Vstatus='B4' where vsid = ?";
			}else if("��ݸ�������ʱ��".equals(type)){
				sql = "update t_project set Vstatus='B10' where vsid = ?";
			}
			pstmt = DB.prepareStatement(conn, sql);
				pstmt.setString(1,vsid);
				pstmt.executeUpdate();
				conn.commit();
		} catch (SQLException e) {
		
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	/**
	 * ���Ļ�ѧ��Ŀ�ı���Ӧ��ʱ��(������ͣ����)
	 * @param 2010-9-8
	 * @param rptime
	 * @param vrid
	 */
	public boolean getUpdateRptime(String  prtime ,String sid){
		Date rptime1 = null;
		if(prtime != null && !"".equals(prtime)) {
			try {
				rptime1= new SimpleDateFormat("yyy-MM-dd HH:mm").parse(prtime);
			} catch (ParseException e) {
				
			}
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null ;
		boolean auto=false;
		conn = DB.getConn();
		try {
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			if(prtime == null){
				//System.out.println("����ʱ��Ϊ�յ�sql");
				sql = "update t_chem_project set drptime=null,vstart='��ͣ' where vsid =?";
			 }
			if(prtime !=null ){
				//System.out.println("----------------------------�� Ҫ��������ô��������������������������������"+rptime1);
				sql = "update t_chem_project set drptime='"+prtime+"',vstart='��ʼ' where vsid =?";
			}
			//System.out.println("sql:"+sql);
			pstmt = DB.prepareStatement(conn, sql);
			//System.out.println(sql+"---"+sid);
			pstmt.setString(1, sid);
			int i=pstmt.executeUpdate();
			if(i>0){
				auto =true;
			}
			conn.commit();
		} catch (SQLException e) {
			System.out.println(e);
		}finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return auto;
	}

	/**
	 * �ж�ʵ����״̬�Ƿ�Ǽ�
	 * @param status ʵ����״̬
	 * @param list ����״̬�б�
	 * @return
	 */
	public boolean getstatus(String status, List<ChemLabTime> list) {
		boolean isok = false;
		for (int i = 0; i < list.size(); i++) {
			if (status.equals(list.get(i).getStatus())) {
				isok = true;
			}
		}
		return isok;
	}

	
}
