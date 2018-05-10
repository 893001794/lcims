package com.lccert.crm.vo;
/**
 * 统计报表
 * @author LC
 *
 */
public class Statistics {
	private float TWTotalpric;   //本周总金额
	private float TWHPay;    //本周收历史欠款
	private float TWPay;     //本周回款
	private float TWPresubcost;  //本周预分包费
	private float TWSubcost;  //本周实际分包费
	private float TWPreagcost; //本周预机构费
	private float TWAgcost;  //本周实际机构费
	private float TMTotalpric;  //本月总金额
	
	private float TMSTotalpric;  //本月收单总金额
	private float TMHPay;   //本月受历史欠款
	private float TMPay;    //本月回款
	private float TMPresubcost;  //本月预分包费
	private float TMSubcost;    //本月实际分包费
	private float TMPreagcost;  //本月预机构费
	private float TMAgcost;  //本月实际机构费
	private float TMHistoryPay; //历史欠款
	private float TMConfirmNotPay; //已收单未收款
	public float getTMConfirmNotPay() {
		return TMConfirmNotPay;
	}
	public void setTMConfirmNotPay(float tMConfirmNotPay) {
		TMConfirmNotPay = tMConfirmNotPay;
	}
	public float getTWTotalpric() {
		return TWTotalpric;
	}
	public void setTWTotalpric(float totalpric) {
		TWTotalpric = totalpric;
	}
	public float getTWHPay() {
		return TWHPay;
	}
	public void setTWHPay(float pay) {
		TWHPay = pay;
	}
	public float getTWPay() {
		return TWPay;
	}
	public void setTWPay(float pay) {
		TWPay = pay;
	}
	public float getTWPresubcost() {
		return TWPresubcost;
	}
	public void setTWPresubcost(float presubcost) {
		TWPresubcost = presubcost;
	}
	public float getTWSubcost() {
		return TWSubcost;
	}
	public void setTWSubcost(float subcost) {
		TWSubcost = subcost;
	}
	public float getTWPreagcost() {
		return TWPreagcost;
	}
	public void setTWPreagcost(float preagcost) {
		TWPreagcost = preagcost;
	}
	public float getTWAgcost() {
		return TWAgcost;
	}
	public void setTWAgcost(float agcost) {
		TWAgcost = agcost;
	}
	public float getTMTotalpric() {
		return TMTotalpric;
	}
	public float getTMSTotalpric() {
		return TMSTotalpric;
	}
	public void setTMSTotalpric(float tMSTotalpric) {
		TMSTotalpric = tMSTotalpric;
	}
	public void setTMTotalpric(float totalpric) {
		TMTotalpric = totalpric;
	}
	public float getTMHPay() {
		return TMHPay;
	}
	public void setTMHPay(float pay) {
		TMHPay = pay;
	}
	public float getTMPay() {
		return TMPay;
	}
	public void setTMPay(float pay) {
		TMPay = pay;
	}
	public float getTMPresubcost() {
		return TMPresubcost;
	}
	public void setTMPresubcost(float presubcost) {
		TMPresubcost = presubcost;
	}
	public float getTMSubcost() {
		return TMSubcost;
	}
	public void setTMSubcost(float subcost) {
		TMSubcost = subcost;
	}
	public float getTMPreagcost() {
		return TMPreagcost;
	}
	public void setTMPreagcost(float preagcost) {
		TMPreagcost = preagcost;
	}
	public float getTMAgcost() {
		return TMAgcost;
	}
	public void setTMAgcost(float agcost) {
		TMAgcost = agcost;
	}
	public float getTMHistoryPay() {
		return TMHistoryPay;
	}
	public void setTMHistoryPay(float historyPay) {
		TMHistoryPay = historyPay;
	}
}
