package com.lccert.crm.dao;

import java.util.List;

import com.lccert.crm.vo.SamplePackage;
 //样品的DAO类
public interface SampleDao {
	//增加包裹信息
	public int addSamplePackage(List list);
	//增加样品状态
	public int addSamplePackage1(List list);
	 // 查询包裹信息
	public List getSamplePackage(List temp);
	//根据包裹号获取包裹信息
	public List getPackageNo (List list,String pno);
	//根据包裹id获取包裹信息
	public List getPackageById (List list,int id);
	//增加样品信息
	public int addSample(List list);
	//增加样品出入库信息
	public int addSamplePursue(List list);
	//查询样品
	public List getSample(List list);
	//查询样品是否有值
	public List getSampleSno(String sno);
	//根据id获取样品信息
	public List getSampleById(List list,int id);
	//更改样品信息
	public int upSample(List list);
	 // 根据报价单号获取样品
	public List getSampleByPid(List list ,String pid,String sno,String client);
	public List getSampleById1(List list,int id);
	//查询样品跟踪信息
	public List getSamplePurser(List list,String sno);
	//生成包裹号的方法
	public String makePNo();
	//根据名称获取邮箱地址
	public List getEmailByName(List list,String name);
	//更改样品出库信息
	public int upOutBound(List list) ;
	//获取一级仓库存放样品
	public List  getParentLab();
	//获取二级仓库存放样品
	public List getChildLab(int parentId);
}
