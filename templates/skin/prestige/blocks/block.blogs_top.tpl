<ul>
	{foreach from=$aBlogs item=oBlog}
		<li>
			<a href="{$oBlog->getUrlFull()}">{if $oBlog->getType()=='close'}<i title="{$aLang.blog_closed}" class="icon icon-lock"></i>{/if} {$oBlog->getTitle()|escape:'html'|truncate:25:'...'}</a>
		</li>
	{/foreach}
    {* Ссылка на все блоги внизу
    <li class="last">
        <a href="{router page='blogs'}">{$aLang.prest_txt_25}</a>
    </li>
    *}
</ul>