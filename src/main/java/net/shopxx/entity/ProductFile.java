/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: RF0wRL0HrvbV2LjNXpI/fGe7zMTgKnE5
 */
package net.shopxx.entity;

import java.io.Serializable;

import javax.validation.constraints.Min;

import org.apache.commons.lang.builder.CompareToBuilder;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.URL;

/**
 * Entity - 商品文件
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public class ProductFile implements Serializable, Comparable<ProductFile> {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5007379038306265257L;

	/**
	 * 原图片
	 */
	@NotEmpty
	@Length(max = 200)
	@URL
	private String source;

	/**
	 * 排序
	 */
	@Min(0)
	private Integer order;

	/**
	 * 获取原图片
	 * 
	 * @return 原图片
	 */
	public String getSource() {
		return source;
	}

	/**
	 * 设置原图片
	 * 
	 * @param source
	 *            原图片
	 */
	public void setSource(String source) {
		this.source = source;
	}

	
	/**
	 * 获取排序
	 * 
	 * @return 排序
	 */
	public Integer getOrder() {
		return order;
	}

	/**
	 * 设置排序
	 * 
	 * @param order
	 *            排序
	 */
	public void setOrder(Integer order) {
		this.order = order;
	}

	/**
	 * 实现compareTo方法
	 * 
	 * @param productImage
	 *            商品图片
	 * @return 比较结果
	 */
	@Override
	public int compareTo(ProductFile productFile) {
		if (productFile == null) {
			return 1;
		}
		return new CompareToBuilder().append(getOrder(), productFile.getOrder()).toComparison();
	}

	/**
	 * 重写equals方法
	 * 
	 * @param obj
	 *            对象
	 * @return 是否相等
	 */
	@Override
	public boolean equals(Object obj) {
		return EqualsBuilder.reflectionEquals(this, obj);
	}

	/**
	 * 重写hashCode方法
	 * 
	 * @return HashCode
	 */
	@Override
	public int hashCode() {
		return HashCodeBuilder.reflectionHashCode(this);
	}

}