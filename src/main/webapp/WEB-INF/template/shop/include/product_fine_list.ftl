<div class="title">
	优秀产品推荐
</div>
[@product_fine count = 3]
	[#list productFine as fine]
		<div>
			<a href="${base}/product/detail/${fine.id}"><img src="${fine.productImages[0].thumbnail}"/>
			<div>${fine.name}</div></a>
		</div>
	[/#list]
[/@product_fine]