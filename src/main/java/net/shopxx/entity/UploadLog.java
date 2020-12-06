/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: mEFxh/6hrdbVJoo5car3VpY4avHtriIf
 */
package net.shopxx.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

/**
 * Entity - 消息
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Entity
public class UploadLog extends BaseEntity<Long> {


	private static final long serialVersionUID = 1L;

	/**
	 * 上传文件路径
	 */
	@Column(nullable = false, updatable = false)
	private String fileUrl;

	/**
	 * 上传人
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(nullable = false, updatable = false)
	private Business uploadUser;
	
	/**
	 * 状态
	 * 0：正在导入，1：导入成功，2：导入失败
	 */
	@Column(nullable = false, updatable = false)
	private String fileFlag;

	public String getFileUrl() {
		return fileUrl;
	}

	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}

	public Business getUploadUser() {
		return uploadUser;
	}

	public void setUploadUser(Business uploadUser) {
		this.uploadUser = uploadUser;
	}

	public String getFileFlag() {
		return fileFlag;
	}

	public void setFileFlag(String fileFlag) {
		this.fileFlag = fileFlag;
	}
}