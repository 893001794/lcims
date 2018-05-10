package com.temp;

import java.io.IOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.client.ClientAction;
import com.lccert.crm.client.ClientForm;
import com.lccert.www.HttpRequest;


/**
 * ��վ�ͻ�ͬ�����¹����ࣨ��ִ���ࣩ
 * @author tangzp
 *
 */
public class UpdateClientData {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		new UpdateClientData().update();
		System.out.println("�������");
	}
	
	
	public void update() {
		List<ClientForm> list = ClientAction.getInstance().getClients();
		if(list != null) {
			for(int i=0;i<list.size();i++) {
				ClientForm clf = list.get(i);
				//updateClient(clf);
				makeString(clf);
			}
		}
	}
	
	private boolean updateClient(ClientForm client) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		boolean isok = false;
		String sql = "update t_client set password=? where id=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);

			pstmt.setString(1, createRandomString(8));
			pstmt.setInt(2, client.getId());

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
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return isok;
	}


	public void makeString(ClientForm clf) {
		Map<String,String> map = new HashMap<String, String>();
		map.put("action", "client");
		map.put("id", clf.getId() + "");
		map.put("userid", clf.getClientid());
		map.put("password", clf.getPassword());
		map.put("name", clf.getName());
		 
        try {
        	HttpRequest request = new HttpRequest();  
			request.sendGet("http://www.lccert.com/updatewebsite.asp",map);
        	//request.sendGet("http://192.168.0.107/update.asp",map);
		} catch (IOException e) {
		}
	}
	
	
	public static String createRandomString(int length) {
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

}
