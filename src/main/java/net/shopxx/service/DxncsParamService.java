package net.shopxx.service;

import java.util.List;

import net.shopxx.Filter;
import net.shopxx.Order;
import net.shopxx.entity.DxncsParam;
import net.shopxx.entity.Product;

/**
 * 电性能参数
 * 
 * @author wxz 2019-05-23
 *
 */
public interface DxncsParamService extends BaseService<DxncsParam, Long> {
	/**
	 * 查询电性能参数
	 * 
	 * @param product
	 * @param count
	 * @param filters
	 * @param orders
	 * @return
	 */
	List<DxncsParam> findList(Product product, Integer count, List<Filter> filters, List<Order> orders);

	/**
	 * 保存电性能参数
	 * 
	 * @param product
	 * @param dxncsParams
	 */
	void save(Long productId, List<DxncsParam> dxncsParams);

	/**
	 * 过滤空值
	 * 
	 * @param dxncsParams
	 */
	void filter(List<DxncsParam> dxncsParams);

	/**
	 * 删除电性能参数
	 * 
	 * @param productForm
	 */
	void removeByProduct(Long id);

}
