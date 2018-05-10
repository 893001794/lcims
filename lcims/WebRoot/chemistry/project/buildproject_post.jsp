<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page errorPage="../../error.jsp" %>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.TimerTask.MyTimerTask"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@ include file="../../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%
	request.setCharacterEncoding("GBK");
	String sidStr = request.getParameter("sid");
	System.out.println(sidStr);
	String []sidLeng =sidStr.split(",");
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	if(sidLeng.length<1) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	int id = 0;
	String strid = request.getParameter("id");
	System.out.println(strid);
	if(strid != null && !"".equals(strid)) {
		id = Integer.parseInt(strid);
	}
	
	String pid = request.getParameter("pid");
	if(pid == null || "".equals(pid)) {
		out.println("<script type='text/javascript'>");
		out.println("window.self.location='javascript:window.history.back();';");
		out.println("</script>");
		return;
	}
	
	String comappidStr = request.getParameter("comappid");
	System.out.print(comappidStr);
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
        comappid=Integer.parseInt(comappidStr);
	}
	
	String strrptime = request.getParameter("rptime");
	Date rptime = null;
	if(strrptime != null && !"".equals(strrptime)) {
		rptime = new SimpleDateFormat("yyy-MM-dd HH:mm").parse(strrptime);
	}
	
	String rpclient = request.getParameter("client");

	String rpclientE=ClientAction.getInstance().findClientEByName(rpclient);
	
	String contact = request.getParameter("contact");
	String samplename = request.getParameter("samplename");
	String samplecount = request.getParameter("samplecount");
	String testcontent = request.getParameter("testcontent");
	String notes = request.getParameter("notes");
	String level = request.getParameter("level");
	String servname = request.getParameter("servname");
	String createname = user.getName();
	String ptype = request.getParameter("ptype");
	String type = request.getParameter("type");
	//草稿版
	String draftV= request.getParameter("draft");
	if(draftV ==null || "".equals(draftV)){
	draftV="n";
	}
	//System.out.println("---------------"+draftV);
	String lab = request.getParameter("lab");
	String rptype = request.getParameter("rptype");
	String company = request.getParameter("company");
	String rid = request.getParameter("rid");
	String isout = request.getParameter("isout");
	String item = request.getParameter("item");
	String filingNo = request.getParameter("filingNo");
	System.out.println(filingNo);
%>
<%-- 
	if("新报价单".equals(quotype)) {
		rid = ProjectAction.getInstance().makeRid(company,ptype,type,lab,isout);
		if(isout == null || "".equals(isout)) {
			out.println("<div alight=center>");
			out.println("请返回选择是否外包！");
			out.println("<br><a href='javascript:window.history.back();'>返回</a>");
			out.println("</div>");
			return;
		}
	} else {
		rid = request.getParameter("rid");
		ChemProject ch = ProjectAction.getInstance().getProjectByRid(rid);
		type = ch.getType();
		lab = ch.getLab();
		isout = ch.getIsout();
		item = ch.getItem();
		rptype = ch.getRptype();
		servname = ch.getServname();
		contact = ch.getContact();
		samplename = ch.getSamplename();
		samplecount = ch.getSamplecount();
		testcontent = ch.getTestcontent();
	}
	
	if("修改报告报价单".equals(quotype)) {
		rid = ProjectAction.getInstance().getReRid(rid);
	}
--%>
<%	
	Project p = new Project();
	ChemProject cp = new ChemProject();
	p.setId(id);
	p.setRid(rid);
	p.setPid(pid);
	p.setPtype(ptype);
	p.setType(type);
	p.setIsout(isout);
	p.setLab(lab);
	p.setLevel(level);
	p.setTestcontent(testcontent);
	p.setNotes(notes);
	cp.setRptype(rptype);
	cp.setContact(contact);
	cp.setRptime(rptime);
	cp.setRpclient(rpclient);
	cp.setClientE(rpclientE);
	cp.setSamplename(samplename);
	cp.setSamplecount(samplecount);
	cp.setCreatename(createname);
	cp.setServname(servname);
	cp.setItem(item);
	cp.setDraft(draftV);
	cp.setFilingNo(filingNo);
	cp.setComappid(comappid);
	p.setObj(cp);
	boolean flag=false ;
	for (int i=0;i<sidLeng.length;i++){
		p.setSid(sidLeng[i]);
		flag=ChemProjectAction.getInstance().addChemProject(p);
	}
	if(flag == true) {
	long rp=new MyTimerTask().getTimeMillis(rptime.toLocaleString());//将一个时间格式转化为long
		//如果添加成功就动态将drptime（应出报告时间）添加到Map集合里面去
		new MyTimerTask().addTask(pid,rp);
		out.println("<div alight=center>");
		out.println("添加成功");
		out.println("<a href='projectdetail.jsp?sid=" + p.getSid() + "'>返回</a>");
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