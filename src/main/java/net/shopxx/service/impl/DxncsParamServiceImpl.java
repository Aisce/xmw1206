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
import net.shopxx.dao.DxncsParamDao;
import net.shopxx.dao.ProductDao;
import net.shopxx.entity.DxncsParam;
import net.shopxx.entity.Product;
import net.shopxx.service.DxncsParamService;

/**
 * 电性能参数
 * 
 * @author wxz 2019-05-23
 *
 */
@Service
public class DxncsParamServiceImpl extends BaseServiceImpl<DxncsParam, Long> implements DxncsParamService {

	@Inject
	private DxncsParamDao dxncsParamDao;
	@Inject
	private ProductDao productDao;

	@Override
	@Transactional(readOnly = true)
	public List<DxncsParam> findList(Product product, Integer count, List<Filter> filters, List<Order> orders) {
		return dxncsParamDao.findList(product, count, filters, orders);
	}

	@Override
	public void save(Long productId, List<DxncsParam> dxncsParams) {
		Product pProduct = productDao.find(productId);
		for (DxncsParam dxncsParam : dxncsParams) {
			dxncsParam.setProduct(pProduct);
			super.save(dxncsParam);
		}
	}

	@Override
	@Transactional(readOnly = true)
	public void filter(List<DxncsParam> dxncsParams) {
		CollectionUtils.filter(dxncsParams, new Predicate() {
			public boolean evaluate(Object object) {
				DxncsParam parameterValue = (DxncsParam) object;
				if (parameterValue == null || StringUtils.isEmpty(parameterValue.getName())) {
					return false;
				}
				return true;
			}
		});
	}

	@Override
	public void removeByProduct(Long id) {
		dxncsParamDao.delete(id);
	}

}
