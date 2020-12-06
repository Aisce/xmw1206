package net.shopxx.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.shopxx.dao.OrderProgressDao;
import net.shopxx.entity.OrderProgress;
import net.shopxx.service.OrderProgressService;

/**
 * 进度信息
 * 
 * @author wxz 2019-06-05
 *
 */
@Service
public class OrderProgressServiceImpl extends BaseServiceImpl<OrderProgress, Long> implements OrderProgressService {

	@Inject
	private OrderProgressDao orderProgressDao;

	@Override
	@Transactional(readOnly = true)
	public List<OrderProgress> list(Long orderId, Long productId) {
		return orderProgressDao.findList(orderId, productId);
	}

}
