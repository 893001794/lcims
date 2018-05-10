package com.lccert.crm.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.client.ClientAction;
import com.lccert.crm.client.ClientForm;
import com.lccert.crm.flow.Flow;
import com.lccert.crm.flow.FlowAction;
import com.lccert.crm.quotation.Quotation;
import com.lccert.crm.quotation.QuotationAction;
/***
 * 防伪码的servler验证类
 * @author tangzp
 *
 */
public class VerificationSecurity extends HttpServlet{
	/**
	 * Constructor of the object.
	 */
	public VerificationSecurity() {
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
	    PrintWriter outData = response.getWriter();
	    String rid = request.getParameter("rid");  //获取传过来的值
	    String security =request.getParameter("security");
	    String xmlString ="";
	    if(rid.length()>12){
    		if(rid.indexOf("-")>-1){
    			rid=rid.substring(0, 12);
    		}
    	}
	    if(security==null){
	    	//根据报告编号获取报价单号
	    	Flow flow =FlowAction.getInstance().getFlowByPid(rid);
	    	Quotation qt = QuotationAction.getInstance().getQuotationByPid(flow.getPid());
	    	ClientForm cf=ClientAction.getInstance().getClientByName(qt.getClient());
	    	String payStatus="";
	    	if(cf.getPay().equals("现付")){
	    		payStatus=qt.getPaystatus();
	    	}else{
	    		payStatus="y";
	    	}
	    	if(payStatus.equals("y")){
	    		xmlString=getSecurity(rid); //获取防伪码的方法
	    	}else{
	    		xmlString="1";
	    	}
	    }else{
		   xmlString = checkVerificatime(Integer.parseInt(security),rid ,response); //调用查询验证的方法
	    }
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
	
	
	public String checkVerificatime(int security,String rid,HttpServletResponse response) {
		response.setContentType("text/xml; charset=GBK");		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		UserForm user = null;
		String xml = "<?xml version='1.0' encoding='GBK' ?>";
		String sql="";
		if(rid !=null && !"".equals(rid)){
		sql = "select * from t_chem_flow where   nsecurity=? and vrid =?";
		}
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setInt(1, security);
			pstmt.setString(2, rid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				 xml = xml+"<agent suc='true' />";
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
	
/**
 * 获取验证码
 * 
 */
	
	public String getSecurity(String rid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean auto = false;
		UserForm user = null;
		int  xml = 0;
		String sql="";
		if(rid !=null){
		sql = "select nsecurity from t_chem_flow where  vrid =?";
		}
		try {
			conn = DB.getConn();
			auto = conn.getAutoCommit();
			conn.setAutoCommit(false);
			pstmt = DB.prepareStatement(conn, sql);
			pstmt.setString(1, rid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				xml = rs.getInt("nsecurity");
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
