<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
    <%@ page errorPage="../error.jsp" %>
<%@page import="com.lccert.crm.system.Forum"%>
<%@page import="com.lccert.crm.system.ForumAction"%>
<%@page import="com.lccert.crm.vo.ProjectChem"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.dao.impl.ProjectChemImpl"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@ include file="../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("GBK");
	String rid = request.getParameter("rid");
	String pid = request.getParameter("pid");
	String startype = request.getParameter("startype");
	String gbk=request.getCharacterEncoding();
	String projectleader = request.getParameter("projectleader");
	String projectissuer = request.getParameter("projectissuer");
	String start =request.getParameter("start");
	String item =request.getParameter("traytype");
	String itestcount = request.getParameter("itestcount");
		String sid =request.getParameter("sid");

	//��ȡ��ĿԤ����Ϣ
	String warning=request.getParameter("warning");
	String oldwarning=request.getParameter("oldwarning");
	//��ȡ�ɵ�Ԥ����Ϣ
	ProjectChem pc = new ProjectChem();
	pc.setPid(pid);
	pc.setProjectleader(projectleader);
	pc.setProjectissuer(projectissuer);
	pc.setWarning(warning);
	String aa="";
	if(itestcount!=null){
	pc.setItestcount(new Integer(itestcount));
	
	pc.setRid(rid);
		
		if(item.equals("��Ʒ")){
			aa="<a href='product_manager.jsp'>����</a>";
		}else if(item.equals("ʳƷ")){
			aa="<a href='food_manager.jsp'>����</a>";
		}
		
	if(item.equals("ɢ��")){
		out.println("����Ʒ����Ϊɢ������Ӳ��ɹ�");
			out.println("<a href='project_chemistry_manage.jsp'>����</a>");
			return;
	}
		
	if(start .equals("add")){
		String projectcontent = request.getParameter("projectcontent");
		String estimate = request.getParameter("estimate");
		
		String createtime = request.getParameter("dcreatetime");
		String completetime = request.getParameter("dcompletetime");
		String rpclient = request.getParameter("rpclient");
		String samplename = request.getParameter("vsamplename");
		
	
		pc.setProjectcontent(projectcontent);
		pc.setEstimate(new Integer(estimate));
	
		Date createtime1=new SimpleDateFormat("yyy-MM-dd HH:mm").parse(createtime);
		pc.setCreatetime(createtime1);
		Date completetime1=new SimpleDateFormat("yyy-MM-dd HH:mm").parse(completetime);
		pc.setCompletetime(completetime1);
		
		pc.setItem(item);
		pc.setSid(sid);
		pc.setRpclient(rpclient);
		pc.setSamplename(samplename);
		
	if(ProjectChemImpl.getInstance().addProjectChem(pc)){
	
			out.println("��ӳɹ�");
			out.println(aa);
			return;
		}
	}
	
	else if(start.equals("update")){
	if(ProjectChemImpl.getInstance().upProjectChem(pc)){
	//�����ĿԤ�������ʼ�֪ͨ�����Ա
		if(warning != null && !"".equals(warning) && !oldwarning.equals(warning)) {
			ChemProjectAction.getInstance().sendProjectwarning(sid,warning);
		}
			out.println("�޸ĳɹ�");
			out.println(aa);
			return;
		}
	
	}
	}
	else if(start.equals("del")){
		if(ProjectChemImpl.getInstance().delProjectChem(rid)){
		    out.println("ɾ���ɹ�");
	
			if(startype.equals("product")){
			aa="<a href='product_manager.jsp'>����</a>";
			out.println(aa);
			}else{
			aa="<a href='food_manager.jsp'>����</a>";
			out.println(aa);
			}
			
			return;
		}
		
	}

		out.println("���ʧ�ܣ��뷵���������룡");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		return;

%>