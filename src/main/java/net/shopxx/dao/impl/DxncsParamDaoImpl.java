package net.shopxx.dao.impl;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.persistence.criteria.Subquery;

import org.springframework.stereotype.Repository;

import net.shopxx.Filter;
import net.shopxx.Order;
import net.shopxx.dao.DxncsParamDao;
import net.shopxx.entity.DxncsParam;
import net.shopxx.entity.Product;

/**
 * 电性能参数
 * 
 * @author wxz 2019-05-23
 *
 */
@Repository
public class DxncsParamDaoImpl extends BaseDaoImpl<DxncsParam, Long> implements DxncsParamDao {

	@Override
	public List<DxncsParam> findList(Product product, Integer count, List<Filter> filters, List<Order> orders) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<DxncsParam> criteriaQuery = criteriaBuilder.createQuery(DxncsParam.class);
		Root<DxncsParam> root = criteriaQuery.from(DxncsParam.class);
		criteriaQuery.select(root);
		Predicate restrictions = criteriaBuilder.conjunction();
		if (product != null) {
			Subquery<Product> subquery = criteriaQuery.subquery(Product.class);
			Root<Product> subqueryRoot = subquery.from(Product.class);
			subquery.select(subqueryRoot);
			subquery.where(criteriaBuilder.or(criteriaBuilder.equal(subqueryRoot, product), criteriaBuilder.equal(subqueryRoot.<String>get("id"),  product.getId() )));
			restrictions = criteriaBuilder.and(restrictions, criteriaBuilder.in(root.get("product")).value(subquery));
		}
		
		criteriaQuery.where(restrictions);
		if (orders == null || orders.isEmpty()) {
			criteriaQuery.orderBy(criteriaBuilder.desc(root.get("createdDate")));
		}
		return super.findList(criteriaQuery, null, count, filters, orders);
	}

	@Override
	public void delete(Long id) {
		String jpql = "delete from DxncsParam dxncsParam where dxncsParam.product.id = :id";
		entityManager.createQuery(jpql).setParameter("id", id).executeUpdate();
	}

}
