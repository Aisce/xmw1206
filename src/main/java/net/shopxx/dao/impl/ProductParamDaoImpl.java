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
import net.shopxx.dao.ProductParamDao;
import net.shopxx.entity.ProductParam;
import net.shopxx.entity.Product;

/**
 * 类似产品参数
 * 
 * @author wxz 2019-05-23
 *
 */
@Repository
public class ProductParamDaoImpl extends BaseDaoImpl<ProductParam, Long> implements ProductParamDao {

	@Override
	public List<ProductParam> findList(Product product, Integer count, List<Filter> filters, List<Order> orders) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<ProductParam> criteriaQuery = criteriaBuilder.createQuery(ProductParam.class);
		Root<ProductParam> root = criteriaQuery.from(ProductParam.class);
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
	public void remove(Long id) {
		String jpql = "delete from ProductParam productParam where productParam.product.id = :id";
		entityManager.createQuery(jpql).setParameter("id", id).executeUpdate();
	}

}
