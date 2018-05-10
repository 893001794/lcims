<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="com.lccert.crm.user.UserForm"%>
<%@page import="java.net.InetAddress"%>

<%
	request.setCharacterEncoding("GBK");
	

	//response.setHeader("Location","");
	InetAddress addr = InetAddress.getLocalHost();
	String ip=addr.getHostAddress();//获得本机IP  
	//得到FORM的参数
	String command = request.getParameter("command");
	//判断参数的值是否等于变量command
	if(command != null && "login".equals(command)) {
	//得到文本框名称为username的值
		String username = request.getParameter("username");
		//得到文本框名称为password的值
		String password = request.getParameter("password");
		if(password.equals("12345678") || password.equals("123456")){
		out.println("<script type='text/javascript'>");
			out.println("alert('密码过于简单，请修改密码！！！');");
			out.println("window.self.location = 'password_modify.jsp?status=1';");
			out.println("</script>");
		}
		
		UserForm user = UserAction.getInstance().checkLogin(username,password);
		if(user == null) {
			response.sendRedirect("loginerror.jsp");
			return;
		} else {
			session.setAttribute("user",user);
			out.println("<script type='text/javascript'>");
			//out.println("window.open('notes.jsp','','height=500,width=700,status=no,toolbar=no,menubar=no,location=no,scrollbars=no');");
			out.println("window.self.location = 'main.jsp';");
			out.println("</script>");
			//response.sendRedirect("main.jsp");
			return;
		}
	}
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD><TITLE>立创信息管理系统</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<META http-equiv=Expires content=0>
<META http-equiv=Cache-Control content=no-cache>
<META http-equiv=Pragma content=no-cache><LINK 
href="images/Default.css" type=text/css rel=stylesheet>
<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />  
<script src="javascript/jquery.js"></script>
<script src="javascript/jquery.autocomplete.min.js"></script>
    <script src="javascript/jquery.autocomplete.js"></script>
<script type="text/javascript">
	function showAllDialog(obj) {
		if(obj==1){
		window.showModalDialog("note/addressBook_manage.jsp" ,"","dialogWidth:1000px;dialogHeight:700px");
		}
		if(obj == 2){
		window.showModalDialog("chemistry/barcode.jsp" ,"","dialogWidth:1000px;dialogHeight:700px");
		}
		if(obj == 3){
		window.showModalDialog("sample/samplerid.jsp" ,"","dialogWidth:1000px;dialogHeight:700px");
		}
		if(obj == 4){
		var mytr=document.getElementById("mytr");
			if(mytr.style.display=="none"){
			mytr.style.display="block";
			}else{
			mytr.style.display="none"
			}
		}
	}
</script>
<META content="MSHTML 6.00.2900.5880" name=GENERATOR></HEAD>
<BODY onload="document.form1.username.focus()">
<FORM 
onkeypress="submit" 
id=form1 name=form1 action="login.jsp?command=login" method=post>

<DIV><BR><BR><BR><BR><BR>
<TABLE cellSpacing=0 cellPadding=0 width=620 align=center border=0>
  <TBODY>
  <TR>
    <TD width=620><IMG height=11 src="images/login_p_img02.gif" 
      width=650></TD></TR>
  <TR>
    <TD align=middle background=images/login_p_img03.gif><BR>
      <TABLE cellSpacing=0 cellPadding=0 width=570 border=0>
        <TBODY>
        <TR>
          <TD><div align="center"> 
            </div><TABLE cellSpacing=0 cellPadding=0 width=570 border=0>
              <TBODY>
              <TR>
                <TD vAlign=top align="center"><h1 align="center">立创信息管理系统</h1></TD>
                </TR></TBODY></TABLE></TD></TR>
        <TR>
          <TD>&nbsp;</TD></TR>
        <TR>
          <TD><IMG height=3 src="images/a_te01.gif" 
        width=570></TD></TR>
        <TR>
          <TD align=middle background=images/a_te02.gif>
            <TABLE cellSpacing=0 cellPadding=0 width=520 border=0>
              <TBODY>
              <TR>
                <TD width=123 height=120><IMG height=95 
                  src="images/login_p_img05.gif" width=123 
                border=0></TD>
                <TD noWrap align=middle>
                  <TABLE cellSpacing=0 cellPadding=0 border=0>
                    <TBODY>
                    <TR>
                      <TD align=left height=25>用户名:</TD>
                      <TD style="WIDTH: 133px"><INPUT class=input 
                        id=txtUsername style="WIDTH: 120px" tabIndex=1 
                        maxLength=22 size=17 name=username>&nbsp; </TD>
                      <TD rowSpan=2><INPUT id=btnLogin 
                        style="BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px" 
                        type=image src="images/login_p_img11.gif" 
                        name=btnLogin></TD></TR>
                    <TR>
               
                      <TD align=left height=25>密&nbsp;&nbsp; 码：</TD>
                      <TD style="WIDTH: 133px"><INPUT class=input id=txtPass 
                        style="WIDTH: 120px" tabIndex=2 type=password 
                        maxLength=22 size=17 name=password>&nbsp; </TD>
                      
                      </TR>
                        
                    <TR>
                      <TD colSpan=3><SPAN id=lblMsg 
                        style="COLOR: red; BACKGROUND-COLOR: transparent"></SPAN></TD></TR>
                    <TR>
                    <TD style="TEXT-ALIGN: left" colSpan=3></TD></TR></TBODY></TABLE>&nbsp; &nbsp;&nbsp; &nbsp; 
                </TD></TR></TBODY></TABLE></TD></TR>
        <TR>
          <TD bgColor=#d5d5d5></TD></TR>
        <TR>
        	
          <TD>
            <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
              <TBODY>
              <TR>
	                <TD 
	                style="PADDING-RIGHT: 14px; PADDING-LEFT: 14px; PADDING-BOTTOM: 14px; PADDING-TOP: 14px; HEIGHT: 80px;size: 30px" align="center" >
	                <a href="javascript:showAllDialog(4)">防伪码</a>
	                <a href="javascript:showAllDialog(1)">通讯录</a>
	                 <a href="javascript:showAllDialog(2)">条形码</a>
	                  <a href="javascript:showAllDialog(3)">样品标签</a>
	                  <font style="color: red;">初始密码:12345678</font>
	                  <br><br>
	                  <div style="display: none;" id ="mytr" name ="mytr">
	                  	报告号:<input id ="rid" name ="rid" type="text" value="">
	                  	<script>   
						        $("#rid").autocomplete("vrid_ajax.jsp",{
						            delay:10,
						            minChars:1,
						            matchSubset:1,
						            matchContains:1,
						            cacheLength:5,
						            matchContains: true,   
						            scrollHeight: 250, 
						            width:250,
						            autoFill:false
						        });    
						        
						        /***
	 * 根据报告号获取防伪码
	 */
	
	
	function ajaxsecurity(){
		var rid =document.getElementById("rid").value;
		$.ajax({ //调用jquery ajax
			type:"POST",  //跳转方法为POST
			url:"/lcims/verificationS", //跳转了路径
			data:"rid="+rid, //传输的值或参数
	        error: function(){alert("error!!");},  //如果路径错误或者参数有错的时候就弹出此窗口
			success: function(data){  //如果正确或拿到java里面传输过来的值
				//alert(data);
				if(data =="1"){
					$("#security").val("该报告还没有付款！！");
				}else{
					$("#security").val(data);
				}
			}
		});
		
	}
						     </script>   
                                                               防伪码:<input id ="security" name ="security" type="text" value="" onfocus="ajaxsecurity();">
	                  </div>
	                </TD>
                </TR>
                
                </TBODY>
                </TABLE>
                
                </TD></TR></TBODY></TABLE></TD></TR>
  <TR>
    <TD><IMG height=11 src="images/login_p_img04.gif" 
  width=650></TD></TR></TBODY></TABLE><BR></DIV>
</FORM></BODY></HTML>
