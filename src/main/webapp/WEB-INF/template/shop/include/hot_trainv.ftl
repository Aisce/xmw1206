[@trainv_list count = 10 orderBy = "hits DESC"]
	[#if trainvs?has_content]
		<div class="hot-article">
			<div class="hot-article-heading">
				<h4>${message("shop.trainv.hotTrainv")}</h4>
			</div>
			<div class="hot-article-body">
				<ul>
					[#list trainvs as trainv]
						<li class="text-overflow">
							<a href="${base}${trainv.path}" title="${trainv.subject}">${trainv.subject}</a>
						</li>
					[/#list]
				</ul>
			</div>
		</div>
	[/#if]
[/@trainv_list]