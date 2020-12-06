[@product_resemble productId = product.id productCategoryId = productCategory.id cpxh = product.cpxh count = 5 orderBy = "monthSales DESC"]
	[#if products?has_content]
		<div class="featured-product">
			<div class="featured-product-heading">
				<h4>${message("shop.product.resembleProduct")}</h4>
			</div>
			<div class="featured-product-body">
				<ul>
					[#list products as product]
						<li>
							<a href="${base}${product.path}" target="_blank">
								<img class="lazy-load img-responsive center-block" src="${base}/resources/common/images/transparent.png" alt="${product.name}" data-original="${product.thumbnail!setting.defaultThumbnailProductImage}">
							</a>
							<!--价格注释START [#if false]
							<strong>
								${currency(product.price, true)}
								[#if setting.isShowMarketPrice]
									<del>${currency(product.marketPrice, true)}</del>
								[/#if]
							</strong>
							[/#if] 价格注释END-->
							<a href="${base}${product.path}" target="_blank">
								<h5 class="text-overflow" title="${product.name}">${product.name}</h5>
								[#if product.caption?has_content]
									<h6 class="text-overflow" title="${product.caption}">${product.caption}</h6>
								[/#if]
							</a>
						</li>
					[/#list]
				</ul>
			</div>
		</div>
	[/#if]
[/@product_resemble]