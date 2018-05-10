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
import com.lccert.crm.dao.CashierDao;
import com.lccert.crm.kis.Order;
import com.lccert.crm.quotation.Cashier;
import com.lccert.oa.db.ImsDB;

public class CashierDaoImpl implements CashierDao {
	public int addCashier(Cashier cashier) {
		List temp =new ArrayList();
		temp.add(cashier.getClient());
		temp.add(cashier.getSubtotal());
		temp.add(cashier.getCreditcard());
		temp.add(cashier.getUi());
		String sql ="insert t_cashier (vclient,subtotal,vcreditcard,ui,dcreatetime) values (?,?,?,?,now())";
		return new ImsDB().getCount(sql,temp);
	}

	public List cashierInfor(String uiNo) {
		List temp =new ArrayList();
		temp.add("subtotal");
		temp.add("vcreditcard");
		temp.add("ui");
		String sql ="select subtotal,vcreditcard,ui from t_cashier where ui ='"+uiNo+"'";
		return new ImsDB().getInfor(temp, sql);
	}
//²éÑ¯Á÷Ë®ºÅ
	public String cashierUI() {
			StringBuffer str = new StringBuffer();
			String last = "";
			Date date = new Date();
			String year = new SimpleDateFormat("yyyy").format(date);
			String month = new SimpleDateFormat("MM").format(date);
			String key =year+month;
			str.append(year + month);
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			boolean auto = false;
			String sql = "select * from t_cashier where ui like '%" + key + "%'" +
					" order by substring(ui,6,11) desc";
			try {
				conn = DB.getConn();
				auto = conn.getAutoCommit();
				conn.setAutoCommit(false);
				pstmt = DB.prepareStatement(conn, sql);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					String sub = rs.getString("ui");
					int code = Integer.parseInt(sub.substring(6, sub.length()));
					code += 1;
					last = new DecimalFormat("0000").format(code);
				} else {
					last = "0001";
				}
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
}
