/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: YISPD7gtl98yzLd5mtDFkVMxjq0GYkKV
 */
package net.shopxx.entity;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Converter;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.apache.commons.beanutils.PropertyUtils;
import org.hibernate.search.annotations.Analyze;
import org.hibernate.search.annotations.Boost;
import org.hibernate.search.annotations.Field;
import org.hibernate.search.annotations.Index;
import org.hibernate.search.annotations.Indexed;
import org.hibernate.search.annotations.Store;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.URL;

import com.fasterxml.jackson.annotation.JsonView;

import net.shopxx.BaseAttributeConverter;

/**
 * Entity - 新品管理
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Indexed
@Entity
public class NewLaunch extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 点击数缓存名称
	 */
	public static final String HITS_CACHE_NAME = "productHits";

	/**
	 * 属性值属性个数
	 */
	public static final int ATTRIBUTE_VALUE_PROPERTY_COUNT = 20;

	/**
	 * 属性值属性名称前缀
	 */
	public static final String ATTRIBUTE_VALUE_PROPERTY_NAME_PREFIX = "attributeValue";

	/**
	 * 最大商品图片数量
	 */
	public static final int MAX_PRODUCT_IMAGE_SIZE = 20;

	/**
	 * 最大参数值数量
	 */
	public static final int MAX_PARAMETER_VALUE_SIZE = 100;

	/**
	 * 最大规格项数量
	 */
	public static final int MAX_SPECIFICATION_ITEM_SIZE = 100;

	/**
	 * 路径
	 */
	private static final String PATH = "/product/detail/%d";


	/**
	 * 排序类型
	 */
	public enum OrderType {

		/**
		 * 置顶降序
		 */
		TOP_DESC,

		/**
		 * 价格升序
		 */
		PRICE_ASC,

		/**
		 * 价格降序
		 */
		PRICE_DESC,

		/**
		 * 销量降序
		 */
		SALES_DESC,

		/**
		 * 评分降序
		 */
		SCORE_DESC,

		/**
		 * 日期降序
		 */
		DATE_DESC
	}

	/**
	 * 排名类型
	 */
	public enum RankingType {

		/**
		 * 评分
		 */
		SCORE,

		/**
		 * 评分数
		 */
		SCORE_COUNT,

		/**
		 * 周点击数
		 */
		WEEK_HITS,

		/**
		 * 月点击数
		 */
		MONTH_HITS,

		/**
		 * 点击数
		 */
		HITS,

		/**
		 * 周销量
		 */
		WEEK_SALES,

		/**
		 * 月销量
		 */
		MONTH_SALES,

		/**
		 * 销量
		 */
		SALES
	}

	/**
	 * 新品发布字段 型号规格，产品名称，质量等级，生产厂商，内容，产品编号， 发布状态，发布人-时间，修改人-时间，定型时间，图片，
	 * 排序，是否置顶，查看次数，删除标记
	 */
	/**
	 * 型号规格
	 */
	@JsonView(BaseView.class)
	@Field(store = Store.YES, index = Index.YES, analyze = Analyze.NO)
	@Length(max = 100)
	@Pattern(regexp = "^[0-9a-zA-Z_-]+$")
	@Column(nullable = false, updatable = false)
	private String typeNorms;

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
	 * 生产厂商
	 */
	@Field(store = Store.YES, index = Index.NO, analyze = Analyze.NO)
	@Length(max = 200)
	private String unit;

	@Length(max = 32)
	private String weight;

	/**
	 * 发布状态 ,1已发布，0未发布，2审核中
	 */
	@JsonView(BaseView.class)
	@Field(store = Store.YES, index = Index.YES, analyze = Analyze.NO)
	@NotNull
	@Column(nullable = false)
	private String releaseFlag;

	/**
	 * 发布人
	 */
	@Column(nullable = true)
	private String creatUser;
	/**
	 * 发布时间
	 */
	@Column(nullable = false)
	private Date creatTime;

	/**
	 * 修改人
	 */
	@Column(nullable = true)
	private String updateUser;

	/**
	 * 修改时间
	 */
	@Column(nullable = true)
	private Date updateTime;

	/**
	 * 定型时间
	 * 
	 */
	@Column(nullable = false)
	private Date stereotypeTime;
	/**
	 * 内容
	 */
	@Field(store = Store.YES, index = Index.YES, analyze = Analyze.YES)
	@Lob
	private String introduction;

	/**
	 * 图片
	 */
	@Length(max = 200)
	@URL
	private String productImages ;

	/**
	 * paixu(序号，发布信息时的序列号)
	 */
	@Column(nullable = true)
	private String serialNumber;

	/**
	 * 查看次数
	 */
	@Column(nullable = true)
	private Long hits;
	/**
	 * 是否为删除 默认0为未删除，1为删除
	 */
	@Column(nullable = false)
	private Integer flag = 0;
	/**
	 * 产品编号
	 */
	@NotNull
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(nullable = false)
	private Product productId;
	//新品简介
	private String synopsis;

	public String getSynopsis() {
		return synopsis;
	}

	public void setSynopsis(String synopsis) {
		this.synopsis = synopsis;
	}

	public Product getProductId() {
		return productId;
	}

	public void setProductId(Product productId) {
		this.productId = productId;
	}

	public String getTypeNorms() {
		return typeNorms;
	}

	public void setTypeNorms(String typeNorms) {
		this.typeNorms = typeNorms;
	}
	public String getReleaseFlag() {
		return releaseFlag;
	}

	public void setReleaseFlag(String releaseFlag) {
		this.releaseFlag = releaseFlag;
	}

	public String getCreatUser() {
		return creatUser;
	}

	public void setCreatUser(String creatUser) {
		this.creatUser = creatUser;
	}

	public Date getCreatTime() {
		return creatTime;
	}

	public void setCreatTime(Date creatTime) {
		this.creatTime = creatTime;
	}

	public String getUpdateUser() {
		return updateUser;
	}

	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public Date getStereotypeTime() {
		return stereotypeTime;
	}

	public void setStereotypeTime(Date stereotypeTime) {
		this.stereotypeTime = stereotypeTime;
	}

	public String getSerialNumber() {
		return serialNumber;
	}

	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}

	public Integer getFlag() {
		return flag;
	}

	public void setFlag(Integer flag) {
		this.flag = flag;
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

	/**
	 * 获取单位
	 * 
	 * @return 单位
	 */
	public String getUnit() {
		return unit;
	}

	/**
	 * 设置单位
	 * 
	 * @param unit 单位
	 */
	public void setUnit(String unit) {
		this.unit = unit;
	}

	/**
	 * 获取重量
	 * 
	 * @return 重量
	 */
	public String getWeight() {
		return weight;
	}

	/**
	 * 设置重量
	 * 
	 * @param weight 重量
	 */
	public void setWeight(String weight) {
		this.weight = weight;
	}
	/**
	 * 获取介绍
	 * 
	 * @return 介绍
	 */
	public String getIntroduction() {
		return introduction;
	}

	/**
	 * 设置介绍
	 * 
	 * @param introduction 介绍
	 */
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	/**
	 * 获取点击数
	 * 
	 * @return 点击数
	 */
	public Long getHits() {
		return hits;
	}

	/**
	 * 设置点击数
	 * 
	 * @param hits 点击数
	 */
	public void setHits(Long hits) {
		this.hits = hits;
	}

	/**
	 * 获取商品图片
	 * 
	 * @return 商品图片
	 */
	public String getProductImages() {
		return productImages;
	}

	/**
	 * 设置商品图片
	 * 
	 * @param productImages 商品图片
	 */
	public void setProductImages(String productImages) {
		this.productImages = productImages;
	}

	/**
	 * 获取路径
	 * 
	 * @return 路径
	 */
	@JsonView(BaseView.class)
	@Transient
	public String getPath() {
		return String.format(NewLaunch.PATH, getId());
	}
	/**
	 * 获取属性值
	 * 
	 * @param attribute 属性
	 * @return 属性值
	 */
	@Transient
	public String getAttributeValue(Attribute attribute) {
		if (attribute == null || attribute.getPropertyIndex() == null) {
			return null;
		}
		try {
			String propertyName = ATTRIBUTE_VALUE_PROPERTY_NAME_PREFIX + attribute.getPropertyIndex();
			return String.valueOf(PropertyUtils.getProperty(this, propertyName));
		} catch (IllegalAccessException e) {
			throw new RuntimeException(e.getMessage(), e);
		} catch (InvocationTargetException e) {
			throw new RuntimeException(e.getMessage(), e);
		} catch (NoSuchMethodException e) {
			throw new RuntimeException(e.getMessage(), e);
		}
	}

	/**
	 * 设置属性值
	 * 
	 * @param attribute      属性
	 * @param attributeValue 属性值
	 */
	@Transient
	public void setAttributeValue(Attribute attribute, String attributeValue) {
		if (attribute == null || attribute.getPropertyIndex() == null) {
			return;
		}
		try {
			String propertyName = ATTRIBUTE_VALUE_PROPERTY_NAME_PREFIX + attribute.getPropertyIndex();
			PropertyUtils.setProperty(this, propertyName, attributeValue);
		} catch (IllegalAccessException e) {
			throw new RuntimeException(e.getMessage(), e);
		} catch (InvocationTargetException e) {
			throw new RuntimeException(e.getMessage(), e);
		} catch (NoSuchMethodException e) {
			throw new RuntimeException(e.getMessage(), e);
		}
	}

	/**
	 * 移除所有属性值
	 */
	@Transient
	public void removeAttributeValue() {
		for (int i = 0; i < ATTRIBUTE_VALUE_PROPERTY_COUNT; i++) {
			String propertyName = ATTRIBUTE_VALUE_PROPERTY_NAME_PREFIX + i;
			try {
				PropertyUtils.setProperty(this, propertyName, null);
			} catch (IllegalAccessException e) {
				throw new RuntimeException(e.getMessage(), e);
			} catch (InvocationTargetException e) {
				throw new RuntimeException(e.getMessage(), e);
			} catch (NoSuchMethodException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
		}
	}

	/**
	 * 类型转换 - 商品图片
	 * 
	 * @author SHOP++ Team
	 * @version 6.1
	 */
	@Converter
	public static class ProductImageConverter extends BaseAttributeConverter<ArrayList<ProductImage>> {
	}

	/**
	 * 类型转换 - 参数值
	 * 
	 * @author SHOP++ Team
	 * @version 6.1
	 */
	@Converter
	public static class ParameterValueConverter extends BaseAttributeConverter<ArrayList<ParameterValue>> {
	}

	/**
	 * 类型转换 - 规格项
	 * 
	 * @author SHOP++ Team
	 * @version 6.1
	 */
	@Converter
	public static class SpecificationItemConverter extends BaseAttributeConverter<ArrayList<SpecificationItem>> {
	}

}