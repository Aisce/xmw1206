/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: r3kK3b23TyiXCz8RGU+JJseZvvLex7bK
 */
package net.shopxx.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

/**
 * Entity - 导航组
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Entity
public class XmNavigationGroup extends BaseEntity<Long> {

	private static final long serialVersionUID = -7911500541698399102L;

	/**
	 * 名称
	 */
	@NotEmpty
	@Length(max = 200)
	@Column(nullable = false)
	private String name;

	/**
	 * 导航
	 */
	@OneToMany(mappedBy = "navigationGroup", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
	@OrderBy("order asc")
	private Set<XmNavigation> navigations = new HashSet<>();
	/**
	 * paixu
	 */
	@Column(nullable = false)
	private String paixu;

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
	 * @param name
	 *            名称
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * 获取导航
	 * 
	 * @return 导航
	 */
	public Set<XmNavigation> getNavigations() {
		return navigations;
	}

	/**
	 * 设置导航
	 * 
	 * @param navigations
	 *            导航
	 */
	public void setNavigations(Set<XmNavigation> navigations) {
		this.navigations = navigations;
	}

	public String getPaixu() {
		return paixu;
	}

	public void setPaixu(String paixu) {
		this.paixu = paixu;
	}

}