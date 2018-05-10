package com.lccert.oa.db;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import com.lccert.oa.vo.OaVacationType;


/***
 *mysql ����192.168.0.2�����ݿ⹤��
 * @author tangzp
 *
 */
public class ConnectionToDB {
	private static final String DRIVERCLASS = "com.mysql.jdbc.Driver";



	private static final ThreadLocal threadLocal = new ThreadLocal();

	ResultSet rs;

	PreparedStatement pstmt;

	Connection con;

	public Connection getConnection() {
		con = (Connection) threadLocal.get();
		try {
			Class.forName(DRIVERCLASS);
		} catch (Exception e1) {
			e1.printStackTrace();
		} 

		try {
			con = DriverManager.getConnection("jdbc:mysql://192.168.0.2:3336/td_oa?useUnicode=true&characterEncoding=GBK","root","tomcat");
//			 System.out.print("�������ݿ�ɹ�");
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return con;
	}

	// ���ص�����¼
	public Vector getSingle(String sql, List temp) {
		Vector<Object> single = new Vector<Object>();
		try {
			pstmt = getConnection().prepareStatement(sql);
			if (temp != null) {
				for (int i = 0; i < temp.size(); i++) {
					pstmt.setObject(i + 1, temp.get(i));
				}
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				single.addElement(rs.getObject(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return single;
	}

	// ����Ӱ������У�����ɾ����
	public int getCount(String sql, List temp) {
		int count = 0;
		try {
			pstmt = getConnection().prepareStatement(sql);
			if (temp != null) {
				for (int i = 0; i < temp.size(); i++) {
					pstmt.setObject(i + 1, temp.get(i));

				}
			}
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}

	// ����ĳһ�еļ�¼
	public Vector getColumn(String sql, List temp) {
		Vector<Object> column = new Vector<Object>();
		try {
			pstmt = getConnection().prepareStatement(sql);
			if (temp != null) {
				for (int i = 0; i < temp.size(); i++) {
					pstmt.setObject(i + 1, temp.get(i));
				}
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				column.addElement(rs.getObject(1));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return column;
	}

	// ���ر�����ʹ�õ�rows,Ӧ������ʾ����
	public Vector getRows(String sql, List temp) {
		Vector<Vector<Object>> vector = new Vector<Vector<Object>>();
		try {
			pstmt = getConnection().prepareStatement(sql);
			if (temp != null) {

				for (int i = 0; i < temp.size(); i++) {
					pstmt.setObject(i + 1, temp.get(i));
				}
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Vector<Object> v = new Vector<Object>();
				for (int j = 0; j < rs.getMetaData().getColumnCount(); j++) {
					v.addElement(rs.getObject(j + 1));
				}
				vector.addElement(v);
			}

		} catch (SQLException e) {

			e.printStackTrace();
		}
		return vector;
	}

	// ��Ĺ�������
	public ResultSet getResult(List temp, String sql) {
		try {
			con = getConnection();// �������ݿ�
			pstmt = con.prepareStatement(sql);
//			System.out.println(sql);
			// �ж�temp�Ƿ�������
			if (temp != null) {
				for (int i = 0; i < temp.size(); i++) {
					pstmt.setObject(i+1, rs.getObject(temp.get(i).toString()));
				}
			}
			// ִ��
			rs = pstmt.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}
	
	
//	//��ѯoa(sql server2000)t_user���е�username��passwordֵ
	public List<?> getInfor(List temp,String sql ) {
		        List row = new ArrayList();
		        List column =null;
		        try {
		            con = getConnection();
		            pstmt=con.prepareStatement(sql);
		            rs=pstmt.executeQuery();
		            while(rs.next()){
		            	column=new ArrayList();
		            	for(int i=0;i<temp.size();i++){
		            		column.add(rs.getString(temp.get(i).toString()));
		            	}
		            	row.add(column);
		            }
		        } catch (Exception ex) {
		           System.out.println("������Ϣ�����������");
		        } finally{
		            try{
		            	closeAll();
		            }catch(Exception e){}
		        }
		        return row;
	}
//	
//	

	// ʹ��statement ���д���SQL���
	public Vector getRowByStmt(String sql) {
		Vector<Vector<Object>> vector = new Vector<Vector<Object>>();
		Statement stmt = null;
		try {
			stmt = getConnection().createStatement();

			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				Vector<Object> v = new Vector<Object>();
				for (int j = 0; j < rs.getMetaData().getColumnCount(); j++) {
					v.addElement(rs.getObject(j + 1));
				}
				vector.addElement(v);
			}
		} catch (SQLException e) {

			e.printStackTrace();
		} 
		return vector;
	}

	// �رչ�������
	public void closeAll() {
		try {
			if (rs != null) {
				rs.close();
				rs = null;
			}
			if (pstmt != null) {
				pstmt.close();
				pstmt = null;
			}
			if (con != null) {
				con.close();
				con = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	* �������������Ĵ洢����
	*/
	public  List callResult(){
	getConnection();
	CallableStatement cs = null;
	ResultSet rs =  null;
	List list =new ArrayList();
	OaVacationType ovt=null;
	try {
	 cs = con.prepareCall("{call attend1()}");
//	 cs = con.prepareCall("{call attend(?,?,?)}");
//	 cs.setInt(1, 6);
//	 cs.setInt(2, 2011);
//	 cs.setInt(3, 109);
	 rs = cs.executeQuery();
	 //ѭ��������
	 while(rs.next()){
	  ovt=new OaVacationType();
	  ovt.setBegin_user(rs.getString("begin_user"));
	  ovt.setData_1(rs.getString("data_1"));
	  ovt.setData_3(rs.getString("data_3"));
	  ovt.setData_11(rs.getString("data_11"));
	  ovt.setData_5(rs.getString("data_5"));
	  ovt.setData_6(rs.getString("data_6"));
	  ovt.setData_111(rs.getString("data_12"));
	  ovt.setData_112(rs.getString("data_13"));
	  ovt.setData_7(rs.getString("data_7"));
	  ovt.setData_8(rs.getString("data_8"));
	  list.add(ovt);
	 }
	} catch (Exception e) {
	 e.printStackTrace();
	} finally {
	 try {
	  if(rs != null){
	   rs.close();
	  }
	  if(cs != null){
	   cs.close();
	  }
	  if(con != null){
	   con.close();
	  }
	 } catch (Exception ex) {
	  ex.printStackTrace();
	 }
	}
	return list;
	}

	

	
	
}