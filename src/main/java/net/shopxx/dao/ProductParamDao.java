package net.shopxx.dao;

import java.util.List;

import net.shopxx.Filter;
import net.shopxx.Order;
import net.shopxx.entity.Product;
import net.shopxx.entity.ProductParam;

/**
 * Dao - 类似产品参数
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public interface ProductParamDao extends BaseDao<ProductParam, Long> {

	/**
	 * 查找 类似产品参数
	 * 
	 * @param product
	 * @param count
	 * @param filters
	 * @param orders
	 * @return
	 */
	List<ProductParam> findList(Product product, Integer count, List<Filter> filters, List<Order> orders);

	/**
	 * 删除 类似产品参数
	 * 
	 * @param id
	 */
	void remove(Long id);
}
