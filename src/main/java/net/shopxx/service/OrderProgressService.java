package net.shopxx.service;

import java.util.List;

import net.shopxx.entity.OrderProgress;

public interface OrderProgressService extends BaseService<OrderProgress, Long> {
	/**
	 * 查看进度信息
	 * @param order
	 * @param product
	 */
	List<OrderProgress> list(Long orderId, Long productId);
}
