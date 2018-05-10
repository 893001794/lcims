package com.lccert.crm.dao.impl;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
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
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lccert.crm.chemistry.util.DB;
import com.lccert.crm.chemistry.util.FlowFinal;
import com.lccert.crm.user.UserForm;
import com.lccert.crm.vo.SalesOrderItem;

/***
 * 用ajax动态拼凑一级、二级、三级的项目名称
 * @author tangzp
 *
 */
public class SalesOrder extends HttpServlet {
	
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		PrintWriter printWriter;

	    try {
	     response.setContentType("text/html; charset=GBK");//解决乱码
	     printWriter = response.getWriter();
	     //spUserName2
	     String parents = request.getParameter("parents"); // 得到一个父类id
	     if(request.getParameter("stutas").equals("1")){
	    
				List<?> ls =SalesOrderItemDaoImpl.getInstance().getchilds(parents);
				if(ls.size()<=0){
					 printWriter.append("<select name=\"childs\"  onchange=\"check(childs);\">");
					ls=SalesOrderItemDaoImpl.getInstance().getThreeChilds(parents);
				}else{
					 printWriter.append("<select name=\"childs\"  onchange=\"retrieveChilds(2);\">");
				    
				}
				 printWriter.append("<option value=\"\">--请选择二级分类--</option>");
				for (int i = 0; i < ls.size(); i++) {
					SalesOrderItem soi =(SalesOrderItem)ls.get(i);
					printWriter.append("<option value=\"" + soi.getItem_number()+ "\">"
							+ soi.getItem_number()+"  "+soi.getName()+ "</option>");
			}
	     
	     }else   if(request.getParameter("stutas").equals("2")){
		     printWriter.append("<select name=\"childs3\"  onchange=\"check(childs3);\">");
		     printWriter.append("<option value=\"\">--请选择三级分类--</option>");
					List<?> ls =SalesOrderItemDaoImpl.getInstance().getThreeChilds(parents);
					for (int i = 0; i < ls.size(); i++) {
						SalesOrderItem soi =(SalesOrderItem)ls.get(i);
						printWriter.append("<option value=\"" + soi.getItem_number()+ "\">"
								+ soi.getItem_number()+"  "+soi.getName()+ "</option>");
					
				}
	    	 
	     }else   if(request.getParameter("stutas").equals("3")){
	    	 		printWriter.append("<select name=\"servid\" style=\"width: 300px\">");
					List<?> ls =FlowFinal.getInstance().getServIdByCompanyid(Integer.parseInt(parents.trim()));
					for (int i = 0; i < ls.size(); i++) {
						UserForm serv =(UserForm)ls.get(i);
						printWriter.append("<option value=\"" +serv.getId()+ "\">"
								+serv.getName()+ "</option>");
					
				}
	    	 
	     }else   if(request.getParameter("stutas").equals("4")){
 	 		printWriter.append("<select name=\"servid\" style=\"width: 300px\">");
			List<?> ls =FlowFinal.getInstance().getServIdByCompanyid1(Integer.parseInt(parents.trim()));
			for (int i = 0; i < ls.size(); i++) {
				UserForm serv =(UserForm)ls.get(i);
				printWriter.append("<option value=\"" +serv.getId()+ "\">"
						+serv.getName()+ "</option>");
			
		}
	 
 }
	    printWriter.append("</select>");
	     printWriter.flush();
	     printWriter.close();
	    } catch (IOException e) {

	     e.printStackTrace();
	    }



	}
	


	

}
