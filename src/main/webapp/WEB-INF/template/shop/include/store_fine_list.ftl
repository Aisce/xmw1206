<div class="title">优秀厂家展示</div>
[@store_fine_list count = 3 status = "SUCCESS" isFine = true]
	[#list store_fine as fine]
		<div>
			<a href="${base}/store/${fine.id}"><img src="${fine.logo}"/>
			<div>优秀厂家${fine.name}</div></a>
		</div>
	[/#list]
[/@store_fine_list]