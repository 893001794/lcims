package com.lccert.crm.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.oa.db.ImsDB;
/***
 * 密码验证的servlet类
 * @author tangzp
 *
 */
public class VerificationPwd extends HttpServlet {
	/**
	 * Constructor of the object.
	 */
	public VerificationPwd() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

        response.setContentType("text/xml; charset=GBK");		
	    PrintWriter outData = response.getWriter();
	    String userName = request.getParameter("userName");  //获取传过来的值
	    String grade =request.getParameter("grade");
		String xmlString = checkVerificatime(userName,grade); //调用查询验证的方法
		outData.write(xmlString); //将xmlString 传输到Jsp页面
		outData.flush();  //清空
		outData.close();//关闭
		
	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);


	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}
	
	
	public String checkVerificatime(String password,String grade) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		UserForm user = null;
		String xml = "<?xml version='1.0' encoding='GBK' ?>";
		String sql="";
		if(grade !=null && !"".equals(grade)){
		sql = "select * from t_user where verification = 'y' and password = md5(?) and name='夏念民[Hadi]' and estatus = '有效'";
		}else{
		 sql = "select * from t_user where verification = 'y' and password = md5(?) and estatus = '有效'";
		}
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, password);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				//将审核人的Id填入到审核人中区
				int id=rs.getInt("id");
				String userId=rs.getString("userid");
//				System.out.println(rs.getInt("id"));
//				String sql1 = "update t_sales_order  set confirmid=? and dconfirmtime=now() where vpid=?";
//				List temp =new ArrayList();
//				temp.add(id);
//				temp.add(userId);
//				new ImsDB().getCount(sql, temp);
				 xml = xml+"<agent suc='true' name='"+id+"'/>";
			}else{
				  xml = xml+"<agent suc='false'/>";
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
		return xml;
	}
}
