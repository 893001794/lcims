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
	//�Ƿ�Ϊ���
	String status=request.getParameter("status");
	//System.out.println(status);
	//����������������ѯ�������ַ
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
	//����ռ��˵����䲻Ϊ�յ�ʱ�򣬾͸���������
		//if(mail !=null && !mail.equals("") && status.equals("n")){
		if(mail !=null && !mail.equals("")&& status.equals("n")){
		List toList =new ArrayList();
		//toList.add("tangzp@lccert.com");
	    toList.add(mail.substring(1, mail.length()-1));
	    //toList.add("service@lccert.com");
		String head ="ǰ̨�мĸ���Ŀ��("+client+")";
		String content="ǰ̨����Ŀ�ݡ�<br>��ݱ��Ϊ��"+ems+"<br>�����ţ�"+pno+"<br>�ļ���˾��"+client+"<br>�ռ��ˣ�"+sales+"<br>�������ʣ����µ�22833366 - 266��ѯ<br><br>�������<br>����:" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		new SendEmail().sendEmailPublic(toList,head,content);
		}
			out.println("��ӳɹ���");
			if(status.equals("n")){
			
			out.println("<a href='sample_package.jsp'>����</a>");
			}else{
			out.println("<a href='derdetail.jsp?pno=" + pno + "'>����</a>");
			}
			return;
	}else{
			out.println("���ʧ�ܣ�<br>");
			out.println("<a href='javascript:window.history.back();'>����</a>");
		}
%>
