<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
    <%@ include file="comman.jsp"  %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>立创信息管理系统</title>		
	</head>
<!--
	<frameset rows="67,600*" cols="*" frameborder="NO" border="0"
		framespacing="0">
		<frame src="head.html" name="topFrame" frameborder="no" scrolling="NO"
			noresize marginwidth="0" marginheight="0">
			-->
		<frameset cols="171,836*" frameborder="NO" border="0" framespacing="0"
			rows="*" name="workaround">
			<frameset rows="15,*" cols="*" framespacing="0" frameborder="NO"
				border="0">
				<frame src="hidden_left_frame.html" name="topFrame1"
					frameborder="no" scrolling="no" noresize>
				<frame name="leftFrame" noresize scrolling="no"  src="menu.jsp"
					frameborder=NO marginwidth="0" marginheight="0">
			</frameset>
			<frameset rows="34,*" cols="*" framespacing="0" frameborder="no"
				border="0">
				<frame src="toolbar.jsp" name="toolBar" frameborder="no"
					scrolling="no" noresize marginwidth="0" marginheight="0"
					id="toolBar">
				<!--
      <frameset rows="*,50" cols="*" framespacing="0" frameborder="NO" border="0" >
      -->
      
    		<%
    		if(user.getDept().equals("销售二部") || user.getDept().equals("电子电器部") || user.getId()==79 || user.getId()==100 ||user.getId()==138){
    		%>
    		<frame name="main" src="physical/project/myproject.jsp" marginWidth=0 scrolling="yes"
					marginheight="0" noresize>
    		<%
    		}else{
    		%>
    		<frame name="main" src="note/system_notes.jsp" marginWidth=0 scrolling="yes"
					marginheight="0" noresize>
    		<%
    		}
    		 %>
				<!--
        <frame src="statusbar.html" name="bottomFrame" scrolling="NO" noresize>
      </frameset>
       
			</frameset>
			 -->
		</frameset>
	</frameset>
	<noframes>
		<body bgcolor="#FFFFFF">
		</body>
	</noframes>
</html>
