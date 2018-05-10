package com.lccert.crm.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.chemistry.util.FlowFinal;
import com.lccert.crm.dao.DaoFactory;
import com.lccert.crm.dao.impl.SalesOrderItemDaoImpl;
import com.lccert.crm.user.UserForm;
import com.lccert.crm.vo.SalesOrderItem;
import com.lccert.crm.vo.Subject;

public class FpayAction extends HttpServlet{
//	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
//		PrintWriter printWriter;
//		String threeSubName = request.getParameter("threeSubName"); // 得到一个父类id
//		try {
//		 response.setContentType("text/xml; charset=GBK");//解决乱码
//		 printWriter = response.getWriter();
//		 Subject sub=DaoFactory.getInstance().getSubject().getSubByFirstSubName(threeSubName);
//		 if(sub !=null && !"".equals(sub)){
//			 String xmlString = "<?xml version='1.0' encoding='GBK' ?><agent suc='true' secondName='"+sub.getSecondname()+"' firstName='"+sub.getFirstname()+"'/>";
//			 printWriter.write(xmlString); //将xmlString 传输到Jsp页面
//		 }
//		 printWriter.flush();
//		 printWriter.close();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//	}
	/**
	 * Constructor of the object.
	 */
	public FpayAction() {
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
		PrintWriter printWriter;
		String threeSubName = request.getParameter("threeSubName"); // 得到一个父类id
		threeSubName=new String(threeSubName.getBytes("ISO8859-1"),"utf-8");
		try {
		 response.setContentType("text/xml; charset=GBK");//解决乱码
		 printWriter = response.getWriter();
		 Subject sub=DaoFactory.getInstance().getSubject().getSubByFirstSubName(threeSubName);
		 if(sub !=null && !"".equals(sub)){
			 String xmlString = "<?xml version='1.0' encoding='GBK' ?><agent suc='true' secondName='"+sub.getSecondname()+"' firstName='"+sub.getFirstname()+"'/>";
			 printWriter.write(xmlString); //将xmlString 传输到Jsp页面
		 }
		 printWriter.flush();
		 printWriter.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
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
}
