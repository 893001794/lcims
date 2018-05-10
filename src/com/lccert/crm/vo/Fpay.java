package com.lccert.crm.vo;
/**
 * 支出bean
 * @author tangzp
 *
 */
public class Fpay {
	private int id ; //支出id 
	private String dpaytime ; // 支出日 期
	private String supplier ; //供应商 / 摘要
	private String dept ; //部门
	private String person ; //人员
	private Double chem ; //化学
	private Double safe ; //安全
	private Double op ; //光性能
	private Double emc ; //emc联营
	private Double dr ; //EMC暗室
	private Double vip ; // 大客户部 
	private Double eq ; // 环境 
	private Double gmo ; //总经办
	private Double finance ; //财务部
	private Double administration ; // 行政部
	private Double engineering ; // 工程部
	private Double  total  ; //小计
	private String account ; //账号名称
	private String einvtype ; // 票据类型 
	private String invoiceno ; //发票号码
	private String billno ; //凭证号
	private String remarks ; //备注
	private String onelevelsub ; //一级科目
	private String twolevelsub ; //二 级科目
	private String threelevelsub ; //三级科目
	private String travel ; //出差地区
	private String summay;  //摘要
	private String entertain; //招待客户
	private int pageNo;
	private int pageSize;
	private String startDpaytime; //支出开始时间
	private String endDayTiem ;//支出结束时间
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
	public String getSupplier() {
		return supplier;
	}
	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getPerson() {
		return person;
	}
	public void setPerson(String person) {
		this.person = person;
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
	public Double getGmo() {
		return gmo;
	}
	public void setGmo(Double gmo) {
		this.gmo = gmo;
	}
	public Double getFinance() {
		return finance;
	}
	public void setFinance(Double finance) {
		this.finance = finance;
	}
	public Double getAdministration() {
		return administration;
	}
	public void setAdministration(Double administration) {
		this.administration = administration;
	}
	public Double getEngineering() {
		return engineering;
	}
	public void setEngineering(Double engineering) {
		this.engineering = engineering;
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
	public String getInvoiceno() {
		return invoiceno;
	}
	public void setInvoiceno(String invoiceno) {
		this.invoiceno = invoiceno;
	}
	public String getBillno() {
		return billno;
	}
	public void setBillno(String billno) {
		this.billno = billno;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getOnelevelsub() {
		return onelevelsub;
	}
	public void setOnelevelsub(String onelevelsub) {
		this.onelevelsub = onelevelsub;
	}
	public String getTwolevelsub() {
		return twolevelsub;
	}
	public void setTwolevelsub(String twolevelsub) {
		this.twolevelsub = twolevelsub;
	}
	public String getThreelevelsub() {
		return threelevelsub;
	}
	public void setThreelevelsub(String threelevelsub) {
		this.threelevelsub = threelevelsub;
	}
	public String getTravel() {
		return travel;
	}
	public void setTravel(String travel) {
		this.travel = travel;
	}
	public String getSummay() {
		return summay;
	}
	public void setSummay(String summay) {
		this.summay = summay;
	}
	public String getEntertain() {
		return entertain;
	}
	public void setEntertain(String entertain) {
		this.entertain = entertain;
	}
	public Double getEq() {
		return eq;
	}
	public void setEq(Double eq) {
		this.eq = eq;
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
	

}
