package com.lccert.crm.sample;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.Response;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.user.UserForm;

public class SamplePackageSerservlet extends HttpServlet {
	@Override
	public void destroy() {
		super.destroy();
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//			response.setCharacterEncoding("GBK");
			PrintWriter outData = response.getWriter();
		    String client = request.getParameter("client");  //获取传过来的值
		    System.out.println(client);
//		    client =new String (client.getBytes("ISO8859-1"),"GBK");
		    String xmlString = getSales(response,client); //调用查询验证的方法
			outData.write(xmlString); //将xmlString 传输到Jsp页面
			outData.flush();  //清空
			outData.close();//关闭
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doGet(req,resp);
	}
	
	

	/**
	 * 获取销售名称
	 * 
	 */
		
		public String getSales(HttpServletResponse response,String client) {
			response.setHeader("Charset","GBK");  
			response.setContentType("text/xml; charset=GBK");		
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			boolean auto = false;
			String xml = "<?xml version='1.0' encoding='GBK' ?>";
			String sql="";
			if(client !=null){
			sql = "select a from v_finance_4 where  b like '%"+client+"%'";
			System.out.println(sql);
			}
			try {
				conn = DB.getConn();
				auto = conn.getAutoCommit();
				conn.setAutoCommit(false);
				pstmt = DB.prepareStatement(conn, sql);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					String sales=rs.getString("a");
//						 System.out.println(response.getCharacterEncoding());
						 //sales =new String (sales.getBytes("ISO8859-1"),"GBK");
						 xml = xml+"<agent suc='true' name='"+sales+"'/>";
//						 System.out.println(response.getCharacterEncoding());
//						 System.out.println(xml);
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
				}
				DB.close(rs);
				DB.close(pstmt);
				DB.close(conn);
			}
			return xml+"";
		}

}
