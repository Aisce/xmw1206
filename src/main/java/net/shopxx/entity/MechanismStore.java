/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: CRGEYhZCJNw3UT3W4p7IEauwP3mgoNZg
 */
package net.shopxx.entity;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.OrderBy;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;
import org.apache.commons.lang.BooleanUtils;
import org.apache.commons.lang.StringUtils;
import org.hibernate.search.annotations.Analyze;
import org.hibernate.search.annotations.Boost;
import org.hibernate.search.annotations.Field;
import org.hibernate.search.annotations.Index;
import org.hibernate.search.annotations.Indexed;
import org.hibernate.search.annotations.Store;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.URL;

import com.fasterxml.jackson.annotation.JsonView;

/**
 * Entity - 机构
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Indexed
@Entity
public class MechanismStore extends BaseEntity<Long> {

	private static final long serialVersionUID = -406440213727498768L;

	/**
	 * 路径
	 */
	private static final String PATH = "/mechanism_store/%d";

	/**
	 * 类型
	 */
	public enum Type {

		/**
		 * 标准化机构
		 */
		STANDARDIZATION,

		/**
		 * 检测机构
		 */
		CHECK
	}
	/**
	 * 名称
	 */
	@JsonView(BaseView.class)
	@Field(store = org.hibernate.search.annotations.Store.YES, index = Index.YES, analyze = Analyze.YES)
	@Boost(1.5F)
	@NotEmpty
	@Length(max = 200)
	@Column(nullable = false, unique = true)
	private String name;

	/**
	 * 店铺编号
	 */
	@NotEmpty
	@Length(max = 6)
	@Pattern(regexp = "^[0-9a-zA-Z_-]+$")
	@Column(nullable = false)
	private String number;

	/**
	 * 类型
	 */
	@JsonView(BaseView.class)
	@Field(store = org.hibernate.search.annotations.Store.YES, index = Index.YES, analyze = Analyze.NO)
	@NotNull
	@Column(nullable = false, updatable = false)
	private MechanismStore.Type type;


	/**
	 * logo
	 */
	@JsonView(BaseView.class)
	@Length(max = 200)
	@URL
	private String logo;

	/**
	 * E-mail
	 */
	@NotEmpty
	@Email
	@Length(max = 200)
	@Column(nullable = false)
	private String email;

	/**
	 * 手机
	 */
	@NotEmpty
	@Length(max = 200)
	@Pattern(regexp = "^1[3|4|5|7|8]\\d{9}$")
	@Column(nullable = false)
	private String mobile;

	/**
	 * 电话
	 */
	@Length(max = 200)
	@Pattern(regexp = "^\\d{3,4}-?\\d{7,9}$")
	private String phone;

	/**
	 * 地址
	 */
	@Length(max = 200)
	private String address;

	/**
	 * 邮编
	 */
	@Length(max = 200)
	@Pattern(regexp = "^\\d{6}$")
	private String zipCode;

	/**
	 * 简介
	 */
	@Lob
	private String introduction;

	/**
	 * 搜索关键词
	 */
	@Field(store = org.hibernate.search.annotations.Store.YES, index = Index.YES, analyze = Analyze.YES)
	@Boost(1.5F)
	@Length(max = 200)
	private String keyword;

	/**
	 * 到期日期
	 */
	@NotNull
	@Column(nullable = false)
	private Date endDate;

	/**
	 * 是否启用
	 */
	@JsonView(BaseView.class)
	@Field(store = org.hibernate.search.annotations.Store.YES, index = Index.YES, analyze = Analyze.NO)
	@NotNull
	@Column(nullable = false)
	private Boolean isEnabled;

	/**
	 * 机构用户
	 */
	@NotNull
	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(nullable = false, updatable = false)
	private Member mechanism;
	
	/**
	 * 详情
	 */
	@Field(store = Store.YES, index = Index.YES, analyze = Analyze.YES)
	@Lob
	private String content;
	
	/**
	 * 图片
	 */
	@Length(max = 200)
	@URL
	private String image;
	@Length(max = 200)
	@URL
	private String url;
	
	/**
	 * 排序
	 */
	@Column(nullable = true)
	private Integer sorting;
	
	public Integer getSorting() {
		return sorting;
	}

	public void setSorting(Integer sorting) {
		this.sorting = sorting;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	/**
	 * 获取名称
	 * 
	 * @return 名称
	 */
	public String getName() {
		return name;
	}

	/**
	 * 设置名称
	 * 
	 * @param name 名称
	 */
	public void setName(String name) {
		this.name = name;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}
	
	public Member getMechanism() {
		return mechanism;
	}

	public void setMechanism(Member mechanism) {
		this.mechanism = mechanism;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	/**
	 * 获取类型
	 * 
	 * @return 类型
	 */
	public MechanismStore.Type getType() {
		return type;
	}

	/**
	 * 设置类型
	 * 
	 * @param type 类型
	 */
	public void setType(MechanismStore.Type type) {
		this.type = type;
	}


	/**
	 * 获取logo
	 * 
	 * @return logo
	 */
	public String getLogo() {
		return logo;
	}

	/**
	 * 设置logo
	 * 
	 * @param logo logo
	 */
	public void setLogo(String logo) {
		this.logo = logo;
	}

	/**
	 * 获取E-mail
	 * 
	 * @return E-mail
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * 设置E-mail
	 * 
	 * @param email E-mail
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * 获取手机
	 * 
	 * @return 手机
	 */
	public String getMobile() {
		return mobile;
	}

	/**
	 * 设置手机
	 * 
	 * @param mobile 手机
	 */
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	/**
	 * 获取电话
	 * 
	 * @return 电话
	 */
	public String getPhone() {
		return phone;
	}

	/**
	 * 设置电话
	 * 
	 * @param phone 电话
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	/**
	 * 获取地址
	 * 
	 * @return 地址
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * 设置地址
	 * 
	 * @param address 地址
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * 获取邮编
	 * 
	 * @return 邮编
	 */
	public String getZipCode() {
		return zipCode;
	}

	/**
	 * 设置邮编
	 * 
	 * @param zipCode 邮编
	 */
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	/**
	 * 获取简介
	 * 
	 * @return 简介
	 */
	public String getIntroduction() {
		return introduction;
	}

	/**
	 * 设置简介
	 * 
	 * @param introduction 简介
	 */
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	/**
	 * 获取搜索关键词
	 * 
	 * @return 搜索关键词
	 */
	public String getKeyword() {
		return keyword;
	}

	/**
	 * 设置搜索关键词
	 * 
	 * @param keyword 搜索关键词
	 */
	public void setKeyword(String keyword) {
		if (keyword != null) {
			keyword = keyword.replaceAll("[,\\s]*,[,\\s]*", ",").replaceAll("^,|,$", StringUtils.EMPTY);
		}
		this.keyword = keyword;
	}

	/**
	 * 获取到期日期
	 * 
	 * @return 到期日期
	 */
	public Date getEndDate() {
		return endDate;
	}

	/**
	 * 设置到期日期
	 * 
	 * @param endDate 到期日期
	 */
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	/**
	 * 获取是否启用
	 * 
	 * @return 是否启用
	 */
	public Boolean getIsEnabled() {
		return isEnabled;
	}

	/**
	 * 设置是否启用
	 * 
	 * @param isEnabled 是否启用
	 */
	public void setIsEnabled(Boolean isEnabled) {
		this.isEnabled = isEnabled;
	}

	/**
	 * 获取路径
	 * 
	 * @return 路径
	 */
	@JsonView(BaseView.class)
	@Transient
	public String getPath() {
		return String.format(MechanismStore.PATH, getId());
	}

	/**
	 * 判断是否为检测机构
	 * 
	 * @return 是否为检测机构
	 */
	@Transient
	public boolean isSelf() {
		return MechanismStore.Type.CHECK.equals(getType());
	}

	/**
	 * 判断店铺是否已过期
	 * 
	 * @return 店铺是否已过期
	 */
	@JsonView(BaseView.class)
	@Transient
	public boolean hasExpired() {
		return getEndDate() != null && !getEndDate().after(new Date());
	}

	/**
	 * 持久化前处理
	 */
	@PrePersist
	public void prePersist() {
		setEmail(StringUtils.lowerCase(getEmail()));
		setMobile(StringUtils.lowerCase(getMobile()));
	}

	/**
	 * 更新前处理
	 */
	@PreUpdate
	public void preUpdate() {
		setEmail(StringUtils.lowerCase(getEmail()));
		setMobile(StringUtils.lowerCase(getMobile()));
	}

}