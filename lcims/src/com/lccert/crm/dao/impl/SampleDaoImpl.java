package com.lccert.crm.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.dao.SampleDao;
import com.lccert.crm.kis.Order;
import com.lccert.oa.db.ImsDB;
/**
 * ��Ʒ������ʵ����
 * @author Administrator
 *
 */
public class SampleDaoImpl implements SampleDao{
/**
 * ���Ӱ�����Ϣ
 */
	public int addSamplePackage(List list) {
		String sql ="insert into t_sample_package(vpno,vems,vpid,vsid,vpackageName,vclient,dreceipt,vreciptent,dcreatetime) values(?,?,?,?,?,?,?,?,now())";
		return new ImsDB().getCount(sql,list);
	}
	
	/***
	 * ��ѯ������Ϣ
	 */
	public List getSamplePackage(List temp) {
		String sql ="select * from t_sample_package order by dcreatetime desc";
	//	System.out.println(sql);
		return new ImsDB().getInfor(temp, sql);
	}
	/**
	 * ������Ʒ״̬
	 */
	public int addSamplePackage1(List list) {
		String sql ="insert into t_sample_pursue(vsno,doutdatetime,tpplication,estatus) values(?,?,?,?)";
		return new ImsDB().getCount(sql,list);
	}
	
/**
 * ������Ʒ��Ϣ
 */
	public int addSample(List list) {
		int cont=0;
		List temp =new ArrayList();
		try {
			String sql ="insert into t_sample(vsno,vsid,vsampleName,vmodel,vspeichorot,voperator,dcreatetime) values(?,?,?,?,?,?,now())";
			cont= new ImsDB().getCount(sql,list);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cont;
	}
	/**
	 * ������Ʒ�������Ϣ
	 */

	public int addSamplePursue(List list) {
		int cont=0;
//		List temp =new ArrayList();
		try {
			String sql ="insert into t_sample_pursue(vsno,vpno,dindatetime,voperator,vlabid,vlabname) values(?,?,now(),?)";
			cont= new ImsDB().getCount(sql,list);
//			temp.add(list.get(4));
//			//����ʵ����״̬
//			String updataLabsql ="update t_sample_lab set vstatus=1 where vlabname=?";
//			cont= new ImsDB().getCount(sql,temp);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cont;
	}
	
	/***
	 * ��ѯ��Ʒ��Ϣ
	 */
	public List getSample(List temp) {
		String sql ="select s.*,sp.vclient from t_sample_pursue as sp1,t_sample as s,t_sample_package as sp where s.vsno=sp1.vsno and sp1.vpno=sp.vpno order by dcreatetime desc limit 1,100";
		return new ImsDB().getInfor(temp, sql);
	}

	
	/***
	 * ����id�õ���Ʒ��Ϣ
	 */
	public List getSampleById(List list,int id){
		String sql ="select * from t_sample where id = ?";
		return new ImsDB().getInforByObject(list, sql,id);
	}
	
	
	/***
	 * ����id�õ���Ʒ��Ϣ
	 */
	public List getSampleById1(List list,int id){
		String sql ="select s.*,sp.vclient,sp.vems from t_sample as s,t_sample_package as sp,t_sample_pursue as sp1 where s.id = ? and s.vsno=sp1.vsno and sp1.vpno=sp.vpno";
		//System.out.println(sql);
		return new ImsDB().getInforByObject(list, sql,id);
	}
	/**
	 * ������Ʒ��Ϣ
	 *
	 */
	public int upSample(List list) {
		String sql ="update  t_sample set vsampleName=?,vmodel=?,vsid=?,vspeichorot=? where id =?";
		return new ImsDB().getCount(sql, list);
	}
	
	/***
	 * ���ݱ��۵��Ż�ȡ��Ʒ
	 */
	public List getSampleByPid(List list ,String pid,String sno,String client){
		StringBuffer str =new StringBuffer();
		if(pid !=null && !"".equals(pid)){
			str.append(" and s.vsid  like '%"+pid+"%'");
		}
		
		if(sno !=null && !"".equals(sno)){
			str.append(" and s.vsno  like '%"+sno+"%'");
		}
		if(client !=null && !"".equals(client)){
			str.append(" and sp.vclient  like '%"+client+"%'");
		}
		String sql ="select s.*,sp.vclient from t_sample as s,t_sample_package as sp,t_sample_pursue as sp1 where s.vsno=sp1.vsno and sp1.vpno=sp.vpno "+str;
//		System.out.println(sql);
		return new ImsDB().getInfor(list, sql);
	}
	/**
	 * ��ȡ��Ʒ���ٱ���Ϣ
	 */
	public List getSamplePurser(List list, String sno) {
		String sql ="select * from t_sample as s,t_sample_pursue as sp1 where sp1.vsno  = ? and  s.vsno=sp1.vsno";
		//System.out.println(sql);
		return new ImsDB().getInforByObject(list, sql,sno);
	}
	/**
	 * ���ݰ����Ų�ѯ���ݿ����Ƿ���ڴ˰���
	 */
	 
	public List getPackageNo(List list,String pno) {
		String sql="select * from t_sample_package where vpno like '%"+pno+"%'";
		//System.out.println(sql);
		return new ImsDB().getInfor(list, sql);
	}
	
	/***
	 * �������ƻ�ȡ�����ַ
	 */
	public List getEmailByName(List list ,String name) {
		String sql ="select  email from t_user where name like '%"+name+"%'";
		return new ImsDB().getInfor(list, sql);
	}
	
	
	
	
	/***
	 * ���ɰ����ŵķ���
	 */
	public String makePNo() {
		StringBuffer str = new StringBuffer();
		String last = "";
		str.append("P");
		
		Date date = new Date();
		String date1 = new SimpleDateFormat("yyMMdd").format(date);
		String key = str.toString() + date1;
		str.append(date1);
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String sql = "select * from t_sample_package where vpno like '%" + key + "%'" +
				" order by substring(vpno,8,11) desc";
		
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String sub = rs.getString("vpno");
				System.out.println(sub);
				int code = Integer.parseInt(sub.substring(8, sub.length()));
				code += 1;
				last = new DecimalFormat("000").format(code);
			} else {
				last = "001";
			}
			System.out.println(last);
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
	 * ������Ʒ������Ϣ
	 *
	 */
	public int upOutBound(List list) {
		int cont=0;
//		List temp =new ArrayList();
		try {
			String sql ="update  t_sample_pursue set doutdatetime=?,tpplication=? where vsno=?";
			cont= new ImsDB().getCount(sql, list);
//			temp.add(list.get(2));
//			//����ʵ����״̬
//			String updataLabsql ="update t_sample_lab set vstatus=0 where vlabname=?";
//			cont= new ImsDB().getCount(sql,temp);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cont;
	}
/**
 * �õ���Ʒ���
 */
	public List getSampleSno(String sno) {
		List list =new ArrayList();
		list.add("vsno");
		String sql ="select vsno from t_sample where vsno like '%"+sno+"%'  order by substring(vsno,12) +0 desc limit 1";
		 return new ImsDB().getInfor(list, sql);
	}
/**
 * ��ȡһ���ֿ�����Ʒ
 */
public List getParentLab() {
	List list =new ArrayList();
	list.add("id");
	list.add("vlabname");
	String sql ="select id,vlabname from t_sample_lab where parentid =0";
	 return new ImsDB().getInfor(list, sql);
}
/**
 * ��ȡ�����ֿ�����Ʒ
 */
public List getChildLab(int parentId) {
	List list =new ArrayList();
	list.add("vlabname");
	String sql ="select vlabname from t_sample_lab where parentid !=0 and parentid="+parentId;
	//����ױƷ�ֿ�ʱ��ôֻ�п׿������ʾ����
//	if(parentId==43){
//		sql+=" and vstatus=1 ";
//	}
	 return new ImsDB().getInfor(list, sql);
}
 /**
  * ���ݰ���id��ȡ������Ϣ
  */
public List getPackageById(List list, int id) {
	String sql ="select * from t_sample_package where id = ?";
	return new ImsDB().getInforByObject(list, sql,id);
}
	
	
	

}
