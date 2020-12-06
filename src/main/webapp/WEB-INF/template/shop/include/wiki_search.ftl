[#noautoesc]
	[#escape x as x?js_string]
		<script>
		$().ready(function() {
		
			var $wikiSearchForm = $("#wikiSearchForm");
			var $keyword = $("#wikiSearchForm [name='keyword']");
			
			// 搜索
			$wikiSearchForm.submit(function() {
				if ($.trim($keyword.val()) === "") {
					return false;
				}
			});
		
		});
		</script>
	[/#escape]
[/#noautoesc]
<div class="article-search">
	<form id="wikiSearchForm" action="${base}/wiki/search" method="get">
		<div class="article-search">
			<div class="article-search-heading">
				<h4>${message("shop.wiki.search")}</h4>
			</div>
			<div class="article-search-body clearfix">
				<input name="keyword" type="text" value="${wikiKeyword}" placeholder="${message("shop.wiki.aritcleSearchSubmit")}" x-webkit-speech="x-webkit-speech" x-webkit-grammar="builtin:search">
				<button type="submit">
					<i class="iconfont icon-search"></i>
				</button>
			</div>
		</div>
	</form>
</div>