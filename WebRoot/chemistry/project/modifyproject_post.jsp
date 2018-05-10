<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
     <%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.TimerTask.MyTimerTask"%>
<%@page import="com.lccert.crm.dao.impl.ProjectChemImpl"%>
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
	int id = 0;
	String strid = request.getParameter("id");
	if(strid != null && !"".equals(strid)) {
		id = Integer.parseInt(strid);
	}
	String rid = request.getParameter("rid");
	if(rid == null || "".equals(rid)) {
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
	String comappidStr = request.getParameter("comappid");
	 Integer comappid=0;
	if(comappidStr != null && !"".equals(comappidStr)){
	//判断是否为数字
		for (int i = comappidStr.length(); --i >= 0;) {  
            if (!Character.isDigit(comappidStr.charAt(i))) {  
               out.println("<script type='text/javascript'> alert(\"化妆品申请单id只能输入数字！\");");
			   out.println("window.self.location='javascript:window.history.back();';");
			   out.println("</script>");
			   return;
            }  
        }  
      comappid =Integer.parseInt(comappidStr);
	}
	
	String strrptime = request.getParameter("rptime");
	Date rptime = null;
	if(strrptime != null && !"".equals(strrptime)) {
		rptime = new SimpleDateFormat("yyy-MM-dd HH:mm").parse(strrptime);
	}
	String rpclient = request.getParameter("rpclient");
	
	String contact = request.getParameter("contact");
	String samplename = request.getParameter("samplename");
	String samplecount = request.getParameter("samplecount");
	String testcontent = request.getParameter("testcontent");
	String notes = request.getParameter("notes");
	String level = request.getParameter("level");
	String servname = request.getParameter("servname");
	String createname = user.getName();
	String quotype = request.getParameter("quotype");
	String ptype = request.getParameter("ptype");
	String rptype = request.getParameter("rptype");
	String company = request.getParameter("company");
	String item = request.getParameter("item");
	String type = request.getParameter("type");
	String lab = request.getParameter("lab");
	String isout = request.getParameter("isout");
	
	//草稿版
	String draftV= request.getParameter("draft");
	if(draftV ==null || "".equals(draftV)){
	draftV="n";
	}
		
	Project p = new Project();
	ChemProject cp = new ChemProject();
	p.setId(id);
	
	p.setRid(rid);
	p.setSid(sid);
	p.setPid(pid);
	p.setPtype(ptype);
	p.setTestcontent(testcontent);
	p.setLevel(level);
	p.setNotes(notes);
	p.setType(type);
	p.setLab(lab);
	p.setIsout(isout);
	
	cp.setRptype(rptype);
	cp.setContact(contact);
	cp.setRptime(rptime);
	cp.setRpclient(rpclient);
	cp.setSamplename(samplename);
	cp.setSamplecount(samplecount);
	cp.setCreatename(createname);
	cp.setServname(servname);
	cp.setDraft(draftV);
	cp.setItem(item);
	cp.setComappid(comappid);
	p.setObj(cp);
	
	if(ChemProjectAction.getInstance().modifyChemProject(p)) {
	//将应出报告时间转为long
		long rp=new MyTimerTask().getTimeMillis(rptime.toLocaleString());
		//根据Pid更改map里面的值
		new MyTimerTask().updateTask(pid,rp);
		//将工程部门的报告应出日期也更改过来
		boolean flag =ProjectChemImpl.getInstance().upProjectTime(p);
		
		out.println("<div alight=center>");
		out.println("添加成功");
		out.println("<a href='myproject.jsp'>返回</a>");
		out.println("</div>");
		return;
	} else {
		out.println("<div alight=center>");
		out.println("添加失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		out.println("</div>");
		return;
	}
%>