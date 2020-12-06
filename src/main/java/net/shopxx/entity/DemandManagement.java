/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: YISPD7gtl98yzLd5mtDFkVMxjq0GYkKV
 */
package net.shopxx.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.Transient;
import javax.validation.constraints.Min;

import org.hibernate.search.annotations.Analyze;
import org.hibernate.search.annotations.Boost;
import org.hibernate.search.annotations.Field;
import org.hibernate.search.annotations.Index;
import org.hibernate.search.annotations.Indexed;
import org.hibernate.search.annotations.NumericField;
import org.hibernate.search.annotations.Store;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import com.fasterxml.jackson.annotation.JsonView;

/**
 * Entity - 集成电路需求管理
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Indexed
@Entity
public class DemandManagement extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 点击数缓存名称
	 */
	public static final String HITS_CACHE_NAME = "demandManagementHits";

	/**
	 * 路径
	 */
	private static final String PATH = "/demand_management/detail/%d";

	/**
	 * 排序类型
	 */

	/**
	 * 需求类型 0研发,1采购
	 */
	@Column(nullable = false, updatable = false)
	private Integer typeNorms;

	/**
	 * 产品名称
	 */
	@JsonView(BaseView.class)
	@Field(store = Store.YES, index = Index.YES, analyze = Analyze.YES)
	@Boost(1.5F)
	@NotEmpty
	@Length(max = 200)
	@Column(nullable = false)
	private String name;

	/**
	 * 质量等级
	 */
	@Field(store = Store.YES, index = Index.NO, analyze = Analyze.NO)
	@NumericField
	@Min(0)
	private Integer weight;

	/**
	 * 需求数量
	 */
	@Column(nullable = true)
	private Integer number;
	/**
	 * 需求方
	 */
	@Column(nullable = true)
	private String demandUser;

	/**
	 * 发布人
	 */
	@Column(nullable = true)
	private String creatUser;

	/**
	 * 修改人
	 */
	@Column(nullable = true)
	private String updateUser;
	
	@Column(nullable = true)
	private Date updateDate;
	/**
	 * 内容
	 */
	@Field(store = Store.YES, index = Index.YES, analyze = Analyze.YES)
	@Lob
	private String introduction;
	/**
	 * 需求简介
	 */
	@Length(max = 200)
	private String synopsis;
	/**
	 * 是否为删除 默认0为未删除，1为删除
	 */
	@Column(nullable = false)
	private Integer flag = 0;
	public String getSynopsis() {
		return synopsis;
	}

	public void setSynopsis(String synopsis) {
		this.synopsis = synopsis;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public Integer getTypeNorms() {
		return typeNorms;
	}

	public void setTypeNorms(Integer typeNorms) {
		this.typeNorms = typeNorms;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getWeight() {
		return weight;
	}

	public void setWeight(Integer weight) {
		this.weight = weight;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public String getDemandUser() {
		return demandUser;
	}

	public void setDemandUser(String demandUser) {
		this.demandUser = demandUser;
	}

	public String getCreatUser() {
		return creatUser;
	}

	public void setCreatUser(String creatUser) {
		this.creatUser = creatUser;
	}

	public String getUpdateUser() {
		return updateUser;
	}

	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public Integer getFlag() {
		return flag;
	}

	public void setFlag(Integer flag) {
		this.flag = flag;
	}

	/**
	 * 获取路径
	 * 
	 * @return 路径
	 */
	@JsonView(BaseView.class)
	@Transient
	public String getPath() {
		return String.format(DemandManagement.PATH, getId());
	}

}