
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="up" scope="page"
	class="com.jspsmart.upload.SmartUpload" />

<%
	request.setCharacterEncoding("GBK");
	String fs = System.getProperties().getProperty("file.separator");
	//String path = new Config().ANNEX_PATH; //����ϴ��������ļ���


	//--- �ϴ�ģ�� ---
	String TimeStamp = java.lang.String.valueOf((new Date()).getTime());
	String Msg = null;
	
	up.initialize(pageContext);
	up.upload();

    String icode = up.getRequest().getParameter("icode");

System.out.println("icode:" + icode + "  ctime:");
			//String path=fs+"opt"+fs+"annex";
			String path=fs+fs+"file"+fs+"10 ��Ѷ��"+fs+"attachmot";
			//System.out.println(path+":path");
	java.io.File savedir = new java.io.File(path);
	//System.out.println(savedir+":savedir");
	// ���Ŀ¼�����ھʹ���
	if (!savedir.exists()) {
		savedir.mkdirs();
	}
	
	for(int i=0;i<up.getFiles().getCount();i++) {
		com.jspsmart.upload.File file = up.getFiles().getFile(i);
		if(!file.isMissing()) {
			//���渽�����ļ�������
			String filepath = path + fs +icode+"."+file.getFileExt();
			System.out.println(file.getFileExt()+"-------------------------");
			//file.saveAs(filepath);
			//���渽��·�������ݿ�
		}
	}
	out.println("<script type='text/javascript'>");
	out.println("alert('�ϴ������ɹ�');");
	out.println("window.self.location='../note/system_notes.jsp';");
	out.println("</script>");
%>
<body bgcolor="eeeeee">
</body>