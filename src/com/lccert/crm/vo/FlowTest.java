package com.lccert.crm.vo;
/**
 * 流转单测试大项bean
 * @author tangzp
 *
 */
public class FlowTest {
	private int id ; //支出id 
	private String fid ; // 流转单编号
	private String fidTestNo ; //流转单测试大项的编号
	private String fidTestName ; //流转单测试大项的名称
	private Integer count ; //测试点数
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFid() {
		return fid;
	}
	public void setFid(String fid) {
		this.fid = fid;
	}
	public String getFidTestNo() {
		return fidTestNo;
	}
	public void setFidTestNo(String fidTestNo) {
		this.fidTestNo = fidTestNo;
	}
	public String getFidTestName() {
		return fidTestName;
	}
	public void setFidTestName(String fidTestName) {
		this.fidTestName = fidTestName;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	
	

}
