
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="up" scope="page"
	class="com.jspsmart.upload.SmartUpload" />

<%
	request.setCharacterEncoding("GBK");
	String fs = System.getProperties().getProperty("file.separator");
	//String path = new Config().ANNEX_PATH; //存放上传附件的文件夹


	//--- 上传模块 ---
	String TimeStamp = java.lang.String.valueOf((new Date()).getTime());
	String Msg = null;
	
	up.initialize(pageContext);
	up.upload();

    String icode = up.getRequest().getParameter("icode");

System.out.println("icode:" + icode + "  ctime:");
			//String path=fs+"opt"+fs+"annex";
			String path=fs+fs+"file"+fs+"10 资讯部"+fs+"attachmot";
			//System.out.println(path+":path");
	java.io.File savedir = new java.io.File(path);
	//System.out.println(savedir+":savedir");
	// 如果目录不存在就创建
	if (!savedir.exists()) {
		savedir.mkdirs();
	}
	
	for(int i=0;i<up.getFiles().getCount();i++) {
		com.jspsmart.upload.File file = up.getFiles().getFile(i);
		if(!file.isMissing()) {
			//保存附件到文件服务器
			String filepath = path + fs +icode+"."+file.getFileExt();
			System.out.println(file.getFileExt()+"-------------------------");
			//file.saveAs(filepath);
			//保存附件路径到数据库
		}
	}
	out.println("<script type='text/javascript'>");
	out.println("alert('上传附件成功');");
	out.println("window.self.location='../note/system_notes.jsp';");
	out.println("</script>");
%>
<body bgcolor="eeeeee">
</body>