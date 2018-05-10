
<%@page import="java.net.InetAddress"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.lccert.crm.user.UserAction"%>
<%@page import="com.lccert.crm.client.ClientAction"%>
<%@ include file="comman.jsp"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">

		<title>系统菜单</title>
	</HEAD>
	<body text="#FFFFFF" topmargin="0" leftmargin=0>
		<SCript LANGUAGE=JSCRIPT>
	<%
	 InetAddress addr = InetAddress.getLocalHost();
	 String ip = addr.getHostAddress();//获得本机IP
	//电脑ip为192.168.0.10不发送10.11.1.222
	if(!ip.equals("10.11.1.222")){//Ip为10.11.1.222的属于东莞的ip，只能看到环境信息
			if(user.getCompanyid() !=4){%>
			OutBarFolder1=new Array("客户管理"
		<%
		//if(user.getTicketid().matches("1\\d\\d\\d\\d\\d\\d\\d")) {//Ip为10.11.1.222的属于东莞的ip，只能看到环境信息
		%>
			,"images/admin.gif","我的客户","client/myclient.jsp","parent.parent.main",
			 "images/admin.gif","客户销售跟进进度","client/clientsalesstatus.jsp","parent.parent.main",
			 "images/admin.gif","添加客户","client/addclient.jsp","parent.parent.main",
			 "images/admin.gif","管理客户","client/searchclient.jsp","parent.parent.main"
		<%
		}if((user.getSales().equals("y") && user.getCtsname() !=null) || user.getId()==103 || user.getId()==130){//有销售权限或者用户id==10和130都可以操作
			String ctsName="";
			if(user.getDept().indexOf("销售")>-1){//部门中包含销售
				ctsName=user.getCtsname();
			}
		%>
			,"images/admin.gif","客户跟踪","oavaction/VOLClient.jsp?ctsName=<%=ctsName%>","parent.parent.main"
		<%
		}
		%>	 
			 ); 
		<%
		}
		%>	 
			OutBarFolder2=new Array("报价管理"
			<%
			if(user.getName().equals("余海珊")||user.getId()==110){
			%>
			,"images/admin.gif","添加报价单","kis/addorder.jsp","parent.parent.main"
			,"images/admin.gif","管理报价单","kis/order_manage.jsp","parent.parent.main"
			<%
			}
		if(user.getTicketid().matches("1\\d\\d\\d\\d\\d\\d\\d")) {//权限为10000000属于销售权限能
		%>
			,"images/admin.gif",	"我的报价单","kis/myorder.jsp","parent.parent.main",
			"images/admin.gif","添加报价单","kis/addorder.jsp","parent.parent.main"
			
			<%
			if(user.getTicketid().matches("\\d1\\d\\d\\d\\d\\d\\d")) {//权限为01000000属于销售权限能
			%>
			,"images/admin.gif","管理报价单","kis/order_manage.jsp","parent.parent.main"
		<%
			}
		}if(user.getName().equals("欧婉雯")||user.getId()==138||user.getId()==103||user.getId()==188){
			%>
			,"images/admin.gif","EMC管理","emckis/order_manage.jsp","parent.parent.main"
		<%
			}
		%>
		
			);
			OutBarFolder3=new Array("销售管理"
		<%
		if(user.getTicketid().matches("1\\d\\d\\d\\d\\d\\d\\d")) {//权限为10000000属于销售权限能
		%>
			 ,"images/admin.gif",	"我的订单","quotation/myquotation.jsp","parent.parent.main",
			 "images/admin.gif","查询订单","quotation/searchquotation.jsp","parent.parent.main",
			"images/admin.gif",	"化学申请表","http://report.lccert.com:1234/report/application/pid.jsp","parent.parent.main",
			 "images/admin.gif","项目分解","project/project_finance_manage.jsp","parent.parent.main",
			  "images/admin.gif","二部项目统计","quotation/phpprojecttree/index.html","parent.parent.main"
		<%
		}
		 if(user.getName().equals("余海珊")){
			%>
			, "images/admin.gif","查询订单","quotation/searchquotation.jsp","parent.parent.main"
		<%
		}
		%>		 
			 ); 
			OutBarFolder4=new Array("样品管理"
			
			<%
			if(!user.getName().equals("欧婉雯")){
			%>
			,"images/admin.gif","添加包裹","sample/sample_package.jsp","parent.parent.main"
			,"images/admin.gif","查看包裹","sample/search_samplepackage.jsp","parent.parent.main"
			, "images/admin.gif","拆样样品","sample/sample.jsp","parent.parent.main"
			, "images/admin.gif","样品管理","sample/search_sample.jsp","parent.parent.main"
			<%
			}
		%>
			);
		
			OutBarFolder5=new Array("客服管理"
		<%
		if(user.getTicketid().matches("\\d\\d1\\d\\d\\d\\d\\d")) {//权限为00100000属于销售权限能
		%>
			,
			 "images/admin.gif","项目排单","chemistry/project/project_manage.jsp","parent.parent.main",
			 "images/admin.gif","管理项目","chemistry/project/myproject.jsp","parent.parent.main",
			 "images/admin.gif","添加流转单","chemistry/project/searchproject.jsp","parent.parent.main",
			 "images/admin.gif","管理流转单","chemistry/flow/flow_manage.jsp","parent.parent.main",
			  "images/admin.gif","外包管理","isout/outproject_manage.jsp","parent.parent.main",
			  "images/admin.gif","月结统计","chemistry/lab/clientproject.jsp","parent.parent.main",
			  "images/admin.gif","项目查询报告","chemistry/project/searchrid.jsp","parent.parent.main",
			   "images/admin.gif","实验室流转单","chemistry/flow/department_flow_manage.jsp","parent.parent.main"
		<%
		}
		%>	
			);
			OutBarFolder6=new Array("测试部管理"
			<%
		if(user.getReportStart().equals("y")&&!user.getName().equals("欧婉雯")){//含有生成报告的权限并且用户名不等于欧婉雯
		%>
			,"images/admin.gif","报告管理","chemistry/project/reportmanage.jsp","parent.parent.main"
		 <%	
		}
		if(user.getTicketid().matches("\\d\\d1\\d\\d\\d\\d\\d")) {//权限为00100000属于销售权限能
		%>
		    ,"images/admin.gif","样品登记","sample/sampleRegistration.jsp","parent.parent.main"
			 ,"images/admin.gif","管理项目","chemistry/lab/mylabproject.jsp","parent.parent.main"
			 <%
			 if(user.getId()==113 || user.getId()==133 ||user.getId()==144 || user.getId()==101 || user.getId()==85  || user.getId()==103){
		%>
			  ,"images/admin.gif","待审报告","testvolumetry/subjudice.jsp","parent.parent.main"
		 <%	
		}
			 %>
			  ,"images/admin.gif","接单统计","chemistry/lab/todayproject.jsp","parent.parent.main"
			  ,"images/admin.gif","综合统计","chemistry/lab/lateproject.jsp","parent.parent.main"
			  ,"images/admin.gif","测试容量","testvolumetry/volumetry_manage.jsp","parent.parent.main"
		<%
		}
		%>	
			);
				OutBarFolder7=new Array("工程部管理"
		<%
		if(user.getTicketid().matches("\\d\\d\\d\\d\\d\\d1\\d")) {
		%>
			 ,"images/admin.gif","添加工程测试","engineering/project_chemistry_manage.jsp","parent.parent.main"
			 <%
		}
		%>	
		<%
		if(!user.getName().equals("郑妙芳")&& (user.getDept().equals("工程部")|| user.getId()==103)|| user.getId()==133) {
		//用户名不等郑妙芳并且（部门等于工程部或者用户有id==103或者133）可以查看流转单
		%>
			, "images/admin.gif","添加流转单","chemistry/project/searchproject.jsp","parent.parent.main"
			 ,"images/admin.gif","管理流转单","chemistry/flow/flow_manage.jsp","parent.parent.main"
			 ,"images/admin.gif","成品测试","engineering/product_manager.jsp","parent.parent.main"
			 ,"images/admin.gif","食品级测试","engineering/food_manager.jsp","parent.parent.main"
			 ,"images/admin.gif","测试项目明细","chemtest/searchchemtest.jsp","parent.parent.main"
			 	<%
		}
		if(user.getId()==101){//用户id==101
		%>
			,"images/admin.gif","测试项目明细","chemtest/searchchemtest.jsp","parent.parent.main"
		<%
		}
		%>
			);
			OutBarFolder8=new Array("电子电器管理"
			<%
		if(user.getTicketid().matches("\\d\\d1\\d\\d\\d\\d\\d")||user.getId()==110||user.getId()==123) {//权限为01000000属于销售权限能排单
		%>
			,"images/admin.gif","项目排单","physical/project/phyproject_paidan.jsp","parent.parent.main"
			 ,"images/admin.gif","管理安规项目","physical/project/phyproject_manage.jsp","parent.parent.main"
			 ,"images/admin.gif","管理实验室","physical/lab/phylab_manage.jsp","parent.parent.main"
			 ,"images/admin.gif","项目状态","physical/phpprojecttree/index.html","parent.parent.main"
			 ,"images/admin.gif","二部报价","physical/quote/searchquotation.jsp","parent.parent.main"
			
			
		<%
		
		}if(user.getDept().equals("电子电器部") || user.getId()==103) {//用户部门等于电子电器或者用户id==103可以查看跟踪项目明细
		%>	
		 ,"images/admin.gif","跟踪项目明细","physical/project/myproject.jsp","parent.parent.main"
		 <%
		   } 
		    %>
		      );
			 
			OutBarFolder9=new Array("财务管理"
		
		<%
		if(user.getId()  == 103 || user.getId() ==123 || user.getId() ==141) {//用户id==103或者==123或者==141可以查看签单统计
		%>	
		 ,"images/admin.gif","签单统计","finance/bills/bills_manage.jsp","parent.parent.main"
		<%
		}
		%>
		<%
		if(user.getId()  == 103 || user.getId() ==123 || user.getId() ==110 || user.getId()==158) {//用户id==103或者==123或者==110可以查看项目统计
		%>	
		 ,"images/admin.gif","项目统计","finance/quotation/project_manage.jsp","parent.parent.main"
		<%
		}
		%>
		<%
		if(user.getId()==233){
		%>
		,"images/admin.gif",	"管理订单","finance/quotation/quotation_manage.jsp","parent.parent.main"
		<%
		}
		if(user.getTicketid().matches("\\d\\d\\d1\\d\\d\\d\\d")) {//权限为00100000属于销售权限
		%>	
			, "images/admin.gif","查询订单","quotation/searchquotation.jsp","parent.parent.main"
			,"images/admin.gif",	"管理订单","finance/quotation/quotation_manage.jsp","parent.parent.main"
			//,"images/admin.gif","管理项目","finance/project/project_manage.jsp","parent.parent.main"
			 ,"images/admin.gif","已收订单","finance/quotation/quotation_confirm.jsp","parent.parent.main"
			 ,"images/admin.gif","支出申请报","cashcount/fpay_manage.jsp","parent.parent.main"
			 ,"images/admin.gif","收入申请报","cashcount/fincome_manage.jsp","parent.parent.main"
			 <%
			 if(user.getTicketid().matches("\\d\\d\\d1\\d1\\d\\d")&&user.getId()!=158&&user.getId()!=396) {//权限为00100000属于销售权限可以查看订单统计和一部订单和二部订单
			 %>
			 ,"images/admin.gif","订单统计","finance/quotation/finance.jsp","parent.parent.main"
			 ,"images/admin.gif","一部订单统计","finance/quotation/financequotationexport.jsp","parent.parent.main"
			  <%
			 if(!user.getName().equals("郑妙芳")&&user.getId()!=158 &&user.getId()!=396) {//用户名不为郑妙芳
			 %>
			 ,"images/admin.gif","二部订单统计","finance/quotation/financequotationexport2.jsp","parent.parent.main"
		<%
			}
			}
		}
		%>	 
			); 
		
		
			OutBarFolder10=new Array("行政后勤"
				<%
			if(user.getId()==193 || user.getId()==194 || user.getId()==366 || user.getId()==85 || user.getId()==195 || user.getId()==103 || user.getId()==105 || user.getId() == 169|| user.getId() == 123 || user.getId()==248||user.getId()==158||user.getId()==375 || user.getId()==396 || user.getId()==452 || user.getId()==372) {
			//用户人id=193或者==194或者==195或者==103或者==105或者==169或者==123或者==248可以查看请款的所以信息
			%>
				 ,"images/admin.gif","新增请款","app/app_add.jsp","parent.parent.main"
				 ,"images/admin.gif","管理请款","app/app_main.jsp","parent.parent.main"
				 ,"images/admin.gif","新增单位","app/sup_add.jsp","parent.parent.main"
				  ,"images/admin.gif","受款单位","app/sup_main.jsp","parent.parent.main"
				 
			<%
				}
			if(user.getId()==218 || user.getId()==219){//用户id==218或者219物品管理
			%>
			 ,"images/admin.gif","库存查询","app/inventory.jsp","parent.parent.main"
			  ,"images/admin.gif","物品管理","article/article_manage.jsp","parent.parent.main"
			<%
			}
			if(user.getId()==195 || user.getId()==103){//用户Id==195或者==103可以查看考勤管理
			%>
			 ,"images/admin.gif","考勤管理","oavaction/vactiontype.jsp","parent.parent.main"
			 <%
			}
		
		%>	
			);
			
			OutBarFolder11=new Array("系统管理"
			 ,"images/admin.gif","密码修改","password_modify.jsp","parent.parent.main"
				<%
				if(user.getTicketid().matches("11111111")||user.getName().equals("陈吉龙")) {
				//用户权限等于11111111或者等于陈吉龙可以查看用户管理和通讯录和群发地址
				%>
					 ,"images/admin.gif","用户管理","user/addUser.jsp","parent.parent.main"
					,"images/admin.gif","通讯录","address.jsp","parent.parent.main"
					,"images/admin.gif","群发地址","http://report/report/mail/mail.jsp","parent.parent.main"
					//,"images/admin.gif","群发地址","http://127.0.0.1:8080/report/mail/mail.jsp","parent.parent.main"
				<%
				}
		%>	
		 , "images/admin.gif","公告管理","note/system_notes.jsp","parent.parent.main"
		  , "images/admin.gif","swf文档","note/pdf2swf.jsp","parent.parent.main"
		  , "images/admin.gif","录音统计","note/record.jsp","parent.parent.main"
		  , "images/admin.gif","任务","task/task.jsp","parent.parent.main"
			);
			
			
			OutBarFolder12=new Array("报告组管理"
				<%
					if(user.getId()==369||user.getId()==359||user.getId()==145||user.getId()==203||user.getId()==101||user.getId()==231||user.getId()==114||user.getId()==77||user.getId()==118||user.getId()==316||user.getId()==390){
					%>
					,"images/admin.gif","报告处理","chemistry/project/reportmanage.jsp","parent.parent.main" //1
					, "images/admin.gif","项目管理","chemistry/flow/flow_manage.jsp","parent.parent.main"    //3
					<%
					}
					if(user.getId()==369||user.getId()==359||user.getId()==145||user.getId()==203||user.getId()==101||user.getId()==231||user.getId()==114||user.getId()==77){
					%>
					,"images/admin.gif","报告查询","quotation/searchquotation.jsp","parent.parent.main"
					<%
					}
					if(user.getId()==101||user.getId()==231||user.getId()==114||user.getId()==77){
					%>
					, "images/admin.gif","项目查询报告","chemistry/project/searchrid.jsp","parent.parent.main"
					,"images/admin.gif","接单统计","chemistry/lab/todayproject.jsp","parent.parent.main"
					,"images/admin.gif","综合统计","chemistry/lab/lateproject.jsp","parent.parent.main"
					,"images/admin.gif","测试项目明细","chemtest/searchchemtest.jsp","parent.parent.main"
					, "images/admin.gif","添加流转单","chemistry/project/searchproject.jsp","parent.parent.main"
					<%
					}
				%>
			);
			
			<%
			if(user.getId() ==103||user.getId()==419||user.getId() ==99||user.getId() ==365||user.getId() ==397||user.getId() ==101){
				%>
				OutBarFolder13=new Array("环境部管理"
				<%
					//if(user.getReportStart().equals("y")&&!user.getName().equals("欧婉雯")){//含有生成报告的权限并且用户名不等于欧婉雯
					%>
						,"images/admin.gif","报告管理","chemistry/project/reportmanage.jsp","parent.parent.main"
					 <%	
					//}
					//if(!user.getName().equals("郑妙芳")&& (user.getDept().equals("工程部")|| user.getId()==103)|| user.getId()==133) {
					//用户名不等郑妙芳并且（部门等于工程部或者用户有id==103或者133）可以查看流转单
					%>
					, "images/admin.gif","添加流转单","chemistry/project/searchproject.jsp","parent.parent.main"
					 ,"images/admin.gif","管理流转单","chemistry/flow/flow_manage.jsp","parent.parent.main"
					<%
					//	}
					%>
					,"images/admin.gif","物品管理","article/article_manage.jsp","parent.parent.main"
				);
				
				 OutBarFolder14=new Array("");
				 OutBarFolder15=new Array("");
				<%
				
			//}
		}
%>
	
 </Script>
		<SCRIPT LANGUAGE="JAVASCRIPT">
	OB_Top=0;									//菜单距离顶部的象素值；
	OB_Left=0;									//菜单距离左侧的象素值；
	OB_Margin=10;								//top and bottom margins between icons and borders
	OB_Width=172;								//菜单宽度
	newHeight=window.screen.height
	OB_Height=newHeight-160;                 	//菜单高度225
	OB_SlideSpeed=10;							//菜单运动速度
	OB_BackgroundColor="#088A4B";    		//背景色
	OB_ItemsSpacing=25;							//2个图标间的距离
	OB_BorderWidth=3;							//border宽度
	OB_BorderStyle="ridge";						//border风格
	OB_BorderColor="#dddddd";					//border颜色
	OB_IconsWidth=32;							//图标宽度
	OB_IconsHeight=32;							//图标高度
	OB_ButtonFontFamily="arial";				//按钮上字体的字型
	OB_ButtonFontSize=9;						//按钮上字体大小 
	OB_ButtonFontColor="black";					//按钮上字体颜色    
	OB_ButtonHeight=22;							//按钮的高度
	OB_LabelFontFamily="arial";					//LOGO下字体的字型
	OB_LabelFontSize=9;							//LOGO下面的字体大小
	OB_LabelFontColor="white";					//LOGO下的字体颜色
	OB_LabelMargin=3;							//margin between labels and icons
	OB_DownArrow="images/arrowup.gif";			//向下滚动的logo箭头
	OB_UpArrow="images/arrowdown.gif";			//向上滚动的logo箭头
	OB_ArrowWidth=15;							//箭头的宽度
	OB_ArrowHeight=15;							//箭头的高度
	OB_ArrowSlideSpeed=10;						//项目列表滚动的速度；

/*以下的代码中你需要改动菜单的数目与实际一致，本例用了4个按钮菜单。*/
function MakeItems(Folder,zorder,top)
{
	var items=0;
	var folderWidth=(OB_Width-OB_BorderWidth*2);
	while(Folder[items+1])
		items+=4;  //需要改这里及下面的4；
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


