[@product_number numbers = product.dxwwyqj count = 5 orderBy = "monthSales DESC"]
	[#if products?has_content]
		<tr>
			<td>典型外围配套元器件</td>
			<td>
			[#list products as product]
				<a href="${base}${product.path}" target="_blank" class="showimg"><img class="lazy-load img-responsive center-block" src="${base}/resources/common/images/transparent.png" alt="${product.name}" data-original="${product.thumbnail!setting.defaultThumbnailProductImage}"></a>		
			[/#list]
			</td>
		</tr>
	[/#if]
[/@product_number]