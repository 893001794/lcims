
<%@page import="java.net.InetAddress"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@ include file="comman.jsp"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">

		<title>ϵͳ�˵�</title>
	</HEAD>
	<body text="#FFFFFF" topmargin="0" leftmargin=0>
		<SCript LANGUAGE=JSCRIPT>
	<%
	 InetAddress addr = InetAddress.getLocalHost();
	 String ip = addr.getHostAddress();//��ñ���IP
	//����ipΪ192.168.0.10������10.11.1.222
	if(!ip.equals("10.11.1.222")){//IpΪ10.11.1.222�����ڶ�ݸ��ip��ֻ�ܿ���������Ϣ
			if(user.getCompanyid() !=4){%>
			OutBarFolder1=new Array("�ͻ�����"
		<%
		//if(user.getTicketid().matches("1\\d\\d\\d\\d\\d\\d\\d")) {//IpΪ10.11.1.222�����ڶ�ݸ��ip��ֻ�ܿ���������Ϣ
		%>
			,"images/admin.gif","�ҵĿͻ�","client/myclient.jsp","parent.parent.main",
			 "images/admin.gif","�ͻ����۸�������","client/clientsalesstatus.jsp","parent.parent.main",
			 "images/admin.gif","���ӿͻ�","client/addclient.jsp","parent.parent.main",
			 "images/admin.gif","�����ͻ�","client/searchclient.jsp","parent.parent.main"
		<%
		}if((user.getSales().equals("y") && user.getCtsname() !=null) || user.getId()==103 || user.getId()==130){//������Ȩ�޻����û�id==10��130�����Բ���
			String ctsName="";
			if(user.getDept().indexOf("����")>-1){//�����а�������
				ctsName=user.getCtsname();
			}
		%>
			,"images/admin.gif","�ͻ�����","oavaction/VOLClient.jsp?ctsName=<%=ctsName%>","parent.parent.main"
		<%
		}
		%>	 
			 ); 
		<%
		}
		%>	 
			OutBarFolder2=new Array("���۹���"
			<%
			if(user.getName().equals("�ຣɺ")||user.getId()==110){
			%>
			,"images/admin.gif","���ӱ��۵�","kis/addorder.jsp","parent.parent.main"
			,"images/admin.gif","�������۵�","kis/order_manage.jsp","parent.parent.main"
			<%
			}
		if(user.getTicketid().matches("1\\d\\d\\d\\d\\d\\d\\d")) {//Ȩ��Ϊ10000000��������Ȩ����
		%>
			,"images/admin.gif",	"�ҵı��۵�","kis/myorder.jsp","parent.parent.main",
			"images/admin.gif","���ӱ��۵�","kis/addorder.jsp","parent.parent.main"
			
			<%
			if(user.getTicketid().matches("\\d1\\d\\d\\d\\d\\d\\d")) {//Ȩ��Ϊ01000000��������Ȩ����
			%>
			,"images/admin.gif","�������۵�","kis/order_manage.jsp","parent.parent.main"
		<%
			}
		}if(user.getName().equals("ŷ����")||user.getId()==138||user.getId()==103||user.getId()==188){
			%>
			,"images/admin.gif","EMC����","emckis/order_manage.jsp","parent.parent.main"
		<%
			}
		%>
		
			);
			OutBarFolder3=new Array("���۹���"
		<%
		if(user.getTicketid().matches("1\\d\\d\\d\\d\\d\\d\\d")) {//Ȩ��Ϊ10000000��������Ȩ����
		%>
			 ,"images/admin.gif",	"�ҵĶ���","quotation/myquotation.jsp","parent.parent.main",
			 "images/admin.gif","��ѯ����","quotation/searchquotation.jsp","parent.parent.main",
			"images/admin.gif",	"��ѧ�����","http://report.lccert.com:1234/report/application/pid.jsp","parent.parent.main",
			 "images/admin.gif","��Ŀ�ֽ�","project/project_finance_manage.jsp","parent.parent.main",
			  "images/admin.gif","������Ŀͳ��","quotation/phpprojecttree/index.html","parent.parent.main"
		<%
		}
		 if(user.getName().equals("�ຣɺ")){
			%>
			, "images/admin.gif","��ѯ����","quotation/searchquotation.jsp","parent.parent.main"
		<%
		}
		%>		 
			 ); 
			OutBarFolder4=new Array("��Ʒ����"
			
			<%
			if(!user.getName().equals("ŷ����")){
			%>
			,"images/admin.gif","���Ӱ���","sample/sample_package.jsp","parent.parent.main"
			,"images/admin.gif","�鿴����","sample/search_samplepackage.jsp","parent.parent.main"
			, "images/admin.gif","������Ʒ","sample/sample.jsp","parent.parent.main"
			, "images/admin.gif","��Ʒ����","sample/search_sample.jsp","parent.parent.main"
			<%
			}
		%>
			);
		
			OutBarFolder5=new Array("�ͷ�����"
		<%
		if(user.getTicketid().matches("\\d\\d1\\d\\d\\d\\d\\d")) {//Ȩ��Ϊ00100000��������Ȩ����
		%>
			,
			 "images/admin.gif","��Ŀ�ŵ�","chemistry/project/project_manage.jsp","parent.parent.main",
			 "images/admin.gif","������Ŀ","chemistry/project/myproject.jsp","parent.parent.main",
			 "images/admin.gif","������ת��","chemistry/project/searchproject.jsp","parent.parent.main",
			 "images/admin.gif","������ת��","chemistry/flow/flow_manage.jsp","parent.parent.main",
			  "images/admin.gif","�������","isout/outproject_manage.jsp","parent.parent.main",
			  "images/admin.gif","�½�ͳ��","chemistry/lab/clientproject.jsp","parent.parent.main",
			  "images/admin.gif","��Ŀ��ѯ����","chemistry/project/searchrid.jsp","parent.parent.main",
			   "images/admin.gif","ʵ������ת��","chemistry/flow/department_flow_manage.jsp","parent.parent.main"
		<%
		}
		%>	
			);
			OutBarFolder6=new Array("���Բ�����"
			<%
		if(user.getReportStart().equals("y")&&!user.getName().equals("ŷ����")){//�������ɱ����Ȩ�޲����û���������ŷ����
		%>
			,"images/admin.gif","�������","chemistry/project/reportmanage.jsp","parent.parent.main"
		 <%	
		}
		if(user.getTicketid().matches("\\d\\d1\\d\\d\\d\\d\\d")) {//Ȩ��Ϊ00100000��������Ȩ����
		%>
		    ,"images/admin.gif","��Ʒ�Ǽ�","sample/sampleRegistration.jsp","parent.parent.main"
			 ,"images/admin.gif","������Ŀ","chemistry/lab/mylabproject.jsp","parent.parent.main"
			 <%
			 if(user.getId()==113 || user.getId()==133 ||user.getId()==144 || user.getId()==101 || user.getId()==85  || user.getId()==103){
		%>
			  ,"images/admin.gif","���󱨸�","testvolumetry/subjudice.jsp","parent.parent.main"
		 <%	
		}
			 %>
			  ,"images/admin.gif","�ӵ�ͳ��","chemistry/lab/todayproject.jsp","parent.parent.main"
			  ,"images/admin.gif","�ۺ�ͳ��","chemistry/lab/lateproject.jsp","parent.parent.main"
			  ,"images/admin.gif","��������","testvolumetry/volumetry_manage.jsp","parent.parent.main"
		<%
		}
		%>	
			);
				OutBarFolder7=new Array("���̲�����"
		<%
		if(user.getTicketid().matches("\\d\\d\\d\\d\\d\\d1\\d")) {
		%>
			 ,"images/admin.gif","���ӹ��̲���","engineering/project_chemistry_manage.jsp","parent.parent.main"
			 <%
		}
		%>	
		<%
		if(!user.getName().equals("֣�")&& (user.getDept().equals("���̲�")|| user.getId()==103)|| user.getId()==133) {
		//�û�������֣����ң����ŵ��ڹ��̲������û���id==103����133�����Բ鿴��ת��
		%>
			, "images/admin.gif","������ת��","chemistry/project/searchproject.jsp","parent.parent.main"
			 ,"images/admin.gif","������ת��","chemistry/flow/flow_manage.jsp","parent.parent.main"
			 ,"images/admin.gif","��Ʒ����","engineering/product_manager.jsp","parent.parent.main"
			 ,"images/admin.gif","ʳƷ������","engineering/food_manager.jsp","parent.parent.main"
			 ,"images/admin.gif","������Ŀ��ϸ","chemtest/searchchemtest.jsp","parent.parent.main"
			 	<%
		}
		if(user.getId()==101){//�û�id==101
		%>
			,"images/admin.gif","������Ŀ��ϸ","chemtest/searchchemtest.jsp","parent.parent.main"
		<%
		}
		%>
			);
			OutBarFolder8=new Array("���ӵ�������"
			<%
		if(user.getTicketid().matches("\\d\\d1\\d\\d\\d\\d\\d")||user.getId()==110||user.getId()==123) {//Ȩ��Ϊ01000000��������Ȩ�����ŵ�
		%>
			,"images/admin.gif","��Ŀ�ŵ�","physical/project/phyproject_paidan.jsp","parent.parent.main"
			 ,"images/admin.gif","����������Ŀ","physical/project/phyproject_manage.jsp","parent.parent.main"
			 ,"images/admin.gif","����ʵ����","physical/lab/phylab_manage.jsp","parent.parent.main"
			 ,"images/admin.gif","��Ŀ״̬","physical/phpprojecttree/index.html","parent.parent.main"
			 ,"images/admin.gif","��������","physical/quote/searchquotation.jsp","parent.parent.main"
			
			
		<%
		
		}if(user.getDept().equals("���ӵ�����") || user.getId()==103) {//�û����ŵ��ڵ��ӵ��������û�id==103���Բ鿴������Ŀ��ϸ
		%>	
		 ,"images/admin.gif","������Ŀ��ϸ","physical/project/myproject.jsp","parent.parent.main"
		 <%
		   } 
		    %>
		      );
			 
			OutBarFolder9=new Array("�������"
		
		<%
		if(user.getId()  == 103 || user.getId() ==123 || user.getId() ==141) {//�û�id==103����==123����==141���Բ鿴ǩ��ͳ��
		%>	
		 ,"images/admin.gif","ǩ��ͳ��","finance/bills/bills_manage.jsp","parent.parent.main"
		<%
		}
		%>
		<%
		if(user.getId()  == 103 || user.getId() ==123 || user.getId() ==110 || user.getId()==158) {//�û�id==103����==123����==110���Բ鿴��Ŀͳ��
		%>	
		 ,"images/admin.gif","��Ŀͳ��","finance/quotation/project_manage.jsp","parent.parent.main"
		<%
		}
		%>
		<%
		if(user.getId()==233){
		%>
		,"images/admin.gif",	"��������","finance/quotation/quotation_manage.jsp","parent.parent.main"
		<%
		}
		if(user.getTicketid().matches("\\d\\d\\d1\\d\\d\\d\\d")) {//Ȩ��Ϊ00100000��������Ȩ��
		%>	
			, "images/admin.gif","��ѯ����","quotation/searchquotation.jsp","parent.parent.main"
			,"images/admin.gif",	"��������","finance/quotation/quotation_manage.jsp","parent.parent.main"
			//,"images/admin.gif","������Ŀ","finance/project/project_manage.jsp","parent.parent.main"
			 ,"images/admin.gif","���ն���","finance/quotation/quotation_confirm.jsp","parent.parent.main"
			 ,"images/admin.gif","֧�����뱨","cashcount/fpay_manage.jsp","parent.parent.main"
			 ,"images/admin.gif","�������뱨","cashcount/fincome_manage.jsp","parent.parent.main"
			 <%
			 if(user.getTicketid().matches("\\d\\d\\d1\\d1\\d\\d")&&user.getId()!=158&&user.getId()!=396) {//Ȩ��Ϊ00100000��������Ȩ�޿��Բ鿴����ͳ�ƺ�һ�������Ͷ�������
			 %>
			 ,"images/admin.gif","����ͳ��","finance/quotation/finance.jsp","parent.parent.main"
			 ,"images/admin.gif","һ������ͳ��","finance/quotation/financequotationexport.jsp","parent.parent.main"
			  <%
			 if(!user.getName().equals("֣�")&&user.getId()!=158 &&user.getId()!=396) {//�û�����Ϊ֣�
			 %>
			 ,"images/admin.gif","��������ͳ��","finance/quotation/financequotationexport2.jsp","parent.parent.main"
		<%
			}
			}
		}
		%>	 
			); 
		
		
			OutBarFolder10=new Array("��������"
				<%
			if(user.getId()==193 || user.getId()==194 || user.getId()==366 || user.getId()==85 || user.getId()==195 || user.getId()==103 || user.getId()==105 || user.getId() == 169|| user.getId() == 123 || user.getId()==248||user.getId()==158||user.getId()==375 || user.getId()==396 || user.getId()==452 || user.getId()==372) {
			//�û���id=193����==194����==195����==103����==105����==169����==123����==248���Բ鿴����������Ϣ
			%>
				 ,"images/admin.gif","�������","app/app_add.jsp","parent.parent.main"
				 ,"images/admin.gif","�������","app/app_main.jsp","parent.parent.main"
				 ,"images/admin.gif","������λ","app/sup_add.jsp","parent.parent.main"
				  ,"images/admin.gif","�ܿλ","app/sup_main.jsp","parent.parent.main"
				 
			<%
				}
			if(user.getId()==218 || user.getId()==219){//�û�id==218����219��Ʒ����
			%>
			 ,"images/admin.gif","����ѯ","app/inventory.jsp","parent.parent.main"
			  ,"images/admin.gif","��Ʒ����","article/article_manage.jsp","parent.parent.main"
			<%
			}
			if(user.getId()==195 || user.getId()==103){//�û�Id==195����==103���Բ鿴���ڹ���
			%>
			 ,"images/admin.gif","���ڹ���","oavaction/vactiontype.jsp","parent.parent.main"
			 <%
			}
		
		%>	
			);
			
			OutBarFolder11=new Array("ϵͳ����"
			 ,"images/admin.gif","�����޸�","password_modify.jsp","parent.parent.main"
				<%
				if(user.getTicketid().matches("11111111")||user.getName().equals("�¼���")) {
				//�û�Ȩ�޵���11111111���ߵ��ڳ¼������Բ鿴�û�������ͨѶ¼��Ⱥ����ַ
				%>
					 ,"images/admin.gif","�û�����","user/addUser.jsp","parent.parent.main"
					,"images/admin.gif","ͨѶ¼","address.jsp","parent.parent.main"
					,"images/admin.gif","Ⱥ����ַ","http://report/report/mail/mail.jsp","parent.parent.main"
					//,"images/admin.gif","Ⱥ����ַ","http://127.0.0.1:8080/report/mail/mail.jsp","parent.parent.main"
				<%
				}
		%>	
		 , "images/admin.gif","�������","note/system_notes.jsp","parent.parent.main"
		  , "images/admin.gif","swf�ĵ�","note/pdf2swf.jsp","parent.parent.main"
		  , "images/admin.gif","¼��ͳ��","note/record.jsp","parent.parent.main"
		  , "images/admin.gif","����","task/task.jsp","parent.parent.main"
			);
			
			
			OutBarFolder12=new Array("���������"
				<%
					if(user.getId()==369||user.getId()==359||user.getId()==145||user.getId()==203||user.getId()==101||user.getId()==231||user.getId()==114||user.getId()==77||user.getId()==118||user.getId()==316||user.getId()==390){
					%>
					,"images/admin.gif","���洦��","chemistry/project/reportmanage.jsp","parent.parent.main" //1
					, "images/admin.gif","��Ŀ����","chemistry/flow/flow_manage.jsp","parent.parent.main"    //3
					<%
					}
					if(user.getId()==369||user.getId()==359||user.getId()==145||user.getId()==203||user.getId()==101||user.getId()==231||user.getId()==114||user.getId()==77){
					%>
					,"images/admin.gif","�����ѯ","quotation/searchquotation.jsp","parent.parent.main"
					<%
					}
					if(user.getId()==101||user.getId()==231||user.getId()==114||user.getId()==77){
					%>
					, "images/admin.gif","��Ŀ��ѯ����","chemistry/project/searchrid.jsp","parent.parent.main"
					,"images/admin.gif","�ӵ�ͳ��","chemistry/lab/todayproject.jsp","parent.parent.main"
					,"images/admin.gif","�ۺ�ͳ��","chemistry/lab/lateproject.jsp","parent.parent.main"
					,"images/admin.gif","������Ŀ��ϸ","chemtest/searchchemtest.jsp","parent.parent.main"
					, "images/admin.gif","������ת��","chemistry/project/searchproject.jsp","parent.parent.main"
					<%
					}
				%>
			);
			
			<%
			if(user.getId() ==103||user.getId()==419||user.getId() ==99||user.getId() ==365||user.getId() ==397||user.getId() ==101){
				%>
				OutBarFolder13=new Array("����������"
				<%
					//if(user.getReportStart().equals("y")&&!user.getName().equals("ŷ����")){//�������ɱ����Ȩ�޲����û���������ŷ����
					%>
						,"images/admin.gif","�������","chemistry/project/reportmanage.jsp","parent.parent.main"
					 <%	
					//}
					//if(!user.getName().equals("֣�")&& (user.getDept().equals("���̲�")|| user.getId()==103)|| user.getId()==133) {
					//�û�������֣����ң����ŵ��ڹ��̲������û���id==103����133�����Բ鿴��ת��
					%>
					, "images/admin.gif","������ת��","chemistry/project/searchproject.jsp","parent.parent.main"
					 ,"images/admin.gif","������ת��","chemistry/flow/flow_manage.jsp","parent.parent.main"
					<%
					//	}
					%>
					,"images/admin.gif","��Ʒ����","article/article_manage.jsp","parent.parent.main"
				);
				
				 OutBarFolder14=new Array("");
				 OutBarFolder15=new Array("");
				<%
				
			//}
		}
%>
	
 </Script>
		<SCRIPT LANGUAGE="JAVASCRIPT">
	OB_Top=0;									//�˵����붥��������ֵ��
	OB_Left=0;									//�˵�������������ֵ��
	OB_Margin=10;								//top and bottom margins between icons and borders
	OB_Width=172;								//�˵�����
	newHeight=window.screen.height
	OB_Height=newHeight-160;                 	//�˵��߶�225
	OB_SlideSpeed=10;							//�˵��˶��ٶ�
	OB_BackgroundColor="#088A4B";    		//����ɫ
	OB_ItemsSpacing=25;							//2��ͼ���ľ���
	OB_BorderWidth=3;							//border����
	OB_BorderStyle="ridge";						//border���
	OB_BorderColor="#dddddd";					//border��ɫ
	OB_IconsWidth=32;							//ͼ�����
	OB_IconsHeight=32;							//ͼ��߶�
	OB_ButtonFontFamily="arial";				//��ť�����������
	OB_ButtonFontSize=9;						//��ť�������С 
	OB_ButtonFontColor="black";					//��ť��������ɫ    
	OB_ButtonHeight=22;							//��ť�ĸ߶�
	OB_LabelFontFamily="arial";					//LOGO�����������
	OB_LabelFontSize=9;							//LOGO����������С
	OB_LabelFontColor="white";					//LOGO�µ�������ɫ
	OB_LabelMargin=3;							//margin between labels and icons
	OB_DownArrow="images/arrowup.gif";			//���¹�����logo��ͷ
	OB_UpArrow="images/arrowdown.gif";			//���Ϲ�����logo��ͷ
	OB_ArrowWidth=15;							//��ͷ�Ŀ���
	OB_ArrowHeight=15;							//��ͷ�ĸ߶�
	OB_ArrowSlideSpeed=10;						//��Ŀ�б��������ٶȣ�

/*���µĴ���������Ҫ�Ķ��˵�����Ŀ��ʵ��һ�£���������4����ť�˵���*/
function MakeItems(Folder,zorder,top)
{
	var items=0;
	var folderWidth=(OB_Width-OB_BorderWidth*2);
	while(Folder[items+1])
		items+=4;  //��Ҫ�����Ｐ�����4��
	items/=4;
	document.write("<DIV id='OB_Folder"+zorder+"' style='position:absolute;left:0;top:"+top+";width:"+folderWidth+";height:"+(OB_Margin*2+items*(OB_IconsHeight+OB_LabelFontSize+OB_LabelMargin)+(items-1)*OB_ItemsSpacing)+";z-index:"+zorder+";clip:rect(0 0 0 0);'>");
	for(var i=1;i<items*4;i+=4)
	{
		document.write("<div targetFrame='"+Folder[i+3]+"' link='"+Folder[i+2]+"' onMouseDown='OutlookLikeBar.ItemClicked(this)' onMouseUp='OutlookLikeBar.ItemSelected(this)' onMouseOver='OutlookLikeBar.OverItems(this)' onMouseOut='OutlookLikeBar.OutItems(this)' style='position:absolute;left:"+(Math.ceil((OB_Width-OB_BorderWidth*2-OB_IconsHeight)/2)-1)+";top:"+(OB_Margin+Math.ceil((i-1)/4)*(OB_ItemsSpacing+OB_LabelFontSize+OB_IconsHeight))+";cursor:hand;clip:rect(0 "+OB_IconsWidth+" "+OB_IconsHeight+" 0;width:"+OB_IconsWidth+";height:"+OB_IconsHeight+"'>");
 		document.write("<img src='"+Folder[i]+"'>");
		document.write("</div>");
		document.write("<div align='center' style='position:absolute;width:160;left:0;top:"+(OB_LabelMargin+OB_IconsHeight+OB_Margin+Math.ceil((i-1)/4)*(OB_ItemsSpacing+OB_LabelFontSize+OB_IconsHeight))+";font-family:"+OB_LabelFontFamily+";font-size:"+OB_LabelFontSize+"pt;color:"+OB_LabelFontColor+"'>");
	//	document.write("<div align='center' style='position:absolute;width:160;left:50;top:"+(OB_LabelMargin+OB_IconsHeight+OB_Margin+Math.ceil((i-1)/4)*(OB_ItemsSpacing+OB_LabelFontSize+OB_IconsHeight))+";font-family:"+OB_LabelFontFamily+";font-size:"+OB_LabelFontSize+"pt;color:"+OB_LabelFontColor+"'>");
		document.write(Folder[i+1]);
		document.write("</div>");
	}	
	document.write("</DIV>");
}

//***************************
//* Outlook-Like Bar Object *
//***************************
function OutBar(width,height,items,buttonHeight,borderWidth,slideSpeed,slideArrowValue,ArrowSlideSpeed)
{
	this.currentFolder=1;
	this.currentItem=null;
	this.slideCount=0;
	this.slideStep=1;
	this.slideArrowValue=slideArrowValue;
	this.slideSpeed=slideSpeed;
	this.borderWidth=borderWidth;
	this.width=width;
	this.visibleAreaHeight=height-2*borderWidth-items*buttonHeight;
	this.visibleAreaWidth=width;
	this.FolderClicked=FolderClicked;
	this.SlideFolders=SlideFolders;
	this.ItemClicked=ItemClicked;
	this.ItemSelected=ItemSelected;
	this.OverItems=OverItems;
	this.OutItems=OutItems;
	this.OverArrow=OverArrow;
	this.OutArrow=OutArrow;
	this.ArrowClicked=ArrowClicked;
	this.ArrowSelected=ArrowSelected;
	this.ArrowSlideSpeed=ArrowSlideSpeed;
	this.SlideItems=SlideItems;
	this.SlideItemsAction=SlideItemsAction;
	this.Start=Start;
	this.ClipFolder=ClipFolder;
	this.SetArrows=SetArrows;
	this.HideArrows=HideArrows;
	this.sliding=false;
	this.items=items;
	this.started=false;
	this.Start();
}

function FolderClicked(folder)
{
	if(this.sliding)
		return;
	if(folder==this.currentFolder)
		return;
	this.sliding=true;		
	this.slideCount=this.visibleAreaHeight;
	this.slideStep=1;
	this.countStep=0;
	this.HideArrows();
	this.SlideFolders(folder,document.all["OB_Button"+folder].position=="DOWN");
}

function SlideFolders(folder,down)
{
	var step;	
	if(down)
	{
		this.slideCount-=Math.floor(this.slideStep);
		if(this.slideCount<0)
			this.slideStep+=this.slideCount;
		step=Math.floor(this.slideStep);
		for(var i=2;i<=folder;i++)
			if(document.all["OB_Button"+i].position=="DOWN")
			{
				document.all["OB_Button"+i].style.pixelTop-=step;
				document.all["OB_Folder"+i].style.pixelTop-=step;
			}				

	    filter = /rect\((\d*)px (\d*)px (\d*)px (\d*)px\)/;

		var clipString=document.all["OB_Folder"+folder].style.clip;
		var clip=clipString.match(filter);
		this.ClipFolder(folder,parseInt(clip[1]),this.visibleAreaWidth,(parseInt(clip[3])+step),0);

		var clipString=document.all["OB_Folder"+this.currentFolder].style.clip;
		var clip=clipString.match(filter);
		this.ClipFolder(this.currentFolder,parseInt(clip[1]),this.visibleAreaWidth,(parseInt(clip[3])-step),0);

		this.slideStep*=this.slideSpeed;
		if(this.slideCount>0)
			setTimeout("OutlookLikeBar.SlideFolders("+folder+",true)",20);
		else		
		{
			for(var k=2;k<=folder;k++)
				document.all["OB_Button"+k].position="UP";
			this.currentFolder=folder;		
			this.SetArrows();
			this.sliding=false;		
		}		
	}
	else		
	{
		this.slideCount-=Math.floor(this.slideStep);
		if(this.slideCount<0)
			this.slideStep+=this.slideCount;
		step=Math.floor(this.slideStep);
		for(var i=folder+1;i<=this.items;i++)
			if(document.all["OB_Button"+i].position=="UP")
			{
				document.all["OB_Button"+i].style.pixelTop+=step;
				document.all["OB_Folder"+i].style.pixelTop+=step;
			}

	    filter = /rect\((\d*)px (\d*)px (\d*)px (\d*)px\)/;

		var clipString=document.all["OB_Folder"+folder].style.clip;
		var clip=clipString.match(filter);
		this.ClipFolder(folder,parseInt(clip[1]),this.visibleAreaWidth,(parseInt(clip[3])+step),0);
var clipString=document.all["OB_Folder"+this.currentFolder].style.clip;
		var clip=clipString.match(filter);
		this.ClipFolder(this.currentFolder,parseInt(clip[1]),this.visibleAreaWidth,(parseInt(clip[3])-step),0);

		this.slideStep*=this.slideSpeed;
		if(this.slideCount>0)
			setTimeout("OutlookLikeBar.SlideFolders("+folder+",false)",20);
		else		
		{
			for(var k=folder+1;k<=this.items;k++)
				document.all["OB_Button"+k].position="DOWN";
			this.currentFolder=folder;		
			this.SetArrows();
			this.sliding=false;		
		}		
	}
}

function ItemClicked(item)
{
	if(this.sliding)
		return;		
	item.style.border="2 inset #ffffff";
}

function ItemSelected(item)
{
	if(this.sliding)
		return;		
	item.style.border="1 outset #ffffff";
	if(item.link.indexOf("javascript")!=-1) 
		eval(item.link)
	else 
		eval(item.targetFrame+".location='"+item.link+"'");
}

function OverItems(item)
{
	if(this.sliding)
		return;		
	item.style.border="1 outset #ffffff";
}

function OutItems(item)
{
	if(this.sliding)
		return;		
	item.style.border="0 none black";
}

function ArrowClicked(arrow)
{
	if(this.sliding)
		return;		
	arrow.style.border="1 inset #ffffff";
}

function ArrowSelected(arrow)
{
	if(this.sliding)
		return;		
	arrow.style.border="0 none black";
	this.SlideItems(arrow.id=="OB_SlideUp");
}

function OverArrow(arrow)
{
	if(this.sliding)
		return;		
	arrow.style.border="1 outset #ffffff";
}

function OutArrow(arrow)
{
	if(this.sliding)
		return;		
	arrow.style.border="0 none black";
}

function ClipFolder(folder,top,right,bottom,left)
{
	document.all["OB_Folder"+folder].style.clip=clip='rect('+top+' '+right+' '+bottom+' '+left+')';
}

function Start()
{
	if(!this.started)
	{
		this.ClipFolder(1,0,this.visibleAreaWidth,this.visibleAreaHeight,0);
		this.SetArrows();
	}		
}

function SetArrows()
{
	document.all["OB_SlideDown"].style.pixelTop=document.all["OB_Button"+this.currentFolder].style.pixelTop+document.all["OB_Button"+this.currentFolder].style.pixelHeight+20;
	document.all["OB_SlideDown"].style.pixelLeft=this.width-document.all["OB_SlideUp"].width-this.borderWidth-10;
	document.all["OB_SlideUp"].style.pixelTop=document.all["OB_Button"+this.currentFolder].style.pixelTop+document.all["OB_Button"+this.currentFolder].style.pixelHeight+this.visibleAreaHeight-document.all["OB_SlideDown"].height-20;
	document.all["OB_SlideUp"].style.pixelLeft=this.width-document.all["OB_SlideDown"].width-this.borderWidth-10;

	var folder=document.all["OB_Folder"+this.currentFolder].style;
	var startTop=document.all["OB_Button"+this.currentFolder].style.pixelTop+document.all["OB_Button"+this.currentFolder].style.pixelHeight;

	if(folder.pixelTop<startTop)
		document.all["OB_SlideDown"].style.visibility="visible";
	else		
		document.all["OB_SlideDown"].style.visibility="hidden";

	if(folder.pixelHeight-(startTop-folder.pixelTop)>this.visibleAreaHeight)
		document.all["OB_SlideUp"].style.visibility="visible";
	else		
		document.all["OB_SlideUp"].style.visibility="hidden";
}

function HideArrows()
{
	document.all["OB_SlideUp"].style.visibility="hidden";
	document.all["OB_SlideDown"].style.visibility="hidden";
}

function SlideItems(up)
{
	this.sliding=true;
	this.slideCount=Math.floor(this.slideArrowValue/this.ArrowSlideSpeed);
	up ? this.SlideItemsAction(-this.ArrowSlideSpeed) : this.SlideItemsAction(this.ArrowSlideSpeed);
}

function SlideItemsAction(value)
{
	document.all["OB_Folder"+this.currentFolder].style.pixelTop+=value;
    filter = /rect\((\d*)px (\d*)px (\d*)px (\d*)px\)/;
    var clipString=document.all["OB_Folder"+this.currentFolder].style.clip;
    var clip=clipString.match(filter);
    this.ClipFolder(this.currentFolder,(parseInt(clip[1])-value),parseInt(clip[2]),(parseInt(clip[3])-value),parseInt(clip[4]));
	this.slideCount--;
	if(this.slideCount>0)
		setTimeout("OutlookLikeBar.SlideItemsAction("+value+")",20);
	else
	{
		if(Math.abs(value)*this.ArrowSlideSpeed!=this.slideArrowValue)		
		{
			document.all["OB_Folder"+this.currentFolder].style.pixelTop+=(value/Math.abs(value)*(this.slideArrowValue%this.ArrowSlideSpeed));
		    filter = /rect\((\d*)px (\d*)px (\d*)px (\d*)px\)/;
			var clipString=document.all["OB_Folder"+this.currentFolder].style.clip;
			var clip=clipString.match(filter);
		    this.ClipFolder(this.currentFolder,(parseInt(clip[1])-(value/Math.abs(value)*(this.slideArrowValue%this.ArrowSlideSpeed))),parseInt(clip[2]),(parseInt(clip[3])-(value/Math.abs(value)*(this.slideArrowValue%this.ArrowSlideSpeed))),parseInt(clip[4]));
		}		    
		this.SetArrows();
		this.sliding=false;
	}		
}
</script>
		<Script>
if (document.all)
{
	document.write("<DIV id='OutlookLikeBar' style='position:absolute;top:"+OB_Top+";left:"+OB_Left+";width:"+OB_Width+";height:"+OB_Height+";border:"+OB_BorderWidth+" "+OB_BorderStyle+" "+OB_BorderColor+";background-color:"+OB_BackgroundColor+";z-index:0;visibility:hidden;clip:rect(0,"+OB_Width+","+OB_Height+",0)'>");
	document.write("<img onMouseUp='OutlookLikeBar.ArrowSelected(this)' onMouseDown='OutlookLikeBar.ArrowClicked(this)' onMouseOver='OutlookLikeBar.OverArrow(this)' onMouseOut='OutlookLikeBar.OutArrow(this)' id='OB_SlideUp' height='"+OB_ArrowHeight+"' width='"+OB_ArrowWidth+"' src='"+OB_UpArrow+"' style='position:absolute;top:0;left:0;cursor:hand;visibility:hidden;z-index:500'>");
	document.write("<img onMouseUp='OutlookLikeBar.ArrowSelected(this)' onMouseDown='OutlookLikeBar.ArrowClicked(this)' onMouseOver='OutlookLikeBar.OverArrow(this)' onMouseOut='OutlookLikeBar.OutArrow(this)' id='OB_SlideDown' height='"+OB_ArrowHeight+"' width='"+OB_ArrowWidth+"' src='"+OB_DownArrow+"' style='position:absolute;top:0;left:0;cursor:hand;visibility:hidden;z-index:500'>");
	j=1;
	while(eval("window.OutBarFolder"+j))
		j++;
	i=j-1;
	while(i>0)
	{
		Folder=eval("OutBarFolder"+i)
//		window.status="Outlook-Like Bar is making folder '"+Folder[0]+"'";
		if(i==1)
		{
			document.write("<INPUT position='UP' id='OB_Button1' onDblClick='OutlookLikeBar.FolderClicked("+i+");this.blur()' onClick='OutlookLikeBar.FolderClicked("+i+");this.blur()' TYPE='button' value='"+Folder[0]+"' style='position:absolute;top:0;left:0;width:"+(OB_Width-2*OB_BorderWidth)+";height:"+OB_ButtonHeight+";font-family:"+OB_ButtonFontFamily+";font-size:"+OB_ButtonFontSize+"pt;cursor:hand;color:"+OB_ButtonFontColor+";z-index:100'>");
			MakeItems(Folder,i,OB_ButtonHeight);		
		}	
		else
		{
			document.write("<INPUT position='DOWN' id='OB_Button"+i+"' onDblClick='OutlookLikeBar.FolderClicked("+i+");this.blur()' onClick='OutlookLikeBar.FolderClicked("+i+");this.blur()' TYPE='button' value='"+Folder[0]+"' style='position:absolute;top:"+(OB_Height-(j-i)*OB_ButtonHeight-OB_BorderWidth*2)+";left:0;width:"+(OB_Width-2*OB_BorderWidth)+";height:"+OB_ButtonHeight+";font-family:"+OB_ButtonFontFamily+";font-size:"+OB_ButtonFontSize+"pt;cursor:hand;color:"+OB_ButtonFontColor+";z-index:100'>");
			MakeItems(Folder,i,(OB_Height-(j-i)*OB_ButtonHeight-OB_BorderWidth*2)+OB_ButtonHeight);		
		}	
			
		i--;
	}	
	document.write("</DIV>");
	var OutlookLikeBar=new OutBar(OB_Width,OB_Height,j-1,OB_ButtonHeight,OB_BorderWidth,OB_SlideSpeed,OB_IconsHeight+OB_LabelFontSize+OB_LabelMargin+OB_ItemsSpacing,OB_ArrowSlideSpeed);
	document.all["OutlookLikeBar"].style.visibility="visible";
}
</SCript>
	</body>
</HTML>

