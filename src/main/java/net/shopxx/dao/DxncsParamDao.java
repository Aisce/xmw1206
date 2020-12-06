package net.shopxx.dao;

import java.util.List;


import net.shopxx.Filter;
import net.shopxx.Order;
import net.shopxx.entity.DxncsParam;
import net.shopxx.entity.Product;

/**
 * Dao - 电性能参数
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface DxncsParamDao extends BaseDao<DxncsParam, Long> {

	/**
	 * 查找 电性能参数
	 * @param product
	 * @param count
	 * @param filters
	 * @param orders
	 * @return
	 */
	List<DxncsParam> findList(Product product, Integer count, List<Filter> filters, List<Order> orders);

	/**
	 * 删除 电性能参数
	 * @param id
	 */
	void delete(Long id);
}
