<ul class="item-list">
	{foreach from=$aBlogs item=oBlog}
		<li>
			
			{if $oBlog->getType()=='close'}<i title="{$aLang.blog_closed}" class="icox icon-lock"></i>{/if}
			<a href="{$oBlog->getUrlFull()}">{$oBlog->getTitle()|escape:'html'}</a>
			
			<p>{$aLang.blog_rating}: <strong>{$oBlog->getRating()}</strong></p>
		</li>
	{/foreach}
    <li>
        <a href="{router page='blogs'}">{$aLang.prest_txt_25}</a>
    </li>
</ul>				