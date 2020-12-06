/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: zaIqQMLtzjnwqXxvw0s8bKnJrXndjBw9
 */
package net.shopxx.entity;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.validation.constraints.NotNull;

import org.hibernate.search.annotations.Analyze;
import org.hibernate.search.annotations.Field;
import org.hibernate.search.annotations.Index;
import org.hibernate.search.annotations.Store;

import com.fasterxml.jackson.annotation.JsonView;


/**
 * Entity - 标准化检测机构
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Entity
public class MechanismArticle extends OrderedEntity<Long> {

	private static final long serialVersionUID = 8136306384949521709L;
	
	/**
	 * 类型
	 */
	public enum Type {

		/**
		 * 标准化机构文章
		 */
		STANDARDIZATION,

		/**
		 * 检测机构文章
		 */
		CHECK,
		/**
		 * 辅助采购文章
		 */
		PURCHASE
	}
	
	@JsonView(BaseView.class)
	@Field(store = org.hibernate.search.annotations.Store.YES, index = Index.YES, analyze = Analyze.NO)
	@NotNull
	@Column(nullable = false, updatable = false)
	private MechanismArticle.Type type;
	
	/**
	 * 详情
	 */
	@Field(store = Store.YES, index = Index.YES, analyze = Analyze.YES)
	@Lob
	private String content;

	public MechanismArticle.Type getType() {
		return type;
	}

	public void setType(MechanismArticle.Type type) {
		this.type = type;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
}
