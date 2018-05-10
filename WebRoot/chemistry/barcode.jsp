<%@page import="com.lccert.crm.chemistry.util.ByteArrayList"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>

<%@page import="com.lccert.crm.chemistry.barcode.BarCodeAction"%>
<%@page import="com.lccert.crm.project.ChemLabTime"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.project.ChemProjectAction"%>
<%@page import="com.lccert.crm.project.PhyProject"%>
<%@page import="com.lccert.crm.project.ChemProject"%>
<%@page import="com.lccert.crm.dao.DaoFactory"%>
<%
	String command = request.getParameter("command");
	String kw = "请读入报告条形码";
	String err = "";
	String fid = "";
	String flowtype = "";
	String retest = "";
	String isfinish = "";
	String endtime="";
	String sendtime ="";
	String samplename="";
	String str="";
	boolean sound = true;
	List chemLabTime =new ArrayList();
	if (command != null && "add".equals(command)) {
		Project chp = (Project) session.getAttribute("project");
		ChemProject chemp = new ChemProject();
		PhyProject phy =new PhyProject();
		Flow flow0 = (Flow)session.getAttribute("flow");
		if(flow0 != null) {
			fid = flow0.getFid();
			flowtype = flow0.getFlowtype();
			if("y".equals(flow0.getRetest())) {
				retest = "重测";
			}
		}
		
		if(chp != null) {
			String rid =chp.getRid();
		 str=chp.getPtype();
		if(chp.getPtype().equals("化学测试")||chp.getPtype().equals("化妆品")||chp.getPtype().equals("环境")){
			chemp = (ChemProject)chp.getObj();
			chemLabTime=chemp.getList();
		//	endtime=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(chemp.getEndtime());
		//	sendtime=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(chemp.getSendtime());
		//	samplename =chemp.getSamplename();
			}else{
			phy =(PhyProject)chp.getObj();
			chemLabTime=phy.getList();
			//endtime=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(phy.getEndtime());
			//samplename=phy.getSamplename();
			}
		}
		String keywords = request.getParameter("keywords").trim();
		keywords=new ByteArrayList().getTranForm(keywords);
		if (keywords.length() == 10) { //&&并且根据keywords查找数据库
			Flow flow = BarCodeAction.getInstance().getFlowByFid(keywords);
			System.out.println("flow:"+flow);
			keywords = keywords.substring(0,9);
			//-----------------------------------------调用phy的表格
			//String rid =flow.getRid();
		 	//str=rid.substring(3, 4);
		 	str=DaoFactory.getInstance().getProjectDao().isChemOrPhy(flow.getRid());
		 	//System.out.println(str+"---------------");
			Project cp1=ChemProjectAction.getInstance().getPlan(str,keywords);
					//sendtime=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(chemp.getSendtime());
		
			if (cp1 != null && flow != null) {
				session.setAttribute("flow",flow);
				session.setAttribute("project", cp1);
				session.setMaxInactiveInterval(10);
				kw = "成功读取流转单号，请在10秒内读取项目状态条形码!";
				sound = false;
			} else {
				err = "无效流转单号!";
			}
		} 
		
		else if ("B11".equals(keywords)) {//生物开始时间
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "生物开始时间",chemLabTime)){
						err = "错误：" + retest + "生物开始时间重复登记!";
					} else {
						
							if(ChemProjectAction.getInstance().updateTime(retest + "生物开始时间",chp.getRid(),chp.getSid(),fid,2,str)){
								//BarCodeAction.getInstance().getUpdateStatus("生物开始时间",chp.getSid());
							kw = retest + "生物开始时间登记成功！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
			} 
		else if ("B12".equals(keywords)) {//生物完成时间
				if (chp == null) {
					err = "错误：尚未读取报告号,或登记间隔时间过长！";
				} else if(BarCodeAction.getInstance().getstatus(retest + "生物完成时间",chemLabTime)){
					err = "错误：" + retest + "生物完成时间重复登记!";
				} else {
					//if(BarCodeAction.getInstance().updateTime(retest + "gcms1有机上机开始时间",chp.getRid(),chp.getSid(),fid,3)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "生物完成时间",chp.getRid(),chp.getSid(),fid,2,str)){
						//BarCodeAction.getInstance().getUpdateStatus("生物完成时间",chp.getSid());
						kw = retest + "生物完成时间登记成功！";
						sound = false;
						session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
					} else {
						err = "读取错误，请重新读取！";
					}
				}
		} 
		else if(flow0 != null && "n".equals(chemp.getIsfinish())||"n".equals(phy.getIsfinish())) {
			 if ("X0".equals(keywords)) {//制备开始时间
					if("无机流转单".equals(flowtype)) {
						if (chp == null) {
							err = "错误：尚未读取报告号,或登记间隔时间过长！";
						} else if(BarCodeAction.getInstance().getstatus(retest + "无机制备开始时间",chemLabTime)){
							err = "错误：" + retest + "无机制备开始时间重复登记!";
						} else {
							if(ChemProjectAction.getInstance().updateTime(retest + "无机制备开始时间",chp.getRid(),chp.getSid(),fid,1,str)){
							//if(BarCodeAction.getInstance().updateTime(retest + "无机制备开始时间",chp.getRid(),chp.getSid(),fid,1)) {
							    BarCodeAction.getInstance().getUpdateStatus("无机制备开始时间",chp.getSid());
								kw = retest + "无机制备开始时间登记成功！";
								sound = false;
								session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
							} else {
								err = "读取错误，请重新读取！";
							}
						}
					} else if("有机流转单".equals(flowtype)) {
						if (chp == null) {
							err = "错误：尚未读取报告号,或登记间隔时间过长！";
						} else if(BarCodeAction.getInstance().getstatus(retest + "有机制备开始时间",chemLabTime)){
							err = "错误：" + retest + "有机制备开始时间重复登记!";
						} else {
							//if(BarCodeAction.getInstance().updateTime(retest + "有机制备开始时间",chp.getRid(),chp.getSid(),fid,1)) {
							if(ChemProjectAction.getInstance().updateTime(retest + "有机制备开始时间",chp.getRid(),chp.getSid(),fid,1,str)){
							BarCodeAction.getInstance().getUpdateStatus("有机制备开始时间",chp.getSid());
								kw = retest + "有机制备开始时间登记成功！";
								sound = false;
								session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
							} else {
								err = "读取错误，请重新读取！";
							}
						}
					
					} else if("食品流转单".equals(flowtype)) {
						if (chp == null) {
							err = "错误：尚未读取报告号,或登记间隔时间过长！";
						} else if(BarCodeAction.getInstance().getstatus(retest + "食品制备开始时间",chemLabTime)){
							err = "错误：" + retest + "食品制备开始时间重复登记!";
						} else {
							//if(BarCodeAction.getInstance().updateTime(retest + "食品制备开始时间",chp.getRid(),chp.getSid(),fid,1)) {
								if(ChemProjectAction.getInstance().updateTime(retest + "食品制备开始时间",chp.getRid(),chp.getSid(),fid,1,str)){
								kw = retest + "食品制备开始时间登记成功！";
								sound = false;
								session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
							} else {
								err = "读取错误，请重新读取！";
							}
						}
					
					}
			}  else if ("A1".equals(keywords)) {//无机前处理开始时间
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "无机前处理开始时间",chemLabTime)){
						err = "错误：" + retest + "无机前处理开始时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "无机前处理开始时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "无机前处理开始时间",chp.getRid(),chp.getSid(),fid,1,str)){
							BarCodeAction.getInstance().getUpdateStatus("无机前处理开始时间",chp.getSid());
							kw = retest + "无机前处理开始时间登记成功！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
			} else if ("A2".equals(keywords)) {//无机上机开始时间
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "无机上机开始时间",chemLabTime)){
						err = "错误：" + retest + "无机上机开始时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "无机上机开始时间",chp.getRid(),chp.getSid(),fid,3)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "无机上机开始时间",chp.getRid(),chp.getSid(),fid,1,str)){
						BarCodeAction.getInstance().getUpdateStatus("无机上机开始时间",chp.getSid());
							kw = retest + "无机上机开始时间登记成功！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
			} else if ("A3".equals(keywords)) {//无机数据完成时间
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "无机数据完成时间",chemLabTime)){
						err = "错误：" + retest + "无机数据完成时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "无机数据完成时间",chp.getRid(),chp.getSid(),fid,4)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "无机数据完成时间",chp.getRid(),chp.getSid(),fid,1,str)){
						BarCodeAction.getInstance().getUpdateStatus("无机数据完成时间",chp.getSid());
							kw = retest + "无机数据完成时间登记成功！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
			}
			
			
			
			//工程部的条形码输入
			//工程部的条形码输入
			else if ("T1".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "拆分开始时间",chemLabTime)){
						err = "错误："+retest+"拆分开始时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "拆分开始时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "拆分开始时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "拆分开始时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
			else if ("T2".equals(keywords)) {
					if (chp == null) {
						err = "错误："+retest+"尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "发出《合并同材质》时间",chemLabTime)){
						err = "错误：发出《合并同材质》时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "发出《合并同材质》时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "发出《合并同材质》时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "发出《合并同材质》时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
			else if ("T3".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "接收《合并同材质》时间",chemLabTime)){
						err = "错误："+retest+"接收《合并同材质》时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "接收《合并同材质》时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "接收《合并同材质》时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "接收《合并同材质》时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
			else if ("T4".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "XRF扫描完成时间",chemLabTime)){
						err = "错误："+retest+"XRF扫描完成时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "XRF扫描完成时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "XRF扫描完成时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "XRF扫描完成时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
			else if ("T5".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					
					} else if(BarCodeAction.getInstance().getstatus(retest + "发出《测试计划》时间",chemLabTime)){
					System.out.println(retest+"-------");
						err = "错误："+retest+"发出《测试计划》时间!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "发出《测试计划》时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "发出《测试计划》时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "发出《测试计划》时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
			else if ("T6".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "发出《补样、换样通知》时间",chemLabTime)){
						err = "错误："+retest+"发出《补样、换样通知》时间!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "发出《补样、换样通知》时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "发出《补样、换样通知》时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "发出《补样、换样通知》时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
			else if ("T7".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "客户完整提供信息时间",chemLabTime)){
						err = "错误："+retest+"客户完整提供信息时间!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "客户完整提供信息时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "客户完整提供信息时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "客户完整提供信息时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
			else if ("T8".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "测试报告编辑完成的时间",chemLabTime)){
						err = "错误："+retest+"测试报告编辑完成的时间!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "测试报告完成的时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "测试报告编辑完成的时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "测试报告编辑完成的时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
			
			else if ("T9".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "发送至TUV的时间",chemLabTime)){
						err = "错误："+retest+"发送至TUV的时间!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "发送至TUV的时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "发送至TUV的时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "发送至TUV的时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
			else if ("T0".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "报告审核完成",chemLabTime)){
						err = "错误："+retest+"报告审核完成!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "报告审核完成",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "报告审核完成",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "报告审核完成！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
					
					
					
					
					
					
				//F为工程食品的测试时间	
			else if ("F1".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "测试点评估开始的时间",chemLabTime)){
						err = "错误："+retest+"测试点评估开始的时间!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "测试点评估开始的时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "测试点评估开始的时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "测试点评估开始的时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
			else if ("F2".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "信息确认发出时间",chemLabTime)){
						err = "错误："+retest+"信息确认发出时间!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "信息确认发出时间",chp.getRid(),chp.getSid(),fid,2)) {
							if(ChemProjectAction.getInstance().updateTime(retest + "信息确认发出时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "信息确认发出时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
			else if ("F3".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "信息确认完成时间",chemLabTime)){
						err = "错误："+retest+"信息确认完成时间!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "信息确认完成时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "信息确认完成时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "信息确认完成时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
			else if ("F4".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "测试开始的时间",chemLabTime)){
						err = "错误："+retest+"测试开始的时间!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "测试开始的时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "测试开始的时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "测试开始的时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
			else if ("F5".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "补样|换样开始的时间",chemLabTime)){
						err = "错误："+retest+"补样|换样开始的时间!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "补样|换样开始的时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "补样|换样开始的时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "补样|换样开始的时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
			else if ("F6".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "补样|换样完成的时间",chemLabTime)){
						err = "错误："+retest+"补样|换样完成的时间!";
					} else {
					//	if(BarCodeAction.getInstance().updateTime(retest + "补样|换样完成的时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "补样|换样完成的时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "补样|换样完成的时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
					
					
					
					
					
					
			else if ("F7".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "报告完成的时间",chemLabTime)){
						err = "错误："+retest+"报告完成的时间!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "报告完成的时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "报告完成的时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "报告完成的时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
			else if ("F8".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "报告审核完成",chemLabTime)){
						err = "错误："+retest+"报告审核完成!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "报告审核完成",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "报告审核完成",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "报告审核完成！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
				}
				else if ("F9".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "草稿完成",chemLabTime)){
						err = "错误："+retest+"草稿完成!";
					} else {
						if(ChemProjectAction.getInstance().updateTime(retest + "草稿完成",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "草稿完成！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
				}
			else if ("C7".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "发送东莞测试",chemLabTime)){
						err = "错误："+retest+"发送东莞测试!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "报告审核完成",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "发送东莞测试",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "发送东莞测试！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
		
			 else if ("B8".equals(keywords)) {//有机上机开始时间
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "gcms1有机上机开始时间",chemLabTime)){
						err = "错误：" + retest + "gcms1有机上机开始时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "gcms1有机上机开始时间",chp.getRid(),chp.getSid(),fid,3)) {
							if(ChemProjectAction.getInstance().updateTime(retest + "gcms1有机上机开始时间",chp.getRid(),chp.getSid(),fid,2,str)){
						BarCodeAction.getInstance().getUpdateStatus("gcms1有机上机开始时间",chp.getSid());
							kw = retest + "gcms1有机上机开始时间登记成功！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
			} 
			else if ("B9".equals(keywords)) {//有机上机开始时间
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "gcms2有机上机开始时间",chemLabTime)){
						err = "错误：" + retest + "gcms2有机上机开始时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "gcms2有机上机开始时间",chp.getRid(),chp.getSid(),fid,3)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "gcms2有机上机开始时间",chp.getRid(),chp.getSid(),fid,2,str)){
							BarCodeAction.getInstance().getUpdateStatus("gcms2有机上机开始时间",chp.getSid());
							kw = retest + "gcms2有机上机开始时间登记成功！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
			} 
			 else if ("B10".equals(keywords)) {//有机上机开始时间
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "东莞数据完成时间",chemLabTime)){
						err = "错误：" + retest + "东莞数据完成时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "gcms1有机上机开始时间",chp.getRid(),chp.getSid(),fid,3)) {
							if(ChemProjectAction.getInstance().updateTime(retest + "东莞数据完成时间",chp.getRid(),chp.getSid(),fid,2,str)){
						BarCodeAction.getInstance().getUpdateStatus("东莞数据完成时间",chp.getSid());
							kw = retest + "东莞数据完成时间登记成功！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
			} 
			 
			else if ("G3".equals(keywords)) {//有机上机开始时间
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "gcms3有机上机开始时间",chemLabTime)){
						err = "错误：" + retest + "gcms3有机上机开始时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "gcms2有机上机开始时间",chp.getRid(),chp.getSid(),fid,3)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "gcms3有机上机开始时间",chp.getRid(),chp.getSid(),fid,2,str)){
							BarCodeAction.getInstance().getUpdateStatus("gcms3有机上机开始时间",chp.getSid());
							kw = retest + "gcms3有机上机开始时间登记成功！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
			} 
			
				else if ("I2".equals(keywords)) {//有机上机开始时间
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "icp2无机机上机开始时间",chemLabTime)){
						err = "错误：" + retest + "icp2无机机上机开始时间!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "gcms2有机上机开始时间",chp.getRid(),chp.getSid(),fid,3)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "icp2无机机上机开始时间",chp.getRid(),chp.getSid(),fid,2,str)){
							BarCodeAction.getInstance().getUpdateStatus("icp2无机机上机开始时间",chp.getSid());
							kw = retest + "icp2无机机上机开始时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
			} 
			
			
			//安规条形码输入
			else if ("P1".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "开始老化时间",chemLabTime)){
						err = "错误："+retest+"开始老化时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "开始老化时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "开始老化时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "开始老化时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
			else if ("P2".equals(keywords)) {
					if (chp == null) {
						err = "错误："+retest+"尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "老化结束时间",chemLabTime)){
						err = "老化结束时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "老化结束时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "老化结束时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "老化结束时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
			else if ("P3".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "开始测试时间",chemLabTime)){
						err = "错误："+retest+"开始测试时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "开始测试时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "开始测试时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "开始测试时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
			else if ("P4".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "测试结束时间",chemLabTime)){
						err = "错误："+retest+"测试结束时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "测试结束时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "测试结束时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "测试结束时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
			else if ("P5".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
						
					} else if(BarCodeAction.getInstance().getstatus(retest + "报告编写时间",chemLabTime)){
						err = "错误："+retest+"报告编写时间!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "报告编写时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "报告编写时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "报告编写时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
			else if ("P6".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "报告审核时间",chemLabTime)){
						err = "错误："+retest+"报告审核时间!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "报告审核时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "报告审核时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "报告审核时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}

	else if ("P7".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "项目开案时间",chemLabTime)){
						err = "错误："+retest+"项目开案时间!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "项目开案时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "项目开案时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "项目开案时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
					
					else if ("P8".equals(keywords)) {
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "实验室接收样品时间",chemLabTime)){
						err = "错误："+retest+"实验室接收样品时间!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "实验室接收样品时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "实验室接收样品时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "实验室接收样品时间！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					}
					
					
			else if ("B4".equals(keywords)) {//有机前处理开始时间
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "有机前处理开始时间",chemLabTime)){
						err = "错误："+retest+"有机前处理开始时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "有机前处理开始时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "有机前处理开始时间",chp.getRid(),chp.getSid(),fid,2,str)){
						BarCodeAction.getInstance().getUpdateStatus("有机前处理开始时间",chp.getSid());
							kw = retest + "有机前处理开始时间登记成功！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
					
			}
			
			 else if ("B5".equals(keywords)) {//有机上机开始时间
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "有机上机开始时间",chemLabTime)){
						err = "错误：" + retest + "有机上机开始时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "有机上机开始时间",chp.getRid(),chp.getSid(),fid,3)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "有机上机开始时间",chp.getRid(),chp.getSid(),fid,2,str)){
						BarCodeAction.getInstance().getUpdateStatus("有机上机开始时间",chp.getSid());
							kw = retest + "有机上机开始时间登记成功！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
			} else if ("B6".equals(keywords)) {//有机数据完成时间
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "有机数据完成时间",chemLabTime)){
						err = "错误：" + retest + "有机数据完成时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "有机数据完成时间",chp.getRid(),chp.getSid(),fid,4)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "有机数据完成时间",chp.getRid(),chp.getSid(),fid,2,str)){
						BarCodeAction.getInstance().getUpdateStatus("有机数据完成时间",chp.getSid());
							kw = retest + "有机数据完成时间登记成功！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
			} else if ("D1".equals(keywords)) {//食品级前处理开始时间
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "食品级前处理开始时间",chemLabTime)){
						err = "错误："+retest+"食品前处理开始时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "食品级前处理开始时间",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "食品级前处理开始时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "食品级前处理开始时间登记成功！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
			} else if ("D2".equals(keywords)) {//食品级上机开始时间
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "食品级上机开始时间",chemLabTime)){
						err = "错误：" + retest + "食品级上机开始时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "食品级上机开始时间",chp.getRid(),chp.getSid(),fid,3)) {
							if(ChemProjectAction.getInstance().updateTime(retest + "食品级上机开始时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "食品级上机开始时间登记成功！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
			} else if ("D3".equals(keywords)) {//食品级数据完成时间
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + "食品级数据完成时间",chemLabTime)){
						err = "错误：" + retest + "食品级数据完成时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "食品级数据完成时间",chp.getRid(),chp.getSid(),fid,4)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "食品级数据完成时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "食品级数据完成时间登记成功！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
			} else if ("C8".equals(keywords)) {//外包发出时间
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + fid + "外包发出时间",chemLabTime)){
						err = "错误：" + retest + "外包发出时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + fid + "外包发出时间",chp.getRid(),chp.getSid(),fid,0)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "外包发出时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "外包发出时间登记成功！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
			} else if ("C9".equals(keywords)) {//外包完成时间
					if (chp == null) {
						err = "错误：尚未读取报告号,或登记间隔时间过长！";
					} else if(BarCodeAction.getInstance().getstatus(retest + fid + "外包完成时间",chemLabTime)){
						err = "错误：" + retest + "外包完成时间重复登记!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + fid + "外包完成时间",chp.getRid(),chp.getSid(),fid,0)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "外包完成时间",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "外包完成时间登记成功！";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "读取错误，请重新读取！";
						}
					}
			}
			else if ("B7".equals(keywords)) {//报告编辑完成完成时间
				if (chp == null) {
					err = "错误：尚未读取报告号,或登记间隔时间过长！";
				} else if(chemp.getEndtime() != null){
					err = "错误：" + retest + "报告完成时间重复登记!";
				} else {
					//if(BarCodeAction.getInstance().updateTime("dendtime",chp.getRid(),chp.getSid(),fid,4)) {
					if(ChemProjectAction.getInstance().updateTime("dendtime",chp.getRid(),chp.getSid(),fid,2,str)){
						kw = retest + "报告完成时间登记成功！";
						sound = false;
						session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
					} else {
						err = "读取错误，请重新读取！";
					}
				}
			}
%> 
<%
		} 
		else if (keywords.length() >= 12) {
			if("LC".equals(keywords.substring(0,2))) {
				Project project = ChemProjectAction.getInstance().searchChemProjectByRid(keywords);
				if(project != null) {
				if(str.equals("C")||str.equals("D")){
					chemp = (ChemProject)project.getObj();
					}else{
					phy = (PhyProject)project.getObj();
					}
				}
				if (project == null) {
					err = "错误：无效报告号！";
				} else if(chemp.getSendtime() != null || phy.getEndtime() !=null){
					err = "错误：" + retest + "报告发出时间重复登记!";
				} else {
					//if(BarCodeAction.getInstance().updateTime("dsendtime",project.getRid(),project.getSid(),fid,4)) {
					if(ChemProjectAction.getInstance().updateTime(retest + "dsendtime",chp.getRid(),chp.getSid(),fid,2,str)){
						kw = retest + "报告发出时间登记成功！";
						sound = false;
						session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,project.getRid()));
					} else {
						err = "读取错误，请重新读取！";
					}
				}
			}
		} else {
			if(chp == null) {
				err = "错误：尚未读取报告号,或登记间隔时间过长！";
			} else if("y".equals(chemp.getIsfinish())||"y".equals(phy.getIsfinish())) {
				err = "错误：报告已经完成或者取消，不可以再录入！";
			}
		}
	}

Project p = (Project) session.getAttribute("project");
  ChemProject cp=null;
  PhyProject phy=null;
  List<ChemLabTime> list=null;
	
	if(p!=null){
		String rid =p.getRid();
		 str=rid.substring(3, 4);
		if(p.getPtype().equals("化学测试")||p.getPtype().equals("化妆品")||p.getPtype().equals("环境")){
	   cp = (ChemProject)p.getObj();
	 	list =cp.getList();
	 	chemLabTime=cp.getList();
	 	if(cp.getEndtime()!=null){
		endtime=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getEndtime());
		}
		if(cp.getSendtime()!=null){
		sendtime=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(cp.getSendtime());
		}
		samplename =cp.getSamplename();
	}else{
	 phy =(PhyProject)p.getObj();
	 list =phy.getList();
	 if(phy.getEndtime()!=null){
	 endtime=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(phy.getEndtime());
	}
	 samplename=phy.getSamplename();
	}
	}
	
	if(p == null) {
		p = new Project();
	}
	if(cp == null) {
		cp = new ChemProject();
	}
	if(phy == null) {
		phy = new PhyProject();
	}
	
	
	if(list == null) {
		list = new ArrayList<ChemLabTime>();
	}
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>项目进度查询</title>
		<link rel="stylesheet" href="../css/drp.css">


<script type="text/javascript">
    window.onload=function(){//页面加载时的函数
    	document.form1.keywords.focus();
    	<%if(!("".equals(err))) {%>
    		alert("<%=err%>");
    	<%}%>
    }
  </script>



		
	</head>

	<body class="body1">  
	
	<%
		if(sound) {
	%>
		<bgsound src="Readagain.wav" loop="1" id="bgs" />
	<%
	}
	%>
	
   
	 
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			align="center">
			<tr>
				<td align="center">
					<b><h2>
							条形码录入
						</h2> </b>
				</td>
			</tr>
		</table>
		
		<hr width="97%" align="center" size=0>
		<form name=form1 method=post action="barcode.jsp?command=add">
			<table width=95% border=0 cellspacing=5 cellpadding=5 align=center>
				<tr>
					<td align=left valign=middle width=50%>
						输入栏：
						<input type=text name="keywords" id="keywords" value="" size="40" />
						<input type="submit" name="submit" value="提交"/>
					</td>
					
				</tr>
				<tr>
					<td align=left valign=middle width=50%>
						<div>
							<font size="5"><strong><u><%=kw %></u>
							</strong>
							</font>
						</div>
					</td>
				</tr>
			</table>


			<hr width="97%" align="center" size=0>
			

			<table align="center" cellspacing=5 cellpadding=5 width="95%">
				<tr>
					<td width="17%">
						报告编号：
					</td>
					<td width="20%">
						<input name="rid" type="text" size="15"
							style="background-color: #F2F2F2" readonly="readonly"
							value="<%=p.getRid()==null?"":p.getRid()%>" />
					</td>
					<td width="17%">
						项目等级：
					</td>
					<td >
						<input type="text" size="15" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=p.getLevel()==null?"":p.getLevel()%>" />
					</td>
				</tr>
			</table>

			<table align="center" cellspacing=5 cellpadding=5 width="95%">
				<tr>
					<td width="17%">
						测试项目：
					</td>
					<td>
						<input size="80" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=p.getTestcontent()==null?"":p.getTestcontent()%>" />
					</td>
				</tr>

				<tr>
					<td>
						样品名称：
					</td>
					<td>
						<input type="text" size="80" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=samplename%>" />
					</td>
				</tr>
				<tr>
					<td>
						备注：
					</td>
					<td>
						<textarea name="notes" cols="80" rows="4" readonly="readonly" style="background-color: #F2F2F2"><%=p.getNotes()==null?"":p.getNotes() %></textarea>
					</td>
				</tr>

			</table>
			<table align="center" cellspacing=5 cellpadding=5 width="95%">
				<tr>
					<td width="20%">
						项目接收时间：
					</td>
					<td style="background: yellow;">
						<%=p.getBuildtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(p.getBuildtime())%>
					</td>
				</tr>
				<tr>
					<td>
						排单时间：
					</td>
					<td style="background: yellow;">
						<%=p.getBuildtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(p.getBuildtime())%>
					</td>
				</tr>
				
				<%
					for(int i=0;i<list.size();i++) {
						ChemLabTime clt = list.get(i);
				 %>
				
				<tr>
					<td>
						<%=clt.getStatus() %>：
					</td>
					<td style="background: yellow;">
						<%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(clt.getTime()) %>
					</td>
					
				</tr>

				<%} %>

				<tr>
					<td>
						报告完成时间：
					</td>
					<td style="background: yellow;">
						<%=endtime%>
					</td>
				</tr>
				<tr>
					<td>
						报告发出时间：
					</td>
					<td style="background: yellow;">
						<%=sendtime%>
					</td>
				</tr>
			</table>
			<br>
			<br>
			<br>
		</form>
	</body>
</html>
