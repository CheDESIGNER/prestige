<div class="blogs-lists-style-2">
    <ul class="lists">
    {if $aBlogs}
        {foreach from=$aBlogs item=oBlog}
            {assign var="oUserOwner" value=$oBlog->getOwner()}
            <li class="one-blog">
                <img src="{$oBlog->getAvatarPath(270)}" class="avatar"/>
                <div class="blog-info-list">
                    <a href="{$oBlog->getUrlFull()}" class="shadow js-style"></a>
                    {if $oUserCurrent and $oUserCurrent->getId()!=$oBlog->getOwnerId()}
                        <button type="submit" class="blog-join button button-primary {if $oBlog->getUserIsJoin()}active{/if}" id="blog-join" data-only-text="1" onclick="ls.blog.toggleJoin(this,{$oBlog->getId()}); return false;">{if $oBlog->getUserIsJoin()}{$aLang.blog_leave}{else}{$aLang.blog_join}{/if}</button>
                    {/if}
                    <a href="{$oBlog->getUrlFull()}" class="title">
                        {if $oBlog->getType() == 'close'}
                            <i title="{$aLang.blog_closed}" class="icox icon-lock"></i>
                        {/if}
                        {$oBlog->getTitle()|escape:'html'}
                    </a>
                    <span class="topics">{$oBlog->getCountTopic()} {$oBlog->getCountTopic()|declension:$aLang.prest_txt_26:'russian'}</span>
                </div>
            </li>
        {/foreach}
        {else}
        <li>
            {if $sBlogsEmptyList}
                {$sBlogsEmptyList}
            {else}
            {/if}
        </li>
    {/if}
    </ul>
</div>