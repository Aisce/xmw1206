/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: S0eHnAMXmCywGTqhcq9GlhL5jBlRFKhi
 */
package net.shopxx.job;

import javax.inject.Inject;

import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import net.shopxx.service.StoreService;

/**
 * Job - 店铺
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Lazy(false)
@Component
public class StoreJob {

	@Inject
	private StoreService storeService;

	/**
	 * 过期店铺处理
	 */
	@Scheduled(cron = "${job.store_expired_processing.cron}")
	public void evictExpired() {
		storeService.expiredStoreProcessing();
	}

}