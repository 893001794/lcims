<%@page import="com.lccert.crm.chemistry.util.SendEmail"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>

<%
	request.setCharacterEncoding("GBK");
	String ems = request.getParameter("ems");
	String packageName = request.getParameter("packageName");
	String client = request.getParameter("client");
	String pid = request.getParameter("pid");
	String sid = request.getParameter("sid");
	String sales = request.getParameter("sales");
	//是否为快的
	String status=request.getParameter("status");
	//System.out.println(status);
	//根据销售名称来查询其邮箱地址
	List temp =new ArrayList();
	temp.add("email");
	List row =DaoFactory.getInstance().getSimpleDao().getEmailByName(temp,sales);
	String mail ="";
	if(row.size()>0){
		mail=row.get(0).toString();
	}
	String dreceipt = request.getParameter("dreceipt");
	//System.out.println("pno:"+pno+"--packageName:"+packageName+"--client:"+client+"--pid:"+pid+"--sid:"+sid+"--sales:"+sales+"--dreceipt:"+dreceipt);
	List list  =new ArrayList ();
	//System.out.println(DaoFactory.getInstance().getSimpleDao().makePNo()+"-----");
	String pno =DaoFactory.getInstance().getSimpleDao().makePNo();
	System.out.println(pno);
	list.add(pno);
	list.add(ems);
	list.add(pid);
	list.add(sid);
	list.add(packageName);
	list.add(client);
	list.add(dreceipt);
	list.add(sales);
	//System.out.println(DaoFactory.getInstance().getSimpleDao().addSamplePackage(list));
	if(DaoFactory.getInstance().getSimpleDao().addSamplePackage(list)>0) {
	//如果收件人的邮箱不为空的时候，就给他发邮箱
		//if(mail !=null && !mail.equals("") && status.equals("n")){
		if(mail !=null && !mail.equals("")&& status.equals("n")){
		List toList =new ArrayList();
		//toList.add("tangzp@lccert.com");
	    toList.add(mail.substring(1, mail.length()-1));
	    //toList.add("service@lccert.com");
		String head ="前台有寄给你的快递("+client+")";
		String content="前台有你的快递。<br>快递编号为："+ems+"<br>包裹号："+pno+"<br>寄件公司："+client+"<br>收件人："+sales+"<br>如有疑问，请致电22833366 - 266查询<br><br>立创检测<br>日期:" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		new SendEmail().sendEmailPublic(toList,head,content);
		}
			out.println("添加成功！");
			if(status.equals("n")){
			
			out.println("<a href='sample_package.jsp'>返回</a>");
			}else{
			out.println("<a href='derdetail.jsp?pno=" + pno + "'>返回</a>");
			}
			return;
	}else{
			out.println("添加失败！<br>");
			out.println("<a href='javascript:window.history.back();'>返回</a>");
		}
%>
