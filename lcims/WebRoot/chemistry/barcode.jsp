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
	String kw = "����뱨��������";
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
				retest = "�ز�";
			}
		}
		
		if(chp != null) {
			String rid =chp.getRid();
		 str=chp.getPtype();
		if(chp.getPtype().equals("��ѧ����")||chp.getPtype().equals("��ױƷ")||chp.getPtype().equals("����")){
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
		if (keywords.length() == 10) { //&&���Ҹ���keywords�������ݿ�
			Flow flow = BarCodeAction.getInstance().getFlowByFid(keywords);
			System.out.println("flow:"+flow);
			keywords = keywords.substring(0,9);
			//-----------------------------------------����phy�ı��
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
				kw = "�ɹ���ȡ��ת���ţ�����10���ڶ�ȡ��Ŀ״̬������!";
				sound = false;
			} else {
				err = "��Ч��ת����!";
			}
		} 
		
		else if ("B11".equals(keywords)) {//���￪ʼʱ��
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "���￪ʼʱ��",chemLabTime)){
						err = "����" + retest + "���￪ʼʱ���ظ��Ǽ�!";
					} else {
						
							if(ChemProjectAction.getInstance().updateTime(retest + "���￪ʼʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
								//BarCodeAction.getInstance().getUpdateStatus("���￪ʼʱ��",chp.getSid());
							kw = retest + "���￪ʼʱ��Ǽǳɹ���";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
			} 
		else if ("B12".equals(keywords)) {//�������ʱ��
				if (chp == null) {
					err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
				} else if(BarCodeAction.getInstance().getstatus(retest + "�������ʱ��",chemLabTime)){
					err = "����" + retest + "�������ʱ���ظ��Ǽ�!";
				} else {
					//if(BarCodeAction.getInstance().updateTime(retest + "gcms1�л��ϻ���ʼʱ��",chp.getRid(),chp.getSid(),fid,3)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "�������ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
						//BarCodeAction.getInstance().getUpdateStatus("�������ʱ��",chp.getSid());
						kw = retest + "�������ʱ��Ǽǳɹ���";
						sound = false;
						session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
					} else {
						err = "��ȡ���������¶�ȡ��";
					}
				}
		} 
		else if(flow0 != null && "n".equals(chemp.getIsfinish())||"n".equals(phy.getIsfinish())) {
			 if ("X0".equals(keywords)) {//�Ʊ���ʼʱ��
					if("�޻���ת��".equals(flowtype)) {
						if (chp == null) {
							err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
						} else if(BarCodeAction.getInstance().getstatus(retest + "�޻��Ʊ���ʼʱ��",chemLabTime)){
							err = "����" + retest + "�޻��Ʊ���ʼʱ���ظ��Ǽ�!";
						} else {
							if(ChemProjectAction.getInstance().updateTime(retest + "�޻��Ʊ���ʼʱ��",chp.getRid(),chp.getSid(),fid,1,str)){
							//if(BarCodeAction.getInstance().updateTime(retest + "�޻��Ʊ���ʼʱ��",chp.getRid(),chp.getSid(),fid,1)) {
							    BarCodeAction.getInstance().getUpdateStatus("�޻��Ʊ���ʼʱ��",chp.getSid());
								kw = retest + "�޻��Ʊ���ʼʱ��Ǽǳɹ���";
								sound = false;
								session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
							} else {
								err = "��ȡ���������¶�ȡ��";
							}
						}
					} else if("�л���ת��".equals(flowtype)) {
						if (chp == null) {
							err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
						} else if(BarCodeAction.getInstance().getstatus(retest + "�л��Ʊ���ʼʱ��",chemLabTime)){
							err = "����" + retest + "�л��Ʊ���ʼʱ���ظ��Ǽ�!";
						} else {
							//if(BarCodeAction.getInstance().updateTime(retest + "�л��Ʊ���ʼʱ��",chp.getRid(),chp.getSid(),fid,1)) {
							if(ChemProjectAction.getInstance().updateTime(retest + "�л��Ʊ���ʼʱ��",chp.getRid(),chp.getSid(),fid,1,str)){
							BarCodeAction.getInstance().getUpdateStatus("�л��Ʊ���ʼʱ��",chp.getSid());
								kw = retest + "�л��Ʊ���ʼʱ��Ǽǳɹ���";
								sound = false;
								session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
							} else {
								err = "��ȡ���������¶�ȡ��";
							}
						}
					
					} else if("ʳƷ��ת��".equals(flowtype)) {
						if (chp == null) {
							err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
						} else if(BarCodeAction.getInstance().getstatus(retest + "ʳƷ�Ʊ���ʼʱ��",chemLabTime)){
							err = "����" + retest + "ʳƷ�Ʊ���ʼʱ���ظ��Ǽ�!";
						} else {
							//if(BarCodeAction.getInstance().updateTime(retest + "ʳƷ�Ʊ���ʼʱ��",chp.getRid(),chp.getSid(),fid,1)) {
								if(ChemProjectAction.getInstance().updateTime(retest + "ʳƷ�Ʊ���ʼʱ��",chp.getRid(),chp.getSid(),fid,1,str)){
								kw = retest + "ʳƷ�Ʊ���ʼʱ��Ǽǳɹ���";
								sound = false;
								session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
							} else {
								err = "��ȡ���������¶�ȡ��";
							}
						}
					
					}
			}  else if ("A1".equals(keywords)) {//�޻�ǰ����ʼʱ��
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "�޻�ǰ����ʼʱ��",chemLabTime)){
						err = "����" + retest + "�޻�ǰ����ʼʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "�޻�ǰ����ʼʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "�޻�ǰ����ʼʱ��",chp.getRid(),chp.getSid(),fid,1,str)){
							BarCodeAction.getInstance().getUpdateStatus("�޻�ǰ����ʼʱ��",chp.getSid());
							kw = retest + "�޻�ǰ����ʼʱ��Ǽǳɹ���";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
			} else if ("A2".equals(keywords)) {//�޻��ϻ���ʼʱ��
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "�޻��ϻ���ʼʱ��",chemLabTime)){
						err = "����" + retest + "�޻��ϻ���ʼʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "�޻��ϻ���ʼʱ��",chp.getRid(),chp.getSid(),fid,3)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "�޻��ϻ���ʼʱ��",chp.getRid(),chp.getSid(),fid,1,str)){
						BarCodeAction.getInstance().getUpdateStatus("�޻��ϻ���ʼʱ��",chp.getSid());
							kw = retest + "�޻��ϻ���ʼʱ��Ǽǳɹ���";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
			} else if ("A3".equals(keywords)) {//�޻��������ʱ��
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "�޻��������ʱ��",chemLabTime)){
						err = "����" + retest + "�޻��������ʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "�޻��������ʱ��",chp.getRid(),chp.getSid(),fid,4)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "�޻��������ʱ��",chp.getRid(),chp.getSid(),fid,1,str)){
						BarCodeAction.getInstance().getUpdateStatus("�޻��������ʱ��",chp.getSid());
							kw = retest + "�޻��������ʱ��Ǽǳɹ���";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
			}
			
			
			
			//���̲�������������
			//���̲�������������
			else if ("T1".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "��ֿ�ʼʱ��",chemLabTime)){
						err = "����"+retest+"��ֿ�ʼʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "��ֿ�ʼʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "��ֿ�ʼʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "��ֿ�ʼʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
			else if ("T2".equals(keywords)) {
					if (chp == null) {
						err = "����"+retest+"��δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "�������ϲ�ͬ���ʡ�ʱ��",chemLabTime)){
						err = "���󣺷������ϲ�ͬ���ʡ�ʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "�������ϲ�ͬ���ʡ�ʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "�������ϲ�ͬ���ʡ�ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "�������ϲ�ͬ���ʡ�ʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
			else if ("T3".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "���ա��ϲ�ͬ���ʡ�ʱ��",chemLabTime)){
						err = "����"+retest+"���ա��ϲ�ͬ���ʡ�ʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "���ա��ϲ�ͬ���ʡ�ʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "���ա��ϲ�ͬ���ʡ�ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "���ա��ϲ�ͬ���ʡ�ʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
			else if ("T4".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "XRFɨ�����ʱ��",chemLabTime)){
						err = "����"+retest+"XRFɨ�����ʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "XRFɨ�����ʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "XRFɨ�����ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "XRFɨ�����ʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
			else if ("T5".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					
					} else if(BarCodeAction.getInstance().getstatus(retest + "���������Լƻ���ʱ��",chemLabTime)){
					System.out.println(retest+"-------");
						err = "����"+retest+"���������Լƻ���ʱ��!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "���������Լƻ���ʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "���������Լƻ���ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "���������Լƻ���ʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
			else if ("T6".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "����������������֪ͨ��ʱ��",chemLabTime)){
						err = "����"+retest+"����������������֪ͨ��ʱ��!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "����������������֪ͨ��ʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "����������������֪ͨ��ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "����������������֪ͨ��ʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
			else if ("T7".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "�ͻ������ṩ��Ϣʱ��",chemLabTime)){
						err = "����"+retest+"�ͻ������ṩ��Ϣʱ��!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "�ͻ������ṩ��Ϣʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "�ͻ������ṩ��Ϣʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "�ͻ������ṩ��Ϣʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
			else if ("T8".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "���Ա���༭��ɵ�ʱ��",chemLabTime)){
						err = "����"+retest+"���Ա���༭��ɵ�ʱ��!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "���Ա�����ɵ�ʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "���Ա���༭��ɵ�ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "���Ա���༭��ɵ�ʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
			
			else if ("T9".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "������TUV��ʱ��",chemLabTime)){
						err = "����"+retest+"������TUV��ʱ��!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "������TUV��ʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "������TUV��ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "������TUV��ʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
			else if ("T0".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "����������",chemLabTime)){
						err = "����"+retest+"����������!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "����������",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "����������",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "���������ɣ�";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
					
					
					
					
					
					
				//FΪ����ʳƷ�Ĳ���ʱ��	
			else if ("F1".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "���Ե�������ʼ��ʱ��",chemLabTime)){
						err = "����"+retest+"���Ե�������ʼ��ʱ��!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "���Ե�������ʼ��ʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "���Ե�������ʼ��ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "���Ե�������ʼ��ʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
			else if ("F2".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "��Ϣȷ�Ϸ���ʱ��",chemLabTime)){
						err = "����"+retest+"��Ϣȷ�Ϸ���ʱ��!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "��Ϣȷ�Ϸ���ʱ��",chp.getRid(),chp.getSid(),fid,2)) {
							if(ChemProjectAction.getInstance().updateTime(retest + "��Ϣȷ�Ϸ���ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "��Ϣȷ�Ϸ���ʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
			else if ("F3".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "��Ϣȷ�����ʱ��",chemLabTime)){
						err = "����"+retest+"��Ϣȷ�����ʱ��!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "��Ϣȷ�����ʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "��Ϣȷ�����ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "��Ϣȷ�����ʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
			else if ("F4".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "���Կ�ʼ��ʱ��",chemLabTime)){
						err = "����"+retest+"���Կ�ʼ��ʱ��!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "���Կ�ʼ��ʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "���Կ�ʼ��ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "���Կ�ʼ��ʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
			else if ("F5".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "����|������ʼ��ʱ��",chemLabTime)){
						err = "����"+retest+"����|������ʼ��ʱ��!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "����|������ʼ��ʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "����|������ʼ��ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "����|������ʼ��ʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
			else if ("F6".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "����|������ɵ�ʱ��",chemLabTime)){
						err = "����"+retest+"����|������ɵ�ʱ��!";
					} else {
					//	if(BarCodeAction.getInstance().updateTime(retest + "����|������ɵ�ʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "����|������ɵ�ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "����|������ɵ�ʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
					
					
					
					
					
					
			else if ("F7".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "������ɵ�ʱ��",chemLabTime)){
						err = "����"+retest+"������ɵ�ʱ��!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "������ɵ�ʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "������ɵ�ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "������ɵ�ʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
			else if ("F8".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "����������",chemLabTime)){
						err = "����"+retest+"����������!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "����������",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "����������",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "���������ɣ�";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
				}
				else if ("F9".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "�ݸ����",chemLabTime)){
						err = "����"+retest+"�ݸ����!";
					} else {
						if(ChemProjectAction.getInstance().updateTime(retest + "�ݸ����",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "�ݸ���ɣ�";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
				}
			else if ("C7".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "���Ͷ�ݸ����",chemLabTime)){
						err = "����"+retest+"���Ͷ�ݸ����!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "����������",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "���Ͷ�ݸ����",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "���Ͷ�ݸ���ԣ�";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
		
			 else if ("B8".equals(keywords)) {//�л��ϻ���ʼʱ��
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "gcms1�л��ϻ���ʼʱ��",chemLabTime)){
						err = "����" + retest + "gcms1�л��ϻ���ʼʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "gcms1�л��ϻ���ʼʱ��",chp.getRid(),chp.getSid(),fid,3)) {
							if(ChemProjectAction.getInstance().updateTime(retest + "gcms1�л��ϻ���ʼʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
						BarCodeAction.getInstance().getUpdateStatus("gcms1�л��ϻ���ʼʱ��",chp.getSid());
							kw = retest + "gcms1�л��ϻ���ʼʱ��Ǽǳɹ���";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
			} 
			else if ("B9".equals(keywords)) {//�л��ϻ���ʼʱ��
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "gcms2�л��ϻ���ʼʱ��",chemLabTime)){
						err = "����" + retest + "gcms2�л��ϻ���ʼʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "gcms2�л��ϻ���ʼʱ��",chp.getRid(),chp.getSid(),fid,3)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "gcms2�л��ϻ���ʼʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							BarCodeAction.getInstance().getUpdateStatus("gcms2�л��ϻ���ʼʱ��",chp.getSid());
							kw = retest + "gcms2�л��ϻ���ʼʱ��Ǽǳɹ���";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
			} 
			 else if ("B10".equals(keywords)) {//�л��ϻ���ʼʱ��
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "��ݸ�������ʱ��",chemLabTime)){
						err = "����" + retest + "��ݸ�������ʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "gcms1�л��ϻ���ʼʱ��",chp.getRid(),chp.getSid(),fid,3)) {
							if(ChemProjectAction.getInstance().updateTime(retest + "��ݸ�������ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
						BarCodeAction.getInstance().getUpdateStatus("��ݸ�������ʱ��",chp.getSid());
							kw = retest + "��ݸ�������ʱ��Ǽǳɹ���";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
			} 
			 
			else if ("G3".equals(keywords)) {//�л��ϻ���ʼʱ��
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "gcms3�л��ϻ���ʼʱ��",chemLabTime)){
						err = "����" + retest + "gcms3�л��ϻ���ʼʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "gcms2�л��ϻ���ʼʱ��",chp.getRid(),chp.getSid(),fid,3)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "gcms3�л��ϻ���ʼʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							BarCodeAction.getInstance().getUpdateStatus("gcms3�л��ϻ���ʼʱ��",chp.getSid());
							kw = retest + "gcms3�л��ϻ���ʼʱ��Ǽǳɹ���";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
			} 
			
				else if ("I2".equals(keywords)) {//�л��ϻ���ʼʱ��
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "icp2�޻����ϻ���ʼʱ��",chemLabTime)){
						err = "����" + retest + "icp2�޻����ϻ���ʼʱ��!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "gcms2�л��ϻ���ʼʱ��",chp.getRid(),chp.getSid(),fid,3)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "icp2�޻����ϻ���ʼʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							BarCodeAction.getInstance().getUpdateStatus("icp2�޻����ϻ���ʼʱ��",chp.getSid());
							kw = retest + "icp2�޻����ϻ���ʼʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
			} 
			
			
			//��������������
			else if ("P1".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "��ʼ�ϻ�ʱ��",chemLabTime)){
						err = "����"+retest+"��ʼ�ϻ�ʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "��ʼ�ϻ�ʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "��ʼ�ϻ�ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "��ʼ�ϻ�ʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
			else if ("P2".equals(keywords)) {
					if (chp == null) {
						err = "����"+retest+"��δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "�ϻ�����ʱ��",chemLabTime)){
						err = "�ϻ�����ʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "�ϻ�����ʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "�ϻ�����ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "�ϻ�����ʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
			else if ("P3".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "��ʼ����ʱ��",chemLabTime)){
						err = "����"+retest+"��ʼ����ʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "��ʼ����ʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "��ʼ����ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "��ʼ����ʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
			else if ("P4".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "���Խ���ʱ��",chemLabTime)){
						err = "����"+retest+"���Խ���ʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "���Խ���ʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "���Խ���ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "���Խ���ʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
			else if ("P5".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
						
					} else if(BarCodeAction.getInstance().getstatus(retest + "�����дʱ��",chemLabTime)){
						err = "����"+retest+"�����дʱ��!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "�����дʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "�����дʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "�����дʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
			else if ("P6".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "�������ʱ��",chemLabTime)){
						err = "����"+retest+"�������ʱ��!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "�������ʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "�������ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "�������ʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}

	else if ("P7".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "��Ŀ����ʱ��",chemLabTime)){
						err = "����"+retest+"��Ŀ����ʱ��!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "��Ŀ����ʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "��Ŀ����ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "��Ŀ����ʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
					
					else if ("P8".equals(keywords)) {
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "ʵ���ҽ�����Ʒʱ��",chemLabTime)){
						err = "����"+retest+"ʵ���ҽ�����Ʒʱ��!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "ʵ���ҽ�����Ʒʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "ʵ���ҽ�����Ʒʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "ʵ���ҽ�����Ʒʱ�䣡";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					}
					
					
			else if ("B4".equals(keywords)) {//�л�ǰ����ʼʱ��
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "�л�ǰ����ʼʱ��",chemLabTime)){
						err = "����"+retest+"�л�ǰ����ʼʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "�л�ǰ����ʼʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "�л�ǰ����ʼʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
						BarCodeAction.getInstance().getUpdateStatus("�л�ǰ����ʼʱ��",chp.getSid());
							kw = retest + "�л�ǰ����ʼʱ��Ǽǳɹ���";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
					
			}
			
			 else if ("B5".equals(keywords)) {//�л��ϻ���ʼʱ��
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "�л��ϻ���ʼʱ��",chemLabTime)){
						err = "����" + retest + "�л��ϻ���ʼʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "�л��ϻ���ʼʱ��",chp.getRid(),chp.getSid(),fid,3)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "�л��ϻ���ʼʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
						BarCodeAction.getInstance().getUpdateStatus("�л��ϻ���ʼʱ��",chp.getSid());
							kw = retest + "�л��ϻ���ʼʱ��Ǽǳɹ���";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
			} else if ("B6".equals(keywords)) {//�л��������ʱ��
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "�л��������ʱ��",chemLabTime)){
						err = "����" + retest + "�л��������ʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "�л��������ʱ��",chp.getRid(),chp.getSid(),fid,4)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "�л��������ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
						BarCodeAction.getInstance().getUpdateStatus("�л��������ʱ��",chp.getSid());
							kw = retest + "�л��������ʱ��Ǽǳɹ���";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
			} else if ("D1".equals(keywords)) {//ʳƷ��ǰ����ʼʱ��
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "ʳƷ��ǰ����ʼʱ��",chemLabTime)){
						err = "����"+retest+"ʳƷǰ����ʼʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "ʳƷ��ǰ����ʼʱ��",chp.getRid(),chp.getSid(),fid,2)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "ʳƷ��ǰ����ʼʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "ʳƷ��ǰ����ʼʱ��Ǽǳɹ���";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
			} else if ("D2".equals(keywords)) {//ʳƷ���ϻ���ʼʱ��
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "ʳƷ���ϻ���ʼʱ��",chemLabTime)){
						err = "����" + retest + "ʳƷ���ϻ���ʼʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "ʳƷ���ϻ���ʼʱ��",chp.getRid(),chp.getSid(),fid,3)) {
							if(ChemProjectAction.getInstance().updateTime(retest + "ʳƷ���ϻ���ʼʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "ʳƷ���ϻ���ʼʱ��Ǽǳɹ���";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
			} else if ("D3".equals(keywords)) {//ʳƷ���������ʱ��
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + "ʳƷ���������ʱ��",chemLabTime)){
						err = "����" + retest + "ʳƷ���������ʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + "ʳƷ���������ʱ��",chp.getRid(),chp.getSid(),fid,4)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "ʳƷ���������ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "ʳƷ���������ʱ��Ǽǳɹ���";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
			} else if ("C8".equals(keywords)) {//�������ʱ��
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + fid + "�������ʱ��",chemLabTime)){
						err = "����" + retest + "�������ʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + fid + "�������ʱ��",chp.getRid(),chp.getSid(),fid,0)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "�������ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "�������ʱ��Ǽǳɹ���";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
			} else if ("C9".equals(keywords)) {//������ʱ��
					if (chp == null) {
						err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
					} else if(BarCodeAction.getInstance().getstatus(retest + fid + "������ʱ��",chemLabTime)){
						err = "����" + retest + "������ʱ���ظ��Ǽ�!";
					} else {
						//if(BarCodeAction.getInstance().updateTime(retest + fid + "������ʱ��",chp.getRid(),chp.getSid(),fid,0)) {
						if(ChemProjectAction.getInstance().updateTime(retest + "������ʱ��",chp.getRid(),chp.getSid(),fid,2,str)){
							kw = retest + "������ʱ��Ǽǳɹ���";
							sound = false;
							session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
						} else {
							err = "��ȡ���������¶�ȡ��";
						}
					}
			}
			else if ("B7".equals(keywords)) {//����༭������ʱ��
				if (chp == null) {
					err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
				} else if(chemp.getEndtime() != null){
					err = "����" + retest + "�������ʱ���ظ��Ǽ�!";
				} else {
					//if(BarCodeAction.getInstance().updateTime("dendtime",chp.getRid(),chp.getSid(),fid,4)) {
					if(ChemProjectAction.getInstance().updateTime("dendtime",chp.getRid(),chp.getSid(),fid,2,str)){
						kw = retest + "�������ʱ��Ǽǳɹ���";
						sound = false;
						session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,chp.getRid()));
					} else {
						err = "��ȡ���������¶�ȡ��";
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
					err = "������Ч����ţ�";
				} else if(chemp.getSendtime() != null || phy.getEndtime() !=null){
					err = "����" + retest + "���淢��ʱ���ظ��Ǽ�!";
				} else {
					//if(BarCodeAction.getInstance().updateTime("dsendtime",project.getRid(),project.getSid(),fid,4)) {
					if(ChemProjectAction.getInstance().updateTime(retest + "dsendtime",chp.getRid(),chp.getSid(),fid,2,str)){
						kw = retest + "���淢��ʱ��Ǽǳɹ���";
						sound = false;
						session.setAttribute("project",ChemProjectAction.getInstance().getPlan(str,project.getRid()));
					} else {
						err = "��ȡ���������¶�ȡ��";
					}
				}
			}
		} else {
			if(chp == null) {
				err = "������δ��ȡ�����,��ǼǼ��ʱ�������";
			} else if("y".equals(chemp.getIsfinish())||"y".equals(phy.getIsfinish())) {
				err = "���󣺱����Ѿ���ɻ���ȡ������������¼�룡";
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
		if(p.getPtype().equals("��ѧ����")||p.getPtype().equals("��ױƷ")||p.getPtype().equals("����")){
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
		<title>��Ŀ���Ȳ�ѯ</title>
		<link rel="stylesheet" href="../css/drp.css">


<script type="text/javascript">
    window.onload=function(){//ҳ�����ʱ�ĺ���
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
							������¼��
						</h2> </b>
				</td>
			</tr>
		</table>
		
		<hr width="97%" align="center" size=0>
		<form name=form1 method=post action="barcode.jsp?command=add">
			<table width=95% border=0 cellspacing=5 cellpadding=5 align=center>
				<tr>
					<td align=left valign=middle width=50%>
						��������
						<input type=text name="keywords" id="keywords" value="" size="40" />
						<input type="submit" name="submit" value="�ύ"/>
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
						�����ţ�
					</td>
					<td width="20%">
						<input name="rid" type="text" size="15"
							style="background-color: #F2F2F2" readonly="readonly"
							value="<%=p.getRid()==null?"":p.getRid()%>" />
					</td>
					<td width="17%">
						��Ŀ�ȼ���
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
						������Ŀ��
					</td>
					<td>
						<input size="80" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=p.getTestcontent()==null?"":p.getTestcontent()%>" />
					</td>
				</tr>

				<tr>
					<td>
						��Ʒ���ƣ�
					</td>
					<td>
						<input type="text" size="80" style="background-color: #F2F2F2"
							readonly="readonly" value="<%=samplename%>" />
					</td>
				</tr>
				<tr>
					<td>
						��ע��
					</td>
					<td>
						<textarea name="notes" cols="80" rows="4" readonly="readonly" style="background-color: #F2F2F2"><%=p.getNotes()==null?"":p.getNotes() %></textarea>
					</td>
				</tr>

			</table>
			<table align="center" cellspacing=5 cellpadding=5 width="95%">
				<tr>
					<td width="20%">
						��Ŀ����ʱ�䣺
					</td>
					<td style="background: yellow;">
						<%=p.getBuildtime()==null?"":new SimpleDateFormat("yyyy-MM-dd HH:mm").format(p.getBuildtime())%>
					</td>
				</tr>
				<tr>
					<td>
						�ŵ�ʱ�䣺
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
						<%=clt.getStatus() %>��
					</td>
					<td style="background: yellow;">
						<%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(clt.getTime()) %>
					</td>
					
				</tr>

				<%} %>

				<tr>
					<td>
						�������ʱ�䣺
					</td>
					<td style="background: yellow;">
						<%=endtime%>
					</td>
				</tr>
				<tr>
					<td>
						���淢��ʱ�䣺
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
