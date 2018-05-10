<%@page import="com.lccert.crm.client.ClientProjectAction"%>
<%@page import="com.lccert.crm.client.ClientProjectForm"%>
<%@page import="com.lccert.crm.client.ClientStatusForm"%>
<%@page import="com.lccert.crm.client.ClientRivalForm"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.quotation.QuotationAction"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@page import="com.lccert.crm.kis.Order"%>
<%@page import="com.lccert.crm.kis.QuoItem"%>
<%@page import="com.lccert.crm.kis.Item"%>
<%@page import="com.lccert.crm.kis.ItemAction"%>
<%@page import="com.lccert.crm.kis.OrderAction"%>
<%@page import="com.lccert.crm.kis.Company"%>
<%@page import="com.lccert.crm.client.ClientForm"%>
<%@page import="com.lccert.crm.kis.Bank"%>
<%@page import="com.lccert.crm.kis.AdvanceType"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@ include file="../comman.jsp"  %>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.lccert.crm.quotation.Quotation"%>
<%
	request.setCharacterEncoding("GBK");
	ClientProjectForm clientProject=new ClientProjectForm();
	String id = request.getParameter("id");
	String clientId = request.getParameter("clientId");
	String client = request.getParameter("client");
	String type = request.getParameter("type");
	String sort = request.getParameter("sort");
	String procure = request.getParameter("procure");
	String projectRound = request.getParameter("projectround");
	String projectAmountStr = request.getParameter("projectamount");
	float projectAmount=0f;
	if(projectAmountStr !=null && !projectAmountStr.equals("")){
		projectAmount=Float.parseFloat(projectAmountStr);
	}
	List<ClientRivalForm> clientRivalList = new ArrayList<ClientRivalForm>();
	String[] rivalid = request.getParameterValues("rivalid");
	String[] name = request.getParameterValues("name");
	String[] rank = request.getParameterValues("rank");
	String[] advantage = request.getParameterValues("advantage");
	String[] inferior = request.getParameterValues("inferior");
	String[] chance = request.getParameterValues("chance");
	String[] methods = request.getParameterValues("methods");
	String[] period = request.getParameterValues("period");
	for(int i=0;i<name.length;i++) {
		if(name[i] != null && !"".equals(name[i])) {
			ClientRivalForm clientRival= new ClientRivalForm();
			if(rivalid !=null && rivalid[i] !=null && !"".equals(rivalid[i])){
				clientRival.setId(Integer.parseInt(rivalid[i]));
			}
			clientRival.setName(name[i]);
			clientRival.setRank(rank[i]);
			clientRival.setAdvantage(advantage[i]);
			clientRival.setInferior(inferior[i]);
			clientRival.setChance(chance[i]);
			clientRival.setMethods(methods[i]);
			clientRival.setPeriod(period[i]);
			clientRivalList.add(clientRival);
		}
	}
	SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd");
	List<ClientStatusForm> clientStatusList=new ArrayList<ClientStatusForm>();
	String[] followupdate = request.getParameterValues("followupdate");
	String[] statuscas = request.getParameterValues("statuscas");
	String[] stautsId = request.getParameterValues("stautsId");
	String[] remark = request.getParameterValues("remark");
	String[] register = request.getParameterValues("register");
	
	for(int i=0;i<followupdate.length;i++) {
		if(followupdate[i] != null && !"".equals(followupdate[i])) {
			ClientStatusForm clientStatus= new ClientStatusForm();
			if(stautsId !=null && i<stautsId.length){
				clientStatus.setId(Integer.parseInt(stautsId[i]));
			}
			if(followupdate[i] !=null && i<followupdate.length){
				clientStatus.setFollowUpdate(sdf.parse(followupdate[i]));
			}
			clientStatus.setStatusCas(statuscas[i]);
			clientStatus.setRemark(remark[i]);
			clientStatus.setRegister(register[i]);
			clientStatusList.add(clientStatus);
		}
	}
	clientProject.setClientId(clientId);
	clientProject.setClientName(client);
	clientProject.setType(type);
	clientProject.setSort(sort);
	clientProject.setProcure(procure);
	clientProject.setProjectRound(projectRound);
	clientProject.setProjectAmount(projectAmount);
	clientProject.setClientRivalList(clientRivalList);
	clientProject.setClientStatusList(clientStatusList);
	int isok = 0;
	System.out.println(id);
	if(id !=null && !"".equals(id)&& !"null".equals(id)){
		clientProject.setId(Integer.parseInt(id));
		isok=ClientProjectAction.getInstance().modifyClientProject(clientProject);
	}else{
		isok=ClientProjectAction.getInstance().addClientProject(clientProject);
	}
	if(isok != 0) {
		out.println("销售客户跟进记录操作成功");
		out.println("<br><a href='javascript:window.location.href=\"addclientstatus.jsp?clientid="+clientId+"\";'>返回</a>");
		return;
	} else {
		out.println("销售客户跟进记录操作失败，请返回重新输入！");
		out.println("<br><a href='javascript:window.history.back();'>返回</a>");
		return;
	}
	
%>