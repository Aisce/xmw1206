package net.shopxx.service;

import java.util.List;

import net.shopxx.Filter;
import net.shopxx.Order;
import net.shopxx.entity.ProductParam;
import net.shopxx.entity.Product;

/**
 * 类似产品参数
 * 
 * @author wxz 2019-05-23
 *
 */
public interface ProductParamService extends BaseService<ProductParam, Long> {
	/**
	 * 查询类似产品参数
	 * 
	 * @param product
	 * @param count
	 * @param filters
	 * @param orders
	 * @return
	 */
	List<ProductParam> findList(Product product, Integer count, List<Filter> filters, List<Order> orders);

	/**
	 * 保存类似产品参数
	 * 
	 * @param product
	 * @param productParams
	 * @param type
	 */
	void save(Long productId, List<ProductParam> productParams, ProductParam.Type type);

	/**
	 * 过滤空值
	 * 
	 * @param productParams
	 */
	public void filter(List<ProductParam> productParams);

	/**
	 * 删除类似产品参数
	 * 
	 * @param productForm
	 */
	void removeByProduct(Long id);
}
