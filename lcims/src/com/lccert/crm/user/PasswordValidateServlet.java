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
 * ������֤servlet
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
		String cts=request.getParameter("cts"); //��ȡ��ѡ��������ֵ
		if(cts!=null && !"".equals(cts)){
			String dept=user.getDept();
			//���ݲ������ƺ�ctsname����ѯ�������ctsname����
			 list = new ConnSqlServserDB().userNameAndPwd(dept,user.getCtsname());
			 if(list.size()>0){
				 com.lccert.oa.vo.UserForm userF=( com.lccert.oa.vo.UserForm)list.get(0);
				 if(userF.getPwd().trim().equals(oldPassword)){
					 falg=true;
				 }
			 }
		}else{
			//�����û�id����������ѯ��userForm�Ķ���
			olduser = UserAction.getInstance().checkLogin(user.getUserid(),oldPassword);
	}
		if (olduser == null && falg==false) {//���olduser��list.size()����һ�����ϸ���������jspҳ�淵�����µ�ֵ
			response.getWriter().println("<font color='red'>����������ԭ���벻����</font>");
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doGet(req, resp);
	}
}
