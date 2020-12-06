/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: 9zUoHPvMhJfH7eJETM9Sv/fbu2OUQHAa
 */
package net.shopxx.dao.impl;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;

import net.shopxx.Page;
import net.shopxx.Pageable;
import net.shopxx.dao.MessageDao;
import net.shopxx.dao.UploadLogDao;
import net.shopxx.entity.Business;
import net.shopxx.entity.BusinessAttribute;
import net.shopxx.entity.DemandManagement;
import net.shopxx.entity.Message;
import net.shopxx.entity.MessageGroup;
import net.shopxx.entity.UploadLog;
import net.shopxx.entity.User;

/**
 * Dao - 消息
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Repository
public class UploadLogDaoImpl extends BaseDaoImpl<UploadLog, Long> implements UploadLogDao {

	@Override
	public List<UploadLog> findList(UploadLog uploadLog, Business user) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<UploadLog> criteriaQuery = criteriaBuilder.createQuery(UploadLog.class);
		Root<UploadLog> root = criteriaQuery.from(UploadLog.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if (uploadLog != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("fileUrl"), uploadLog.getFileUrl()));
		}
		if (user != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("uploadUser"), user));
		}
		criteriaQuery.where(restrictions);
		criteriaQuery.orderBy(criteriaBuilder.asc(root.get("createdDate")));
		return super.findList(criteriaQuery);
	}
	@Override
	public Page<UploadLog> findPage(Pageable pageable,Business user) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<UploadLog> criteriaQuery = criteriaBuilder.createQuery(UploadLog.class);
		Root<UploadLog> root = criteriaQuery.from(UploadLog.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		
		if (user != null) {
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.equal(root.get("uploadUser"), user));
		}
		
		criteriaQuery.where(restrictions);
		if (pageable == null || ((StringUtils.isEmpty(pageable.getOrderProperty()) || pageable.getOrderDirection() == null) && CollectionUtils.isEmpty(pageable.getOrders()))) {
			criteriaQuery.orderBy(criteriaBuilder.desc(root.get("createdDate")));
		}
		return super.findPage(criteriaQuery, pageable);
	}
	@Override
	public void update(UploadLog uploadLog) {
		if (uploadLog == null) {
			return;
		}
		String jpql = "update UploadLog uploadLog set uploadLog.fileFlag = :fileFlag where uploadLog.id = :id";
		entityManager.createQuery(jpql).setParameter("fileFlag", uploadLog.getFileFlag()).setParameter("id", uploadLog.getId()).executeUpdate();
	}
}