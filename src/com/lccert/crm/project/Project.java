package com.lccert.crm.project;

import java.util.Date;

/**
 * 项目公共实体类（财务）
 * 
 * @author Eason
 * 
 */
public class Project {
	//ID
	private int id;
	//项目号
	private String sid;
	//报告号
	private String rid;
	//报价单号
	private String pid;
	//测试类型（化学测试、电子电器测试、EMC测试...）
	private String ptype;
	//测试项目
	private String testcontent;
	//分解人
	private String buildname;
	//分解时间
	private Date buildtime;
	//分项目金额
	private float price;
	//预估外部分包费
	private String presubcost;
	//外部分包机构
	private String subname;
	//预估外部分包费2
	private String  presubcost2;
	//外部分包机构2
	private String subname2;
	//实际外部分包费
	private float subcost;
	//外部分包费收款日期
	private Date subcosttime;
	//外部分包费支付票据
	private String subcostnotes;
	//
	private String subcosttag;
	//实际外部分包费2
	private float subcost2;
	//外部分包费2收款日期
	private Date subcosttime2;
	//外部分包费2支付票据
	private String subcostnotes2;
	//
	private String subcosttag2;
	//内部分包费
	private float insubcost;
	//内部分包说明
	private String insubtag;
	//预估合作机构费用
	private float preagcost;
	//合作机构名称
	private String agname;
	//机构费用是否客户支付
	private String clientpay;
	//实际合作机构费用
	private float agcost;
	//合作机构费用支付日期
	private Date agtime;
	//合作机构费用支付票据
	private String agnotes;
	//
	private String agtag;
	//其它费用
	private float otherscost;
	//其它费用备注
	private String otherstag;
	//票据类型
	private String invtype;
	//开票方式
	private String invhead;
	//票据内容
	private String invcontent;
	//预估开票金额
	private float preinvprice;
	//实际开票金额
	private float invprice;
	//客服审核人
	private String auditman;
	//客服审核时间
	private Date audittime;
	//
	private String projectsettle;
	//分项目核算金额
	private float ppreacount;
	//分项目结算金额
	private float pacount;
	//项目等级
	private String level;
	//测试方式（自测、机构合作）
	private String type;
	//是否外包
	private String isout;
	//实验室（东莞实验室、中山实验室）
	private String lab;
	//备注
	private String notes;
	//测试项目（化学项目、安规项目）
	private Object obj;
	private Object objcp;
	private Object objf;
	//记录t_chem_project_time的流转单进行状态
	private String status;
	//记录机构费用的备注
	private String agremarks;
	//外包发出时间
	private Date ostime;
	//外包数据应回时间
	private Date ortime;
	//请款时间
	private Date bqtime;
	//实际回数据时间
	private Date oetime;
	private String sales ; //销售名称
	private String samplename ; //样品名称
	private String client ;  //客户名称
	private Float assist; //辅助财务统计
	
	//TUV检测编号
	private String tuvno ;
	//TUV项目简称
	private String tuvpshort  ;
	//立创实际报价（内部报价）
	private float lcrealprice ;
	//实际外包金额
	private float oeprice;
	private String quotytp ; //报价单类型
	private String granttime;
	private String filingNo; //备案编号(化妆品用了定义报告号用)

	
	
	public String getGranttime() {
		return granttime;
	}
	public void setGranttime(String granttime) {
		this.granttime = granttime;
	}
	public String getQuotytp() {
		return quotytp;
	}
	public void setQuotytp(String quotytp) {
		this.quotytp = quotytp;
	}
	public Float getAssist() {
		return assist;
	}
	public void setAssist(Float assist) {
		this.assist = assist;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getPtype() {
		return ptype;
	}
	public void setPtype(String ptype) {
		this.ptype = ptype;
	}
	public String getTestcontent() {
		return testcontent;
	}
	public void setTestcontent(String testcontent) {
		this.testcontent = testcontent;
	}
	public String getBuildname() {
		return buildname;
	}
	public void setBuildname(String buildname) {
		this.buildname = buildname;
	}
	public Date getBuildtime() {
		return buildtime;
	}
	public void setBuildtime(Date buildtime) {
		this.buildtime = buildtime;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public String getPresubcost() {
		return presubcost;
	}
	public void setPresubcost(String presubcost) {
		this.presubcost = presubcost;
	}
	public String getSubname() {
		return subname;
	}
	public void setSubname(String subname) {
		this.subname = subname;
	}
	public String getPresubcost2() {
		return presubcost2;
	}
	public void setPresubcost2(String presubcost2) {
		this.presubcost2 = presubcost2;
	}
	public String getSubname2() {
		return subname2;
	}
	public void setSubname2(String subname2) {
		this.subname2 = subname2;
	}
	public float getSubcost() {
		return subcost;
	}
	public void setSubcost(float subcost) {
		this.subcost = subcost;
	}
	public Date getSubcosttime() {
		return subcosttime;
	}
	public void setSubcosttime(Date subcosttime) {
		this.subcosttime = subcosttime;
	}
	public String getSubcostnotes() {
		return subcostnotes;
	}
	public void setSubcostnotes(String subcostnotes) {
		this.subcostnotes = subcostnotes;
	}
	public String getSubcosttag() {
		return subcosttag;
	}
	public void setSubcosttag(String subcosttag) {
		this.subcosttag = subcosttag;
	}
	public float getSubcost2() {
		return subcost2;
	}
	public void setSubcost2(float subcost2) {
		this.subcost2 = subcost2;
	}
	public Date getSubcosttime2() {
		return subcosttime2;
	}
	public void setSubcosttime2(Date subcosttime2) {
		this.subcosttime2 = subcosttime2;
	}
	public String getSubcostnotes2() {
		return subcostnotes2;
	}
	public void setSubcostnotes2(String subcostnotes2) {
		this.subcostnotes2 = subcostnotes2;
	}
	public String getSubcosttag2() {
		return subcosttag2;
	}
	public void setSubcosttag2(String subcosttag2) {
		this.subcosttag2 = subcosttag2;
	}
	public float getInsubcost() {
		return insubcost;
	}
	public void setInsubcost(float insubcost) {
		this.insubcost = insubcost;
	}
	public String getInsubtag() {
		return insubtag;
	}
	public void setInsubtag(String insubtag) {
		this.insubtag = insubtag;
	}
	public float getPreagcost() {
		return preagcost;
	}
	public void setPreagcost(float preagcost) {
		this.preagcost = preagcost;
	}
	public String getAgname() {
		return agname;
	}
	public void setAgname(String agname) {
		this.agname = agname;
	}
	public String getClientpay() {
		return clientpay;
	}
	public void setClientpay(String clientpay) {
		this.clientpay = clientpay;
	}
	public float getAgcost() {
		return agcost;
	}
	public void setAgcost(float agcost) {
		this.agcost = agcost;
	}
	public Date getAgtime() {
		return agtime;
	}
	public void setAgtime(Date agtime) {
		this.agtime = agtime;
	}
	public String getAgnotes() {
		return agnotes;
	}
	public void setAgnotes(String agnotes) {
		this.agnotes = agnotes;
	}
	public String getAgtag() {
		return agtag;
	}
	public void setAgtag(String agtag) {
		this.agtag = agtag;
	}
	public float getOtherscost() {
		return otherscost;
	}
	public void setOtherscost(float otherscost) {
		this.otherscost = otherscost;
	}
	public String getOtherstag() {
		return otherstag;
	}
	public void setOtherstag(String otherstag) {
		this.otherstag = otherstag;
	}
	public String getInvtype() {
		return invtype;
	}
	public void setInvtype(String invtype) {
		this.invtype = invtype;
	}
	public String getInvhead() {
		return invhead;
	}
	public void setInvhead(String invhead) {
		this.invhead = invhead;
	}
	public String getInvcontent() {
		return invcontent;
	}
	public void setInvcontent(String invcontent) {
		this.invcontent = invcontent;
	}
	public float getPreinvprice() {
		return preinvprice;
	}
	public void setPreinvprice(float preinvprice) {
		this.preinvprice = preinvprice;
	}
	public float getInvprice() {
		return invprice;
	}
	public void setInvprice(float invprice) {
		this.invprice = invprice;
	}
	public String getAuditman() {
		return auditman;
	}
	public void setAuditman(String auditman) {
		this.auditman = auditman;
	}
	public Date getAudittime() {
		return audittime;
	}
	public void setAudittime(Date audittime) {
		this.audittime = audittime;
	}
	public String getProjectsettle() {
		return projectsettle;
	}
	public void setProjectsettle(String projectsettle) {
		this.projectsettle = projectsettle;
	}
	public float getPpreacount() {
		return ppreacount;
	}
	public void setPpreacount(float ppreacount) {
		this.ppreacount = ppreacount;
	}
	public float getPacount() {
		return pacount;
	}
	public void setPacount(float pacount) {
		this.pacount = pacount;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getIsout() {
		return isout;
	}
	public void setIsout(String isout) {
		this.isout = isout;
	}
	public String getLab() {
		return lab;
	}
	public void setLab(String lab) {
		this.lab = lab;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
	public Object getObj() {
		return obj;
	}
	public void setObj(Object obj) {
		this.obj = obj;
	}
	public Object getObjcp() {
		return objcp;
	}
	public void setObjcp(Object objcp) {
		this.objcp = objcp;
	}
	public Object getObjf() {
		return objf;
	}
	public void setObjf(Object objf) {
		this.objf = objf;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getAgremarks() {
		return agremarks;
	}
	public void setAgremarks(String agremarks) {
		this.agremarks = agremarks;
	}
	public Date getOstime() {
		return ostime;
	}
	public void setOstime(Date ostime) {
		this.ostime = ostime;
	}
	public Date getOrtime() {
		return ortime;
	}
	public void setOrtime(Date ortime) {
		this.ortime = ortime;
	}
	public Date getBqtime() {
		return bqtime;
	}
	public void setBqtime(Date bqtime) {
		this.bqtime = bqtime;
	}
	public Date getOetime() {
		return oetime;
	}
	public void setOetime(Date oetime) {
		this.oetime = oetime;
	}
	public String getSales() {
		return sales;
	}
	public void setSales(String sales) {
		this.sales = sales;
	}
	public String getSamplename() {
		return samplename;
	}
	public void setSamplename(String samplename) {
		this.samplename = samplename;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getTuvno() {
		return tuvno;
	}
	public void setTuvno(String tuvno) {
		this.tuvno = tuvno;
	}
	public String getTuvpshort() {
		return tuvpshort;
	}
	public void setTuvpshort(String tuvpshort) {
		this.tuvpshort = tuvpshort;
	}
	public float getLcrealprice() {
		return lcrealprice;
	}
	public void setLcrealprice(float lcrealprice) {
		this.lcrealprice = lcrealprice;
	}
	public float getOeprice() {
		return oeprice;
	}
	public void setOeprice(float oeprice) {
		this.oeprice = oeprice;
	}
	public String getFilingNo() {
		return filingNo;
	}
	public void setFilingNo(String filingNo) {
		this.filingNo = filingNo;
	}
	
	
	
	

}