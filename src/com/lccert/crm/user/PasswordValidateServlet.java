package com.lccert.crm.user;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lccert.oa.db.ConnSqlServserDB;


/**
 * 密码验证servlet
 * @author Eason
 *
 */
public class PasswordValidateServlet extends HttpServlet {
	private static final String CONTENT_TYPE = "text/html; charset=GBK";

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType(CONTENT_TYPE);
		List list=new ArrayList();
		boolean falg=false;
		UserForm olduser=null;
		String oldPassword = request.getParameter("oldPassword");
		UserForm user = (UserForm) request.getSession().getAttribute("user");
		String cts=request.getParameter("cts"); //获取复选框的里面的值
		if(cts!=null && !"".equals(cts)){
			String dept=user.getDept();
			//根据部门名称和ctsname来查询其密码和ctsname名称
			 list = new ConnSqlServserDB().userNameAndPwd(dept,user.getCtsname());
			 if(list.size()>0){
				 com.lccert.oa.vo.UserForm userF=( com.lccert.oa.vo.UserForm)list.get(0);
				 if(userF.getPwd().trim().equals(oldPassword)){
					 falg=true;
				 }
			 }
		}else{
			//根据用户id和密码来查询其userForm的对象
			olduser = UserAction.getInstance().checkLogin(user.getUserid(),oldPassword);
	}
		if (olduser == null && falg==false) {//如果olduser和list.size()其中一个符合该条件就想jsp页面返回以下的值
			response.getWriter().println("<font color='red'>输入密码与原密码不符！</font>");
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doGet(req, resp);
	}
}
