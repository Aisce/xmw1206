[@wiki_category_root_list count = 10]
	[#if wikiCategories?has_content]
		<div class="hot-article-category">
			<div class="hot-article-category-heading">
				<h4>${message("shop.wiki.hotWikiCategory")}</h4>
			</div>
			<div class="hot-article-category-body">
				<ul>
					[#list wikiCategories as wikiCategory]
						<li>
							<a href="${base}${wikiCategory.path}">${wikiCategory.name}</a>
						</li>
						[@wiki_category_children_list wikiCategoryId = wikiCategory.id recursive = false]
							[#list wikiCategories as wikiCategorie]
								<li>
									<a class="text-overflow" href="${base}${wikiCategorie.path}" title="${wikiCategorie.name}">${wikiCategorie.name}</a>
								</li>
							[/#list]
						[/@wiki_category_children_list]
					[/#list]
				</ul>
			</div>
		</div>
	[/#if]
[/@wiki_category_root_list]