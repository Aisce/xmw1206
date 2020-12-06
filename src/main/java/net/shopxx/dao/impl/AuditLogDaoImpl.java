/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: KNU/errMPD5j8yvZPlMTMzscCE48mhUp
 */
package net.shopxx.dao.impl;

import org.springframework.stereotype.Repository;

import net.shopxx.dao.AuditLogDao;
import net.shopxx.entity.AuditLog;

/**
 * Dao - 审计日志
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Repository
public class AuditLogDaoImpl extends BaseDaoImpl<AuditLog, Long> implements AuditLogDao {

	@Override
	public void removeAll() {
		String jpql = "delete from AuditLog auditLog";
		entityManager.createQuery(jpql).executeUpdate();
	}

}