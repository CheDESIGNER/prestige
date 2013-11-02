<div class="blogs-lists">
    <ul class="lists">
    {if $aBlogs}
        {foreach from=$aBlogs item=oBlog}
            {assign var="oUserOwner" value=$oBlog->getOwner()}

            <li class="one-blog">
                <div id="vote_area_blog_{$oBlog->getId()}" class="vote {if $oBlog->getRating() > 0}vote-count-positive{elseif $oBlog->getRating() < 0}vote-count-negative{/if} {if $oVote} voted {if $oVote->getDirection()>0}voted-up{elseif $oVote->getDirection()<0}voted-down{/if}{/if}">
                    <div id="vote_total_blog_{$oBlog->getId()}" class="vote-count count" title="{$aLang.blog_vote_count}: {$oBlog->getCountVote()}">{if $oBlog->getRating() > 0}+{/if}{$oBlog->getRating()}</div>
                    <a href="#" class="vote-down" onclick="return ls.vote.vote({$oBlog->getId()},this,-1,'blog');"><i class="icox icon-thumbs-down"></i></a>
                    <div class="vote-line"></div>
                    <a href="#" class="vote-up" onclick="return ls.vote.vote({$oBlog->getId()},this,1,'blog');"><i class="icox icon-thumbs-up"></i></a>
                </div>

                <div class="name-blog">
                    <a href="{$oBlog->getUrlFull()}" class="avatar">
                        <img src="{$oBlog->getAvatarPath(150)}" />
                    </a>

                    {if $oBlog->getType() == 'close'}
                        <i title="{$aLang.blog_closed}" class="icox icon-lock"></i>
                    {/if}

                    <a href="{$oBlog->getUrlFull()}" class="title">{$oBlog->getTitle()|escape:'html'}</a>

                    {if $oUserCurrent}
                        {if $oUserCurrent->getId() != $oBlog->getOwnerId() and $oBlog->getType() == 'open'}
                            <a href="#" onclick="ls.blog.toggleJoin(this, {$oBlog->getId()}); return false;" class="join-link">
                                {if $oBlog->getUserIsJoin()}
                                    {$aLang.blog_leave}
                                {else}
                                    {$aLang.blog_join}
                                {/if}
                            </a>
                        {/if}
                    {/if}
                </div>

                <ul class="nav nav-pills nav-profile nav-info-blog">
                    <li class="link-desc active"><a>{$aLang.prest_txt_13}</a></li>
                    <li class="link-admin"><a>{$aLang.prest_txt_14}</a></li>
                    <li class="link-moder"><a>{$aLang.prest_txt_15}</a></li>
                    <li class="link-read"><a>{$aLang.prest_txt_16}</a></li>
                </ul>

                <div class="txt-info desc-info-blog">
                    {$oBlog->getDescription()|truncate:280:'...'}
                </div>

                <div class="avatar-info admin-blog">
                    <a href="{$oUserOwner->getUserWebPath()}" class="user"><i class="icon-user"></i>{$oUserOwner->getLogin()}</a>
                    {if $aBlogAdministrators}
                        {foreach from=$aBlogAdministrators item=oBlogUser}
                            {assign var="oUser" value=$oBlogUser->getUser()}
                            <a href="{$oUser->getUserWebPath()}" class="user"><i class="icon-user"></i>{$oUser->getLogin()}</a>
                        {/foreach}
                    {/if}
                </div>

                <div class="avatar-info moder-blog">
                    {if $aBlogModerators}
                        {foreach from=$aBlogModerators item=oBlogUser}
                            {assign var="oUser" value=$oBlogUser->getUser()}
                            <a href="{$oUser->getUserWebPath()}" class="user"><i class="icon-user"></i>{$oUser->getLogin()}</a>
                        {/foreach}
                    {else}
                        {$aLang.blog_user_moderators_empty}
                    {/if}
                </div>

                <div class="avatar-info user-blog">
                    {if $aBlogUsers}
                        {foreach from=$aBlogUsers item=oBlogUser}
                            {assign var="oUser" value=$oBlogUser->getUser()}
                            <a href="{$oUser->getUserWebPath()}" class="user"><i class="icon-user"></i>{$oUser->getLogin()}</a>
                        {/foreach}

                        {if count($aBlogUsers) < $iCountBlogUsers}
                            <br /><a href="{$oBlog->getUrlFull()}users/">{$aLang.blog_user_readers_all}</a>
                        {/if}
                    {else}
                        {$aLang.blog_user_readers_empty}
                    {/if}
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