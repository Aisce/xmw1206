[@store_product_category_root_list storeId = store.id]
	[#if storeProductCategories?has_content]
		<div class="store-product-category">
			<dl class="clearfix">
				<dt>
					<a href="${base}/product/list?storeProductCategoryId=-1&storeId=${store.id}" title="全部">全部</a>
				</dt>
			</dl>
			[#list storeProductCategories as storeProductCategory]
				<dl class="clearfix">
					<dt>
						<a href="${base}${storeProductCategory.path}" title="${storeProductCategory.name}">${abbreviate(storeProductCategory.name, 15, "...")}</a>
					</dt>
					[@store_product_category_children_list storeProductCategoryId = storeProductCategory.id storeId = store.id recursive = false]
						[#list storeProductCategories as storeProductCategory]
							<dd>
								<a class="text-overflow" href="${base}${storeProductCategory.path}" title="${storeProductCategory.name}">${storeProductCategory.name}</a>
							</dd>
							[@store_product_category_children_list storeProductCategoryId = storeProductCategory.id storeId = store.id recursive = false]
								[#list storeProductCategories as storeProductCategory3]
									<dd>
										<a class="text-overflow" href="${base}${storeProductCategory3.path}" title="${storeProductCategory3.name}">${storeProductCategory3.name}</a>
									</dd>
								[/#list]
							[/@store_product_category_children_list]
						[/#list]
					[/@store_product_category_children_list]
				</dl>
			[/#list]
		</div>
	[/#if]
[/@store_product_category_root_list]