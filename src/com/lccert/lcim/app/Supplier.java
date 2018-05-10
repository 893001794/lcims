package com.lccert.lcim.app;
/**
 * 供应商的实体类
 * @author tangzp
 *
 */
public class Supplier {
	private int id;
	
	private String name;
	
	private String bank;
	
	private String creditname;
	
	private String creditcard;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getCreditname() {
		return creditname;
	}

	public void setCreditname(String creditname) {
		this.creditname = creditname;
	}

	public String getCreditcard() {
		return creditcard;
	}

	public void setCreditcard(String creditcard) {
		this.creditcard = creditcard;
	}

}
