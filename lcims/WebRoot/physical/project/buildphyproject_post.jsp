<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
     <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%@page import="com.lccert.crm.project.PhyProjectAction"%>
<%@ include file="../../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%
	request.setCharacterEncoding("GBK");
	String sid = request.getParameter("sid");
	if(sid == null || "".equals(sid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	
	String pid = request.getParameter("pid");
	if(pid == null || "".equals(pid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	
	String strrptime = request.getParameter("rptime");
	if(strrptime == null || "".equals(strrptime)) {
		out.println("<script type='text/javascript'>");
		out.println("window.history.back();");
		out.println("</script>");
		return;
	}
	Date rptime = new SimpleDateFormat("yyy-MM-dd HH:mm").parse(strrptime);
	String rpclient = request.getParameter("rpclient");
	
	String contact = request.getParameter("contact");
	String samplename = request.getParameter("samplename");
	String samplecount = request.getParameter("samplecount");
	//String samplecategory = request.getParameter("samplecategory");
	String samplemodel = request.getParameter("samplemodel");
	String testStandard = request.getParameter("testStandard"); //���Ա�׼
	String notes = request.getParameter("notes");
	String level = request.getParameter("level");
	String servname = request.getParameter("servname");
	String createname = user.getName();
	String ptype = request.getParameter("ptype");
	String type = request.getParameter("type");
	
	String rptype = request.getParameter("rptype");
	String company = request.getParameter("company");
	String rid = request.getParameter("rid");
	String lab = request.getParameter("lab");
	String isout = request.getParameter("isout");
	String engineer = request.getParameter("engineer");
	
	//��ȡ���ѹ
	String ratedvoltage=request.getParameter("ratedvoltage");
	//��ȡ�����
	String ratedcurrent=request.getParameter("ratedcurrent");
	//��ȡ�����
	String ratedpower=request.getParameter("ratedpower");
	//��ȡ����
	String other=request.getParameter("other");
	//��ȡ��Դ����
	String lightsourcetype=request.getParameter("lightsourcetype");
	//������������
	String copy =request.getParameter("copy");
	Project p = new Project();
	PhyProject pp = new PhyProject();
	p.setRid(rid);
	p.setPid(pid);
	p.setPtype(ptype);
	p.setType(type);
	p.setIsout(isout);
	p.setLab(lab);
	p.setLevel(level);
	//p.setTestcontent(testcontent);
	p.setNotes(notes);
	
	pp.setRptype(rptype);
	pp.setContact(contact);
	pp.setRptime(rptime);
	pp.setRpclient(rpclient);
	pp.setSamplename(samplename);
	pp.setSamplecount(samplecount);
	pp.setTestStandard(testStandard);
	//pp.setSamplecategory(samplecategory);
	pp.setSamplemodel(samplemodel);
	pp.setCreatename(createname);
	pp.setServname(servname);
	pp.setEngineer(engineer);
	pp.setRatedvoltage(ratedvoltage);
	pp.setRatedcurrent(ratedcurrent);
	pp.setRatedpower(ratedpower);
	pp.setOther(other);
	pp.setLightsourcetype(lightsourcetype);
	p.setObj(pp);
	//---------------2010-12-29----------------
	int copysize=Integer.parseInt(copy);
	int countsid =0;
	boolean flag=false;
	if(copysize>0){
	//��ȡsid���ַ���Ϊ ��LCQ210050101-��
	sid =sid.substring(0,sid.indexOf("-")+1);
	for(int i=0;i<copysize;i++){
	//ÿ��ѭ��������+1
	countsid =countsid+1;
	//Ϊp.sid ��ֵ
	p.setSid(sid+countsid);
	//������ӵķ���
	flag=PhyProjectAction.getInstance().addPhyProject(p);
	}
	}else{
	p.setSid(sid);
	flag=PhyProjectAction.getInstance().addPhyProject(p);
	}
	//---------------------2010-12-29--------------------
	
	if(flag == true) {
		out.println("<div alight=center>");
		out.println("��ӳɹ�");
		out.println("<a href='phyprojectdetail.jsp?sid=" + p.getSid() + "'>����</a>");
		out.println("</div>");
		return;
	} else {
		out.println("<div alight=center>");
		out.println("���ʧ�ܣ��뷵���������룡");
		out.println("<br><a href='javascript:window.history.back();'>����</a>");
		out.println("</div>");
		return;
	}
%>