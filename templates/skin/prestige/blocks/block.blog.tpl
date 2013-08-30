{if $oTopic}
    {assign var="oBlog" value=$oTopic->getBlog()}
    {if $oBlog->getType()!='personal'}
        <section class="block block-type-blog blog-left-info">
            <img src="{$oBlog->getAvatarPath(270)}" class="avatar"/>
            <a href="{$oBlog->getUrlFull()}" class="shadow"></a>
            <a href="{$oBlog->getUrlFull()}" class="title">
                {if $oBlog->getType() == 'close'}
                    <i title="{$aLang.blog_closed}" class="icon-lock"></i>
                {/if}
                {$oBlog->getTitle()|escape:'html'}
            </a>

            <span class="topics">
                {$oBlog->getCountTopic()} {$oBlog->getCountTopic()|declension:$aLang.prest_txt_26:'russian'} / <span id="blog_user_count_{$oBlog->getId()}">{$oBlog->getCountUser()}</span> {$oBlog->getCountUser()|declension:$aLang.reader_declension:'russian'}
            </span>

            <a href="{router page='rss'}blog/{$oBlog->getUrl()}/" class="rss">RSS</a>

            {if $oUserCurrent and $oUserCurrent->getId()!=$oBlog->getOwnerId()}
                <button type="submit" class="button button-primary {if $oBlog->getUserIsJoin()}active{/if}" id="blog-join" data-only-text="1" onclick="ls.blog.toggleJoin(this,{$oBlog->getId()}); return false;">{if $oBlog->getUserIsJoin()}{$aLang.blog_leave}{else}{$aLang.blog_join}{/if}</button>&nbsp;&nbsp;
            {/if}
        </section>
    {/if}
{/if}