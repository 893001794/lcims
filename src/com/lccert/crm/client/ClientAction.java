package com.lccert.crm.client;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.apache.poi.util.StringUtil;

import com.lccert.crm.chemistry.email.Email;
import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.chemistry.util.PageModel;
import com.lccert.crm.chemistry.util.SendMail;
import com.lccert.crm.user.UserAction;
import com.lccert.crm.user.UserForm;
import com.lccert.www.UpdateWebSite;

/**
 * �ͻ���Ϣ�����ࣨ����Service���dao�㣩
 * 
 * @author eason
 * 
 */
public class ClientAction {

	private static ClientAction instance = new ClientAction();

	private ClientAction() {
	}

	public static ClientAction getInstance() {
		return instance;
	}

	/**
	 * ����clientid���ҿͻ�
	 * 
	 * @param clientid
	 * @return boolean
	 */
	public boolean findClientById(String clientid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "select * from t_client where client = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, clientid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				isok = true;
			}
			conn.commit();
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
	 * ����name���ҿͻ�
	 * 
	 * @param clientid
	 * @return boolean
	 */
	public boolean findClientByName(String name) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "select * from t_client where name = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				isok = true;
			}
			conn.commit();
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
	 * ����name���ҿͻ�
	 * 
	 * @param clientid
	 * @return boolean
	 */
	public ClientForm findById(String clientid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = false;
		ClientForm client=new ClientForm();
		String sql = "select * from t_client where clientid = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, clientid);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				client.setId(rs.getInt("id"));
				client.setClientid(rs.getString("clientid"));
				client.setName(rs.getString("name"));
			}
			conn.commit();
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
		return client;
	}
	/**
	 * ����name���ҿͻ�
	 * 
	 * @param clientid
	 * @return boolean
	 */
	public ClientForm findByName(String name,String shortname) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = false;
		ClientForm client=null;
		String sql = "select * from t_client where name = ?";
		if(shortname !=null &&!"".equals(shortname.trim())){
			sql+=" or shortname='"+shortname+"'";
		}
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				client=new ClientForm();
				
				
				client.setId(rs.getInt("id"));
				client.setClientid(rs.getString("clientid"));
				client.setName(rs.getString("name"));
				//��������Id��ѯ��������
				UserForm user=UserAction.getInstance().getUserById(Integer.parseInt(rs.getString("salesid")));
				if(user !=null){
					client.setSales(user.getName());
				}
			}
			conn.commit();
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
		return client;
	}
	/**
	 * ��������name����Ӣ����
	 * 
	 * @param clientid
	 * @return boolean
	 */
	public String findClientEByName(String name) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String clientE="";
		String sql = "select ename from t_client where name = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				clientE=rs.getString("ename");
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
		return clientE;
	}

	/**
	 * ����¿ͻ�
	 * 
	 * @param client
	 * @return
	 */
	public boolean addClient(ClientForm client) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = true;
		int key = 0;
		
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			String sql1 = "insert into t_client_contact(clientid,contact,tel,fax,email,sex,mobile,qq,dept,job,purchase,level,degree,visitnum,time) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,now())";
			pstmt = DB.prepareStatement(conn, sql1,Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, client.getClientid());
			pstmt.setString(2, client.getContact().getContact());
			pstmt.setString(3, client.getContact().getTel());
			pstmt.setString(4, client.getContact().getFax());
			pstmt.setString(5, client.getContact().getEmail());
			pstmt.setString(6, client.getContact().getSex());
			pstmt.setString(7, client.getContact().getMobile());
			pstmt.setString(8, client.getContact().getQq());
			pstmt.setString(9, client.getContact().getDept());
			pstmt.setString(10, client.getContact().getJob());
			//System.out.println(client.getContact().getPurchase()+"------"+client.getContact().getLevel()+"******"+client.getContact().getDegree()+"------*****"+client.getContact().getVisitnum());
			pstmt.setString(11, client.getContact().getPurchase()==null?"":client.getContact().getPurchase());
			pstmt.setString(12, client.getContact().getLevel()==null?"":client.getContact().getLevel());
			pstmt.setString(13, client.getContact().getDegree()==null?"":client.getContact().getDegree());
			pstmt.setInt(14, client.getContact().getVisitnum()==null?0:client.getContact().getVisitnum());
			pstmt.executeUpdate();
			
			rs = pstmt.getGeneratedKeys();
			if(rs.next()) {
				key = rs.getInt(1);
			}
			String sql = "insert into t_client(clientid,name,ename,addr,eaddr,product,"
				+ "clevel,creditlevel,pay,area,salesid,zipcode,shortname,contactid,password,createtime) values"
				+ "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now())";
			
			pstmt = DB.prepareStatement(conn, sql,Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, client.getClientid());
			pstmt.setString(2, client.getName());
			pstmt.setString(3, client.getEname());
			pstmt.setString(4, client.getAddr());
			pstmt.setString(5, client.getEaddr());
			pstmt.setString(6, client.getProduct());
			pstmt.setString(7, client.getClevel());
			pstmt.setString(8, client.getCreditlevel());
			pstmt.setString(9, client.getPay());
			pstmt.setString(10, client.getArea());
			pstmt.setInt(11, client.getSalesid());
			pstmt.setString(12, client.getZipcode());
			pstmt.setString(13, client.getShortname());
			pstmt.setInt(14, key);
			pstmt.setString(15, createRandomString(8));

			pstmt.executeUpdate();
//			���ͻ��������ַ�Զ���ӵ�t_mail������
//			String sql2 ="insert into t_mail(email) values (?)";
//			pstmt = DB.prepareStatement(conn,sql2,Statement.RETURN_GENERATED_KEYS);
//			pstmt.setString(1, client.getContact().getEmail());
//			pstmt.executeUpdate();
			conn.commit();
			//������վ����
			rs = pstmt.getGeneratedKeys();
			if(rs.next()) {
				key = rs.getInt(1);
			}
			UpdateWebSite up = new UpdateWebSite();
			up.setId(key);
			up.setType("client");
			Thread t = new Thread(up);
			t.start();
			  
			//���ʼ�
		//	sendwarning(up);
			
			
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
	
	
//	public synchronized void sendwarning(UpdateWebSite up){
//		Email email = new Email();
//		List<String> to = new ArrayList<String>();
//		to.add("tangzp@lccert.com");
//		String head = up.getId()+":up.setId";
//		String content = up.getType()+"��up.getType";
//		email.setTo(to);
//		email.setHead(head);
//		email.setContent(content);
//		SendMail send = new SendMail();
//		send.setEmail(email);
//		Thread t1 = new Thread(send);
//		t1.start();
//	}
	/**
	 * �����������
	 * @param length
	 * @return
	 */
	private String createRandomString(int length) {
		Random random = new Random();
		char ch[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8',
	            '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L',
	            'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y',
	            'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
	            'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y',
	            'z', '0', '1' };//������ظ�����0��1����Ϊ��Ҫ�������鳤��Ϊ64

        if (length > 0) {
            int index = 0;
            char[] temp = new char[length];
            int num = random.nextInt();
            for (int i = 0; i < length % 5; i++) {
                temp[index++] = ch[num & 63];//ȡ������λ���ǵö�Ӧ�Ķ��������Բ�����ʽ���ڵġ�
                num >>= 6;//63�Ķ�����Ϊ:111111
                // ΪʲôҪ����6λ����Ϊ��������һ����64����Ч�ַ���ΪʲôҪ��5ȡ�ࣿ��Ϊһ��int��Ҫ��4���ֽڱ�ʾ��Ҳ����32λ��
            }
            for (int i = 0; i < length / 5; i++) {
                num = random.nextInt();
                for (int j = 0; j < 5; j++) {
                    temp[index++] = ch[num & 63];
                    num >>= 6;
                }
            }
            return new String(temp, 0, length);
        } else if (length == 0) {
            return "";
        } else {
            throw new IllegalArgumentException();
        }
    }

	/**
	 * �����ϵ��
	 * 
	 * @param client
	 * @return
	 */
	public boolean addContact(String clientid, ContactForm contact) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql1 = "insert into t_client_contact(clientid,contact,tel,fax,email,sex,mobile,qq,notes,dept,job,purchase,level,degree,visitnum,time) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now())";

		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql1);
			pstmt.setString(1, clientid);
			pstmt.setString(2, contact.getContact());
			pstmt.setString(3, contact.getTel());
			pstmt.setString(4, contact.getFax());
			pstmt.setString(5, contact.getEmail());
			pstmt.setString(6, contact.getSex());
			pstmt.setString(7, contact.getMobile());
			pstmt.setString(8, contact.getQq());
			pstmt.setString(9, contact.getNotes());
			pstmt.setString(10, contact.getDept());
			pstmt.setString(11, contact.getJob());
			pstmt.setString(12, contact.getPurchase());
			pstmt.setString(13, contact.getLevel());
			pstmt.setString(14, contact.getDegree());
			pstmt.setInt(15, contact.getVisitnum());
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
	 * �޸Ŀͻ���Ϣ
	 * 
	 * @param client
	 * @return
	 */
	public synchronized boolean modifyClient(ClientForm client) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_client set name=?,ename=?,addr=?,eaddr=?,product=?,clevel=?,creditlevel=?,pay=?,salesid=?,zipcode=?,shortname=?,applicant=?  where id=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);

			pstmt.setString(1, client.getName());
			pstmt.setString(2, client.getEname());
			pstmt.setString(3, client.getAddr());
			pstmt.setString(4, client.getEaddr());
			pstmt.setString(5, client.getProduct());
			pstmt.setString(6, client.getClevel());
			pstmt.setString(7, client.getCreditlevel());
			pstmt.setString(8, client.getPay());
			pstmt.setInt(9, client.getSalesid());
			pstmt.setString(10, client.getZipcode());
			pstmt.setString(11, client.getShortname());
			pstmt.setInt(12, client.getApplicant());
			pstmt.setInt(13, client.getId());
			pstmt.executeUpdate();
			conn.commit();


			String sql1 = "update t_client_contact set contact=?,tel=?,fax=?,email=?,sex=?,mobile=?,qq=?,notes=?,dept=?,job=?,purchase=?,level=?,degree=?,visitnum=? where id=?";
			pstmt = DB.prepareStatement(conn, sql1);

			pstmt.setString(1, client.getContact().getContact());
			pstmt.setString(2, client.getContact().getTel());
			pstmt.setString(3, client.getContact().getFax());
			pstmt.setString(4, client.getContact().getEmail());
			pstmt.setString(5, client.getContact().getSex());
			pstmt.setString(6, client.getContact().getMobile());
			pstmt.setString(7, client.getContact().getQq());
			pstmt.setString(8, client.getContact().getNotes());
			pstmt.setString(9, client.getContact().getDept());
			pstmt.setString(10, client.getContact().getJob());
			pstmt.setString(11, client.getContact().getPurchase());
			pstmt.setString(12, client.getContact().getLevel());
			pstmt.setString(13, client.getContact().getDegree());
			pstmt.setInt(14, client.getContact().getVisitnum()==null?0:client.getContact().getVisitnum());
			pstmt.setInt(15, client.getContact().getId());
		
			pstmt.executeUpdate();
			conn.commit();
			isok = true;
			
			//������վ����
			UpdateWebSite up = new UpdateWebSite();
			up.setId(client.getId());
			up.setType("client");
			Thread t = new Thread(up);
			t.start();
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

	
	/***
	 * ����ְ�����۵Ŀͻ�ת����������
	 */
	
	/**
	 * �޸Ŀͻ���Ϣ
	 * 
	 * @param client
	 * @return
	 */
	public synchronized boolean transferClient(ClientForm client,int status) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = false;
		
		
		String field="";
		int fieldValue=0;
		if(status==1){
			field="applicant=?";
			fieldValue=client.getApplicant();
		}
		if(status==2){
			field="salesid=?";
			fieldValue=client.getSalesid();
		}
		String sql = "";
		if(client.getSales() ==null){
			sql ="update t_client set "+field+" where id=?";
		}else{
			sql="update t_client set "+field+" ,sales='"+client.getSales()+"' where id=?";
		}
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, fieldValue);
			pstmt.setInt(2, client.getId());
			pstmt.executeUpdate();
			conn.commit();
			isok = true;
			
			//������վ����
			UpdateWebSite up = new UpdateWebSite();
			up.setId(client.getId());
			up.setType("client");
			Thread t = new Thread(up);
			t.start();
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
	 * �޸Ŀͻ���ϵ��
	 * @param cf
	 * @return
	 */
	public synchronized boolean modifyContact(ContactForm cf) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_client_contact set contact=?,tel=?,fax=?,email=?,sex=?,mobile=?,qq=?,notes=?,dept=?,job=?,purchase=?,level=?,degree=?,visitnum=? where id=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);

			pstmt.setString(1, cf.getContact());
			pstmt.setString(2, cf.getTel());
			pstmt.setString(3, cf.getFax());
			pstmt.setString(4, cf.getEmail());
			pstmt.setString(5, cf.getSex());
			pstmt.setString(6, cf.getMobile());
			pstmt.setString(7, cf.getQq());
			pstmt.setString(8, cf.getNotes());
			pstmt.setString(9, cf.getDept());
			pstmt.setString(10,cf.getJob());
			pstmt.setString(11,cf.getPurchase());
			pstmt.setString(12,cf.getLevel());
			pstmt.setString(13,cf.getDegree());
			pstmt.setInt(14,cf.getVisitnum());
			pstmt.setInt(15,cf.getId());

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
	 * �޸���Ҫ��ϵ��
	 * @param cf
	 * @return
	 */
	public synchronized boolean modifyMainContact(String clientid,int contactid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_client set contactid=? where clientid=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, contactid);
			pstmt.setString(2, clientid);

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
	 * ���Ŀͻ���ҵ����׼ʱ��
	 * @param cf
	 * @return
	 */
	public synchronized boolean modifyBenchmark(String name,Date benchmark) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_client set dperformance=? where name=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setTimestamp(1,new Timestamp(benchmark.getTime()));
			pstmt.setString(2, name);
			
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
	 * ȡ�����пͻ���Ϣ
	 * 
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public List<ClientForm> getClients() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List<ClientForm> list = new ArrayList<ClientForm>();
		String sql = "select * from t_client order by area ";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ClientForm client = new ClientForm();
				client.setId(rs.getInt("id"));
				client.setClientid(rs.getString("clientid"));
				client.setName(rs.getString("name"));
				client.setPassword(rs.getString("password"));

				list.add(client);
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
	
	/**
	 * ��̬��ajax��ʽ��ȡ�ÿͻ��б�
	 * @param key
	 * @return
	 */
	public List<ClientForm> getClientsByAjax(String key) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List<ClientForm> list = new ArrayList<ClientForm>();
		String sql = "select * from t_client where name like '%" + key + "%' order by area ";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ClientForm client = new ClientForm();
				client.setClientid(rs.getString("clientid"));
				client.setName(rs.getString("name"));

				list.add(client);
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
	
	/**
	 * ��̬��ajax��ʽ��ȡ���ҵĿͻ�
	 * @param key �ͻ�����
	 * @param sales ����
	 * @return
	 */
	public List<ClientForm> getMyClientsByAjax(String key,String sales) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List<ClientForm> list = new ArrayList<ClientForm>();
		String sql = "select * from t_client where name like '%" + key + "%' and sales = '" + sales + "' order by area ";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ClientForm client = new ClientForm();
				client.setClientid(rs.getString("clientid"));
				client.setName(rs.getString("name"));

				list.add(client);
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
	
	/**
	 * ��̬��ajax��ʽ��ȡ������
	 * @param key
	 * @return
	 */
	public List<String> getSalesByAjax(String key) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		List<String> list = new ArrayList<String>();
		String sql = "select name from t_user where name like '%" + key + "%'";
		try {
			conn = DB.getConn();
			//������Ӵ����Զ��ύģʽ���������� SQL ��䶼����ִ�в���Ϊ�����������ύ�������� SQL ��佫�����鵽���ύ��ع�������ֹ�������С�Ĭ������£������Ӵ����Զ��ύģʽ��
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String sales = rs.getString("name");
				list.add(sales);
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

	/**
	 * ȡ�����пͻ���Ϣ
	 * 
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public PageModel getClients(int pageNo, int pageSize) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rsre = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List<ClientForm> list = new ArrayList<ClientForm>();
		String sql = "select * from t_client order by area " + "limit "
				+ (pageNo - 1) * pageSize + ", " + pageSize;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ClientForm client = new ClientForm();
				client.setClientid(rs.getString("clientid"));
				client.setName(rs.getString("name"));
				client.setShortname(rs.getString("shortname"));
				client.setEname(rs.getString("ename"));
				client.setAddr(rs.getString("addr"));
				client.setEaddr(rs.getString("eaddr"));
				client.setZipcode(rs.getString("zipcode"));
				client.setClevel(rs.getString("clevel"));
				client.setProduct(rs.getString("product"));
				client.setCreditlevel(rs.getString("creditlevel"));
				client.setPay(rs.getString("pay"));
				client.setSalesid(rs.getInt("salesid"));
				client.setArea(rs.getString("area"));
				client.setStatus(rs.getString("status"));
				client.setContact(getContactById(rs.getInt("contactid")));
				client.setPassword(rs.getString("password"));

				list.add(client);
			}
			int totalRecords = getTotalRecords(conn,"select count(*) from t_client");
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
	 * ȡ��ÿ�����۸���Ŀͻ���Ϣ
	 * 
	 * @param pageNo
	 * @param pageSize
	 * @param sales
	 * @return
	 */
	public PageModel getClients(int pageNo, int pageSize, int salesid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rsre = null;
		boolean auto = false;
		PageModel pm = new PageModel();
		List<ClientForm> list = new ArrayList<ClientForm>();
		String sql = "select * from t_client where salesid = " + salesid + " order by area "
				+ "limit " + (pageNo - 1) * pageSize + ", " + pageSize;
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ClientForm client = new ClientForm();
				client.setClientid(rs.getString("clientid"));
				client.setName(rs.getString("name"));
				client.setShortname(rs.getString("shortname"));
				client.setEname(rs.getString("ename"));
				client.setAddr(rs.getString("addr"));
				client.setEaddr(rs.getString("eaddr"));
				client.setZipcode(rs.getString("zipcode"));
				client.setClevel(rs.getString("clevel"));
				client.setProduct(rs.getString("product"));
				client.setCreditlevel(rs.getString("creditlevel"));
				client.setPay(rs.getString("pay"));
				client.setSalesid(rs.getInt("salesid"));
				client.setArea(rs.getString("area"));
				client.setStatus(rs.getString("status"));
				client.setContact(getContactById(rs.getInt("contactid")));
				client.setPassword(rs.getString("password"));

				list.add(client);
			}
			int totalRecords = getTotalRecords(conn,"select count(*) from t_client where salesid = " + salesid);
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
	 * ȡ�����еļ�¼��
	 * 
	 * @param conn
	 *            connection
	 * @return ���еļ�¼��
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
	 * ���ݿͻ����Ʋ��ҿͻ�
	 * 
	 * @param name
	 * @return
	 */
	public ClientForm getClientByName(String name) {
		String sql = "select * from t_client where name = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rsre = null;
		ClientForm client = new ClientForm();
		try {
			conn = DB.getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				
				client.setId(rs.getInt("id"));
				client.setClientid(rs.getString("clientid"));
				client.setName(rs.getString("name"));
				client.setShortname(rs.getString("shortname"));
				client.setEname(rs.getString("ename"));
				client.setAddr(rs.getString("addr"));
				client.setEaddr(rs.getString("eaddr"));
				client.setZipcode(rs.getString("zipcode"));
				client.setClevel(rs.getString("clevel"));
				client.setProduct(rs.getString("product"));
				client.setCreditlevel(rs.getString("creditlevel"));
				client.setPay(rs.getString("pay"));
				client.setSalesid(rs.getInt("salesid"));
				client.setArea(rs.getString("area"));
				client.setStatus(rs.getString("status"));
				client.setContact(getContactById(rs.getInt("contactid")));
				client.setContactid(rs.getInt("contactid"));
				client.setPassword(rs.getString("password"));
				client.setCreatetime(rs.getTimestamp("createtime"));
				client.setDperformance(rs.getTimestamp("dperformance"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rsre);
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return client;
	}
	
	/**
	 * ���ݿͻ����Ʋ��ҿͻ�,����boolean ����
	 * 
	 * @param name
	 * @return
	 */
	public boolean selectClientByName(String name) {
		String sql = "select * from t_client where name=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rsre = null;
		ClientForm client = null;
		boolean flag =false;
		try {
			conn = DB.getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			if (rs.next()) {
			flag=true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rsre);
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return flag;
	}

	/**
	 * ����idȡ�ÿͻ�
	 * 
	 * @param clientid
	 *            �ͻ�id
	 * @return ClientForm����
	 */
	public ClientForm getClientById(String clientid) {
		String sql = "select * from t_client where clientid=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rsre = null;
		ClientForm client = null;
		try {
			conn = DB.getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, clientid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				client = new ClientForm();
				client.setId(rs.getInt("id"));
				client.setClientid(rs.getString("clientid"));
				client.setName(rs.getString("name"));
				client.setShortname(rs.getString("shortname"));
				client.setEname(rs.getString("ename"));
				client.setAddr(rs.getString("addr"));
				client.setEaddr(rs.getString("eaddr"));
				client.setZipcode(rs.getString("zipcode"));
				client.setClevel(rs.getString("clevel"));
				client.setProduct(rs.getString("product"));
				client.setCreditlevel(rs.getString("creditlevel"));
				client.setPay(rs.getString("pay"));
				client.setSalesid(rs.getInt("salesid"));
				client.setArea(rs.getString("area"));
				client.setStatus(rs.getString("status"));
				client.setContact(getContactById(rs.getInt("contactid")));
				client.setPassword(rs.getString("password"));

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rsre);
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return client;
	}
	
	/**
	 * ����idȡ�ÿͻ�
	 * @param id
	 * @return
	 */
	public ClientForm getClientById(int id) {
		String sql = "select * from t_client where id = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rsre = null;
		ClientForm client = new ClientForm();
		try {
			conn = DB.getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				client.setId(rs.getInt("id"));
				client.setClientid(rs.getString("clientid"));
				client.setName(rs.getString("name"));
				client.setShortname(rs.getString("shortname"));
				client.setEname(rs.getString("ename"));
				client.setAddr(rs.getString("addr"));
				client.setEaddr(rs.getString("eaddr"));
				client.setZipcode(rs.getString("zipcode"));
				client.setClevel(rs.getString("clevel"));
				client.setProduct(rs.getString("product"));
				client.setCreditlevel(rs.getString("creditlevel"));
				client.setPay(rs.getString("pay"));
				client.setSalesid(rs.getInt("salesid"));
				client.setArea(rs.getString("area"));
				client.setStatus(rs.getString("status"));
				client.setContactid(rs.getInt("contactid"));
				client.setContact(getContactById(rs.getInt("contactid")));
				
				client.setPassword(rs.getString("password"));

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rsre);
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return client;
	}
	
	/**
	 * ����idȡ�ÿͻ�����
	 * @param id
	 * @return
	 */
	public String getNameById(int id) {
		String sql = "select * from t_client where id=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rsre = null;
		String name = "";
		try {
			conn = DB.getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				name = rs.getString("name");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rsre);
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return name;
	}

	/**
	 * ����idȡ����ϵ��
	 * 
	 * @param id
	 * @return
	 */
	public ContactForm getContactById(int id) {
		String sql = "select * from t_client_contact where id=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ContactForm cf = null;
		try {
			conn = DB.getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				cf = new ContactForm();
				cf.setId(rs.getInt("id"));
				cf.setContact(rs.getString("contact"));
				cf.setSex(rs.getString("sex"));
				cf.setDept(rs.getString("dept"));
				cf.setJob(rs.getString("job"));
				cf.setEmail(rs.getString("email"));
				cf.setMobile(rs.getString("mobile"));
				cf.setFax(rs.getString("fax"));
				cf.setQq(rs.getString("qq"));
				cf.setTel(rs.getString("tel"));
				cf.setNotes(rs.getString("notes"));
				cf.setTime(rs.getTimestamp("time"));
				cf.setStatus(rs.getString("status"));
				cf.setPurchase(rs.getString("purchase"));
				cf.setLevel(rs.getString("level"));
				cf.setDegree(rs.getString("degree"));
				cf.setVisitnum(rs.getInt("visitnum"));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return cf;
	}

	/**
	 * ����clientidȡ��������ϵ��
	 * 
	 * @param clientid
	 *            �ͻ�id
	 * @return ContactForm����
	 */
	public List<ContactForm> getContacts(String clientid) {
		String sql = "select * from t_client_contact where clientid=?";
		List<ContactForm> list = new ArrayList<ContactForm>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, clientid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ContactForm cf = new ContactForm();
				cf.setId(rs.getInt("id"));
				cf.setContact(rs.getString("contact"));
				cf.setSex(rs.getString("sex"));
				cf.setDept(rs.getString("dept"));
				cf.setJob(rs.getString("job"));
				cf.setEmail(rs.getString("email"));
				cf.setMobile(rs.getString("mobile"));
				cf.setFax(rs.getString("fax"));
				cf.setQq(rs.getString("qq"));
				cf.setTel(rs.getString("tel"));
				cf.setNotes(rs.getString("notes"));
				cf.setTime(rs.getTimestamp("time"));
				cf.setStatus(rs.getString("status"));
				cf.setPurchase(rs.getString("purchase"));
				cf.setLevel(rs.getString("level"));
				cf.setDegree(rs.getString("degree"));
				cf.setVisitnum(rs.getInt("visitnum"));
				list.add(cf);
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
	 * ����clientid
	 * 
	 * @param code
	 * @param area
	 * @return
	 */
	public synchronized String makeClientId(String code, String area) {
		StringBuffer str = new StringBuffer();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String sql = "Select clientid from t_client where clientid like '"+code+"%'    order by clientid desc";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
//			pstmt.setString(1, area);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String sub = rs.getString("clientid");
				int key = Integer.parseInt(sub.substring(3, 7));
				key += 1;
				String s = new DecimalFormat("0000").format(key);
				str.append(code + s);
			} else {
				str.append(code + "0001");
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
		return str.toString();
	}

	/**
	 * �����������Ŀͻ�
	 * 
	 * @param type
	 * @param keywords
	 * @return
	 */
	public List<ClientForm> searchClient(String type, String keywords,int saleId,String reserve,String agree,UserForm user) {
		String sql = "";
		//��ѯ��ǰ������¼��name�ǿͻ�����ֶΣ�
		StringBuffer str =new StringBuffer();
		if("reserve".equals(reserve) && ! reserve.equals("")){
				 if ("clientid".equals(type) && !keywords.equals("")) {
					 str.append(" and clientid like '%" + keywords+ "%'");
				 }
				 if ("name".equals(type) && !keywords.equals("")) {//���ͻ����е�name�ֶε���type�����Ĳ���keywords���ı��򲻵���Null������¾�ִ��
					 str.append(" and name like '%" + keywords+ "%' ");
					}
				 if(agree.equals("n")){
					 str.append(" and applicant is  null ");
				 }
//				 if(status.equals("plane")){
//					 str.append(" and salesid =0 ");
//				 }else{
					 str.append(" and  salesid in (select id  from t_user where estatus ='��Ч')  ");
//				 }
				 sql="select  *  from t_client where  1=1 and sales in (select name  from t_user where companyid ="+user.getCompanyid()+" and dept ='"+user.getDept()+"')"+str+"";
		}else{
			
				if(saleId !=0 ){
				str.append(" and salesid ='"+saleId+"'");
				}else{
					str.append("");
				}
				
				
				if ("name".equals(type) && !keywords.equals("")) {//���ͻ����е�name�ֶε���type�����Ĳ���keywords���ı��򲻵���Null������¾�ִ��
					sql = "select * from t_client where name like '%" + keywords
							+ "%' "+str+" limit 0,30";
				} else if ("clientid".equals(type) && !keywords.equals("")) {
					sql = "select * from t_client where clientid like '%" + keywords
							+ "%'  "+str+"  limit 0,30";
				}
				else {
					sql = "select * from t_client where 1=1 "+str+"  limit 0,30";
				}
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rsre = null;
		List<ClientForm> list = new ArrayList<ClientForm>();
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ClientForm client = new ClientForm();
				client.setId(rs.getInt("id"));
				client.setClientid(rs.getString("clientid"));
				client.setName(rs.getString("name"));
				client.setShortname(rs.getString("shortname"));
				client.setEname(rs.getString("ename"));
				client.setAddr(rs.getString("addr"));
				client.setEaddr(rs.getString("eaddr"));
				client.setZipcode(rs.getString("zipcode"));
				client.setClevel(rs.getString("clevel"));
				client.setProduct(rs.getString("product"));
				client.setCreditlevel(rs.getString("creditlevel"));
				client.setPay(rs.getString("pay"));
				client.setSalesid(rs.getInt("salesid"));
				client.setArea(rs.getString("area"));
				client.setStatus(rs.getString("status"));
				client.setContact(getContactById(rs.getInt("contactid")));
				client.setPassword(rs.getString("password"));
				client.setApplicant(rs.getInt("applicant"));

				list.add(client);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rsre);
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return list;
	}

	/**
	 * ���ҿͻ�����Ȩ��
	 * 
	 * @param userid
	 * @return
	 */
	public ClientPermission findClientPermission(String userid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		ClientPermission cp = null;
		String sql = "select * from t_client_perm where userid = ?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);

			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				cp = new ClientPermission();
				cp.setUserid(rs.getString("userid"));
				cp.setClientid(rs.getString("clientid"));
				cp.setName(rs.getString("name"));
				cp.setShortname(rs.getString("shortname"));
				cp.setEname(rs.getString("ename"));
				cp.setAddr(rs.getString("addr"));
				cp.setEaddr(rs.getString("eaddr"));
				cp.setZipcode(rs.getString("zipcode"));
				cp.setClevel(rs.getString("clevel"));
				cp.setProduct(rs.getString("product"));
				cp.setCreditlevel(rs.getString("creditlevel"));
				cp.setPay(rs.getString("pay"));
				cp.setSales(rs.getString("sales"));
				cp.setArea(rs.getString("area"));
				cp.setStatus(rs.getString("status"));
				cp.setCreatetime(rs.getString("createtime"));
				cp.setNotes(rs.getString("notes"));
				cp.setContact(rs.getString("contact"));
				cp.setSex(rs.getString("sex"));
				cp.setTel(rs.getString("tel"));
				cp.setMobile(rs.getString("mobile"));
				cp.setFax(rs.getString("fax"));
				cp.setQq(rs.getString("qq"));
				cp.setEmail(rs.getString("email"));
				cp.setCstatus(rs.getString("cstatus"));
				cp.setCtime(rs.getString("ctime"));
				cp.setCnotes(rs.getString("cnotes"));
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
		return cp;
	}
	
	/**
	 * ���������½�ͻ�
	 * @param client
	 * @return
	 */
	public List<ClientForm> getClientInMonth(String client) {
		List<ClientForm> list = new ArrayList<ClientForm>();
		String sql = "select * from t_client where pay = '�½�' and name like '%" + client + "%'";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			pstmt = DB.prepareStatement(conn, sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ClientForm clf = new ClientForm();
				clf.setId(rs.getInt("id"));
				clf.setName(rs.getString("name"));
				list.add(clf);
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
	

}
