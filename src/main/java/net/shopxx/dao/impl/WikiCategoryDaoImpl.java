/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: yIQaFLFLxXEIF1ynycGGAFSHFXON58UB
 */
package net.shopxx.dao.impl;

import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.persistence.TypedQuery;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.builder.CompareToBuilder;
import org.springframework.stereotype.Repository;

import net.shopxx.dao.WikiCategoryDao;
import net.shopxx.entity.WikiCategory;

/**
 * Dao - 文章分类
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
@Repository
public class WikiCategoryDaoImpl extends BaseDaoImpl<WikiCategory, Long> implements WikiCategoryDao {

	@Override
	public List<WikiCategory> findRoots(Integer count) {
		String jpql = "select wikiCategory from WikiCategory wikiCategory where wikiCategory.parent is null order by wikiCategory.order asc";
		TypedQuery<WikiCategory> query = entityManager.createQuery(jpql, WikiCategory.class);
		if (count != null) {
			query.setMaxResults(count);
		}
		return query.getResultList();
	}

	@Override
	public List<WikiCategory> findParents(WikiCategory wikiCategory, boolean recursive, Integer count) {
		if (wikiCategory == null || wikiCategory.getParent() == null) {
			return Collections.emptyList();
		}
		TypedQuery<WikiCategory> query;
		if (recursive) {
			String jpql = "select wikiCategory from WikiCategory wikiCategory where wikiCategory.id in (:ids) order by wikiCategory.grade asc";
			query = entityManager.createQuery(jpql, WikiCategory.class).setParameter("ids", Arrays.asList(wikiCategory.getParentIds()));
		} else {
			String jpql = "select wikiCategory from WikiCategory wikiCategory where wikiCategory = :wikiCategory";
			query = entityManager.createQuery(jpql, WikiCategory.class).setParameter("wikiCategory", wikiCategory.getParent());
		}
		if (count != null) {
			query.setMaxResults(count);
		}
		return query.getResultList();
	}

	@Override
	public List<WikiCategory> findChildren(WikiCategory wikiCategory, boolean recursive, Integer count) {
		TypedQuery<WikiCategory> query;
		if (recursive) {
			if (wikiCategory != null) {
				String jpql = "select wikiCategory from WikiCategory wikiCategory where wikiCategory.treePath like :treePath order by wikiCategory.grade asc, wikiCategory.order asc";
				query = entityManager.createQuery(jpql, WikiCategory.class).setParameter("treePath", "%" + WikiCategory.TREE_PATH_SEPARATOR + wikiCategory.getId() + WikiCategory.TREE_PATH_SEPARATOR + "%");
			} else {
				String jpql = "select wikiCategory from WikiCategory wikiCategory order by wikiCategory.grade asc, wikiCategory.order asc";
				query = entityManager.createQuery(jpql, WikiCategory.class);
			}
			if (count != null) {
				query.setMaxResults(count);
			}
			List<WikiCategory> result = query.getResultList();
			sort(result);
			return result;
		} else {
			String jpql = "select wikiCategory from WikiCategory wikiCategory where wikiCategory.parent = :parent order by wikiCategory.order asc";
			query = entityManager.createQuery(jpql, WikiCategory.class).setParameter("parent", wikiCategory);
			if (count != null) {
				query.setMaxResults(count);
			}
			return query.getResultList();
		}
	}

	/**
	 * 排序文章分类
	 * 
	 * @param wikiCategories
	 *            文章分类
	 */
	private void sort(List<WikiCategory> wikiCategories) {
		if (CollectionUtils.isEmpty(wikiCategories)) {
			return;
		}
		final Map<Long, Integer> orderMap = new HashMap<>();
		for (WikiCategory wikiCategory : wikiCategories) {
			orderMap.put(wikiCategory.getId(), wikiCategory.getOrder());
		}
		Collections.sort(wikiCategories, new Comparator<WikiCategory>() {
			@Override
			public int compare(WikiCategory wikiCategory1, WikiCategory wikiCategory2) {
				Long[] ids1 = (Long[]) ArrayUtils.add(wikiCategory1.getParentIds(), wikiCategory1.getId());
				Long[] ids2 = (Long[]) ArrayUtils.add(wikiCategory2.getParentIds(), wikiCategory2.getId());
				Iterator<Long> iterator1 = Arrays.asList(ids1).iterator();
				Iterator<Long> iterator2 = Arrays.asList(ids2).iterator();
				CompareToBuilder compareToBuilder = new CompareToBuilder();
				while (iterator1.hasNext() && iterator2.hasNext()) {
					Long id1 = iterator1.next();
					Long id2 = iterator2.next();
					Integer order1 = orderMap.get(id1);
					Integer order2 = orderMap.get(id2);
					compareToBuilder.append(order1, order2).append(id1, id2);
					if (!iterator1.hasNext() || !iterator2.hasNext()) {
						compareToBuilder.append(wikiCategory1.getGrade(), wikiCategory2.getGrade());
					}
				}
				return compareToBuilder.toComparison();
			}
		});
	}

}