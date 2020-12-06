[#noautoesc]
	[#escape x as x?js_string]
		<script>
		$().ready(function() {
		
			var $trainvSearchForm = $("#trainvSearchForm");
			var $keyword = $("#trainvSearchForm [name='keyword']");
			
			// 搜索
			$trainvSearchForm.submit(function() {
				if ($.trim($keyword.val()) === "") {
					return false;
				}
			});
		
		});
		</script>
	[/#escape]
[/#noautoesc]
<div class="article-search">
	<form id="trainvSearchForm" action="${base}/trainv/search" method="get">
		<div class="article-search">
			<div class="article-search-heading">
				<h4>${message("shop.trainv.search")}</h4>
			</div>
			<div class="article-search-body clearfix">
				<input name="keyword" type="text" value="${trainvKeyword}" placeholder="${message("shop.trainv.trainvSearchSubmit")}" x-webkit-speech="x-webkit-speech" x-webkit-grammar="builtin:search">
				<button type="submit">
					<i class="iconfont icon-search"></i>
				</button>
			</div>
		</div>
	</form>
</div>