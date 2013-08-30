{if $aPaging and $aPaging.iCountPage>1} 
	<div class="pagination">
		<ul>
			{if $aPaging.iCurrentPage>1}<li class="hidden-phone"><a href="{$aPaging.sBaseUrl}/{$aPaging.sGetParams}" title="{$aLang.paging_first}">{$aLang.paging_first}</a></li>{/if}
			
			
			{if $aPaging.iPrevPage}
				<li class="hidden-phone"><a href="{$aPaging.sBaseUrl}/page{$aPaging.iPrevPage}/{$aPaging.sGetParams}" class="js-paging-prev-page" title="{$aLang.paging_previos}">← {$aLang.paging_previos}</a></li>
				<li class="visible-phone"><a href="{$aPaging.sBaseUrl}/page{$aPaging.iPrevPage}/{$aPaging.sGetParams}" class="js-paging-prev-page" title="{$aLang.paging_previos}">←</a></li>
			{/if}
			
			
			{foreach from=$aPaging.aPagesLeft item=iPage}
				<li><a href="{$aPaging.sBaseUrl}/page{$iPage}/{$aPaging.sGetParams}">{$iPage}</a></li>
			{/foreach}
			
			<li class="active"><span>{$aPaging.iCurrentPage}</span></li>
			
			{foreach from=$aPaging.aPagesRight item=iPage}
				<li><a href="{$aPaging.sBaseUrl}/page{$iPage}/{$aPaging.sGetParams}">{$iPage}</a></li>
			{/foreach}
			
			
			{if $aPaging.iNextPage}
				<li class="hidden-phone"><a href="{$aPaging.sBaseUrl}/page{$aPaging.iNextPage}/{$aPaging.sGetParams}" class="js-paging-next-page" title="{$aLang.paging_next}">{$aLang.paging_next} →</a></li>
                <li class="visible-phone"><a href="{$aPaging.sBaseUrl}/page{$aPaging.iNextPage}/{$aPaging.sGetParams}" class="js-paging-next-page" title="{$aLang.paging_next}">→</a></li>
			{/if}
			
			
			{if $aPaging.iCurrentPage<$aPaging.iCountPage}<li class="hidden-phone"><a href="{$aPaging.sBaseUrl}/page{$aPaging.iCountPage}/{$aPaging.sGetParams}" title="{$aLang.paging_last}">{$aLang.paging_last}</a></li>{/if}
		</ul>
	</div>
{/if}