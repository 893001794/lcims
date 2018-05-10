package com.lccert.crm.sample;

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
public class upSamplePack extends HttpServlet {
	/**
	 * Constructor of the object.
	 */
	public upSamplePack() {
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
	    String client = request.getParameter("client");  //获取传过来的值
	    client= new String (client.getBytes("ISO8859-1"),"UTF-8");
	    String id =request.getParameter("id");
		String xmlString = updatePack(Integer.parseInt(id),client); //调用查询验证的方法
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
	
	
	public String updatePack(int id,String client) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		String xml = "<?xml version='1.0' encoding='GBK' ?>";
		String sql="update t_sample_package set vclient='"+client+"' where id=?";
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, id);
			int count = pstmt.executeUpdate();
			if (count>0) {
				 xml = xml+"<agent suc='true'/>";
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
