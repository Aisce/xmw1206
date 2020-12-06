[@wiki_list wikiCategoryId = wikiCategory.id count = 10 orderBy = "hits DESC"]
	[#if wikis?has_content]
		<div class="hot-article">
			<div class="hot-article-heading">
				<h4>${message("shop.wiki.hotWiki")}</h4>
			</div>
			<div class="hot-article-body">
				<ul>
					[#list wikis as wiki]
						<li class="text-overflow">
							<a href="${base}${wiki.path}" title="${wiki.title}">${wiki.title}</a>
						</li>
					[/#list]
				</ul>
			</div>
		</div>
	[/#if]
[/@wiki_list]