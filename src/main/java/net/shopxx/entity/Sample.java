/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: GXOHf9DFnr9JqhiXh7anfmSImDcf7k0L
 */
package net.shopxx.entity;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.hibernate.search.annotations.Indexed;
import org.hibernate.validator.constraints.Length;


/**
 * Entity - 索取样片
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Indexed
@Entity
public class Sample extends BaseEntity<Long> {


	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 *  申请人
	 */
	@Column(nullable = false)
	private String applyUser;

	/**
	 *  申请单位
	 */
	@Length(max = 200)
	private String applyCompany;

	/**
	 *  应用产品
	 */
	@Length(max = 50)
	private String applicationProduct;

	/**
	 * 应用背景
	 */
	@Length(max = 200)
	private String applicationBackground;

	/**
	 * 样品数量
	 */
	@Length(max = 200)
	private String sampleNumber;

	/**
	 * 地址
	 */
	@Length(max = 200)
	private String address;

	/**
	 * 联系电话
	 */
	@Column(nullable = true)
	private String phone;

	/**
	 * 状态 
	 * 注 ： 0 ：审核中，1：审核通过,2:审核不通过
	 */
	@Column(nullable = false)
	private String flag;

	/**
	 * 不通过的原因
	 */
	@Column(nullable = true)
	@Length(max = 500)
	private String reason;
	
	/**
	 * 快递单号
	 */
	@Column(nullable = true)
	private String orderNubmer;
	
	/**
	 * 快递公司
	 */
	@Column(nullable = true)
	private String kuaidiCompany;


	/**
	 * 商品
	 */
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(nullable = false, updatable = false)
	private Product product;
	
	/**
	 * 用户
	 */
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn()
	private Member memberUser;
	
	/**
	 * 店铺
	 */
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn()
	private Store store;


	public String getApplyUser() {
		return applyUser;
	}


	public void setApplyUser(String applyUser) {
		this.applyUser = applyUser;
	}


	public String getApplyCompany() {
		return applyCompany;
	}


	public void setApplyCompany(String applyCompany) {
		this.applyCompany = applyCompany;
	}


	public String getApplicationProduct() {
		return applicationProduct;
	}


	public void setApplicationProduct(String applicationProduct) {
		this.applicationProduct = applicationProduct;
	}


	public String getApplicationBackground() {
		return applicationBackground;
	}


	public void setApplicationBackground(String applicationBackground) {
		this.applicationBackground = applicationBackground;
	}


	public String getSampleNumber() {
		return sampleNumber;
	}


	public void setSampleNumber(String sampleNumber) {
		this.sampleNumber = sampleNumber;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public String getFlag() {
		return flag;
	}


	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getReason() {
		return reason;
	}


	public void setReason(String reason) {
		this.reason = reason;
	}


	public Product getProduct() {
		return product;
	}


	public void setProduct(Product product) {
		this.product = product;
	}


	public String getOrderNubmer() {
		return orderNubmer;
	}


	public void setOrderNubmer(String orderNubmer) {
		this.orderNubmer = orderNubmer;
	}


	public String getKuaidiCompany() {
		return kuaidiCompany;
	}


	public void setKuaidiCompany(String kuaidiCompany) {
		this.kuaidiCompany = kuaidiCompany;
	}


	public Member getMemberUser() {
		return memberUser;
	}


	public void setMemberUser(Member memberUser) {
		this.memberUser = memberUser;
	}

	public Store getStore() {
		return store;
	}


	public void setStore(Store store) {
		this.store = store;
	}
	
	
}