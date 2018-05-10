package com.lccert.crm.vo;
/**
 * 收入bean
 * @author tangzp
 *
 */
public class Fincome {
	private int id ; //收入id 
	private String dpaytime ; // 收款日 期
	private String client ; //客户名称
	private String vpyear; //报价单所属年份
	private String vpmonth ; //报价单所属月份
	private String vpid ; //报价单号
	private String dept ; //部门
	private String sales ; //销售
	private Double chem ; //化学
	private Double safe ; //安全
	private Double op ; //光性能
	private Double emc ; //emc联营
	private Double dr ; //EMC暗室
	private Double vip ; // 大客户部 
	private Double eq ; //环境部
	private Double finance ; //财务部
	private Double gz ; // 广州公司 
	private Double  total  ; //小计
	private String account ; //账号名称
	private String einvtype ; // 票据类型 
	private String province ; //省份
	private String city ; //城市
	private String einvno ; //票据号码
	private String remarks ; //备注
	private int pageNo;
	private int pageSize;
	private String startDpaytime; //收入开始时间
	private String endDayTiem ;//收入结束时间
	private String startCreatetime; //录入开始时间
	private String endCreatetime; //录入结束时间
	
	public String getEinvno() {
		return einvno;
	}
	public void setEinvno(String einvno) {
		this.einvno = einvno;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDpaytime() {
		return dpaytime;
	}
	public void setDpaytime(String dpaytime) {
		this.dpaytime = dpaytime;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getVpyear() {
		return vpyear;
	}
	public void setVpyear(String vpyear) {
		this.vpyear = vpyear;
	}
	public String getVpmonth() {
		return vpmonth;
	}
	public void setVpmonth(String vpmonth) {
		this.vpmonth = vpmonth;
	}
	public String getVpid() {
		return vpid;
	}
	public void setVpid(String vpid) {
		this.vpid = vpid;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getSales() {
		return sales;
	}
	public void setSales(String sales) {
		this.sales = sales;
	}
	public Double getChem() {
		return chem;
	}
	public void setChem(Double chem) {
		this.chem = chem;
	}
	public Double getSafe() {
		return safe;
	}
	public void setSafe(Double safe) {
		this.safe = safe;
	}
	public Double getOp() {
		return op;
	}
	public void setOp(Double op) {
		this.op = op;
	}
	public Double getEmc() {
		return emc;
	}
	public void setEmc(Double emc) {
		this.emc = emc;
	}
	public Double getDr() {
		return dr;
	}
	public void setDr(Double dr) {
		this.dr = dr;
	}
	public Double getVip() {
		return vip;
	}
	public void setVip(Double vip) {
		this.vip = vip;
	}
	public Double getEq() {
		return eq;
	}
	public void setEq(Double eq) {
		this.eq = eq;
	}
	public Double getFinance() {
		return finance;
	}
	public void setFinance(Double finance) {
		this.finance = finance;
	}
	public Double getGz() {
		return gz;
	}
	public void setGz(Double gz) {
		this.gz = gz;
	}
	public Double getTotal() {
		return total;
	}
	public void setTotal(Double total) {
		this.total = total;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getEinvtype() {
		return einvtype;
	}
	public void setEinvtype(String einvtype) {
		this.einvtype = einvtype;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public String getStartDpaytime() {
		return startDpaytime;
	}
	public void setStartDpaytime(String startDpaytime) {
		this.startDpaytime = startDpaytime;
	}
	public String getEndDayTiem() {
		return endDayTiem;
	}
	public void setEndDayTiem(String endDayTiem) {
		this.endDayTiem = endDayTiem;
	}
	public String getStartCreatetime() {
		return startCreatetime;
	}
	public void setStartCreatetime(String startCreatetime) {
		this.startCreatetime = startCreatetime;
	}
	public String getEndCreatetime() {
		return endCreatetime;
	}
	public void setEndCreatetime(String endCreatetime) {
		this.endCreatetime = endCreatetime;
	}
	
	
}
