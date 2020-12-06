package net.shopxx.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.shopxx.Filter;
import net.shopxx.Order;
import net.shopxx.dao.ProductDao;
import net.shopxx.dao.ProductParamDao;
import net.shopxx.entity.Product;
import net.shopxx.entity.ProductParam;
import net.shopxx.service.ProductParamService;

/**
 * 类似产品参数
 * 
 * @author wxz 2019-05-23
 *
 */
@Service
public class ProductParamServiceImpl extends BaseServiceImpl<ProductParam, Long> implements ProductParamService {

	@Inject
	private ProductParamDao productParamDao;
	@Inject
	private ProductDao productDao;

	@Override
	@Transactional(readOnly = true)
	public List<ProductParam> findList(Product product, Integer count, List<Filter> filters, List<Order> orders) {
		return productParamDao.findList(product, count, filters, orders);
	}

	@Override
	public void save(Long productId, List<ProductParam> productParams, ProductParam.Type type) {
		Product pProduct = productDao.find(productId);
		for (ProductParam productParam : productParams) {
			productParam.setProduct(pProduct);
			productParam.setType(type);
			super.save(productParam);
		}
	}

	@Override
	@Transactional(readOnly = true)
	public void filter(List<ProductParam> productParams) {
		CollectionUtils.filter(productParams, new Predicate() {
			public boolean evaluate(Object object) {
				ProductParam parameterValue = (ProductParam) object;
				if (parameterValue == null || StringUtils.isEmpty(parameterValue.getName())) {
					return false;
				}
				return true;
			}
		});
	}

	@Override
	public void removeByProduct(Long id) {
		productParamDao.remove(id);
	}

}
